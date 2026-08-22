import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/design_tokens.dart';
import '../../models/design_selection_model.dart';
import '../../models/electrical_model.dart';
import '../../providers/design_provider.dart';
import '../../providers/electrical_provider.dart';
import '../../widgets/common/success_toast.dart';
import '../../widgets/design/stage_progress_line.dart';
import '../../widgets/room/room_perspective_view.dart';
import '../../widgets/room_3d_rail.dart';

const _elektrDevices = [
  RailItem(id: 'box', label: 'Elektr qutisi', icon: Icons.electrical_services),
  RailItem(id: 'switch1', label: 'Bitta kalit', icon: Icons.toggle_on_outlined),
  RailItem(
    id: 'switch2',
    label: 'Ikkita kalit',
    icon: Icons.dashboard_customize_outlined,
  ),
  RailItem(id: 'outlet1', label: 'Bitta rozetka', icon: Icons.power_outlined),
  RailItem(id: 'outlet2', label: 'Ikkita rozetka', icon: Icons.power),
  RailItem(
    id: 'tv-eth',
    label: 'TV+Ethernet',
    icon: Icons.settings_input_hdmi_outlined,
  ),
];
const _yorugDevices = [
  RailItem(id: 'lyustra', label: 'Lyustra', icon: Icons.light),
  RailItem(id: 'spot', label: 'Spot', icon: Icons.lightbulb_outline),
  RailItem(id: 'lenta', label: 'Lenta', icon: Icons.linear_scale),
];
const _santexnikaDevices = [
  RailItem(id: 'smesitel', label: 'Smesitel', icon: Icons.water_drop_outlined),
  RailItem(id: 'unitaz', label: 'Unitaz', icon: Icons.wc_outlined),
  RailItem(id: 'dush', label: 'Dush', icon: Icons.shower_outlined),
];

DeviceType _deviceTypeFor(String itemId) => switch (itemId) {
  'box' => DeviceType.breaker,
  'switch1' || 'switch2' => DeviceType.lightSwitch,
  'lyustra' || 'spot' || 'lenta' => DeviceType.light,
  _ => DeviceType.outlet,
};

/// D1-D7: Elektr / Yorug'lik / Santexnika stage — one continuous
/// drag-to-place screen across 3 rail tabs, matching the spec's
/// "recurring pattern" (never leave the 3D room during decoration/
/// electrical). The box must be placed before any other Elektr device
/// unlocks (D1's rule); sockets placed near furniture reference the
/// room's real placed-furniture data (D3), not a hardcoded spot.
class D1ElectricalIntroScreen extends ConsumerStatefulWidget {
  const D1ElectricalIntroScreen({super.key});

  @override
  ConsumerState<D1ElectricalIntroScreen> createState() =>
      _D1ElectricalIntroScreenState();
}

class _D1ElectricalIntroScreenState
    extends ConsumerState<D1ElectricalIntroScreen> {
  final _viewKey = GlobalKey();
  ColorTemp _lightTemp = ColorTemp.neutral;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final roomId = ref.read(activeDesignProvider)?.roomId ?? 'room';
      if (ref.read(electricalLayoutProvider) == null) {
        ref.read(electricalLayoutProvider.notifier).startForRoom(roomId);
      }
    });
  }

  void _handleDrop(RailItem item, Offset globalPosition) {
    final notifier = ref.read(electricalLayoutProvider.notifier);
    final box = _viewKey.currentContext?.findRenderObject() as RenderBox?;
    final local = box?.globalToLocal(globalPosition) ?? Offset.zero;

    if (item.id == 'box') {
      notifier.placeBox(local, 'wallA');
      notifier.recomputeWires();
      SuccessToast.show(context, '✓ Elektr qutisi joylashtirildi');
      return;
    }

    if (!notifier.hasBox) {
      SuccessToast.show(context, 'Avval elektr qutisini joylashtiring');
      return;
    }

    final furniture = ref.read(activeDesignProvider)?.furniture ?? const [];
    String? helper;
    if (item.id.startsWith('outlet') && furniture.isNotEmpty) {
      // D3: sockets placed near furniture reference the actual placed
      // sofa/furniture position, not a coincidental hardcoded spot.
      final nearest = furniture.first;
      final distance = (local - nearest.position).distance;
      if (distance < 120) {
        helper = '${nearest.name} yonida — TV va zaryadlagich uchun';
      }
    }

    notifier.addDevice(
      ElectricalDevice(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        type: _deviceTypeFor(item.id),
        position: local,
        wallId: 'wallA',
        heightCm: item.id.startsWith('switch') ? 90 : 30,
        colorTemp: _yorugDevices.any((d) => d.id == item.id)
            ? _lightTemp
            : null,
      ),
    );
    notifier.recomputeWires();
    SuccessToast.show(context, helper ?? '✓ Qurilma qo\'shildi');
  }

  @override
  Widget build(BuildContext context) {
    final layout = ref.watch(electricalLayoutProvider);
    final condition =
        ref.watch(activeDesignProvider.select((d) => d?.roomCondition));

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            key: _viewKey,
            child: DragTarget<RailItem>(
              onWillAcceptWithDetails: (_) => true,
              onAcceptWithDetails: (details) =>
                  _handleDrop(details.data, details.offset),
              builder: (context, candidateData, rejectedData) {
                return Stack(
                  children: [
                    RoomPerspectiveView(
                      wallCondition: condition?.wall ?? SurfaceCondition.raw,
                    ),
                    if (_lightTemp == ColorTemp.warm)
                      Container(color: Colors.orange.withValues(alpha: 0.12)),
                    for (final device
                        in layout?.devices ?? const <ElectricalDevice>[])
                      Positioned(
                        left: device.position.dx - 16,
                        top: device.position.dy - 16,
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: device.type == DeviceType.breaker
                                ? DesignTokens.textDark
                                : DesignTokens.primaryBlue,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: DesignTokens.white,
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                  ],
                );
              },
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
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StageProgressLine(
                      currentStep: RenovationStage.elektr.index,
                      totalSteps: RenovationStage.values.length,
                      stageLabel: 'Elektr bosqichi',
                    ),
                    const SizedBox(height: DesignTokens.spacingSm),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        for (final temp in ColorTemp.values)
                          Padding(
                            padding: const EdgeInsets.only(
                              right: DesignTokens.spacingXs,
                            ),
                            child: ChoiceChip(
                              label: Text(switch (temp) {
                                ColorTemp.warm => 'Issiq',
                                ColorTemp.neutral => 'Neytral',
                                ColorTemp.cold => 'Sovuq',
                                ColorTemp.rgb => 'RGB',
                              }),
                              selected: _lightTemp == temp,
                              onSelected: (_) =>
                                  setState(() => _lightTemp = temp),
                            ),
                          ),
                      ],
                    ),
                  ],
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
                  RailTab(label: 'Elektr', items: _elektrDevices),
                  RailTab(label: 'Yorug\'lik', items: _yorugDevices),
                  RailTab(label: 'Santexnika', items: _santexnikaDevices),
                ],
                onItemSelected: (_) {}, // Placement is drag-drop only.
              ),
            ),
          ),
          if ((layout?.devices.length ?? 0) > 1)
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
                    onPressed: () => context.push('/electrical/d8'),
                    child: const Text('Keyingi →'),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
