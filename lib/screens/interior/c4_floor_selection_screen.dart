import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/design_tokens.dart';
import '../../models/design_selection_model.dart';
import '../../providers/design_provider.dart';
import '../../widgets/common/success_toast.dart';
import '../../widgets/design/stage_progress_line.dart';
import '../../widgets/room/room_perspective_view.dart';
import '../../widgets/room_3d_rail.dart';

const _kafelFloor = [
  RailItem(id: 'kafel-oq', label: 'Oq kafel', color: Color(0xFFF2F2F2)),
];
const _laminatFloor = [
  RailItem(id: 'laminat-eman', label: 'Eman laminat', color: Color(0xFFD9C2A0)),
  RailItem(
    id: 'laminat-yong',
    label: 'Yong\'oq laminat',
    color: Color(0xFF9C7A54),
  ),
];
const _parketFloor = [
  RailItem(id: 'parket-dub', label: 'Dub parket', color: Color(0xFFC9A876)),
];
const _betonFloor = [
  RailItem(id: 'beton-och', label: 'Och beton', color: Color(0xFFC7C7C7)),
];

/// C4: Pol stage — floor material drag-to-surface, per spec's rail tabs
/// Kafel/Laminat/Parket/Beton.
class C4FloorSelectionScreen extends ConsumerStatefulWidget {
  const C4FloorSelectionScreen({super.key});

  @override
  ConsumerState<C4FloorSelectionScreen> createState() =>
      _C4FloorSelectionScreenState();
}

class _C4FloorSelectionScreenState
    extends ConsumerState<C4FloorSelectionScreen> {
  Color? _floorColor;

  void _applyFloor(RailItem item) {
    setState(() => _floorColor = item.color);
    SuccessToast.show(context, '✓ Polga qo\'llanildi');
  }

  @override
  Widget build(BuildContext context) {
    final design = ref.watch(activeDesignProvider);
    final condition = design?.roomCondition;
    final stageStates = condition == null
        ? null
        : deriveStageStates(
            condition: condition,
            currentStage: RenovationStage.pol,
          );

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: RoomPerspectiveView(
              wallCondition: condition?.wall ?? SurfaceCondition.raw,
              floorColor: _floorColor,
              onFloorDrop: _applyFloor,
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(DesignTokens.spacingMd),
              child: Container(
                padding: const EdgeInsets.all(DesignTokens.spacingMd),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.92),
                  borderRadius: BorderRadius.circular(DesignTokens.radiusLg),
                ),
                child: StageProgressLine(
                  currentStep: RenovationStage.pol.index,
                  totalSteps: RenovationStage.values.length,
                  stageStates: stageStates,
                  stageLabel: 'Pol bosqichi',
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: SafeArea(
              child: Room3DRail(
                initiallyExpanded: true,
                tabs: const [
                  RailTab(label: 'Kafel', items: _kafelFloor),
                  RailTab(label: 'Laminat', items: _laminatFloor),
                  RailTab(label: 'Parket', items: _parketFloor),
                  RailTab(label: 'Beton', items: _betonFloor),
                ],
                onItemSelected: _applyFloor,
              ),
            ),
          ),
          if (_floorColor != null)
            Positioned(
              left: DesignTokens.spacingMd,
              right: DesignTokens.spacingMd,
              bottom: DesignTokens.spacingXl,
              child: SafeArea(
                top: false,
                child: SizedBox(
                  width: double.infinity,
                  height: DesignTokens.buttonHeightLarge,
                  child: ElevatedButton(
                    onPressed: () {
                      ref
                          .read(activeDesignProvider.notifier)
                          .setRenovationStageLocal(RenovationStage.mebel);
                      context.push('/interior/c5');
                    },
                    child: const Text('Keyingi bosqich →'),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
