import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../config/design_tokens.dart';
import '../../l10n/app_localizations.dart';
import '../../models/business_profile.dart';
import '../../providers/business_provider.dart';
import '../../utils/currency.dart';
import '../../utils/error_mapper.dart';
import '../../widgets/periodic_refresh.dart';

String _stageLabel(AppLocalizations l, SellerOrderStage s) => switch (s) {
  SellerOrderStage.accepted => l.orderStepAccepted,
  SellerOrderStage.gathering => l.orderStepGathering,
  SellerOrderStage.onTheWay => l.orderStepOnTheWay,
  SellerOrderStage.delivered => l.orderStepDelivered,
  SellerOrderStage.unknown => '',
};

String _advanceLabel(AppLocalizations l, SellerOrderStage target) =>
    switch (target) {
      SellerOrderStage.gathering => l.shopOrderMarkGathering,
      SellerOrderStage.onTheWay => l.shopOrderMarkOnTheWay,
      SellerOrderStage.delivered => l.shopOrderMarkDelivered,
      _ => '',
    };

String _paymentLabel(AppLocalizations l, String method) => switch (method) {
  'cash' => l.shopOrderPayCash,
  'card' => l.shopOrderPayCard,
  _ => method,
};

/// The shop's incoming orders, newest first. The shop moves each order one
/// stage forward at a time (accepted → gathering → on the way → delivered);
/// the list refreshes itself every 30 seconds while the screen is open.
class ShopOrdersScreen extends ConsumerWidget {
  const ShopOrdersScreen({super.key});

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
        title: Text(l10n.shopOrdersTitle, style: DesignTokens.heading3),
      ),
      body: PeriodicRefresh(
        onTick: () => ref.invalidate(mySellerOrdersProvider),
        child: RefreshIndicator(
          onRefresh: () async => ref.invalidate(mySellerOrdersProvider),
          child: ref
              .watch(mySellerOrdersProvider)
              .when(
                skipLoadingOnReload: true,
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
                data: (items) => items.isEmpty
                    ? ListView(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(
                              DesignTokens.spacingLg,
                            ),
                            child: Text(
                              l10n.shopOrdersEmpty,
                              textAlign: TextAlign.center,
                              style: DesignTokens.body2.copyWith(
                                color: DesignTokens.textGray,
                              ),
                            ),
                          ),
                        ],
                      )
                    : ListView.separated(
                        padding: const EdgeInsets.all(
                          DesignTokens.screenPaddingHorizontal,
                        ),
                        itemCount: items.length,
                        separatorBuilder: (_, _) =>
                            const SizedBox(height: DesignTokens.spacingSm),
                        itemBuilder: (_, i) => _OrderTile(order: items[i]),
                      ),
              ),
        ),
      ),
    );
  }
}

class _OrderTile extends ConsumerWidget {
  const _OrderTile({required this.order});

  final SellerOrder order;

  Future<void> _advance(
    BuildContext context,
    WidgetRef ref,
    SellerOrderStage target,
  ) async {
    final messenger = ScaffoldMessenger.of(context);
    try {
      await ref
          .read(businessRepositoryProvider)
          .advanceSellerOrder(order.id, target);
    } catch (e) {
      messenger.showSnackBar(
        SnackBar(content: Text(mapErrorWithServerDetail(e))),
      );
    }
    // Success or not, re-read: a 409/404 means the list on screen was stale.
    ref.invalidate(mySellerOrdersProvider);
  }

  Color get _statusColor => switch (order.status) {
    SellerOrderStage.delivered => DesignTokens.successGreen,
    SellerOrderStage.onTheWay => DesignTokens.primaryBlue,
    SellerOrderStage.gathering => DesignTokens.accentOrange,
    _ => DesignTokens.textGray,
  };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final d = order.createdAt.toLocal();
    final date =
        '${d.day.toString().padLeft(2, '0')}.${d.month.toString().padLeft(2, '0')}.${d.year}';
    final items = order.lines
        .map((l) => '${l.productName} × ${_qty(l.quantity)} ${l.unit}'.trim())
        .join(', ');
    final phone = order.phone;
    final address = order.deliveryAddress;
    final payment = order.paymentMethod;
    final target = order.status.next;
    return Container(
      padding: const EdgeInsets.all(DesignTokens.spacingMd),
      decoration: BoxDecoration(
        color: DesignTokens.white,
        borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
        border: Border.all(color: const Color(0xFFF0F1F4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  order.dealerName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: DesignTokens.subtitle2,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: DesignTokens.spacingSm,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: _statusColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(DesignTokens.radiusSm),
                ),
                child: Text(
                  _stageLabel(l10n, order.status),
                  style: DesignTokens.caption.copyWith(
                    color: _statusColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),
          Text(
            '$date · ${formatSom(order.totalUzs)}',
            style: DesignTokens.caption.copyWith(color: DesignTokens.textMuted),
          ),
          if (items.isNotEmpty) ...[
            const SizedBox(height: DesignTokens.spacingXs),
            Text(items, style: DesignTokens.body2),
          ],
          if (address != null && address.isNotEmpty) ...[
            const SizedBox(height: DesignTokens.spacingXs),
            Text(
              l10n.shopOrderAddressLine(address),
              style: DesignTokens.body2.copyWith(color: DesignTokens.textGray),
            ),
          ],
          if (payment != null && payment.isNotEmpty) ...[
            const SizedBox(height: 2),
            Text(
              l10n.shopOrderPaymentLine(_paymentLabel(l10n, payment)),
              style: DesignTokens.body2.copyWith(color: DesignTokens.textGray),
            ),
          ],
          if (phone != null && phone.isNotEmpty || target != null) ...[
            const SizedBox(height: DesignTokens.spacingSm),
            Wrap(
              spacing: DesignTokens.spacingSm,
              runSpacing: DesignTokens.spacingXs,
              children: [
                if (phone != null && phone.isNotEmpty)
                  FilledButton.tonalIcon(
                    onPressed: () => launchUrl(Uri(scheme: 'tel', path: phone)),
                    icon: const Icon(Icons.call_outlined),
                    label: Text(phone),
                  ),
                if (target != null)
                  FilledButton(
                    onPressed: () => _advance(context, ref, target),
                    child: Text(_advanceLabel(l10n, target)),
                  ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

String _qty(num q) =>
    q == q.roundToDouble() ? q.toInt().toString() : q.toString();
