import 'package:flutter_test/flutter_test.dart';
import 'package:tamir_uy_mobile_flutter/models/design_selection_model.dart';

void main() {
  group(
    'deriveStageStates — wall condition drives suvoq/shpaklovka exclusion',
    () {
      test('korobka (raw) walls exclude nothing', () {
        final states = deriveStageStates(
          condition: const RoomCondition(wall: SurfaceCondition.raw),
          currentStage: RenovationStage.suvoq,
        );

        expect(
          states[RenovationStage.suvoq.index],
          StageDisplayState.inProgress,
        );
        expect(
          states[RenovationStage.shpaklovka.index],
          StageDisplayState.upcoming,
        );
        expect(
          states[RenovationStage.boyoqOboi.index],
          StageDisplayState.upcoming,
        );
      });

      test('suvoq (plastered) walls exclude only the Suvoq stage', () {
        final states = deriveStageStates(
          condition: const RoomCondition(wall: SurfaceCondition.plastered),
          currentStage: RenovationStage.shpaklovka,
        );

        expect(states[RenovationStage.suvoq.index], StageDisplayState.excluded);
        expect(
          states[RenovationStage.shpaklovka.index],
          StageDisplayState.inProgress,
        );
        expect(
          states[RenovationStage.boyoqOboi.index],
          StageDisplayState.upcoming,
        );
      });

      test('shpaklovka (puttied) walls exclude both Suvoq and Shpaklovka', () {
        final states = deriveStageStates(
          condition: const RoomCondition(wall: SurfaceCondition.puttied),
          currentStage: RenovationStage.boyoqOboi,
        );

        expect(states[RenovationStage.suvoq.index], StageDisplayState.excluded);
        expect(
          states[RenovationStage.shpaklovka.index],
          StageDisplayState.excluded,
        );
        expect(
          states[RenovationStage.boyoqOboi.index],
          StageDisplayState.inProgress,
        );
      });
    },
  );

  group(
    'deriveStageStates — floor condition drives Pol exclusion independently of wall',
    () {
      test(
        'floor already covered (puttied) excludes Pol even when walls are raw',
        () {
          final states = deriveStageStates(
            condition: const RoomCondition(
              wall: SurfaceCondition.raw,
              floor: SurfaceCondition.puttied,
            ),
            currentStage: RenovationStage.suvoq,
          );

          expect(states[RenovationStage.pol.index], StageDisplayState.excluded);
          // Wall stages are unaffected by the floor's condition.
          expect(
            states[RenovationStage.suvoq.index],
            StageDisplayState.inProgress,
          );
        },
      );

      test(
        'floor with only screed (plastered) does NOT exclude Pol — covering still needed',
        () {
          final states = deriveStageStates(
            condition: const RoomCondition(
              wall: SurfaceCondition.raw,
              floor: SurfaceCondition.plastered,
            ),
            currentStage: RenovationStage.pol,
          );

          expect(
            states[RenovationStage.pol.index],
            StageDisplayState.inProgress,
          );
        },
      );

      test('null floor condition (unspecified) does not exclude Pol', () {
        final states = deriveStageStates(
          condition: const RoomCondition(wall: SurfaceCondition.raw),
          currentStage: RenovationStage.pol,
        );

        expect(states[RenovationStage.pol.index], StageDisplayState.inProgress);
      });
    },
  );

  group(
    'deriveStageStates — furniture/electrical/lighting/plumbing are never excluded',
    () {
      test(
        'even a fully-finished room (shpaklovka + covered floor) never excludes Mebel/Elektr/Yorug\'lik/Santexnika',
        () {
          final states = deriveStageStates(
            condition: const RoomCondition(
              wall: SurfaceCondition.puttied,
              floor: SurfaceCondition.puttied,
            ),
            currentStage: RenovationStage.mebel,
          );

          expect(
            states[RenovationStage.mebel.index],
            isNot(StageDisplayState.excluded),
          );
          expect(
            states[RenovationStage.elektr.index],
            isNot(StageDisplayState.excluded),
          );
          expect(
            states[RenovationStage.yoruglik.index],
            isNot(StageDisplayState.excluded),
          );
          expect(
            states[RenovationStage.santexnika.index],
            isNot(StageDisplayState.excluded),
          );
        },
      );
    },
  );

  group('deriveStageStates — completed/upcoming boundary around currentStage', () {
    test(
      'every stage before currentStage is completed (when not excluded), after is upcoming',
      () {
        final states = deriveStageStates(
          condition: const RoomCondition(wall: SurfaceCondition.raw),
          currentStage: RenovationStage.elektr,
        );

        expect(
          states[RenovationStage.suvoq.index],
          StageDisplayState.completed,
        );
        expect(
          states[RenovationStage.shpaklovka.index],
          StageDisplayState.completed,
        );
        expect(
          states[RenovationStage.boyoqOboi.index],
          StageDisplayState.completed,
        );
        expect(states[RenovationStage.pol.index], StageDisplayState.completed);
        expect(
          states[RenovationStage.mebel.index],
          StageDisplayState.completed,
        );
        expect(
          states[RenovationStage.elektr.index],
          StageDisplayState.inProgress,
        );
        expect(
          states[RenovationStage.yoruglik.index],
          StageDisplayState.upcoming,
        );
        expect(
          states[RenovationStage.santexnika.index],
          StageDisplayState.upcoming,
        );
      },
    );

    test(
      'excluded overrides completed — an excluded stage stays excluded even after currentStage passes it',
      () {
        final states = deriveStageStates(
          condition: const RoomCondition(wall: SurfaceCondition.puttied),
          currentStage: RenovationStage.santexnika,
        );

        expect(states[RenovationStage.suvoq.index], StageDisplayState.excluded);
        expect(
          states[RenovationStage.shpaklovka.index],
          StageDisplayState.excluded,
        );
      },
    );
  });

  test(
    'deriveStageStates always returns exactly 8 entries, one per RenovationStage',
    () {
      final states = deriveStageStates(
        condition: const RoomCondition(wall: SurfaceCondition.raw),
        currentStage: RenovationStage.suvoq,
      );

      expect(states.length, RenovationStage.values.length);
      expect(states.length, 8);
    },
  );
}
