import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../config/design_tokens.dart';
import '../../l10n/app_localizations.dart';
import '../../models/business_profile.dart';
import '../../providers/business_provider.dart';

/// A simple dashboard of the shop: products by moderation state, catalog
/// visibility, customer inquiries and how often products are used in rooms.
class ShopStatsScreen extends ConsumerWidget {
  const ShopStatsScreen({super.key});

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
          onPressed: () =>
              context.canPop() ? context.pop() : context.go('/business'),
        ),
        title: Text(l10n.shopStatsTitle, style: DesignTokens.heading3),
      ),
      body: RefreshIndicator(
        onRefresh: () async => ref.invalidate(myStatsProvider),
        child: ref
            .watch(myStatsProvider)
            .when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (_, _) => ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(DesignTokens.spacingLg),
                    child: Text(
                      l10n.businessLoadFailed,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              data: (s) => ListView(
                padding: const EdgeInsets.all(
                  DesignTokens.screenPaddingHorizontal,
                ),
                children: [
                  _grid([
                    _StatCard(l10n.shopStatsProducts, s.productsTotal),
                    _StatCard(l10n.shopStatsApproved, s.productsApproved),
                    _StatCard(l10n.shopStatsPending, s.productsPending),
                    _StatCard(l10n.shopStatsRejected, s.productsRejected),
                    _StatCard(l10n.shopStatsVisible, s.visible),
                    _StatCard(l10n.shopStatsPlacements, s.placementsTotal),
                    _StatCard(l10n.shopStatsInquiries, s.inquiriesTotal),
                    _StatCard(
                      l10n.shopStatsNewInquiries,
                      s.inquiriesNew,
                      highlight: s.inquiriesNew > 0,
                    ),
                  ]),
                  const SizedBox(height: DesignTokens.spacingLg),
                  Text(l10n.shopStatsTop, style: DesignTokens.subtitle2),
                  const SizedBox(height: DesignTokens.spacingSm),
                  if (s.topProducts.isEmpty)
                    Text(
                      l10n.shopStatsTopEmpty,
                      style: DesignTokens.body2.copyWith(
                        color: DesignTokens.textGray,
                      ),
                    )
                  else
                    for (final t in s.topProducts) _TopRow(t),
                ],
              ),
            ),
      ),
    );
  }

  Widget _grid(List<Widget> cards) => Wrap(
    spacing: DesignTokens.spacingSm,
    runSpacing: DesignTokens.spacingSm,
    children: cards,
  );
}

class _StatCard extends StatelessWidget {
  const _StatCard(this.label, this.value, {this.highlight = false});

  final String label;
  final int value;
  final bool highlight;

  @override
  Widget build(BuildContext context) {
    final width =
        (MediaQuery.of(context).size.width -
            DesignTokens.screenPaddingHorizontal * 2 -
            DesignTokens.spacingSm) /
        2;
    return Container(
      width: width,
      padding: const EdgeInsets.all(DesignTokens.spacingMd),
      decoration: BoxDecoration(
        color: DesignTokens.white,
        borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
        border: Border.all(
          color: highlight
              ? DesignTokens.accentOrange
              : const Color(0xFFF0F1F4),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$value', style: DesignTokens.heading3),
          const SizedBox(height: 2),
          Text(
            label,
            style: DesignTokens.caption.copyWith(color: DesignTokens.textMuted),
          ),
        ],
      ),
    );
  }
}

class _TopRow extends StatelessWidget {
  const _TopRow(this.t);

  final TopProduct t;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: DesignTokens.spacingXs),
    child: Row(
      children: [
        Expanded(
          child: Text(
            t.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: DesignTokens.body2,
          ),
        ),
        Text('${t.placements}', style: DesignTokens.subtitle2),
      ],
    ),
  );
}
