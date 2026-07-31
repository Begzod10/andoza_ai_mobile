import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../config/design_tokens.dart';

/// Room dimensions model
class RoomDimensions {
  final double width;
  final double length;
  final double height;
  final String unit;

  RoomDimensions({
    required this.width,
    required this.length,
    required this.height,
    required this.unit,
  });

  RoomDimensions copyWith({
    double? width,
    double? length,
    double? height,
    String? unit,
  }) {
    return RoomDimensions(
      width: width ?? this.width,
      length: length ?? this.length,
      height: height ?? this.height,
      unit: unit ?? this.unit,
    );
  }

  double getVolume() {
    return width * length * height;
  }

  bool isValid() {
    return width > 0 && length > 0 && height > 0;
  }
}

final dimensionsProvider = StateProvider<RoomDimensions>((ref) {
  return RoomDimensions(width: 0, length: 0, height: 0, unit: 'meters');
});

/// Room Dimensions Manual Entry (A6)
/// Allows users to manually enter room dimensions
class DimensionsEntryScreen extends ConsumerStatefulWidget {
  const DimensionsEntryScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<DimensionsEntryScreen> createState() =>
      _DimensionsEntryScreenState();
}

class _DimensionsEntryScreenState extends ConsumerState<DimensionsEntryScreen> {
  late TextEditingController _widthController;
  late TextEditingController _lengthController;
  late TextEditingController _heightController;

  @override
  void initState() {
    super.initState();
    _widthController = TextEditingController();
    _lengthController = TextEditingController();
    _heightController = TextEditingController();
  }

  @override
  void dispose() {
    _widthController.dispose();
    _lengthController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dimensions = ref.watch(dimensionsProvider);
    final isValid = dimensions.isValid();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: DesignTokens.backgroundLight,
        title: const Text('Room Dimensions'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: DesignTokens.backgroundLight,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(DesignTokens.spacingMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Text('Enter Room Dimensions', style: DesignTokens.heading2),
            const SizedBox(height: DesignTokens.spacingSm),
            Text(
              'Manually specify the room measurements for precise 3D modeling',
              style: DesignTokens.body1.copyWith(color: DesignTokens.textGray),
            ),
            const SizedBox(height: DesignTokens.spacingLg),
            // Unit selector
            Text('Unit', style: DesignTokens.subtitle2),
            const SizedBox(height: DesignTokens.spacingSm),
            Row(
              children: [
                Expanded(
                  child: _UnitButton(
                    label: 'Meters',
                    isSelected: dimensions.unit == 'meters',
                    onTap: () {
                      ref.read(dimensionsProvider.notifier).state = dimensions
                          .copyWith(unit: 'meters');
                    },
                  ),
                ),
                const SizedBox(width: DesignTokens.spacingMd),
                Expanded(
                  child: _UnitButton(
                    label: 'Feet',
                    isSelected: dimensions.unit == 'feet',
                    onTap: () {
                      ref.read(dimensionsProvider.notifier).state = dimensions
                          .copyWith(unit: 'feet');
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: DesignTokens.spacingLg),
            // Input fields
            Text('Dimensions', style: DesignTokens.subtitle2),
            const SizedBox(height: DesignTokens.spacingMd),
            // Width
            _DimensionInput(
              label: 'Width',
              unit: dimensions.unit == 'meters' ? 'm' : 'ft',
              controller: _widthController,
              onChanged: (value) {
                final width = double.tryParse(value) ?? 0;
                ref.read(dimensionsProvider.notifier).state = dimensions
                    .copyWith(width: width);
              },
            ),
            const SizedBox(height: DesignTokens.spacingMd),
            // Length
            _DimensionInput(
              label: 'Length',
              unit: dimensions.unit == 'meters' ? 'm' : 'ft',
              controller: _lengthController,
              onChanged: (value) {
                final length = double.tryParse(value) ?? 0;
                ref.read(dimensionsProvider.notifier).state = dimensions
                    .copyWith(length: length);
              },
            ),
            const SizedBox(height: DesignTokens.spacingMd),
            // Height
            _DimensionInput(
              label: 'Height (Ceiling)',
              unit: dimensions.unit == 'meters' ? 'm' : 'ft',
              controller: _heightController,
              onChanged: (value) {
                final height = double.tryParse(value) ?? 0;
                ref.read(dimensionsProvider.notifier).state = dimensions
                    .copyWith(height: height);
              },
            ),
            const SizedBox(height: DesignTokens.spacingXl),
            // Summary card
            if (isValid)
              Container(
                padding: const EdgeInsets.all(DesignTokens.spacingMd),
                decoration: BoxDecoration(
                  color: DesignTokens.primaryBlue.withOpacity(0.05),
                  border: Border.all(color: DesignTokens.primaryBlue),
                  borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Room Summary', style: DesignTokens.subtitle2),
                    const SizedBox(height: DesignTokens.spacingMd),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _SummaryItem(
                          label: 'Floor Area',
                          value:
                              '${(dimensions.width * dimensions.length).toStringAsFixed(2)} ${dimensions.unit == 'meters' ? 'm²' : 'ft²'}',
                        ),
                        _SummaryItem(
                          label: 'Volume',
                          value:
                              '${dimensions.getVolume().toStringAsFixed(2)} ${dimensions.unit == 'meters' ? 'm³' : 'ft³'}',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            const SizedBox(height: DesignTokens.spacingXl),
            // Action buttons
            SizedBox(
              width: double.infinity,
              height: DesignTokens.buttonHeightLarge,
              child: ElevatedButton(
                onPressed: isValid
                    ? () {
                        Navigator.of(context).pushNamed('/wall-measurements');
                      }
                    : null,
                child: const Text('Continue to Wall Measurements'),
              ),
            ),
            const SizedBox(height: DesignTokens.spacingMd),
            SizedBox(
              width: double.infinity,
              height: DesignTokens.buttonHeightMedium,
              child: OutlinedButton.icon(
                onPressed: () {
                  Navigator.of(context).pushNamed('/photo-scan');
                },
                icon: const Icon(Icons.arrow_back),
                label: const Text('Back'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DimensionInput extends StatelessWidget {
  final String label;
  final String unit;
  final TextEditingController controller;
  final Function(String) onChanged;

  const _DimensionInput({
    required this.label,
    required this.unit,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: DesignTokens.body2.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: DesignTokens.spacingSm),
        TextField(
          controller: controller,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
          ],
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: 'Enter $label',
            suffixText: unit,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
              borderSide: const BorderSide(color: DesignTokens.borderGray),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
              borderSide: const BorderSide(
                color: DesignTokens.primaryBlue,
                width: 2,
              ),
            ),
            prefixIcon: Icon(Icons.straighten, color: DesignTokens.textGray),
          ),
        ),
      ],
    );
  }
}

class _UnitButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _UnitButton({
    required this.label,
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
          vertical: DesignTokens.spacingMd,
        ),
        decoration: BoxDecoration(
          color: isSelected ? DesignTokens.primaryBlue : DesignTokens.white,
          border: Border.all(
            color: isSelected
                ? DesignTokens.primaryBlue
                : DesignTokens.borderGray,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
        ),
        child: Center(
          child: Text(
            label,
            style: DesignTokens.subtitle2.copyWith(
              color: isSelected ? DesignTokens.white : DesignTokens.textDark,
            ),
          ),
        ),
      ),
    );
  }
}

class _SummaryItem extends StatelessWidget {
  final String label;
  final String value;

  const _SummaryItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: DesignTokens.caption.copyWith(color: DesignTokens.textGray),
        ),
        const SizedBox(height: DesignTokens.spacingSm),
        Text(value, style: DesignTokens.subtitle1),
      ],
    );
  }
}
