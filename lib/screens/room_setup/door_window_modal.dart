import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../config/design_tokens.dart';

/// Door/Window model
class DoorWindowFeature {
  final String id;
  final String type;
  final String name;
  final double width;
  final double height;
  final double positionX;
  final double positionY;
  final String material;

  DoorWindowFeature({
    required this.id,
    required this.type,
    required this.name,
    required this.width,
    required this.height,
    required this.positionX,
    required this.positionY,
    required this.material,
  });

  DoorWindowFeature copyWith({
    String? id,
    String? type,
    String? name,
    double? width,
    double? height,
    double? positionX,
    double? positionY,
    String? material,
  }) {
    return DoorWindowFeature(
      id: id ?? this.id,
      type: type ?? this.type,
      name: name ?? this.name,
      width: width ?? this.width,
      height: height ?? this.height,
      positionX: positionX ?? this.positionX,
      positionY: positionY ?? this.positionY,
      material: material ?? this.material,
    );
  }
}

final doorWindowFeaturesProvider = StateNotifierProvider<
    DoorWindowNotifier,
    List<DoorWindowFeature>>((ref) => DoorWindowNotifier());

class DoorWindowNotifier extends StateNotifier<List<DoorWindowFeature>> {
  DoorWindowNotifier() : super([]);

  void addFeature(DoorWindowFeature feature) {
    state = [...state, feature];
  }

  void updateFeature(DoorWindowFeature feature) {
    final index = state.indexWhere((f) => f.id == feature.id);
    if (index >= 0) {
      final newList = List<DoorWindowFeature>.from(state);
      newList[index] = feature;
      state = newList;
    }
  }

  void removeFeature(String id) {
    state = state.where((f) => f.id != id).toList();
  }
}

/// Door/Window Adding Modal (A8)
/// Allows adding doors and windows to room
class DoorWindowModal extends ConsumerStatefulWidget {
  const DoorWindowModal({Key? key}) : super(key: key);

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => const DoorWindowModal(),
      isScrollControlled: true,
      backgroundColor: DesignTokens.backgroundLight,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(DesignTokens.radiusXl),
        ),
      ),
    );
  }

  @override
  ConsumerState<DoorWindowModal> createState() => _DoorWindowModalState();
}

class _DoorWindowModalState extends ConsumerState<DoorWindowModal> {
  late TextEditingController _nameController;
  late TextEditingController _widthController;
  late TextEditingController _heightController;
  late TextEditingController _positionXController;
  late TextEditingController _positionYController;

  String _selectedType = 'window';
  String _selectedMaterial = 'glass';

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _widthController = TextEditingController();
    _heightController = TextEditingController();
    _positionXController = TextEditingController();
    _positionYController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _widthController.dispose();
    _heightController.dispose();
    _positionXController.dispose();
    _positionYController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.85,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (context, scrollController) {
        return SingleChildScrollView(
          controller: scrollController,
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              DesignTokens.spacingMd,
              DesignTokens.spacingMd,
              DesignTokens.spacingMd,
              MediaQuery.of(context).viewInsets.bottom + DesignTokens.spacingMd,
            ),
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
                  'Add Door or Window',
                  style: DesignTokens.heading2,
                ),
                const SizedBox(height: DesignTokens.spacingSm),
                Text(
                  'Define the position and dimensions of doors and windows',
                  style: DesignTokens.body2.copyWith(
                    color: DesignTokens.textGray,
                  ),
                ),
                const SizedBox(height: DesignTokens.spacingLg),
                // Type selection
                Text(
                  'Feature Type',
                  style: DesignTokens.subtitle2,
                ),
                const SizedBox(height: DesignTokens.spacingSm),
                Row(
                  children: [
                    Expanded(
                      child: _TypeButton(
                        label: 'Window',
                        icon: Icons.window,
                        isSelected: _selectedType == 'window',
                        onTap: () => setState(() => _selectedType = 'window'),
                      ),
                    ),
                    const SizedBox(width: DesignTokens.spacingMd),
                    Expanded(
                      child: _TypeButton(
                        label: 'Door',
                        icon: Icons.door_front_door,
                        isSelected: _selectedType == 'door',
                        onTap: () => setState(() => _selectedType = 'door'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: DesignTokens.spacingLg),
                // Form fields
                Text(
                  'Details',
                  style: DesignTokens.subtitle2,
                ),
                const SizedBox(height: DesignTokens.spacingMd),
                // Name
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Name (e.g., Main Door, Bay Window)',
                    prefixIcon: const Icon(Icons.label_outline),
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(DesignTokens.radiusMd),
                      borderSide: const BorderSide(
                        color: DesignTokens.borderGray,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: DesignTokens.spacingMd),
                // Width and Height
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _widthController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Width (m)',
                          prefixIcon: const Icon(Icons.straighten),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              DesignTokens.radiusMd,
                            ),
                            borderSide: const BorderSide(
                              color: DesignTokens.borderGray,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: DesignTokens.spacingMd),
                    Expanded(
                      child: TextField(
                        controller: _heightController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Height (m)',
                          prefixIcon: const Icon(Icons.straighten),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              DesignTokens.radiusMd,
                            ),
                            borderSide: const BorderSide(
                              color: DesignTokens.borderGray,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: DesignTokens.spacingMd),
                // Position
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _positionXController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Pos X (m)',
                          prefixIcon: const Icon(Icons.location_on_outlined),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              DesignTokens.radiusMd,
                            ),
                            borderSide: const BorderSide(
                              color: DesignTokens.borderGray,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: DesignTokens.spacingMd),
                    Expanded(
                      child: TextField(
                        controller: _positionYController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Pos Y (m)',
                          prefixIcon: const Icon(Icons.location_on_outlined),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              DesignTokens.radiusMd,
                            ),
                            borderSide: const BorderSide(
                              color: DesignTokens.borderGray,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: DesignTokens.spacingMd),
                // Material selection (for windows)
                if (_selectedType == 'window') ...[
                  Text(
                    'Material',
                    style: DesignTokens.body2.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: DesignTokens.spacingSm),
                  Wrap(
                    spacing: DesignTokens.spacingSm,
                    runSpacing: DesignTokens.spacingSm,
                    children: ['glass', 'wood', 'plastic', 'metal']
                        .map((material) => FilterChip(
                          label: Text(material),
                          selected: _selectedMaterial == material,
                          onSelected: (selected) {
                            setState(() => _selectedMaterial = material);
                          },
                        ))
                        .toList(),
                  ),
                  const SizedBox(height: DesignTokens.spacingMd),
                ],
                // Action buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancel'),
                      ),
                    ),
                    const SizedBox(width: DesignTokens.spacingMd),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _canSave()
                            ? () {
                                final feature = DoorWindowFeature(
                                  id:
                                      '${_selectedType}-${DateTime.now().millisecondsSinceEpoch}',
                                  type: _selectedType,
                                  name: _nameController.text,
                                  width:
                                      double.tryParse(_widthController.text) ??
                                          0,
                                  height: double.tryParse(
                                          _heightController.text) ??
                                      0,
                                  positionX: double.tryParse(
                                          _positionXController.text) ??
                                      0,
                                  positionY: double.tryParse(
                                          _positionYController.text) ??
                                      0,
                                  material: _selectedMaterial,
                                );

                                ref
                                    .read(doorWindowFeaturesProvider.notifier)
                                    .addFeature(feature);

                                Navigator.pop(context);
                              }
                            : null,
                        child: const Text('Add Feature'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: DesignTokens.spacingMd),
              ],
            ),
          ),
        );
      },
    );
  }

  bool _canSave() {
    return _nameController.text.isNotEmpty &&
        _widthController.text.isNotEmpty &&
        _heightController.text.isNotEmpty &&
        _positionXController.text.isNotEmpty &&
        _positionYController.text.isNotEmpty;
  }
}

class _TypeButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _TypeButton({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: DesignTokens.spacingMd,
          vertical: DesignTokens.spacingLg,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? DesignTokens.primaryBlue.withOpacity(0.1)
              : DesignTokens.white,
          border: Border.all(
            color: isSelected
                ? DesignTokens.primaryBlue
                : DesignTokens.borderGray,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: DesignTokens.iconLg,
              color: isSelected
                  ? DesignTokens.primaryBlue
                  : DesignTokens.textGray,
            ),
            const SizedBox(height: DesignTokens.spacingSm),
            Text(
              label,
              style: DesignTokens.body2.copyWith(
                color: isSelected
                    ? DesignTokens.primaryBlue
                    : DesignTokens.textGray,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
