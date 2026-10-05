import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/design_tokens.dart';
import '../../l10n/app_localizations.dart';
import '../../providers/electrical_provider.dart';
import '../../widgets/common/skeleton_loader.dart';
import '../../widgets/electrical/electrical_totals_card.dart';

/// D9: Elektr natijasi — quantities only, no prices anywhere (money
/// doesn't appear until E1, reached via D10).
class D9CostEstimateScreen extends ConsumerWidget {
  const D9CostEstimateScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final layout = ref.watch(electricalLayoutProvider);

    return Scaffold(
      backgroundColor: DesignTokens.backgroundLight,
      appBar: AppBar(
        backgroundColor: DesignTokens.backgroundLight,
        elevation: 0,
        title: Text(l10n.electricalResult, style: DesignTokens.heading3),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(DesignTokens.screenPaddingHorizontal),
          child: Column(
            children: [
              Expanded(
                child: layout == null
                    ? const _D9Skeleton()
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
                  child: Text(l10n.electricalFinish),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Mimics [ElectricalTotalsCard]'s shape — title, two stat tiles, a device
/// table with a few rows, and a row of summary chips — so the skeleton
/// doesn't reflow once the real totals arrive.
class _D9Skeleton extends StatelessWidget {
  const _D9Skeleton();

  @override
  Widget build(BuildContext context) {
    return SkeletonShimmer(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(DesignTokens.spacingMd),
        decoration: BoxDecoration(
          border: Border.all(color: DesignTokens.borderGray),
          borderRadius: BorderRadius.circular(DesignTokens.radiusLg),
          color: DesignTokens.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SkeletonBox(
              width: 140,
              height: 18,
              borderRadius: BorderRadius.circular(DesignTokens.radiusSm),
            ),
            const SizedBox(height: DesignTokens.spacingMd),
            Row(
              children: [
                Expanded(
                  child: SkeletonBox(
                    height: 72,
                    borderRadius: BorderRadius.circular(
                      DesignTokens.radiusMd,
                    ),
                  ),
                ),
                const SizedBox(width: DesignTokens.spacingMd),
                Expanded(
                  child: SkeletonBox(
                    height: 72,
                    borderRadius: BorderRadius.circular(
                      DesignTokens.radiusMd,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: DesignTokens.spacingMd),
            for (var i = 0; i < 4; i++) ...[
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: DesignTokens.spacingXs,
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: SkeletonBox(
                        height: 12,
                        borderRadius: BorderRadius.circular(
                          DesignTokens.radiusSm,
                        ),
                      ),
                    ),
                    const SizedBox(width: DesignTokens.spacingSm),
                    Expanded(
                      child: SkeletonBox(
                        height: 12,
                        borderRadius: BorderRadius.circular(
                          DesignTokens.radiusSm,
                        ),
                      ),
                    ),
                    const SizedBox(width: DesignTokens.spacingSm),
                    Expanded(
                      flex: 1,
                      child: SkeletonBox(
                        height: 12,
                        borderRadius: BorderRadius.circular(
                          DesignTokens.radiusSm,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
            const SizedBox(height: DesignTokens.spacingMd),
            Wrap(
              spacing: DesignTokens.spacingSm,
              runSpacing: DesignTokens.spacingSm,
              children: [
                SkeletonBox(
                  width: 110,
                  height: 24,
                  borderRadius: BorderRadius.circular(
                    DesignTokens.radiusFull,
                  ),
                ),
                SkeletonBox(
                  width: 110,
                  height: 24,
                  borderRadius: BorderRadius.circular(
                    DesignTokens.radiusFull,
                  ),
                ),
                SkeletonBox(
                  width: 130,
                  height: 24,
                  borderRadius: BorderRadius.circular(
                    DesignTokens.radiusFull,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
