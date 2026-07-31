import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/design_tokens.dart';
import '../../models/shop_model.dart';
import '../../providers/orders_provider.dart';
import '../../utils/currency.dart';
import '../../widgets/empty_state_pattern.dart';

/// E6: Buyurtmalarim — real (session-local) order history, appended by
/// s6_checkout_screen.dart on each completed checkout. Also bound to the
/// shell's `/history` tab route — intentional: the spec has no separate
/// "history" concept, orders are the only history this app tracks.
class E6OrdersScreen extends ConsumerStatefulWidget {
  const E6OrdersScreen({super.key});

  @override
  ConsumerState<E6OrdersScreen> createState() => _E6OrdersScreenState();
}

class _E6OrdersScreenState extends ConsumerState<E6OrdersScreen> {
  OrderStep? _filter;

  @override
  Widget build(BuildContext context) {
    final orders = ref.watch(ordersProvider);
    final visible = _filter == null
        ? orders
        : orders.where((o) => o.currentStep == _filter).toList();

    return Scaffold(
      backgroundColor: DesignTokens.backgroundLight,
      appBar: AppBar(
        backgroundColor: DesignTokens.backgroundLight,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text('Buyurtmalarim', style: DesignTokens.heading3),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: DesignTokens.screenPaddingHorizontal,
              vertical: DesignTokens.spacingSm,
            ),
            child: SizedBox(
              height: 40,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _FilterChip(
                    label: 'Barchasi',
                    selected: _filter == null,
                    onTap: () => setState(() => _filter = null),
                  ),
                  for (final step in [
                    OrderStep.gathering,
                    OrderStep.onTheWay,
                    OrderStep.delivered,
                  ])
                    Padding(
                      padding: const EdgeInsets.only(
                        left: DesignTokens.spacingSm,
                      ),
                      child: _FilterChip(
                        label: step.label,
                        selected: _filter == step,
                        onTap: () => setState(() => _filter = step),
                      ),
                    ),
                ],
              ),
            ),
          ),
          Expanded(
            child: visible.isEmpty
                ? Padding(
                    padding: const EdgeInsets.all(
                      DesignTokens.screenPaddingHorizontal,
                    ),
                    child: Center(
                      child: EmptyStatePattern(
                        icon: Icons.shopping_bag_outlined,
                        title: 'Buyurtma yo\'q',
                        message:
                            'Do\'kondan xarid qilganingizda shu yerda ko\'rinadi',
                      ),
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.all(
                      DesignTokens.screenPaddingHorizontal,
                    ),
                    itemCount: visible.length,
                    separatorBuilder: (_, _) =>
                        const SizedBox(height: DesignTokens.spacingSm),
                    itemBuilder: (context, index) =>
                        _OrderCard(order: visible[index]),
                  ),
          ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      onSelected: (_) => onTap(),
      backgroundColor: DesignTokens.white,
      selectedColor: DesignTokens.primaryBlue,
      labelStyle: DesignTokens.caption.copyWith(
        color: selected ? DesignTokens.white : DesignTokens.textDark,
      ),
    );
  }
}

class _OrderCard extends StatelessWidget {
  const _OrderCard({required this.order});

  final ShopOrder order;

  Color get _statusColor => switch (order.currentStep) {
    OrderStep.accepted => DesignTokens.textGray,
    OrderStep.gathering => DesignTokens.accentOrange,
    OrderStep.onTheWay => DesignTokens.primaryBlue,
    OrderStep.delivered => DesignTokens.successGreen,
  };

  @override
  Widget build(BuildContext context) {
    final extraCount = order.lines.length > 2 ? order.lines.length - 2 : 0;

    return InkWell(
      onTap: () => context.push('/shop/s7', extra: order),
      borderRadius: BorderRadius.circular(DesignTokens.radiusLg),
      child: Container(
        padding: const EdgeInsets.all(DesignTokens.spacingMd),
        decoration: BoxDecoration(
          color: DesignTokens.white,
          borderRadius: BorderRadius.circular(DesignTokens.radiusLg),
          border: Border.all(color: DesignTokens.borderGray),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(child: Text(order.id, style: DesignTokens.subtitle2)),
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
                    order.currentStep.label,
                    style: DesignTokens.caption.copyWith(
                      color: _statusColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Text(
              '${order.createdAt.day}.${order.createdAt.month}.${order.createdAt.year}',
              style: DesignTokens.caption.copyWith(
                color: DesignTokens.textGray,
              ),
            ),
            const SizedBox(height: DesignTokens.spacingSm),
            Row(
              children: [
                for (final _ in order.lines.take(2))
                  Padding(
                    padding: const EdgeInsets.only(
                      right: DesignTokens.spacingXs,
                    ),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: DesignTokens.borderGrayAlt,
                        borderRadius: BorderRadius.circular(
                          DesignTokens.radiusSm,
                        ),
                      ),
                      child: const Icon(
                        Icons.image_outlined,
                        size: 18,
                        color: DesignTokens.textMuted,
                      ),
                    ),
                  ),
                if (extraCount > 0)
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: DesignTokens.borderGrayAlt,
                      borderRadius: BorderRadius.circular(
                        DesignTokens.radiusSm,
                      ),
                    ),
                    child: Center(
                      child: Text('+$extraCount', style: DesignTokens.caption),
                    ),
                  ),
                const Spacer(),
                Text(
                  formatSom(order.total),
                  style: DesignTokens.subtitle2.copyWith(
                    color: DesignTokens.primaryBlue,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
