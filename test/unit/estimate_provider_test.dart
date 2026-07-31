import 'package:flutter_test/flutter_test.dart';
import 'package:tamir_uy_mobile_flutter/models/design_selection_model.dart';
import 'package:tamir_uy_mobile_flutter/providers/estimate_provider.dart';
import 'package:tamir_uy_mobile_flutter/providers/shop_provider.dart';

const _areas = (floorArea: 18.0, wallArea: 48.0);
const _electrical = ElectricalNeed(
  outletCount: 8,
  wireMeters: 72,
  switchCount: 4,
  lightCount: 6,
  pipeCount: 4,
);

void main() {
  group('buildEstimate — delta mechanic pricing', () {
    test('excluded stage is charged 0 but keeps a real counterfactual', () {
      final estimate = buildEstimate(
        roomId: 'r1',
        areas: _areas,
        electrical: _electrical,
        furnitureCount: 5,
        excludedStages: {RenovationStage.suvoq},
        tier: QualityTier.standart,
        diy: false,
      );
      final suvoq = estimate.stages.firstWhere(
        (s) => s.name == RenovationStage.suvoq,
      );
      expect(suvoq.isExcluded, isTrue);
      expect(suvoq.subtotal, 0);
      expect(suvoq.counterfactualSubtotal, greaterThan(0));
    });

    test('two different exclusion sets produce different savings totals', () {
      final noneExcluded = buildEstimate(
        roomId: 'r1',
        areas: _areas,
        electrical: _electrical,
        furnitureCount: 5,
        excludedStages: const {},
        tier: QualityTier.standart,
        diy: false,
      );
      final suvoqShpaklovkaExcluded = buildEstimate(
        roomId: 'r1',
        areas: _areas,
        electrical: _electrical,
        furnitureCount: 5,
        excludedStages: {RenovationStage.suvoq, RenovationStage.shpaklovka},
        tier: QualityTier.standart,
        diy: false,
      );

      final savingsNone = estimateSavingsTotal(noneExcluded);
      final savingsTwo = estimateSavingsTotal(suvoqShpaklovkaExcluded);

      expect(savingsNone, 0);
      expect(savingsTwo, greaterThan(0));
      expect(
        noneExcluded.totalPrice,
        greaterThan(suvoqShpaklovkaExcluded.totalPrice),
      );
    });

    test('quality tier scales the total proportionally to its multiplier', () {
      final ekonom = buildEstimate(
        roomId: 'r1',
        areas: _areas,
        electrical: _electrical,
        furnitureCount: 5,
        excludedStages: const {},
        tier: QualityTier.ekonom,
        diy: false,
      );
      final standart = buildEstimate(
        roomId: 'r1',
        areas: _areas,
        electrical: _electrical,
        furnitureCount: 5,
        excludedStages: const {},
        tier: QualityTier.standart,
        diy: false,
      );
      final premium = buildEstimate(
        roomId: 'r1',
        areas: _areas,
        electrical: _electrical,
        furnitureCount: 5,
        excludedStages: const {},
        tier: QualityTier.premium,
        diy: false,
      );

      expect(ekonom.totalPrice, lessThan(standart.totalPrice));
      expect(standart.totalPrice, lessThan(premium.totalPrice));
      expect(
        standart.totalPrice / QualityTier.standart.multiplier,
        closeTo(ekonom.totalPrice / QualityTier.ekonom.multiplier, 0.01),
      );
    });

    test(
      'DIY mode removes labor from the charged total, not the counterfactual',
      () {
        final withLabor = buildEstimate(
          roomId: 'r1',
          areas: _areas,
          electrical: _electrical,
          furnitureCount: 5,
          excludedStages: const {},
          tier: QualityTier.standart,
          diy: false,
        );
        final diy = buildEstimate(
          roomId: 'r1',
          areas: _areas,
          electrical: _electrical,
          furnitureCount: 5,
          excludedStages: const {},
          tier: QualityTier.standart,
          diy: true,
        );

        expect(estimateLaborTotal(diy), 0);
        expect(estimateLaborTotal(withLabor), greaterThan(0));
        expect(diy.totalPrice, lessThan(withLabor.totalPrice));
        // Counterfactual (what a pro would have charged) is diy-independent.
        final withLaborSuvoq = withLabor.stages.first;
        final diySuvoq = diy.stages.first;
        expect(
          diySuvoq.counterfactualSubtotal,
          withLaborSuvoq.counterfactualSubtotal,
        );
      },
    );

    test('materials + labor totals sum to the grand total', () {
      final estimate = buildEstimate(
        roomId: 'r1',
        areas: _areas,
        electrical: _electrical,
        furnitureCount: 5,
        excludedStages: {RenovationStage.suvoq},
        tier: QualityTier.standart,
        diy: false,
      );
      final materials = estimateMaterialsTotal(estimate);
      final labor = estimateLaborTotal(estimate);
      expect(materials + labor, closeTo(estimate.totalPrice, 0.01));
    });
  });
}
