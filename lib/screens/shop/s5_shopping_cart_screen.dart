import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/design_tokens.dart';

/// S5: Shopping Cart
/// Review cart items and proceed to checkout
class S5ShoppingCartScreen extends ConsumerStatefulWidget {
  const S5ShoppingCartScreen({super.key});

  @override
  ConsumerState<S5ShoppingCartScreen> createState() =>
      _S5ShoppingCartScreenState();
}

class _S5ShoppingCartScreenState extends ConsumerState<S5ShoppingCartScreen> {
  bool _isCheckingOut = false;

  Future<void> _proceedCheckout() async {
    setState(() => _isCheckingOut = true);
    await Future.delayed(const Duration(milliseconds: 500));
    if (mounted) {
      context.go('/shop/s7');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Cart'),
        automaticallyImplyLeading: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(DesignTokens.spacing16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Cart items
                    Text(
                      'Cart Items (3)',
                      style: DesignTokens.subtitle1.copyWith(
                        color: DesignTokens.text,
                      ),
                    ),
                    const SizedBox(height: DesignTokens.spacing16),
                    _CartItem(
                      name: 'Premium Ceramic Tiles',
                      quantity: 2,
                      price: 850,
                      unit: 'm²',
                    ),
                    const SizedBox(height: DesignTokens.spacing12),
                    _CartItem(
                      name: 'Matte Wall Paint (1L)',
                      quantity: 5,
                      price: 180,
                      unit: 'L',
                    ),
                    const SizedBox(height: DesignTokens.spacing12),
                    _CartItem(
                      name: 'LED Ceiling Light 60W',
                      quantity: 3,
                      price: 45000,
                      unit: 'unit',
                    ),
                    const SizedBox(height: DesignTokens.spacing24),

                    // Order summary
                    Text(
                      'Order Summary',
                      style: DesignTokens.subtitle1.copyWith(
                        color: DesignTokens.text,
                      ),
                    ),
                    const SizedBox(height: DesignTokens.spacing12),
                    _SummaryRow(label: 'Subtotal', value: '366,900 UZS'),
                    const SizedBox(height: DesignTokens.spacing8),
                    _SummaryRow(label: 'Shipping', value: '15,000 UZS'),
                    const SizedBox(height: DesignTokens.spacing8),
                    _SummaryRow(
                      label: 'Discount (10%)',
                      value: '-36,690 UZS',
                      isDiscount: true,
                    ),
                    Divider(
                      height: DesignTokens.spacing20,
                      color: DesignTokens.border,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total',
                          style: DesignTokens.subtitle1.copyWith(
                            color: DesignTokens.text,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '345,210 UZS',
                          style: DesignTokens.heading3.copyWith(
                            color: DesignTokens.primaryBlue,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Checkout button
          Container(
            padding: const EdgeInsets.all(DesignTokens.spacing16),
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: DesignTokens.border)),
            ),
            child: ElevatedButton(
              onPressed: _isCheckingOut ? () {} : _proceedCheckout,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: DesignTokens.spacing12,
                ),
                child: _isCheckingOut
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Proceed to Checkout'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CartItem extends StatelessWidget {
  const _CartItem({
    required this.name,
    required this.quantity,
    required this.price,
    required this.unit,
  });

  final String name;
  final int quantity;
  final int price;
  final String unit;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(DesignTokens.spacing12),
      decoration: BoxDecoration(
        border: Border.all(color: DesignTokens.border),
        borderRadius: BorderRadius.circular(DesignTokens.radiusSm),
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: DesignTokens.primaryBlue.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(DesignTokens.radiusSm),
            ),
          ),
          const SizedBox(width: DesignTokens.spacing12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: DesignTokens.bodyMedium.copyWith(
                    color: DesignTokens.text,
                  ),
                ),
                const SizedBox(height: DesignTokens.spacing4),
                Text(
                  'Qty: $quantity $unit',
                  style: DesignTokens.caption.copyWith(
                    color: DesignTokens.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Text(
            '${price * quantity} UZS',
            style: DesignTokens.subtitle2.copyWith(
              color: DesignTokens.primaryBlue,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({
    required this.label,
    required this.value,
    this.isDiscount = false,
  });

  final String label;
  final String value;
  final bool isDiscount;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: DesignTokens.bodyMedium.copyWith(
            color: DesignTokens.textSecondary,
          ),
        ),
        Text(
          value,
          style: DesignTokens.bodyMedium.copyWith(
            color: isDiscount ? DesignTokens.success : DesignTokens.text,
            fontWeight: isDiscount ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
