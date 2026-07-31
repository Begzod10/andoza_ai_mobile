import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../config/design_tokens.dart';
import '../../providers/estimate_provider.dart';
import '../../providers/masters_provider.dart';
import '../../utils/currency.dart';

/// U5: send-smeta sheet — "Loyihangizni [ism]ga yuborasizmi?" The
/// project-summary figure is the real [estimateProvider] total (backfilled
/// from Step 6's placeholder once Step 11's pricing layer landed).
class U5BookingConfirmationScreen extends ConsumerStatefulWidget {
  const U5BookingConfirmationScreen({this.master, super.key});

  final MockMaster? master;

  @override
  ConsumerState<U5BookingConfirmationScreen> createState() =>
      _U5BookingConfirmationScreenState();
}

class _U5BookingConfirmationScreenState
    extends ConsumerState<U5BookingConfirmationScreen> {
  final _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final m = widget.master ?? ref.watch(mockMastersProvider).first;
    final estimate = ref.watch(estimateProvider);

    return Scaffold(
      backgroundColor: DesignTokens.backgroundLight,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(DesignTokens.screenPaddingHorizontal),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Loyihangizni ${m.master.name.split(' ').first} akaga yuborasizmi?',
                style: DesignTokens.heading3,
              ),
              const SizedBox(height: DesignTokens.spacingLg),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(DesignTokens.spacingMd),
                decoration: BoxDecoration(
                  color: DesignTokens.white,
                  borderRadius: BorderRadius.circular(DesignTokens.radiusLg),
                  border: Border.all(color: DesignTokens.borderGray),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Mehmonxona ta\'miri', style: DesignTokens.subtitle2),
                    const SizedBox(height: DesignTokens.spacingXs),
                    Text(
                      '${estimate.roomArea.toStringAsFixed(1)} m² · '
                      '${formatSom(estimate.totalPrice.round())}',
                      style: DesignTokens.body2.copyWith(
                        color: DesignTokens.textGray,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: DesignTokens.spacingLg),
              TextField(
                controller: _commentController,
                maxLines: 3,
                decoration: const InputDecoration(
                  hintText: 'Izoh (ixtiyoriy)',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: DesignTokens.spacingSm),
              Text(
                'Usta smetani ko\'rib, o\'z narxini taklif qiladi',
                style: DesignTokens.caption.copyWith(
                  color: DesignTokens.textGray,
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: DesignTokens.buttonHeightLarge,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: DesignTokens.accentOrange,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Smeta yuborildi')),
                    );
                  },
                  child: const Text('Yuborish'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
