import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/design_tokens.dart';
import '../../models/room_model.dart';
import '../../models/room_plan.dart';
import '../../providers/room_provider.dart';

/// One manually-entered room, added via the "+" Xona qo'shish tile.
class ManualRoomEntry {
  final String id;
  final String name;
  final RoomDimensions dimensions;

  const ManualRoomEntry({
    required this.id,
    required this.name,
    required this.dimensions,
  });

  double get area => dimensions.width * dimensions.length;
}

final manualRoomsProvider =
    StateNotifierProvider<ManualRoomsNotifier, List<ManualRoomEntry>>(
      (ref) => ManualRoomsNotifier(),
    );

class ManualRoomsNotifier extends StateNotifier<List<ManualRoomEntry>> {
  ManualRoomsNotifier() : super([]);

  void addRoom(ManualRoomEntry room) => state = [...state, room];
}

/// A6: Xona o'lchamlari — "Qo'lda kiritish" (room cards grid + add-room
/// dialog) / "Plan yuklash" (floorplan upload) tabs.
class DimensionsEntryScreen extends ConsumerStatefulWidget {
  const DimensionsEntryScreen({super.key});

  @override
  ConsumerState<DimensionsEntryScreen> createState() =>
      _DimensionsEntryScreenState();
}

class _DimensionsEntryScreenState extends ConsumerState<DimensionsEntryScreen> {
  bool _manualEntryActive = true;

  @override
  Widget build(BuildContext context) {
    final rooms = ref.watch(manualRoomsProvider);
    final totalArea = rooms.fold<double>(0, (sum, r) => sum + r.area);

    return Scaffold(
      backgroundColor: DesignTokens.backgroundLight,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: DesignTokens.backgroundLight,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: DesignTokens.textDark),
          tooltip: 'Orqaga',
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Xona o\'lchamlari', style: DesignTokens.heading3),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(DesignTokens.spacingMd),
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: DesignTokens.borderGrayAlt,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: _SegmentButton(
                        label: 'Qo\'lda kiritish',
                        selected: _manualEntryActive,
                        onTap: () => setState(() => _manualEntryActive = true),
                      ),
                    ),
                    Expanded(
                      child: _SegmentButton(
                        label: 'Plan yuklash',
                        selected: !_manualEntryActive,
                        onTap: () => setState(() => _manualEntryActive = false),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: _manualEntryActive
                  ? _ManualEntryTab(rooms: rooms)
                  : const _FloorplanUploadTab(),
            ),
            Padding(
              padding: const EdgeInsets.all(
                DesignTokens.screenPaddingHorizontal,
              ),
              child: Column(
                children: [
                  if (_manualEntryActive && rooms.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: DesignTokens.spacingMd,
                      ),
                      child: Text(
                        'Jami: ${rooms.length} xona · ${totalArea.toStringAsFixed(1)} m²',
                        style: DesignTokens.subtitle2,
                      ),
                    ),
                  SizedBox(
                    width: double.infinity,
                    height: DesignTokens.buttonHeightLarge,
                    child: ElevatedButton(
                      onPressed: _manualEntryActive && rooms.isEmpty
                          ? null
                          : () => context.push('/setup/wall-measurements'),
                      child: Text(
                        _manualEntryActive
                            ? 'Keyingi: devorlarni o\'lchash'
                            : '3D ga aylantirish',
                      ),
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

class _SegmentButton extends StatelessWidget {
  const _SegmentButton({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: DesignTokens.animationFast,
        padding: const EdgeInsets.symmetric(vertical: DesignTokens.spacingSm),
        decoration: BoxDecoration(
          color: selected ? DesignTokens.white : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          boxShadow: selected ? [DesignTokens.shadowCard] : null,
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: DesignTokens.body2.copyWith(
            color: selected ? DesignTokens.primaryBlue : DesignTokens.textGray,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

class _ManualEntryTab extends ConsumerWidget {
  const _ManualEntryTab({required this.rooms});

  final List<ManualRoomEntry> rooms;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GridView.count(
      padding: const EdgeInsets.symmetric(
        horizontal: DesignTokens.screenPaddingHorizontal,
      ),
      crossAxisCount: 2,
      mainAxisSpacing: DesignTokens.spacingMd,
      crossAxisSpacing: DesignTokens.spacingMd,
      childAspectRatio: 1.1,
      children: [
        for (final room in rooms)
          Container(
            padding: const EdgeInsets.all(DesignTokens.spacingMd),
            decoration: BoxDecoration(
              color: DesignTokens.white,
              borderRadius: BorderRadius.circular(DesignTokens.radiusLg),
              border: Border.all(color: DesignTokens.borderGray),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(room.name, style: DesignTokens.subtitle2),
                const SizedBox(height: DesignTokens.spacingXs),
                Text(
                  '${room.area.toStringAsFixed(1)} m²',
                  style: DesignTokens.caption.copyWith(
                    color: DesignTokens.textGray,
                  ),
                ),
              ],
            ),
          ),
        GestureDetector(
          onTap: () => _showAddRoomDialog(context, ref),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(DesignTokens.radiusLg),
              border: Border.all(color: const Color(0xFFD6DAE2), width: 2),
            ),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.add, color: DesignTokens.primaryBlue),
                  const SizedBox(height: DesignTokens.spacingXs),
                  Text(
                    '+ Xona qo\'shish',
                    style: DesignTokens.caption.copyWith(
                      color: DesignTokens.primaryBlue,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showAddRoomDialog(BuildContext context, WidgetRef ref) {
    final nameController = TextEditingController(
      text: 'Xona ${rooms.length + 1}',
    );
    final lengthController = TextEditingController();
    final widthController = TextEditingController();
    final heightController = TextEditingController();

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (sheetContext) => Padding(
        padding: EdgeInsets.only(
          left: DesignTokens.screenPaddingHorizontal,
          right: DesignTokens.screenPaddingHorizontal,
          top: DesignTokens.spacingLg,
          bottom:
              MediaQuery.of(sheetContext).viewInsets.bottom +
              DesignTokens.spacingLg,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Xona nomi'),
            ),
            const SizedBox(height: DesignTokens.spacingMd),
            TextField(
              controller: lengthController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(labelText: 'Uzunlik (m)'),
            ),
            const SizedBox(height: DesignTokens.spacingMd),
            TextField(
              controller: widthController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(labelText: 'Kenglik (m)'),
            ),
            const SizedBox(height: DesignTokens.spacingMd),
            TextField(
              controller: heightController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(labelText: 'Balandlik (m)'),
            ),
            const SizedBox(height: DesignTokens.spacingLg),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  final length = double.tryParse(lengthController.text) ?? 0;
                  final width = double.tryParse(widthController.text) ?? 0;
                  final height = double.tryParse(heightController.text) ?? 0;
                  if (length <= 0 || width <= 0 || height <= 0) return;

                  ref
                      .read(manualRoomsProvider.notifier)
                      .addRoom(
                        ManualRoomEntry(
                          id: DateTime.now().microsecondsSinceEpoch.toString(),
                          name: nameController.text,
                          dimensions: RoomDimensions(
                            width: width,
                            length: length,
                            height: height,
                          ),
                        ),
                      );
                  // The manual W/L/H entry is a plain box: land it as a
                  // rectangle plan (in-app source of truth). The mirrored legacy
                  // Room keeps downstream display working; the last-added room
                  // wins as the active one.
                  ref.read(activeRoomPlanProvider.notifier).setPlan(
                        RoomPlan.rectangle(
                          width: width,
                          length: length,
                          ceilingHeightM: height,
                          source: RoomSource.wizard,
                          name: nameController.text.isEmpty
                              ? 'Xona'
                              : nameController.text,
                        ),
                      );
                  Navigator.of(sheetContext).pop();
                },
                child: const Text('Qo\'shish'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FloorplanUploadTab extends StatelessWidget {
  const _FloorplanUploadTab();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(DesignTokens.screenPaddingHorizontal),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(DesignTokens.spacingXl),
            decoration: BoxDecoration(
              color: const Color(0xFFF9FAFC),
              borderRadius: BorderRadius.circular(DesignTokens.radiusXl),
              border: Border.all(color: const Color(0xFFC3CBDA), width: 2),
            ),
            child: Column(
              children: [
                Container(
                  width: 76,
                  height: 76,
                  decoration: BoxDecoration(
                    color: DesignTokens.borderGrayAlt,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.cloud_upload_outlined,
                    color: DesignTokens.primaryBlue,
                    size: DesignTokens.iconXl,
                  ),
                ),
                const SizedBox(height: DesignTokens.spacingMd),
                Text(
                  'Floorplan rasmini yuklang',
                  style: DesignTokens.subtitle1,
                ),
                const SizedBox(height: DesignTokens.spacingXs),
                Text(
                  'PNG yoki JPG · maksimal 10 MB\nYoki bu yerga sudrab tashlang',
                  textAlign: TextAlign.center,
                  style: DesignTokens.caption.copyWith(
                    color: DesignTokens.textGray,
                  ),
                ),
                const SizedBox(height: DesignTokens.spacingMd),
                OutlinedButton(
                  onPressed: () {},
                  child: const Text('Fayl tanlash'),
                ),
              ],
            ),
          ),
          const SizedBox(height: DesignTokens.spacingMd),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(DesignTokens.spacingMd),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF6EE),
              borderRadius: BorderRadius.circular(DesignTokens.radiusLg),
              border: Border.all(color: const Color(0xFFFDE4CE)),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.info_outline,
                  color: DesignTokens.accentOrange,
                  size: DesignTokens.iconSm,
                ),
                const SizedBox(width: DesignTokens.spacingSm),
                Expanded(
                  child: Text(
                    'Aniq natija uchun o\'lchamlar ko\'rsatilgan plan yuklang',
                    style: DesignTokens.caption.copyWith(
                      color: const Color(0xFF9A5B22),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
