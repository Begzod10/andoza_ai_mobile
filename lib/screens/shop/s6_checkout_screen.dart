import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/design_tokens.dart';
import '../../models/api/api.dart';
import '../../models/shop_model.dart';
import '../../providers/cart_provider.dart';
import '../../providers/orders_provider.dart';
import '../../utils/currency.dart';

/// Matches a canonical UUID — used to decide whether a cart product's id is a
/// real backend material UUID (send as `material_id`) or a local/synthetic
/// slug (send null).
final _uuidRe = RegExp(
  r'^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$',
);

enum _PaymentMethod { payme, click, uzum, cash }

extension on _PaymentMethod {
  String get label => switch (this) {
    _PaymentMethod.payme => 'Payme',
    _PaymentMethod.click => 'Click',
    _PaymentMethod.uzum => 'Uzum Bank',
    _PaymentMethod.cash => 'Naqd (yetkazishda)',
  };

  IconData get icon => switch (this) {
    _PaymentMethod.payme => Icons.account_balance_wallet_outlined,
    _PaymentMethod.click => Icons.touch_app_outlined,
    _PaymentMethod.uzum => Icons.credit_card_outlined,
    _PaymentMethod.cash => Icons.payments_outlined,
  };
}

/// S6: To'lov — delivery address, phone, in-app payment method tiles
/// (Payme/Click/Uzum/Naqd — never an external redirect), order summary,
/// sticky "To'lash" total. No card numbers or payment credentials are
/// collected here — method selection only, per the mock-payment scope of
/// this rebuild pass.
class S6CheckoutScreen extends ConsumerStatefulWidget {
  const S6CheckoutScreen({super.key});

  @override
  ConsumerState<S6CheckoutScreen> createState() => _S6CheckoutScreenState();
}

class _S6CheckoutScreenState extends ConsumerState<S6CheckoutScreen> {
  final _addressController = TextEditingController(
    text: 'Toshkent sh., Chilonzor tumani',
  );
  final _phoneController = TextEditingController();
  _PaymentMethod _method = _PaymentMethod.payme;
  bool _isPlacing = false;

  @override
  void dispose() {
    _addressController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _placeOrder(int total, List<CartLine> lines) async {
    setState(() => _isPlacing = true);
    await Future.delayed(const Duration(milliseconds: 500));
    if (!mounted) return;
    final dealerName = lines.isEmpty ? '—' : lines.first.dealer.name;
    final order = ShopOrder(
      id: 'ORD-${lines.length}${total % 10000}',
      lines: lines,
      total: total,
      currentStep: OrderStep.accepted,
      dealerName: dealerName,
      createdAt: DateTime.now(),
    );
    ref.read(cartProvider.notifier).clear();
    ref.read(ordersProvider.notifier).add(order);
    // Best-effort server persistence — never blocks the user; S7 shows the
    // local optimistic order regardless of whether the POST succeeds.
    unawaited(_persistOrder(order.id, dealerName, lines));
    context.push('/shop/s7', extra: order);
  }

  /// POSTs the placed order to `/orders`, then invalidates the server list so
  /// E6/Profile refetch the authoritative history. Failures are surfaced via
  /// a snackbar only — the user's flow is not interrupted.
  Future<void> _persistOrder(
    String localId,
    String dealerName,
    List<CartLine> lines,
  ) async {
    try {
      await ref.read(ordersRepositoryProvider).createOrder(
        dealerName: dealerName,
        lines: [
          for (final line in lines)
            OrderLineCreate(
              materialId: _uuidRe.hasMatch(line.product.id)
                  ? line.product.id
                  : null,
              productName: line.product.name,
              unit: line.product.unit,
              unitPriceUzs: line.product.pricePerUnit,
              quantity: line.quantity,
            ),
        ],
      );
      // Server now owns this order — drop the local optimistic copy so the
      // merged history doesn't list it twice (local id vs server UUID).
      ref.read(ordersProvider.notifier).remove(localId);
      ref.invalidate(serverOrdersProvider);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Buyurtmani serverga saqlashda xatolik: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final lines = ref.watch(cartProvider);
    final grouped = ref.watch(cartByDealerProvider);
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
        title: Text('To\'lov', style: DesignTokens.heading3),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(
                DesignTokens.screenPaddingHorizontal,
              ),
              children: [
                Text('Yetkazish manzili', style: DesignTokens.subtitle2),
                const SizedBox(height: DesignTokens.spacingSm),
                Container(
                  height: 100,
                  decoration: BoxDecoration(
                    color: DesignTokens.borderGrayAlt,
                    borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.map_outlined,
                      color: DesignTokens.textMuted,
                      size: DesignTokens.iconXl,
                    ),
                  ),
                ),
                const SizedBox(height: DesignTokens.spacingSm),
                TextField(
                  controller: _addressController,
                  decoration: const InputDecoration(hintText: 'Manzil'),
                ),
                const SizedBox(height: DesignTokens.spacingSm),
                TextField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(hintText: 'Telefon raqami'),
                ),
                const SizedBox(height: DesignTokens.spacingLg),
                Text('To\'lov usuli', style: DesignTokens.subtitle2),
                const SizedBox(height: DesignTokens.spacingSm),
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  mainAxisSpacing: DesignTokens.spacingSm,
                  crossAxisSpacing: DesignTokens.spacingSm,
                  childAspectRatio: 2.4,
                  children: [
                    for (final method in _PaymentMethod.values)
                      _PaymentTile(
                        method: method,
                        selected: _method == method,
                        onTap: () => setState(() => _method = method),
                      ),
                  ],
                ),
                const SizedBox(height: DesignTokens.spacingLg),
                Text('Buyurtma xulosasi', style: DesignTokens.subtitle2),
                const SizedBox(height: DesignTokens.spacingSm),
                Container(
                  padding: const EdgeInsets.all(DesignTokens.spacingMd),
                  decoration: BoxDecoration(
                    color: DesignTokens.white,
                    borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
                    border: Border.all(color: DesignTokens.borderGray),
                  ),
                  child: Column(
                    children: [
                      _Row(
                        label: 'Materiallar',
                        value: formatSom(materialsTotal),
                      ),
                      const SizedBox(height: DesignTokens.spacingXs),
                      _Row(label: 'Yetkazish', value: formatSom(deliveryTotal)),
                    ],
                  ),
                ),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('To\'lanadi', style: DesignTokens.subtitle1),
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
                      onPressed: _isPlacing || lines.isEmpty
                          ? null
                          : () => _placeOrder(grandTotal, lines),
                      child: _isPlacing
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: DesignTokens.white,
                              ),
                            )
                          : const Text('To\'lash'),
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

class _PaymentTile extends StatelessWidget {
  const _PaymentTile({
    required this.method,
    required this.selected,
    required this.onTap,
  });

  final _PaymentMethod method;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: DesignTokens.spacingSm),
        decoration: BoxDecoration(
          color: selected
              ? DesignTokens.primaryBlue.withValues(alpha: 0.08)
              : DesignTokens.white,
          borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
          border: Border.all(
            color: selected
                ? DesignTokens.primaryBlue
                : DesignTokens.borderGray,
            width: selected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              method.icon,
              color: selected
                  ? DesignTokens.primaryBlue
                  : DesignTokens.textGray,
            ),
            const SizedBox(width: DesignTokens.spacingSm),
            Expanded(
              child: Text(
                method.label,
                style: DesignTokens.caption.copyWith(
                  color: selected
                      ? DesignTokens.primaryBlue
                      : DesignTokens.textDark,
                  fontWeight: selected ? FontWeight.bold : FontWeight.normal,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Row extends StatelessWidget {
  const _Row({required this.label, required this.value});

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
