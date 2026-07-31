import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../config/design_tokens.dart';

/// Room type model
class RoomType {
  final String id;
  final String name;
  final String icon;
  final String description;

  const RoomType({
    required this.id,
    required this.name,
    required this.icon,
    required this.description,
  });
}

/// Riverpod provider for room selection
final selectedRoomTypeProvider = StateProvider<RoomType?>((ref) => null);

const List<RoomType> predefinedRooms = [
  RoomType(
    id: 'living-room',
    name: 'Living Room',
    icon: '🛋️',
    description: 'Main living space',
  ),
  RoomType(
    id: 'bedroom',
    name: 'Bedroom',
    icon: '🛏️',
    description: 'Sleeping area',
  ),
  RoomType(
    id: 'kitchen',
    name: 'Kitchen',
    icon: '🍳',
    description: 'Cooking area',
  ),
  RoomType(
    id: 'bathroom',
    name: 'Bathroom',
    icon: '🚿',
    description: 'Bath/WC',
  ),
  RoomType(
    id: 'office',
    name: 'Office',
    icon: '💼',
    description: 'Work space',
  ),
  RoomType(
    id: 'garage',
    name: 'Garage',
    icon: '🚗',
    description: 'Parking/Storage',
  ),
  RoomType(
    id: 'hallway',
    name: 'Hallway',
    icon: '🚪',
    description: 'Corridor',
  ),
  RoomType(
    id: 'custom',
    name: 'Custom',
    icon: '✏️',
    description: 'Define your own',
  ),
];

/// Room Selection Bottom Sheet (A3)
/// Allows user to select room type when adding a new room
class RoomSelectionSheet extends ConsumerStatefulWidget {
  final Function(RoomType)? onRoomSelected;

  const RoomSelectionSheet({
    Key? key,
    this.onRoomSelected,
  }) : super(key: key);

  @override
  ConsumerState<RoomSelectionSheet> createState() => _RoomSelectionSheetState();

  static void show(BuildContext context, Function(RoomType) onRoomSelected) {
    showModalBottomSheet(
      context: context,
      builder: (context) => RoomSelectionSheet(
        onRoomSelected: onRoomSelected,
      ),
      isScrollControlled: true,
      backgroundColor: DesignTokens.backgroundLight,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(DesignTokens.radiusXl),
        ),
      ),
    );
  }
}

class _RoomSelectionSheetState extends ConsumerState<RoomSelectionSheet> {
  late TextEditingController _customRoomController;
  bool _showCustomInput = false;

  @override
  void initState() {
    super.initState();
    _customRoomController = TextEditingController();
  }

  @override
  void dispose() {
    _customRoomController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.8,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (context, scrollController) {
        return SingleChildScrollView(
          controller: scrollController,
          child: Padding(
            padding: const EdgeInsets.all(DesignTokens.spacingMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Handle
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: DesignTokens.spacingLg),
                    decoration: BoxDecoration(
                      color: DesignTokens.borderGray,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                // Title
                Text(
                  'Select Room Type',
                  style: DesignTokens.heading2,
                ),
                const SizedBox(height: DesignTokens.spacingSm),
                Text(
                  'Choose the type of room you want to scan',
                  style: DesignTokens.body2.copyWith(
                    color: DesignTokens.textGray,
                  ),
                ),
                const SizedBox(height: DesignTokens.spacingLg),
                // Room Grid
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: DesignTokens.spacingMd,
                    mainAxisSpacing: DesignTokens.spacingMd,
                    childAspectRatio: 1.1,
                  ),
                  itemCount: predefinedRooms.length,
                  itemBuilder: (context, index) {
                    final room = predefinedRooms[index];
                    final isCustom = room.id == 'custom';

                    return _RoomTypeCard(
                      room: room,
                      onTap: () {
                        if (isCustom) {
                          setState(() => _showCustomInput = true);
                        } else {
                          if (widget.onRoomSelected != null) {
                            widget.onRoomSelected!(room);
                          } else {
                            ref.read(selectedRoomTypeProvider.notifier).state = room;
                          }
                          Navigator.pop(context);
                        }
                      },
                    );
                  },
                ),
                const SizedBox(height: DesignTokens.spacingLg),
                // Custom input
                if (_showCustomInput) ...[
                  Text(
                    'Room Name',
                    style: DesignTokens.subtitle2,
                  ),
                  const SizedBox(height: DesignTokens.spacingSm),
                  TextField(
                    controller: _customRoomController,
                    decoration: InputDecoration(
                      hintText: 'Enter room name',
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(DesignTokens.radiusMd),
                        borderSide: const BorderSide(
                          color: DesignTokens.borderGray,
                        ),
                      ),
                      prefixIcon: const Icon(Icons.edit_outlined),
                    ),
                  ),
                  const SizedBox(height: DesignTokens.spacingMd),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            setState(() {
                              _showCustomInput = false;
                              _customRoomController.clear();
                            });
                          },
                          child: const Text('Cancel'),
                        ),
                      ),
                      const SizedBox(width: DesignTokens.spacingMd),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _customRoomController.text.isNotEmpty
                              ? () {
                                  final customRoom = RoomType(
                                    id: 'custom-${DateTime.now().millisecondsSinceEpoch}',
                                    name: _customRoomController.text,
                                    icon: '✏️',
                                    description: 'Custom room',
                                  );
                                  if (widget.onRoomSelected != null) {
                                    widget.onRoomSelected!(customRoom);
                                  } else {
                                    ref.read(selectedRoomTypeProvider.notifier).state = customRoom;
                                  }
                                  Navigator.pop(context);
                                }
                              : null,
                          child: const Text('Confirm'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: DesignTokens.spacingMd),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}

class _RoomTypeCard extends StatefulWidget {
  final RoomType room;
  final VoidCallback onTap;

  const _RoomTypeCard({
    required this.room,
    required this.onTap,
  });

  @override
  State<_RoomTypeCard> createState() => _RoomTypeCardState();
}

class _RoomTypeCardState extends State<_RoomTypeCard> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          decoration: BoxDecoration(
            color: _isHovering
                ? DesignTokens.primaryBlue.withOpacity(0.05)
                : DesignTokens.white,
            border: Border.all(
              color: _isHovering
                  ? DesignTokens.primaryBlue.withOpacity(0.3)
                  : DesignTokens.borderGray,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(DesignTokens.radiusLg),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.room.icon,
                style: const TextStyle(fontSize: 40),
              ),
              const SizedBox(height: DesignTokens.spacingSm),
              Text(
                widget.room.name,
                style: DesignTokens.subtitle2,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: DesignTokens.spacingSm),
              Text(
                widget.room.description,
                style: DesignTokens.caption.copyWith(
                  color: DesignTokens.textGray,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
