import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/design_tokens.dart';
import '../../models/shop_model.dart';
import '../../providers/cart_provider.dart';
import '../../utils/currency.dart';

/// S5: Savat — items grouped by dealer (each block: dealer header, item
/// rows with quantity steppers, then that dealer's delivery fee), footer
/// with materials/delivery/grand total.
class S5ShoppingCartScreen extends ConsumerWidget {
  const S5ShoppingCartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final grouped = ref.watch(cartByDealerProvider);
    final lines = ref.watch(cartProvider);
    final materialsTotal = cartMaterialsTotal(lines);
    final deliveryTotal = grouped.keys.fold<int>(
      0,
      (sum, dealer) => sum + deliveryFeeFor(dealer),
    );
    final grandTotal = materialsTotal + deliveryTotal;

    return Scaffold(
      backgroundColor: DesignTokens.backgroundLight,
      appBar: AppBar(
        backgroundColor: DesignTokens.backgroundLight,
        elevation: 0,
        title: const Text('Savat', style: DesignTokens.heading3),
      ),
      body: lines.isEmpty
          ? Center(
              child: Text(
                'Savat bo\'sh',
                style: DesignTokens.body2.copyWith(
                  color: DesignTokens.textGray,
                ),
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(
                      DesignTokens.screenPaddingHorizontal,
                    ),
                    children: [
                      for (final entry in grouped.entries) ...[
                        _DealerBlock(
                          dealer: entry.key,
                          lines: entry.value,
                          onQuantityChanged: (line, qty) => ref
                              .read(cartProvider.notifier)
                              .updateQuantity(
                                line.product.id,
                                line.dealer.id,
                                qty,
                              ),
                          onRemove: (line) => ref
                              .read(cartProvider.notifier)
                              .remove(line.product.id, line.dealer.id),
                        ),
                        const SizedBox(height: DesignTokens.spacingMd),
                      ],
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(DesignTokens.spacingMd),
                  decoration: const BoxDecoration(
                    color: DesignTokens.white,
                    boxShadow: [DesignTokens.shadowNavBar],
                  ),
                  child: SafeArea(
                    top: false,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _SummaryRow(
                          label: 'Materiallar',
                          value: formatSom(materialsTotal),
                        ),
                        const SizedBox(height: DesignTokens.spacingXs),
                        _SummaryRow(
                          label: 'Yetkazish',
                          value: formatSom(deliveryTotal),
                        ),
                        const Divider(height: DesignTokens.spacingLg),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Umumiy summa', style: DesignTokens.subtitle1),
                            Text(
                              formatSom(grandTotal),
                              style: DesignTokens.heading3.copyWith(
                                color: DesignTokens.primaryBlue,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: DesignTokens.spacingMd),
                        SizedBox(
                          height: DesignTokens.buttonHeightLarge,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: DesignTokens.accentOrange,
                            ),
                            onPressed: () => context.push('/shop/s6'),
                            child: const Text('Buyurtmani rasmiylashtirish'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

class _DealerBlock extends StatelessWidget {
  const _DealerBlock({
    required this.dealer,
    required this.lines,
    required this.onQuantityChanged,
    required this.onRemove,
  });

  final Dealer dealer;
  final List<CartLine> lines;
  final void Function(CartLine line, double quantity) onQuantityChanged;
  final void Function(CartLine line) onRemove;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(DesignTokens.spacingMd),
      decoration: BoxDecoration(
        color: DesignTokens.white,
        borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
        border: Border.all(color: DesignTokens.borderGray),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Flexible(
                      child: Text(dealer.name, style: DesignTokens.subtitle2),
                    ),
                    if (dealer.isOfficial) ...[
                      const SizedBox(width: DesignTokens.spacingXs),
                      const Icon(
                        Icons.verified,
                        size: 14,
                        color: DesignTokens.primaryBlue,
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
          const Divider(height: DesignTokens.spacingLg),
          for (final line in lines) ...[
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(line.product.name, style: DesignTokens.body2),
                      Text(
                        formatSom(line.lineTotal),
                        style: DesignTokens.caption.copyWith(
                          color: DesignTokens.textGray,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.remove_circle_outline, size: 20),
                  onPressed: () => onQuantityChanged(line, line.quantity - 1),
                ),
                Text(formatQuantity(line.quantity), style: DesignTokens.body2),
                IconButton(
                  icon: const Icon(Icons.add_circle_outline, size: 20),
                  onPressed: () => onQuantityChanged(line, line.quantity + 1),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.close,
                    size: 18,
                    color: DesignTokens.textMuted,
                  ),
                  onPressed: () => onRemove(line),
                ),
              ],
            ),
          ],
          const SizedBox(height: DesignTokens.spacingXs),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Yetkazish',
                style: DesignTokens.caption.copyWith(
                  color: DesignTokens.textGray,
                ),
              ),
              Text(
                formatSom(deliveryFeeFor(dealer)),
                style: DesignTokens.caption.copyWith(
                  color: DesignTokens.textGray,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: DesignTokens.body2.copyWith(color: DesignTokens.textGray),
        ),
        Text(value, style: DesignTokens.body2),
      ],
    );
  }
}
