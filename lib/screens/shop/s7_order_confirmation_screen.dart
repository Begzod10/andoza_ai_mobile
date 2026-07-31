import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/design_tokens.dart';

/// S7: Order Confirmation
/// Order placed successfully with tracking and details
class S7OrderConfirmationScreen extends ConsumerWidget {
  const S7OrderConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Confirmed'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(DesignTokens.spacing24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Success animation
              Center(
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: DesignTokens.success.withValues(alpha: 0.1),
                  ),
                  child: Icon(
                    Icons.check_circle,
                    size: 80,
                    color: DesignTokens.success,
                  ),
                ),
              ),
              const SizedBox(height: DesignTokens.spacing24),

              // Success message
              Text(
                'Order Placed Successfully!',
                style: DesignTokens.heading3.copyWith(
                  color: DesignTokens.text,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: DesignTokens.spacing12),
              Text(
                'Your order has been confirmed. You can track it using the order ID below.',
                style: DesignTokens.bodyMedium.copyWith(
                  color: DesignTokens.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: DesignTokens.spacing32),

              // Order details
              Container(
                padding: const EdgeInsets.all(DesignTokens.spacing16),
                decoration: BoxDecoration(
                  border: Border.all(color: DesignTokens.border),
                  borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Order Details',
                      style: DesignTokens.subtitle1.copyWith(
                        color: DesignTokens.text,
                      ),
                    ),
                    const SizedBox(height: DesignTokens.spacing16),
                    _DetailRow(
                      label: 'Order ID',
                      value: 'ORD-2026-345210',
                    ),
                    const SizedBox(height: DesignTokens.spacing12),
                    _DetailRow(
                      label: 'Order Date',
                      value: 'July 30, 2026',
                    ),
                    const SizedBox(height: DesignTokens.spacing12),
                    _DetailRow(
                      label: 'Total Amount',
                      value: '345,210 UZS',
                    ),
                    const SizedBox(height: DesignTokens.spacing12),
                    _DetailRow(
                      label: 'Estimated Delivery',
                      value: '3-5 business days',
                    ),
                    const SizedBox(height: DesignTokens.spacing12),
                    _DetailRow(
                      label: 'Status',
                      value: 'Processing',
                      isStatus: true,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: DesignTokens.spacing32),

              // Delivery address
              Container(
                padding: const EdgeInsets.all(DesignTokens.spacing16),
                decoration: BoxDecoration(
                  border: Border.all(color: DesignTokens.border),
                  borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Delivery Address',
                      style: DesignTokens.subtitle1.copyWith(
                        color: DesignTokens.text,
                      ),
                    ),
                    const SizedBox(height: DesignTokens.spacing12),
                    Text(
                      'Tashkent Region\n42 Main Street, Apt 5\n100000, Tashkent\nUzbekistan',
                      style: DesignTokens.bodyMedium.copyWith(
                        color: DesignTokens.textSecondary,
                        height: 1.6,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: DesignTokens.spacing32),

              // Order items
              Text(
                'Items (3)',
                style: DesignTokens.subtitle1.copyWith(
                  color: DesignTokens.text,
                ),
              ),
              const SizedBox(height: DesignTokens.spacing12),
              _OrderItem(name: 'Premium Ceramic Tiles', qty: '2 m²'),
              const SizedBox(height: DesignTokens.spacing8),
              _OrderItem(name: 'Matte Wall Paint (1L)', qty: '5 L'),
              const SizedBox(height: DesignTokens.spacing8),
              _OrderItem(name: 'LED Ceiling Light 60W', qty: '3 unit'),
              const SizedBox(height: DesignTokens.spacing32),

              // Next steps
              Container(
                padding: const EdgeInsets.all(DesignTokens.spacing16),
                decoration: BoxDecoration(
                  color: DesignTokens.primaryBlue.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
                  border: Border.all(
                    color: DesignTokens.primaryBlue.withValues(alpha: 0.2),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'What\'s Next?',
                      style: DesignTokens.subtitle2.copyWith(
                        color: DesignTokens.text,
                      ),
                    ),
                    const SizedBox(height: DesignTokens.spacing8),
                    Text(
                      '1. You will receive a confirmation email shortly\n'
                      '2. Track your order using ID: ORD-2026-345210\n'
                      '3. Driver will contact before delivery\n'
                      '4. Inspect items upon receipt',
                      style: DesignTokens.caption.copyWith(
                        color: DesignTokens.textSecondary,
                        height: 1.6,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: DesignTokens.spacing32),

              // Action buttons
              ElevatedButton.icon(
                onPressed: () => context.go('/shop/s1'),
                icon: const Icon(Icons.shopping_bag_outlined),
                label: const Text('Continue Shopping'),
              ),
              const SizedBox(height: DesignTokens.spacing12),
              OutlinedButton.icon(
                onPressed: () => context.go('/'),
                icon: const Icon(Icons.home_outlined),
                label: const Text('Back to Home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({
    required this.label,
    required this.value,
    this.isStatus = false,
  });

  final String label;
  final String value;
  final bool isStatus;

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
        if (isStatus)
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: DesignTokens.spacing8,
              vertical: DesignTokens.spacing4,
            ),
            decoration: BoxDecoration(
              color: DesignTokens.success.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(DesignTokens.radiusSm),
              border: Border.all(
                color: DesignTokens.success.withValues(alpha: 0.3),
              ),
            ),
            child: Text(
              value,
              style: DesignTokens.caption.copyWith(
                color: DesignTokens.success,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        else
          Text(
            value,
            style: DesignTokens.subtitle2.copyWith(
              color: DesignTokens.text,
              fontWeight: FontWeight.w600,
            ),
          ),
      ],
    );
  }
}

class _OrderItem extends StatelessWidget {
  const _OrderItem({
    required this.name,
    required this.qty,
  });

  final String name;
  final String qty;

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
            width: 50,
            height: 50,
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
                  qty,
                  style: DesignTokens.caption.copyWith(
                    color: DesignTokens.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.check_circle_outlined,
            color: DesignTokens.success,
            size: 20,
          ),
        ],
      ),
    );
  }
}
