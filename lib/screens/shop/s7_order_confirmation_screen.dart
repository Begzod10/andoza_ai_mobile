import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/design_tokens.dart';
import '../../models/shop_model.dart';
import '../../utils/currency.dart';

/// S7: Buyurtma holati — vertical stepper (Qabul qilindi → Yig'ilmoqda →
/// Yo'lda → Yetkazildi), dealer/courier contact row, order contents and
/// total, secondary "Ustaga topshirish" to notify the craftsman once
/// materials arrive.
class S7OrderConfirmationScreen extends ConsumerWidget {
  const S7OrderConfirmationScreen({this.order, super.key});

  final ShopOrder? order;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final o =
        order ??
        ShopOrder(
          id: 'ORD-0000',
          lines: const [],
          total: 0,
          currentStep: OrderStep.accepted,
          dealerName: '—',
          createdAt: DateTime.now(),
        );

    return Scaffold(
      backgroundColor: DesignTokens.backgroundLight,
      appBar: AppBar(
        backgroundColor: DesignTokens.backgroundLight,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text('Buyurtma holati', style: DesignTokens.heading3),
      ),
      body: ListView(
        padding: const EdgeInsets.all(DesignTokens.screenPaddingHorizontal),
        children: [
          Text(
            o.id,
            style: DesignTokens.caption.copyWith(color: DesignTokens.textGray),
          ),
          const SizedBox(height: DesignTokens.spacingLg),
          Container(
            padding: const EdgeInsets.all(DesignTokens.spacingMd),
            decoration: BoxDecoration(
              color: DesignTokens.white,
              borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
              border: Border.all(color: DesignTokens.borderGray),
            ),
            child: Column(
              children: [
                for (final step in OrderStep.values)
                  _StepRow(
                    step: step,
                    isLast: step == OrderStep.values.last,
                    state: step.index < o.currentStep.index
                        ? _StepState.done
                        : step.index == o.currentStep.index
                        ? _StepState.active
                        : _StepState.upcoming,
                  ),
              ],
            ),
          ),
          const SizedBox(height: DesignTokens.spacingLg),
          Container(
            padding: const EdgeInsets.all(DesignTokens.spacingMd),
            decoration: BoxDecoration(
              color: DesignTokens.white,
              borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
              border: Border.all(color: DesignTokens.borderGray),
            ),
            child: Row(
              children: [
                const CircleAvatar(
                  backgroundColor: DesignTokens.primaryBlue,
                  child: Icon(
                    Icons.local_shipping_outlined,
                    color: DesignTokens.white,
                  ),
                ),
                const SizedBox(width: DesignTokens.spacingSm),
                Expanded(
                  child: Text(o.dealerName, style: DesignTokens.subtitle2),
                ),
                IconButton(
                  icon: const Icon(Icons.call_outlined),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.message_outlined),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          const SizedBox(height: DesignTokens.spacingLg),
          const Text('Buyurtma tarkibi', style: DesignTokens.subtitle2),
          const SizedBox(height: DesignTokens.spacingSm),
          for (final line in o.lines) ...[
            _OrderItemRow(line: line),
            const SizedBox(height: DesignTokens.spacingXs),
          ],
          const SizedBox(height: DesignTokens.spacingSm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Jami', style: DesignTokens.subtitle1),
              Text(
                formatSom(o.total),
                style: DesignTokens.heading3.copyWith(
                  color: DesignTokens.primaryBlue,
                ),
              ),
            ],
          ),
          const SizedBox(height: DesignTokens.spacingXl),
          SizedBox(
            width: double.infinity,
            height: DesignTokens.buttonHeightLarge,
            child: OutlinedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Usta xabardor qilindi')),
                );
              },
              child: const Text('Ustaga topshirish'),
            ),
          ),
          const SizedBox(height: DesignTokens.spacingSm),
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: () => context.go('/shop/s1'),
              child: const Text('Do\'konga qaytish'),
            ),
          ),
        ],
      ),
    );
  }
}

enum _StepState { done, active, upcoming }

class _StepRow extends StatelessWidget {
  const _StepRow({
    required this.step,
    required this.state,
    required this.isLast,
  });

  final OrderStep step;
  final _StepState state;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final color = switch (state) {
      _StepState.done => DesignTokens.successGreen,
      _StepState.active => DesignTokens.primaryBlue,
      _StepState.upcoming => DesignTokens.textMuted,
    };
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
                child: state == _StepState.done
                    ? const Icon(
                        Icons.check,
                        size: 14,
                        color: DesignTokens.white,
                      )
                    : null,
              ),
              if (!isLast) Expanded(child: Container(width: 2, color: color)),
            ],
          ),
          const SizedBox(width: DesignTokens.spacingSm),
          Padding(
            padding: const EdgeInsets.only(bottom: DesignTokens.spacingMd),
            child: Text(
              step.label,
              style: DesignTokens.body2.copyWith(
                color: DesignTokens.textDark,
                fontWeight: state == _StepState.active
                    ? FontWeight.bold
                    : FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _OrderItemRow extends StatelessWidget {
  const _OrderItemRow({required this.line});

  final CartLine line;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            '${line.product.name} · ${formatQuantity(line.quantity)} '
            '${line.product.unit}',
            style: DesignTokens.body2,
          ),
        ),
        Text(
          formatSom(line.lineTotal),
          style: DesignTokens.caption.copyWith(color: DesignTokens.textGray),
        ),
      ],
    );
  }
}
