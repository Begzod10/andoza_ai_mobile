import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/design_tokens.dart';
import '../../models/design_selection_model.dart';
import '../../models/estimate_model.dart';
import '../../providers/estimate_provider.dart';
import '../../providers/room_provider.dart';
import '../../utils/currency.dart';

const _stageLabels = {
  RenovationStage.suvoq: 'Suvoq',
  RenovationStage.shpaklovka: 'Shpaklovka',
  RenovationStage.boyoqOboi: 'Bo\'yoq/Oboi',
  RenovationStage.pol: 'Pol',
  RenovationStage.mebel: 'Mebel',
  RenovationStage.elektr: 'Elektr montaj',
  RenovationStage.yoruglik: 'Yorug\'lik',
  RenovationStage.santexnika: 'Santexnika',
};

/// E1: Remont smetasi — money appears for the first time here. Big blue
/// total card (Materiallar/Ishchi kuchi split), a green delta-savings
/// banner computed from actually-excluded stages (never hardcoded), and
/// a stage list where excluded stages render gray/struck-through/
/// "hisoblanmadi" — all driven by the real [estimateProvider].
class E1EstimationIntroScreen extends ConsumerWidget {
  const E1EstimationIntroScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final estimate = ref.watch(estimateProvider);
    final room = ref.watch(activeRoomProvider);
    final materials = estimateMaterialsTotal(estimate);
    final labor = estimateLaborTotal(estimate);
    final savings = estimateSavingsTotal(estimate);
    final savingsStage = estimate.stages.firstWhere(
      (s) => s.isExcluded,
      orElse: () => estimate.stages.first,
    );

    return Scaffold(
      backgroundColor: DesignTokens.backgroundLight,
      appBar: AppBar(
        backgroundColor: DesignTokens.backgroundLight,
        elevation: 0,
        title: Text(
          'Remont smetasi · ${room?.name ?? 'Mehmonxona'}'
          '${room != null ? ' · ${room.dimensions.width.toStringAsFixed(1)} × ${room.dimensions.length.toStringAsFixed(1)} m' : ''}',
          style: DesignTokens.subtitle2,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.tune),
            tooltip: 'Smeta sozlash',
            onPressed: () => context.push('/estimation/e3'),
          ),
        ],
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
                  padding: const EdgeInsets.all(DesignTokens.spacingLg),
                  decoration: BoxDecoration(
                    color: DesignTokens.primaryBlue,
                    borderRadius: BorderRadius.circular(DesignTokens.radiusLg),
                    boxShadow: [DesignTokens.shadowElevated],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Taxminiy umumiy narx',
                        style: DesignTokens.body2.copyWith(
                          color: DesignTokens.white.withValues(alpha: 0.75),
                        ),
                      ),
                      Text(
                        formatSom(estimate.totalPrice.round()),
                        style: DesignTokens.heading1.copyWith(
                          color: DesignTokens.white,
                        ),
                      ),
                      const SizedBox(height: DesignTokens.spacingMd),
                      Row(
                        children: [
                          Expanded(
                            child: _TotalColumn(
                              label: 'Materiallar',
                              value: formatSom(materials.round()),
                            ),
                          ),
                          Expanded(
                            child: _TotalColumn(
                              label: 'Ishchi kuchi',
                              value: formatSom(labor.round()),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                if (savings > 0) ...[
                  const SizedBox(height: DesignTokens.spacingMd),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(DesignTokens.spacingMd),
                    decoration: BoxDecoration(
                      color: DesignTokens.successGreen.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(
                        DesignTokens.radiusMd,
                      ),
                      border: Border.all(
                        color: DesignTokens.successGreen.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.savings_outlined,
                          color: DesignTokens.successGreen,
                        ),
                        const SizedBox(width: DesignTokens.spacingSm),
                        Expanded(
                          child: Text(
                            '${_stageLabels[savingsStage.name]} allaqachon bor '
                            'edi — ${formatSom(savings.round())} tejaldingiz',
                            style: DesignTokens.body2.copyWith(
                              color: DesignTokens.successGreen,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                const SizedBox(height: DesignTokens.spacingLg),
                for (final stage in estimate.stages) ...[
                  _StageRow(
                    stage: stage,
                    onTap: stage.isExcluded
                        ? null
                        : () => context.push('/estimation/e2', extra: stage),
                  ),
                  const SizedBox(height: DesignTokens.spacingSm),
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
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: DesignTokens.buttonHeightLarge,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: DesignTokens.accentOrange,
                      ),
                      onPressed: () => context.push('/shop/s5'),
                      child: const Text('Do\'konlardan xarid qilish'),
                    ),
                  ),
                  const SizedBox(height: DesignTokens.spacingSm),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () => context.push('/masters/u1'),
                      child: const Text('Ustaga yuborish'),
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

class _TotalColumn extends StatelessWidget {
  const _TotalColumn({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: DesignTokens.caption.copyWith(
            color: DesignTokens.white.withValues(alpha: 0.7),
          ),
        ),
        Text(
          value,
          style: DesignTokens.subtitle2.copyWith(color: DesignTokens.white),
        ),
      ],
    );
  }
}

class _StageRow extends StatelessWidget {
  const _StageRow({required this.stage, required this.onTap});

  final EstimateStage stage;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final label = _stageLabels[stage.name] ?? stage.name.name;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
      child: Container(
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
                label,
                style: DesignTokens.body2.copyWith(
                  color: stage.isExcluded
                      ? DesignTokens.textMuted
                      : DesignTokens.textDark,
                ),
              ),
            ),
            if (stage.isExcluded)
              Text(
                'sizda mavjud — hisoblanmadi',
                style: DesignTokens.caption.copyWith(
                  color: DesignTokens.textMuted,
                ),
              )
            else
              const Icon(Icons.chevron_right, color: DesignTokens.textMuted),
            const SizedBox(width: DesignTokens.spacingSm),
            Text(
              stage.isExcluded ? '0 so\'m' : formatSom(stage.subtotal.round()),
              style: DesignTokens.subtitle2.copyWith(
                color: stage.isExcluded
                    ? DesignTokens.textMuted
                    : DesignTokens.primaryBlue,
                decoration: stage.isExcluded
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
