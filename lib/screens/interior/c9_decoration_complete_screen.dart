import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/design_tokens.dart';
import '../../models/design_selection_model.dart';
import '../../providers/design_provider.dart';

/// C9: Bezash yakunlandi — decoration complete, hands off to Batch D
/// (electrical), which is always last per the spec's ordering rule.
class C9DecorationCompleteScreen extends ConsumerWidget {
  const C9DecorationCompleteScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: DesignTokens.backgroundLight,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(DesignTokens.screenPaddingHorizontal),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 88,
                height: 88,
                decoration: const BoxDecoration(
                  color: DesignTokens.successGreen,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check,
                  color: DesignTokens.white,
                  size: 44,
                ),
              ),
              const SizedBox(height: DesignTokens.spacingLg),
              const Text(
                'Bezash yakunlandi',
                style: DesignTokens.heading2,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: DesignTokens.spacingXxl),
              SizedBox(
                width: double.infinity,
                height: DesignTokens.buttonHeightLarge,
                child: ElevatedButton(
                  onPressed: () {
                    ref
                        .read(activeDesignProvider.notifier)
                        .setRenovationStageLocal(RenovationStage.elektr);
                    context.push('/electrical/d1');
                  },
                  child: const Text('Elektrga o\'tish →'),
                ),
              ),
              const SizedBox(height: DesignTokens.spacingMd),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => context.go('/design/b2'),
                  child: const Text('3D\'ga qaytish'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
