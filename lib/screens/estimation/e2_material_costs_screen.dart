import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../config/design_tokens.dart';
import '../../models/estimate_model.dart';
import '../../utils/currency.dart';

const _stageLabels = {
  'suvoq': 'Suvoq',
  'shpaklovka': 'Shpaklovka',
  'boyoqOboi': 'Bo\'yoq/Oboi',
  'pol': 'Pol',
  'mebel': 'Mebel',
  'elektr': 'Elektr montaj',
  'yoruglik': 'Yorug\'lik',
  'santexnika': 'Santexnika',
};

/// E2: Bosqich smetasi batafsil — per-stage breakdown: material lines
/// (real qty × unit price), "Materiallar jami," labour lines, sticky
/// blue "Bosqich jami," CTA to Do'kon.
class E2MaterialCostsScreen extends StatelessWidget {
  const E2MaterialCostsScreen({required this.stage, super.key});

  final EstimateStage stage;

  @override
  Widget build(BuildContext context) {
    final materialItems = stage.lineItems
        .where((i) => i.id.endsWith('_mat'))
        .toList();
    final laborItems = stage.lineItems
        .where((i) => i.id.endsWith('_labor'))
        .toList();
    final materialTotal = materialItems.fold<double>(
      0,
      (sum, i) => sum + i.lineTotal,
    );
    final laborTotal = laborItems.fold<double>(
      0,
      (sum, i) => sum + i.lineTotal,
    );
    final label = _stageLabels[stage.name.name] ?? stage.name.name;

    return Scaffold(
      backgroundColor: DesignTokens.backgroundLight,
      appBar: AppBar(
        backgroundColor: DesignTokens.backgroundLight,
        elevation: 0,
        title: Text(label, style: DesignTokens.heading3),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(
                DesignTokens.screenPaddingHorizontal,
              ),
              children: [
                Text('Materiallar', style: DesignTokens.subtitle2),
                const SizedBox(height: DesignTokens.spacingSm),
                for (final item in materialItems) ...[
                  _LineRow(item: item),
                  const SizedBox(height: DesignTokens.spacingXs),
                ],
                const Divider(height: DesignTokens.spacingLg),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Materiallar jami', style: DesignTokens.subtitle2),
                    Text(
                      formatSom(materialTotal.round()),
                      style: DesignTokens.subtitle2.copyWith(
                        color: DesignTokens.primaryBlue,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: DesignTokens.spacingLg),
                if (laborItems.isNotEmpty) ...[
                  Text('Ishchi kuchi', style: DesignTokens.subtitle2),
                  const SizedBox(height: DesignTokens.spacingSm),
                  for (final item in laborItems) ...[
                    _LineRow(item: item),
                    const SizedBox(height: DesignTokens.spacingXs),
                  ],
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
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: const EdgeInsets.all(DesignTokens.spacingMd),
                    decoration: BoxDecoration(
                      color: DesignTokens.primaryBlue,
                      borderRadius: BorderRadius.circular(
                        DesignTokens.radiusMd,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Bosqich jami',
                          style: DesignTokens.subtitle2.copyWith(
                            color: DesignTokens.white,
                          ),
                        ),
                        Text(
                          formatSom((materialTotal + laborTotal).round()),
                          style: DesignTokens.subtitle1.copyWith(
                            color: DesignTokens.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: DesignTokens.spacingSm),
                  SizedBox(
                    height: DesignTokens.buttonHeightLarge,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: DesignTokens.accentOrange,
                      ),
                      onPressed: () => context.push('/shop/s2'),
                      child: const Text('Materiallarni savatga'),
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

class _LineRow extends StatelessWidget {
  const _LineRow({required this.item});

  final EstimateLineItem item;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            '${item.description} · ${formatQuantity(item.quantity)} '
            '× ${formatSom(item.unitPrice.round())}',
            style: DesignTokens.body2,
          ),
        ),
        Text(
          formatSom(item.lineTotal.round()),
          style: DesignTokens.body2.copyWith(color: DesignTokens.textGray),
        ),
      ],
    );
  }
}
