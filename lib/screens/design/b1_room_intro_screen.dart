import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/design_tokens.dart';
import '../../models/design_selection_model.dart';
import '../../providers/design_provider.dart';
import '../../widgets/design/room_condition_card.dart';
import 'b1_alt_surface_sheet.dart';

/// B1: Xona holati — the room's baseline surface condition, per spec's
/// single question "Xonangiz hozir qaysi holatda?" Floor/ceiling default
/// to matching the wall condition unless overridden via B1-alt.
class B1RoomIntroScreen extends ConsumerStatefulWidget {
  const B1RoomIntroScreen({super.key});

  @override
  ConsumerState<B1RoomIntroScreen> createState() => _B1RoomIntroScreenState();
}

class _B1RoomIntroScreenState extends ConsumerState<B1RoomIntroScreen> {
  SurfaceCondition _wallCondition = SurfaceCondition.raw;
  SurfaceCondition? _floorOverride;
  SurfaceCondition? _ceilingOverride;

  void _enterRoom() {
    final roomCondition = RoomCondition(
      wall: _wallCondition,
      floor: _floorOverride ?? _wallCondition,
      ceiling: _ceilingOverride ?? _wallCondition,
    );
    ref
        .read(activeDesignProvider.notifier)
        .setRoomConditionLocal(roomCondition);
    context.go('/design/b2');
  }

  void _openFloorCeilingSheet() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (_) => B1AltSurfaceSheet(
        initialFloor: _floorOverride ?? _wallCondition,
        initialCeiling: _ceilingOverride ?? _wallCondition,
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
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(DesignTokens.screenPaddingHorizontal),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Xonangiz hozir qaysi holatda?',
                style: DesignTokens.heading2,
              ),
              const SizedBox(height: DesignTokens.spacingXl),
              RoomConditionCard(
                condition: _wallCondition,
                onChanged: (value) => setState(() => _wallCondition = value),
              ),
              const SizedBox(height: DesignTokens.spacingLg),
              GestureDetector(
                onTap: _openFloorCeilingSheet,
                child: Text(
                  'Farqini bilmayapsizmi? →',
                  style: DesignTokens.body2.copyWith(
                    color: DesignTokens.primaryBlue,
                  ),
                ),
              ),
              const SizedBox(height: DesignTokens.spacingSm),
              GestureDetector(
                onTap: _openFloorCeilingSheet,
                child: Text(
                  'Pol yoki shift boshqacha bo\'lsa →',
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
                  onPressed: _enterRoom,
                  child: const Text('Xonaga kirish'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
