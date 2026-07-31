import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/design_tokens.dart';
import '../../providers/cart_provider.dart';
import '../../providers/shop_provider.dart';
import '../../utils/currency.dart';

/// S2: Loyiha materiallari — the screen where the app's intelligence
/// shows: a green banner stating the app computed everything from the
/// project's real state, then the required materials grouped by
/// renovation stage (never a stage the room's starting condition already
/// excludes).
class S2ProjectMaterialsScreen extends ConsumerWidget {
  const S2ProjectMaterialsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groups = ref.watch(projectMaterialsProvider);
    final (area, stageCount) = ref.watch(projectMaterialsSummaryProvider);
    final catalog = ref.watch(shopCatalogProvider);

    return Scaffold(
      backgroundColor: DesignTokens.backgroundLight,
      appBar: AppBar(
        backgroundColor: DesignTokens.backgroundLight,
        elevation: 0,
        title: Text('Loyiha materiallari', style: DesignTokens.heading3),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(
                DesignTokens.screenPaddingHorizontal,
              ),
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(DesignTokens.spacingMd),
                  decoration: BoxDecoration(
                    color: DesignTokens.successGreen.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
                    border: Border.all(
                      color: DesignTokens.successGreen.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.auto_awesome,
                        color: DesignTokens.successGreen,
                      ),
                      const SizedBox(width: DesignTokens.spacingSm),
                      Expanded(
                        child: Text(
                          'App loyihangiz asosida avtomatik hisobladi — '
                          '${area.toStringAsFixed(1)} m², $stageCount bosqich',
                          style: DesignTokens.body2.copyWith(
                            color: DesignTokens.textDark,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: DesignTokens.spacingLg),
                for (final group in groups) ...[
                  Text(group.stageLabel, style: DesignTokens.subtitle1),
                  const SizedBox(height: DesignTokens.spacingSm),
                  for (final item in group.items) ...[
                    _MaterialRow(
                      name: item.name,
                      quantity: formatQuantity(item.quantity),
                      unit: item.unit,
                    ),
                    const SizedBox(height: DesignTokens.spacingSm),
                  ],
                  const SizedBox(height: DesignTokens.spacingMd),
                ],
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(DesignTokens.spacingMd),
            decoration: BoxDecoration(
              color: DesignTokens.white,
              boxShadow: [DesignTokens.shadowNavBar],
            ),
            child: SafeArea(
              top: false,
              child: SizedBox(
                width: double.infinity,
                height: DesignTokens.buttonHeightLarge,
                child: ElevatedButton(
                  onPressed: () {
                    final cart = ref.read(cartProvider.notifier);
                    for (final group in groups) {
                      for (final item in group.items) {
                        final product = catalog
                            .where((p) => p.name == item.name)
                            .firstOrNull;
                        if (product == null) continue;
                        final dealer = bestDealer(dealersForProduct(product));
                        cart.add(product, dealer, quantity: item.quantity);
                      }
                    }
                    context.push('/shop/s5');
                  },
                  child: const Text('Hammasini savatga'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MaterialRow extends StatelessWidget {
  const _MaterialRow({
    required this.name,
    required this.quantity,
    required this.unit,
  });

  final String name;
  final String quantity;
  final String unit;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(DesignTokens.spacingMd),
      decoration: BoxDecoration(
        color: DesignTokens.white,
        borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
        border: Border.all(color: DesignTokens.borderGray),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              name,
              style: DesignTokens.body2.copyWith(color: DesignTokens.textDark),
            ),
          ),
          Text(
            '$quantity $unit',
            style: DesignTokens.subtitle2.copyWith(
              color: DesignTokens.primaryBlue,
            ),
          ),
        ],
      ),
    );
  }
}
