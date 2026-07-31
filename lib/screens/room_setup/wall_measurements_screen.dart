import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../config/design_tokens.dart';

/// Wall information model
class WallMeasurement {
  final String id;
  final String name;
  final double length;
  final double height;
  final String wallType;
  final List<String> features;

  WallMeasurement({
    required this.id,
    required this.name,
    required this.length,
    required this.height,
    required this.wallType,
    required this.features,
  });

  WallMeasurement copyWith({
    String? id,
    String? name,
    double? length,
    double? height,
    String? wallType,
    List<String>? features,
  }) {
    return WallMeasurement(
      id: id ?? this.id,
      name: name ?? this.name,
      length: length ?? this.length,
      height: height ?? this.height,
      wallType: wallType ?? this.wallType,
      features: features ?? this.features,
    );
  }
}

final wallMeasurementsProvider =
    StateNotifierProvider<WallMeasurementsNotifier, List<WallMeasurement>>(
      (ref) => WallMeasurementsNotifier(),
    );

class WallMeasurementsNotifier extends StateNotifier<List<WallMeasurement>> {
  WallMeasurementsNotifier()
    : super([
        WallMeasurement(
          id: 'wall-n',
          name: 'North Wall',
          length: 4.5,
          height: 2.8,
          wallType: 'exterior',
          features: ['window'],
        ),
        WallMeasurement(
          id: 'wall-e',
          name: 'East Wall',
          length: 3.5,
          height: 2.8,
          wallType: 'interior',
          features: ['door'],
        ),
      ]);

  void updateWall(WallMeasurement wall) {
    final index = state.indexWhere((w) => w.id == wall.id);
    if (index >= 0) {
      final newList = List<WallMeasurement>.from(state);
      newList[index] = wall;
      state = newList;
    }
  }

  void addWall(WallMeasurement wall) {
    state = [...state, wall];
  }

  void removeWall(String id) {
    state = state.where((w) => w.id != id).toList();
  }
}

/// Wall Measurements with Elevation (A7)
/// Shows wall measurements and elevation data
class WallMeasurementsScreen extends ConsumerStatefulWidget {
  const WallMeasurementsScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<WallMeasurementsScreen> createState() =>
      _WallMeasurementsScreenState();
}

class _WallMeasurementsScreenState
    extends ConsumerState<WallMeasurementsScreen> {
  late PageController _pageController;
  int _currentWallIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final walls = ref.watch(wallMeasurementsProvider);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: DesignTokens.backgroundLight,
        title: const Text('Wall Measurements'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: DesignTokens.backgroundLight,
      body: Column(
        children: [
          // Info banner
          Container(
            margin: const EdgeInsets.all(DesignTokens.spacingMd),
            padding: const EdgeInsets.all(DesignTokens.spacingMd),
            decoration: BoxDecoration(
              color: DesignTokens.accentOrange.withOpacity(0.1),
              border: Border.all(
                color: DesignTokens.accentOrange.withOpacity(0.3),
              ),
              borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
            ),
            child: Row(
              children: [
                Icon(Icons.info_outlined, color: DesignTokens.accentOrange),
                const SizedBox(width: DesignTokens.spacingMd),
                Expanded(
                  child: Text(
                    'Review and adjust wall measurements and elevation for accurate modeling',
                    style: DesignTokens.body2.copyWith(
                      color: DesignTokens.textGray,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Wall viewer with elevation
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() => _currentWallIndex = index);
              },
              itemCount: walls.length,
              itemBuilder: (context, index) {
                return _WallElevationViewer(wall: walls[index]);
              },
            ),
          ),
          // Wall indicator and nav
          Padding(
            padding: const EdgeInsets.all(DesignTokens.spacingMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Page indicator
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${_currentWallIndex + 1} of ${walls.length}',
                      style: DesignTokens.body2.copyWith(
                        color: DesignTokens.textGray,
                      ),
                    ),
                    Row(
                      children: List.generate(
                        walls.length,
                        (index) => Container(
                          width: 8,
                          height: 8,
                          margin: const EdgeInsets.symmetric(
                            horizontal: DesignTokens.spacingSm,
                          ),
                          decoration: BoxDecoration(
                            color: index == _currentWallIndex
                                ? DesignTokens.primaryBlue
                                : DesignTokens.borderGray,
                            borderRadius: BorderRadius.circular(
                              DesignTokens.radiusFull,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: DesignTokens.spacingMd),
                // Wall details panel
                Container(
                  padding: const EdgeInsets.all(DesignTokens.spacingMd),
                  decoration: BoxDecoration(
                    color: DesignTokens.white,
                    border: Border.all(color: DesignTokens.borderGray),
                    borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                walls[_currentWallIndex].name,
                                style: DesignTokens.subtitle1,
                              ),
                              const SizedBox(height: DesignTokens.spacingSm),
                              Text(
                                '${walls[_currentWallIndex].length.toStringAsFixed(2)}m × ${walls[_currentWallIndex].height.toStringAsFixed(2)}m',
                                style: DesignTokens.body2.copyWith(
                                  color: DesignTokens.textGray,
                                ),
                              ),
                            ],
                          ),
                          Chip(
                            label: Text(
                              walls[_currentWallIndex].wallType,
                              style: DesignTokens.caption.copyWith(
                                color: DesignTokens.white,
                              ),
                            ),
                            backgroundColor:
                                walls[_currentWallIndex].wallType == 'exterior'
                                ? DesignTokens.accentOrange
                                : DesignTokens.primaryBlue,
                          ),
                        ],
                      ),
                      const SizedBox(height: DesignTokens.spacingMd),
                      // Features
                      if (walls[_currentWallIndex].features.isNotEmpty) ...[
                        Text(
                          'Features',
                          style: DesignTokens.body2.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: DesignTokens.spacingSm),
                        Wrap(
                          spacing: DesignTokens.spacingSm,
                          runSpacing: DesignTokens.spacingSm,
                          children: walls[_currentWallIndex].features
                              .map(
                                (feature) => Chip(
                                  label: Text(feature),
                                  backgroundColor: DesignTokens.borderGray,
                                  labelStyle: DesignTokens.caption,
                                ),
                              )
                              .toList(),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: DesignTokens.spacingMd),
                // Edit button
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () {
                      // Open edit dialog
                      _showEditWallDialog(context, walls[_currentWallIndex]);
                    },
                    icon: const Icon(Icons.edit),
                    label: const Text('Edit Wall'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).pushNamed('/door-window-modal');
        },
        backgroundColor: DesignTokens.primaryBlue,
        icon: const Icon(Icons.add),
        label: const Text('Add Door/Window'),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(DesignTokens.spacingMd),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back),
                label: const Text('Back'),
              ),
            ),
            const SizedBox(width: DesignTokens.spacingMd),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).pushNamed('/room-summary');
                },
                icon: const Icon(Icons.arrow_forward),
                label: const Text('Next'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showEditWallDialog(BuildContext context, WallMeasurement wall) {
    showDialog(
      context: context,
      builder: (context) => _WallEditDialog(
        wall: wall,
        onSave: (updatedWall) {
          ref.read(wallMeasurementsProvider.notifier).updateWall(updatedWall);
          Navigator.pop(context);
        },
      ),
    );
  }
}

class _WallElevationViewer extends StatelessWidget {
  final WallMeasurement wall;

  const _WallElevationViewer({required this.wall});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(DesignTokens.spacingMd),
      decoration: BoxDecoration(
        color: DesignTokens.white,
        borderRadius: BorderRadius.circular(DesignTokens.radiusLg),
        border: Border.all(color: DesignTokens.borderGray),
      ),
      child: CustomPaint(
        painter: _WallElevationPainter(wall: wall),
        size: Size.infinite,
      ),
    );
  }
}

class _WallElevationPainter extends CustomPainter {
  final WallMeasurement wall;

  _WallElevationPainter({required this.wall});

  @override
  void paint(Canvas canvas, Size size) {
    const padding = 40.0;
    final width = size.width - (2 * padding);
    final height = size.height - (2 * padding);

    // Scale factors
    final scaleX = width / wall.length;
    final scaleY = height / wall.height;

    // Draw grid
    final gridPaint = Paint()
      ..color = DesignTokens.borderGray.withOpacity(0.3)
      ..strokeWidth = 0.5;

    // Horizontal lines
    for (int i = 0; i <= 4; i++) {
      final y = padding + (i * height / 4);
      canvas.drawLine(
        Offset(padding, y),
        Offset(padding + width, y),
        gridPaint,
      );
    }

    // Vertical lines
    for (int i = 0; i <= 4; i++) {
      final x = padding + (i * width / 4);
      canvas.drawLine(
        Offset(x, padding),
        Offset(x, padding + height),
        gridPaint,
      );
    }

    // Draw wall
    final wallPaint = Paint()
      ..color = DesignTokens.primaryBlue
      ..strokeWidth = 3;

    final wallRect = Rect.fromLTWH(padding, padding, width, height);

    canvas.drawRect(
      wallRect,
      Paint()..color = DesignTokens.primaryBlue.withOpacity(0.05),
    );

    canvas.drawRect(wallRect, wallPaint..style = PaintingStyle.stroke);

    // Draw dimension lines
    final dimensionPaint = Paint()
      ..color = DesignTokens.accentOrange
      ..strokeWidth = 2;

    // Width dimension
    canvas.drawLine(
      Offset(padding, padding + height + 20),
      Offset(padding + width, padding + height + 20),
      dimensionPaint,
    );

    // Height dimension
    canvas.drawLine(
      Offset(padding - 20, padding),
      Offset(padding - 20, padding + height),
      dimensionPaint,
    );

    // Draw text labels
    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );

    // Width label
    textPainter.text = TextSpan(
      text: '${wall.length.toStringAsFixed(2)}m',
      style: const TextStyle(
        color: Color(0xFFF97316),
        fontSize: 12,
        fontWeight: FontWeight.bold,
      ),
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(
        padding + (width / 2) - (textPainter.width / 2),
        padding + height + 30,
      ),
    );

    // Height label
    textPainter.text = TextSpan(
      text: '${wall.height.toStringAsFixed(2)}m',
      style: const TextStyle(
        color: Color(0xFFF97316),
        fontSize: 12,
        fontWeight: FontWeight.bold,
      ),
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(padding - 40, padding + (height / 2) - (textPainter.height / 2)),
    );
  }

  @override
  bool shouldRepaint(_WallElevationPainter oldDelegate) {
    return oldDelegate.wall.length != wall.length ||
        oldDelegate.wall.height != wall.height;
  }
}

class _WallEditDialog extends StatefulWidget {
  final WallMeasurement wall;
  final Function(WallMeasurement) onSave;

  const _WallEditDialog({required this.wall, required this.onSave});

  @override
  State<_WallEditDialog> createState() => _WallEditDialogState();
}

class _WallEditDialogState extends State<_WallEditDialog> {
  late TextEditingController _lengthController;
  late TextEditingController _heightController;

  @override
  void initState() {
    super.initState();
    _lengthController = TextEditingController(
      text: widget.wall.length.toString(),
    );
    _heightController = TextEditingController(
      text: widget.wall.height.toString(),
    );
  }

  @override
  void dispose() {
    _lengthController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Edit ${widget.wall.name}'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _lengthController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Length (m)',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
              ),
            ),
          ),
          const SizedBox(height: DesignTokens.spacingMd),
          TextField(
            controller: _heightController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Height (m)',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
              ),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            final updatedWall = widget.wall.copyWith(
              length: double.tryParse(_lengthController.text) ?? 0,
              height: double.tryParse(_heightController.text) ?? 0,
            );
            widget.onSave(updatedWall);
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
