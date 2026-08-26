import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../config/design_tokens.dart';
import '../../models/api/room_state.dart';
import '../../models/design_selection_model.dart';
import '../../providers/apartment_provider.dart';
import '../../providers/design_provider.dart';
import '../../widgets/design/room_condition_card.dart';
import '../design/b1_alt_surface_sheet.dart';

/// Asked once, right after the room's full measurement is finalised and
/// before the 3D Studio opens: "Devor hozir qaysi holatda?" (What state are
/// the walls in now?). The answer is the baseline for the whole renovation —
/// an already-plastered or already-puttied wall means those stages are done,
/// so the studio must start the user on the next real stage instead of always
/// on Suvoq.
///
/// On continue it:
///  1. records the [RoomCondition] locally (so native estimates exclude the
///     stages the wall already has — the "tejaldingiz" delta mechanic), and
///     jumps the local renovation stage to the first stage that still needs
///     doing;
///  2. persists the room's construction state to the backend
///     (`POST /rooms/{id}/state`), best-effort; and
///  3. opens the WebView 3D Studio at the matching phase
///     (`/studio/{id}?phase=…`) so the design flow begins on the right layer,
///     with the finished layers shown as done.
class WallConditionScreen extends ConsumerStatefulWidget {
  const WallConditionScreen({required this.roomId, super.key});

  final String roomId;

  @override
  ConsumerState<WallConditionScreen> createState() =>
      _WallConditionScreenState();
}

class _WallConditionScreenState extends ConsumerState<WallConditionScreen> {
  SurfaceCondition _wall = SurfaceCondition.raw;
  SurfaceCondition? _floorOverride;
  SurfaceCondition? _ceilingOverride;
  bool _saving = false;

  /// First renovation stage that still needs doing given the wall's baseline.
  /// Wall finish is linear: plastered ⇒ Suvoq done, puttied ⇒ Suvoq +
  /// Shpaklovka done.
  RenovationStage get _startStage => switch (_wall) {
        SurfaceCondition.raw => RenovationStage.suvoq,
        SurfaceCondition.plastered => RenovationStage.shpaklovka,
        SurfaceCondition.puttied => RenovationStage.boyoqOboi,
      };

  /// The web studio's phase key (see `frontend/src/lib/phases.ts`) the studio
  /// should open on for this baseline.
  String get _studioPhase => switch (_wall) {
        SurfaceCondition.raw => 'suvoq',
        SurfaceCondition.plastered => 'shpaklovka',
        SurfaceCondition.puttied => 'boyoq',
      };

  /// The backend construction state for this baseline.
  RoomStateValue get _roomState => switch (_wall) {
        SurfaceCondition.raw => RoomStateValue.xom,
        SurfaceCondition.plastered => RoomStateValue.suvoq,
        SurfaceCondition.puttied => RoomStateValue.shpaklovka,
      };

  Future<void> _continue() async {
    setState(() => _saving = true);

    final condition = RoomCondition(
      wall: _wall,
      floor: _floorOverride ?? _wall,
      ceiling: _ceilingOverride ?? _wall,
    );
    final design = ref.read(activeDesignProvider.notifier);
    design.setRoomCondition(condition);
    design.setRenovationStageLocal(_startStage);

    // Persist the backend construction state so the delta / estimates on the
    // server exclude the finished stages too. Best-effort: a raw wall needs no
    // call (the server defaults new rooms to `xom`), and any failure must not
    // block entering the studio.
    if (_roomState != RoomStateValue.xom) {
      try {
        await ref
            .read(roomStateRepositoryProvider)
            .setState(widget.roomId, currentState: _roomState);
      } catch (_) {
        // Best-effort — the studio phase param still carries the user's choice.
      }
    }

    if (!mounted) return;
    context.go('/studio/${widget.roomId}?phase=$_studioPhase');
  }

  void _openFloorCeilingSheet() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (_) => B1AltSurfaceSheet(
        initialFloor: _floorOverride ?? _wall,
        initialCeiling: _ceilingOverride ?? _wall,
        onSave: (floor, ceiling) => setState(() {
          _floorOverride = floor;
          _ceilingOverride = ceiling;
        }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DesignTokens.backgroundLight,
      appBar: AppBar(
        backgroundColor: DesignTokens.backgroundLight,
        elevation: 0,
        foregroundColor: DesignTokens.textDark,
        title: const Text('Devor holati'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Orqaga',
          onPressed: _saving
              ? null
              : () => context.canPop() ? context.pop() : context.go('/'),
        ),
      ),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(DesignTokens.screenPaddingHorizontal),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Devorlaringiz hozir qaysi holatda?',
                style: DesignTokens.heading2,
              ),
              const SizedBox(height: DesignTokens.spacingSm),
              Text(
                'Bu javob qaysi ishlar kerakligini belgilaydi — allaqachon '
                'bajarilgan bosqichlar dizayn va hisob-kitobdan chiqariladi.',
                style: DesignTokens.body2.copyWith(
                  color: DesignTokens.textGray,
                ),
              ),
              const SizedBox(height: DesignTokens.spacingXl),
              RoomConditionCard(
                condition: _wall,
                onChanged: (value) => setState(() => _wall = value),
              ),
              const SizedBox(height: DesignTokens.spacingLg),
              GestureDetector(
                onTap: _saving ? null : _openFloorCeilingSheet,
                child: Text(
                  'Pol yoki shift boshqacha bo\'lsa',
                  style: DesignTokens.body2.copyWith(
                    color: DesignTokens.primaryBlue,
                  ),
                ),
              ),
              const SizedBox(height: DesignTokens.spacingXl),
              SizedBox(
                width: double.infinity,
                height: DesignTokens.buttonHeightLarge,
                child: ElevatedButton(
                  onPressed: _saving ? null : _continue,
                  child: _saving
                      ? const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: DesignTokens.white,
                          ),
                        )
                      : const Text('Davom etish'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
