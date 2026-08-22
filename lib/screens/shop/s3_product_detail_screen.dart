import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/design_tokens.dart';
import '../../models/shop_model.dart';
import '../../providers/cart_provider.dart';
import '../../providers/shop_provider.dart';
import '../../utils/currency.dart';

/// S3: Mahsulot kartasi — product detail with a blue recommendation card
/// showing the real computed project quantity (never a hardcoded guess)
/// when this product is tied to the active project's needs.
class S3ProductDetailScreen extends ConsumerStatefulWidget {
  const S3ProductDetailScreen({required this.product, super.key});

  final Product product;

  @override
  ConsumerState<S3ProductDetailScreen> createState() =>
      _S3ProductDetailScreenState();
}

class _S3ProductDetailScreenState extends ConsumerState<S3ProductDetailScreen> {
  late double _quantity = widget.product.projectQuantity ?? 1;

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    final defaultDealer = bestDealer(dealersForProduct(product));

    return Scaffold(
      backgroundColor: DesignTokens.backgroundLight,
      appBar: AppBar(
        backgroundColor: DesignTokens.backgroundLight,
        elevation: 0,
        title: Text(product.name, style: DesignTokens.subtitle1),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(
                DesignTokens.screenPaddingHorizontal,
              ),
              children: [
                AspectRatio(
                  aspectRatio: 1.4,
                  child: Builder(
                    builder: (context) {
                      final placeholder = Container(
                        decoration: BoxDecoration(
                          color: DesignTokens.borderGrayAlt,
                          borderRadius: BorderRadius.circular(
                            DesignTokens.radiusLg,
                          ),
                        ),
                        child: const Icon(
                          Icons.image_outlined,
                          size: DesignTokens.iconXxl,
                          color: DesignTokens.textMuted,
                        ),
                      );
                      final url = product.imageUrl;
                      if (url == null) return placeholder;
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(
                          DesignTokens.radiusLg,
                        ),
                        child: Image.network(
                          url,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                          loadingBuilder: (context, child, progress) =>
                              progress == null ? child : placeholder,
                          errorBuilder: (context, error, stack) => placeholder,
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: DesignTokens.spacingMd),
                if (product.isOfficialDealer)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: DesignTokens.spacingSm,
                      vertical: DesignTokens.spacingXs,
                    ),
                    decoration: BoxDecoration(
                      color: DesignTokens.successGreen.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(
                        DesignTokens.radiusSm,
                      ),
                    ),
                    child: Text(
                      '✓ Rasmiy diler',
                      style: DesignTokens.caption.copyWith(
                        color: DesignTokens.successGreen,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                const SizedBox(height: DesignTokens.spacingXs),
                Text(product.brand, style: DesignTokens.body2),
                Text(product.name, style: DesignTokens.heading3),
                const SizedBox(height: DesignTokens.spacingXs),
                Text(
                  '${formatSom(product.pricePerUnit)} / ${product.unit}',
                  style: DesignTokens.subtitle1.copyWith(
                    color: DesignTokens.primaryBlue,
                  ),
                ),
                if (product.isInProject) ...[
                  const SizedBox(height: DesignTokens.spacingMd),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(DesignTokens.spacingMd),
                    decoration: BoxDecoration(
                      color: DesignTokens.primaryBlue.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(
                        DesignTokens.radiusMd,
                      ),
                      border: Border.all(
                        color: DesignTokens.primaryBlue.withValues(alpha: 0.25),
                      ),
                    ),
                    child: Text(
                      'Loyihangiz uchun ~${formatQuantity(product.projectQuantity!)} '
                      '${product.unit} kerak'
                      '${product.coverage != null ? ' — ${product.coverage}' : ''}',
                      style: DesignTokens.body2.copyWith(
                        color: DesignTokens.primaryBlue,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
                const SizedBox(height: DesignTokens.spacingLg),
                Row(
                  children: [
                    const Text('Miqdor:', style: DesignTokens.body2),
                    const Spacer(),
                    _QtyButton(
                      icon: Icons.remove,
                      onTap: () => setState(
                        () => _quantity = (_quantity - 1).clamp(1, 9999),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: DesignTokens.spacingMd,
                      ),
                      child: Text(
                        '${formatQuantity(_quantity)} ${product.unit}',
                        style: DesignTokens.subtitle2,
                      ),
                    ),
                    _QtyButton(
                      icon: Icons.add,
                      onTap: () => setState(() => _quantity += 1),
                    ),
                  ],
                ),
                const SizedBox(height: DesignTokens.spacingLg),
                if (product.coverage != null)
                  _SpecRow(label: 'Qoplama', value: product.coverage!),
                if (product.dryingTime != null)
                  _SpecRow(label: 'Quriish vaqti', value: product.dryingTime!),
                if (product.washable != null)
                  _SpecRow(
                    label: 'Yuvilishi',
                    value: product.washable! ? 'Ha' : 'Yo\'q',
                  ),
                const SizedBox(height: DesignTokens.spacingLg),
                InkWell(
                  onTap: () => context.push('/shop/s4', extra: product),
                  borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
                  child: Container(
                    padding: const EdgeInsets.all(DesignTokens.spacingMd),
                    decoration: BoxDecoration(
                      color: DesignTokens.white,
                      borderRadius: BorderRadius.circular(
                        DesignTokens.radiusMd,
                      ),
                      border: Border.all(color: DesignTokens.borderGray),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.storefront_outlined,
                          color: DesignTokens.primaryBlue,
                        ),
                        const SizedBox(width: DesignTokens.spacingSm),
                        Expanded(
                          child: Text(
                            'Qayerdan olish — ${defaultDealer.name}',
                            style: DesignTokens.body2,
                          ),
                        ),
                        const Icon(
                          Icons.chevron_right,
                          color: DesignTokens.textMuted,
                        ),
                      ],
                    ),
                  ),
                ),
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
              child: SizedBox(
                width: double.infinity,
                height: DesignTokens.buttonHeightLarge,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: DesignTokens.accentOrange,
                  ),
                  onPressed: () {
                    ref
                        .read(cartProvider.notifier)
                        .add(product, defaultDealer, quantity: _quantity);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Savatga qo\'shildi')),
                    );
                  },
                  child: Text(
                    'Savatga qo\'shish · '
                    '${formatSom((defaultDealer.pricePerUnit * _quantity).round())}',
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _QtyButton extends StatelessWidget {
  const _QtyButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(DesignTokens.radiusSm),
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: DesignTokens.borderGrayAlt,
          borderRadius: BorderRadius.circular(DesignTokens.radiusSm),
        ),
        child: Icon(icon, size: DesignTokens.iconSm),
      ),
    );
  }
}

class _SpecRow extends StatelessWidget {
  const _SpecRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: DesignTokens.spacingXs),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: DesignTokens.body2.copyWith(color: DesignTokens.textGray),
          ),
          Text(value, style: DesignTokens.body2),
        ],
      ),
    );
  }
}
