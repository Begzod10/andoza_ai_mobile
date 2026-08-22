import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/design_tokens.dart';
import '../../models/design_selection_model.dart';
import '../../providers/design_provider.dart';
import '../../providers/electrical_provider.dart';
import '../../providers/room_provider.dart';
import '../../widgets/electrical/wire_routing_view.dart';
import '../../widgets/room/room_perspective_view.dart';

enum _RoutingView { plan2d, view3d, both }

/// D8: Sim yo'nalishi — split view showing the real computed wire graph
/// (every device wired directly back to the electrical box), not a
/// decorative illustration.
class D8ElectricalSummaryScreen extends ConsumerStatefulWidget {
  const D8ElectricalSummaryScreen({super.key});

  @override
  ConsumerState<D8ElectricalSummaryScreen> createState() =>
      _D8ElectricalSummaryScreenState();
}

class _D8ElectricalSummaryScreenState
    extends ConsumerState<D8ElectricalSummaryScreen> {
  _RoutingView _view = _RoutingView.both;

  @override
  Widget build(BuildContext context) {
    final layout = ref.watch(electricalLayoutProvider);
    final room = ref.watch(activeRoomProvider);

    return Scaffold(
      backgroundColor: DesignTokens.backgroundLight,
      appBar: AppBar(
        backgroundColor: DesignTokens.backgroundLight,
        elevation: 0,
        title: const Text('Sim yo\'nalishi', style: DesignTokens.heading3),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(DesignTokens.spacingMd),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ChoiceChip(
                    label: const Text('2D reja'),
                    selected: _view == _RoutingView.plan2d,
                    onSelected: (_) =>
                        setState(() => _view = _RoutingView.plan2d),
                  ),
                  const SizedBox(width: DesignTokens.spacingSm),
                  ChoiceChip(
                    label: const Text('3D'),
                    selected: _view == _RoutingView.view3d,
                    onSelected: (_) =>
                        setState(() => _view = _RoutingView.view3d),
                  ),
                  const SizedBox(width: DesignTokens.spacingSm),
                  ChoiceChip(
                    label: const Text('Ikkalasi'),
                    selected: _view == _RoutingView.both,
                    onSelected: (_) =>
                        setState(() => _view = _RoutingView.both),
                  ),
                ],
              ),
            ),
            Expanded(
              child: layout == null || room == null
                  ? const Center(child: CircularProgressIndicator())
                  : Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: DesignTokens.screenPaddingHorizontal,
                      ),
                      child: Column(
                        children: [
                          if (_view != _RoutingView.view3d)
                            Expanded(
                              child: WireRoutingView(
                                width: room.dimensions.width,
                                length: room.dimensions.length,
                                layout: layout,
                              ),
                            ),
                          if (_view == _RoutingView.both)
                            const SizedBox(height: DesignTokens.spacingMd),
                          if (_view != _RoutingView.plan2d)
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(
                                  DesignTokens.radiusLg,
                                ),
                                child: RoomPerspectiveView(
                                  wallCondition:
                                      ref
                                          .watch(activeDesignProvider)
                                          ?.roomCondition
                                          ?.wall ??
                                      SurfaceCondition.raw,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
            ),
            Padding(
              padding: const EdgeInsets.all(
                DesignTokens.screenPaddingHorizontal,
              ),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        ref
                            .read(electricalLayoutProvider.notifier)
                            .recomputeWires();
                      },
                      icon: const Icon(Icons.refresh),
                      label: const Text('Trassani qayta hisoblash'),
                    ),
                  ),
                  const SizedBox(height: DesignTokens.spacingSm),
                  SizedBox(
                    width: double.infinity,
                    height: DesignTokens.buttonHeightLarge,
                    child: ElevatedButton(
                      onPressed: () => context.push('/electrical/d9'),
                      child: const Text('Keyingi →'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
