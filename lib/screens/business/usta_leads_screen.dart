import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../config/design_tokens.dart';
import '../../l10n/app_localizations.dart';
import '../../models/business_profile.dart';
import '../../providers/business_provider.dart';

String _leadStatusLabel(AppLocalizations l, LeadStatus s) => switch (s) {
      LeadStatus.fresh => l.leadStatusNew,
      LeadStatus.viewed => l.leadStatusViewed,
      LeadStatus.contacted => l.leadStatusContacted,
      LeadStatus.closed => l.leadStatusClosed,
    };

/// The usta's inbox: customers who contacted them, newest first, with a call
/// button and a way to move each request along (viewed → contacted → closed).
class UstaLeadsScreen extends ConsumerWidget {
  const UstaLeadsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: DesignTokens.backgroundLight,
      appBar: AppBar(
        backgroundColor: DesignTokens.backgroundLight,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.canPop() ? context.pop() : context.go('/business'),
        ),
        title: Text(l10n.ustaLeadsTitle, style: DesignTokens.heading3),
      ),
      body: RefreshIndicator(
        onRefresh: () async => ref.invalidate(myLeadsProvider),
        child: ref.watch(myLeadsProvider).when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (_, _) => ListView(children: [
                Padding(
                  padding: const EdgeInsets.all(DesignTokens.spacingLg),
                  child: Text(l10n.businessLoadFailed, textAlign: TextAlign.center),
                ),
              ]),
              data: (items) => items.isEmpty
                  ? ListView(children: [
                      Padding(
                        padding: const EdgeInsets.all(DesignTokens.spacingLg),
                        child: Text(l10n.ustaLeadsEmpty,
                            textAlign: TextAlign.center,
                            style: DesignTokens.body2.copyWith(color: DesignTokens.textGray)),
                      ),
                    ])
                  : ListView.separated(
                      padding: const EdgeInsets.all(DesignTokens.screenPaddingHorizontal),
                      itemCount: items.length,
                      separatorBuilder: (_, _) => const SizedBox(height: DesignTokens.spacingSm),
                      itemBuilder: (_, i) => _LeadTile(lead: items[i]),
                    ),
            ),
      ),
    );
  }
}

class _LeadTile extends ConsumerWidget {
  const _LeadTile({required this.lead});

  final UstaLead lead;

  Future<void> _set(BuildContext context, WidgetRef ref, LeadStatus status) async {
    final l10n = AppLocalizations.of(context)!;
    final messenger = ScaffoldMessenger.of(context);
    try {
      await ref.read(businessRepositoryProvider).setLeadStatus(lead.id, status);
      ref.invalidate(myLeadsProvider);
    } catch (_) {
      messenger.showSnackBar(SnackBar(content: Text(l10n.ustaEditFailed)));
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final isNew = lead.status == LeadStatus.fresh;
    final phone = lead.clientPhone;
    final d = lead.createdAt.toLocal();
    final date = '${d.day.toString().padLeft(2, '0')}.${d.month.toString().padLeft(2, '0')}.${d.year}';
    return Container(
      padding: const EdgeInsets.all(DesignTokens.spacingMd),
      decoration: BoxDecoration(
        color: DesignTokens.white,
        borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
        border: Border.all(color: isNew ? DesignTokens.accentOrange : const Color(0xFFF0F1F4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Expanded(
              child: Text(lead.clientName ?? l10n.ustaLeadClient,
                  maxLines: 1, overflow: TextOverflow.ellipsis, style: DesignTokens.subtitle2),
            ),
            Text(
              _leadStatusLabel(l10n, lead.status),
              style: DesignTokens.caption.copyWith(
                color: isNew ? DesignTokens.accentOrange : DesignTokens.textMuted,
                fontWeight: FontWeight.w700,
              ),
            ),
          ]),
          const SizedBox(height: 2),
          Text(
            [if (lead.roomName != null) lead.roomName!, date].join(' · '),
            style: DesignTokens.caption.copyWith(color: DesignTokens.textMuted),
          ),
          if (lead.totalUzs != null) ...[
            const SizedBox(height: DesignTokens.spacingXs),
            Text(l10n.ustaLeadEstimate(_uzs(lead.totalUzs!), lead.linesCount), style: DesignTokens.body2),
          ],
          if ((lead.message ?? '').trim().isNotEmpty) ...[
            const SizedBox(height: DesignTokens.spacingXs),
            Text(l10n.ustaLeadMessage(lead.message!.trim()),
                maxLines: 3, overflow: TextOverflow.ellipsis, style: DesignTokens.body2),
          ],
          const SizedBox(height: DesignTokens.spacingSm),
          Wrap(spacing: DesignTokens.spacingSm, children: [
            FilledButton.tonalIcon(
              onPressed: phone == null
                  ? null
                  : () async {
                      await launchUrl(Uri(scheme: 'tel', path: phone));
                      if (context.mounted && lead.status == LeadStatus.fresh) {
                        await _set(context, ref, LeadStatus.contacted);
                      }
                    },
              icon: const Icon(Icons.call_outlined),
              label: Text(phone ?? l10n.ustaLeadNoPhone),
            ),
            if (lead.status == LeadStatus.fresh)
              OutlinedButton(
                  onPressed: () => _set(context, ref, LeadStatus.viewed),
                  child: Text(l10n.ustaLeadMarkViewed)),
            if (lead.status != LeadStatus.closed)
              OutlinedButton(
                  onPressed: () => _set(context, ref, LeadStatus.closed),
                  child: Text(l10n.ustaLeadMarkClosed)),
          ]),
        ],
      ),
    );
  }
}

String _uzs(int v) {
  final s = v.toString();
  final b = StringBuffer();
  for (var i = 0; i < s.length; i++) {
    if (i > 0 && (s.length - i) % 3 == 0) b.write(' ');
    b.write(s[i]);
  }
  return "$b so'm";
}
