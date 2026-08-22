import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/design_tokens.dart';
import '../../providers/electrical_provider.dart';
import '../../widgets/electrical/electrical_totals_card.dart';

/// D9: Elektr natijasi — quantities only, no prices anywhere (money
/// doesn't appear until E1, reached via D10).
class D9CostEstimateScreen extends ConsumerWidget {
  const D9CostEstimateScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final layout = ref.watch(electricalLayoutProvider);

    return Scaffold(
      backgroundColor: DesignTokens.backgroundLight,
      appBar: AppBar(
        backgroundColor: DesignTokens.backgroundLight,
        elevation: 0,
        title: const Text('Elektr natijasi', style: DesignTokens.heading3),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(DesignTokens.screenPaddingHorizontal),
          child: Column(
            children: [
              Expanded(
                child: layout == null
                    ? const Center(child: CircularProgressIndicator())
                    : SingleChildScrollView(
                        child: ElectricalTotalsCard(layout: layout),
                      ),
              ),
              const SizedBox(height: DesignTokens.spacingMd),
              SizedBox(
                width: double.infinity,
                height: DesignTokens.buttonHeightLarge,
                child: ElevatedButton(
                  onPressed: () => context.push('/electrical/d10'),
                  child: const Text('Yakunlash →'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
