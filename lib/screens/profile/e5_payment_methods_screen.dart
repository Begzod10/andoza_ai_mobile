import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../config/design_tokens.dart';

/// E5: Payment Methods & Billing
/// Manage payment methods and billing information
class E5PaymentMethodsScreen extends ConsumerStatefulWidget {
  const E5PaymentMethodsScreen({super.key});

  @override
  ConsumerState<E5PaymentMethodsScreen> createState() =>
      _E5PaymentMethodsScreenState();
}

class _E5PaymentMethodsScreenState extends ConsumerState<E5PaymentMethodsScreen> {
  String _selectedPayment = 'card1';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Methods'),
        automaticallyImplyLeading: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Saved cards
            Padding(
              padding: const EdgeInsets.all(DesignTokens.spacing16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Saved Cards',
                    style: DesignTokens.subtitle1.copyWith(
                      color: DesignTokens.text,
                    ),
                  ),
                  const SizedBox(height: DesignTokens.spacing12),
                  _PaymentCard(
                    cardName: 'Visa Card',
                    cardNumber: '**** **** **** 4242',
                    expiry: '12/26',
                    isSelected: _selectedPayment == 'card1',
                    onSelect: () => setState(() => _selectedPayment = 'card1'),
                    onDelete: () {},
                  ),
                  const SizedBox(height: DesignTokens.spacing12),
                  _PaymentCard(
                    cardName: 'Mastercard',
                    cardNumber: '**** **** **** 5555',
                    expiry: '08/25',
                    isSelected: _selectedPayment == 'card2',
                    onSelect: () => setState(() => _selectedPayment = 'card2'),
                    onDelete: () {},
                  ),
                ],
              ),
            ),

            // Add new payment
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: DesignTokens.spacing16,
              ),
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.add),
                label: const Text('Add New Card'),
              ),
            ),
            const SizedBox(height: DesignTokens.spacing32),

            // Billing history
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: DesignTokens.spacing16,
              ),
              child: Text(
                'Billing History',
                style: DesignTokens.subtitle1.copyWith(
                  color: DesignTokens.text,
                ),
              ),
            ),
            const SizedBox(height: DesignTokens.spacing12),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: DesignTokens.spacing16,
              ),
              child: Column(
                children: [
                  _BillingItem(
                    date: 'July 15, 2026',
                    amount: '345,210 UZS',
                    status: 'Paid',
                    onTap: () {},
                  ),
                  const SizedBox(height: DesignTokens.spacing12),
                  _BillingItem(
                    date: 'June 20, 2026',
                    amount: '280,000 UZS',
                    status: 'Paid',
                    onTap: () {},
                  ),
                  const SizedBox(height: DesignTokens.spacing12),
                  _BillingItem(
                    date: 'May 10, 2026',
                    amount: '420,500 UZS',
                    status: 'Paid',
                    onTap: () {},
                  ),
                ],
              ),
            ),
            const SizedBox(height: DesignTokens.spacing32),

            // Billing preferences
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: DesignTokens.spacing16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Billing Preferences',
                    style: DesignTokens.subtitle1.copyWith(
                      color: DesignTokens.text,
                    ),
                  ),
                  const SizedBox(height: DesignTokens.spacing12),
                  Container(
                    padding: const EdgeInsets.all(DesignTokens.spacing12),
                    decoration: BoxDecoration(
                      border: Border.all(color: DesignTokens.border),
                      borderRadius:
                          BorderRadius.circular(DesignTokens.radiusMd),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Checkbox(value: true, onChanged: null),
                            const SizedBox(width: DesignTokens.spacing8),
                            Expanded(
                              child: Text(
                                'Send invoice emails',
                                style: DesignTokens.bodyMedium.copyWith(
                                  color: DesignTokens.text,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: DesignTokens.spacing12),
                        Row(
                          children: [
                            Checkbox(value: true, onChanged: null),
                            const SizedBox(width: DesignTokens.spacing8),
                            Expanded(
                              child: Text(
                                'Auto-pay with selected card',
                                style: DesignTokens.bodyMedium.copyWith(
                                  color: DesignTokens.text,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: DesignTokens.spacing32),
          ],
        ),
      ),
    );
  }
}

class _PaymentCard extends StatelessWidget {
  const _PaymentCard({
    required this.cardName,
    required this.cardNumber,
    required this.expiry,
    required this.isSelected,
    required this.onSelect,
    required this.onDelete,
  });

  final String cardName;
  final String cardNumber;
  final String expiry;
  final bool isSelected;
  final VoidCallback onSelect;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onSelect,
      child: Container(
        padding: const EdgeInsets.all(DesignTokens.spacing12),
        decoration: BoxDecoration(
          border: Border.all(
            color:
                isSelected ? DesignTokens.primaryBlue : DesignTokens.border,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
          color: isSelected
              ? DesignTokens.primaryBlue.withValues(alpha: 0.05)
              : DesignTokens.surface,
        ),
        child: Row(
          children: [
            Radio(
              value: cardName,
              groupValue: isSelected ? cardName : '',
              onChanged: null,
            ),
            const SizedBox(width: DesignTokens.spacing8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cardName,
                    style: DesignTokens.subtitle2.copyWith(
                      color: DesignTokens.text,
                    ),
                  ),
                  const SizedBox(height: DesignTokens.spacing4),
                  Text(
                    '$cardNumber • Exp: $expiry',
                    style: DesignTokens.caption.copyWith(
                      color: DesignTokens.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}

class _BillingItem extends StatelessWidget {
  const _BillingItem({
    required this.date,
    required this.amount,
    required this.status,
    required this.onTap,
  });

  final String date;
  final String amount;
  final String status;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(DesignTokens.spacing12),
        decoration: BoxDecoration(
          border: Border.all(color: DesignTokens.border),
          borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  date,
                  style: DesignTokens.subtitle2.copyWith(
                    color: DesignTokens.text,
                  ),
                ),
                const SizedBox(height: DesignTokens.spacing4),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: DesignTokens.spacing8,
                    vertical: DesignTokens.spacing4,
                  ),
                  decoration: BoxDecoration(
                    color: DesignTokens.success.withValues(alpha: 0.1),
                    borderRadius:
                        BorderRadius.circular(DesignTokens.radiusSm),
                  ),
                  child: Text(
                    status,
                    style: DesignTokens.caption.copyWith(
                      color: DesignTokens.success,
                    ),
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  amount,
                  style: DesignTokens.subtitle2.copyWith(
                    color: DesignTokens.primaryBlue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: DesignTokens.spacing4),
                Icon(
                  Icons.receipt_outlined,
                  size: 16,
                  color: DesignTokens.textSecondary,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
