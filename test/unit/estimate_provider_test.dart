import 'package:flutter_test/flutter_test.dart';
import 'package:tamir_uy_mobile_flutter/geometry/room_geometry.dart';
import 'package:tamir_uy_mobile_flutter/models/design_selection_model.dart';
import 'package:tamir_uy_mobile_flutter/models/room_plan.dart';
import 'package:tamir_uy_mobile_flutter/providers/estimate_provider.dart';
import 'package:tamir_uy_mobile_flutter/providers/shop_provider.dart';
import 'package:tamir_uy_mobile_flutter/utils/project_areas.dart';

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

  group('computeProjectAreas — plan vs legacy Room', () {
    List<Vec2> rect() =>
        const [Vec2(0, 0), Vec2(4, 0), Vec2(4, 3), Vec2(0, 3)];

    // An L-shape: 4×4 bounding box, true area 12 m².
    List<Vec2> lShape() => const [
          Vec2(0, 0),
          Vec2(4, 0),
          Vec2(4, 2),
          Vec2(2, 2),
          Vec2(2, 4),
          Vec2(0, 4),
        ];

    test('rectangle: plan path is numerically identical to the Room path', () {
      final plan = RoomPlan.fromCorners(
        rect(),
        ceilingHeightM: 2.8,
        source: RoomSource.wizard,
      );
      // The current (legacy) computation uses the derived bounding Room.
      final legacy = computeProjectAreas(plan.toLegacyRoom());
      final viaPlan = computeProjectAreas(null, plan: plan);
      expect(viaPlan.floorArea, closeTo(legacy.floorArea, 1e-9));
      expect(viaPlan.wallArea, closeTo(legacy.wallArea, 1e-9));
    });

    test('L-shape: floorArea is the true polygon area, not the bounding box',
        () {
      final plan = RoomPlan.fromCorners(
        lShape(),
        ceilingHeightM: 2.8,
        source: RoomSource.sketch,
      );
      final areas = computeProjectAreas(null, plan: plan);
      expect(areas.floorArea, closeTo(plan.areaM2, 1e-9));
      expect(areas.floorArea, closeTo(12.0, 1e-9));
      // The bounding-box Room would report 16 m² — confirm the plan path wins.
      final bounding = computeProjectAreas(plan.toLegacyRoom());
      expect(bounding.floorArea, closeTo(16.0, 1e-9));
      // Wall area follows the true perimeter, not the bounding perimeter.
      expect(areas.wallArea, closeTo(plan.netWallAreaM2, 1e-9));
    });
  });
}
