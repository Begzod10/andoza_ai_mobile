import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/design_tokens.dart';
import '../../providers/measurement_provider.dart';

class A4ManualDimensionsScreen extends ConsumerStatefulWidget {
  const A4ManualDimensionsScreen({super.key});

  @override
  ConsumerState<A4ManualDimensionsScreen> createState() =>
      _A4ManualDimensionsScreenState();
}

class _A4ManualDimensionsScreenState
    extends ConsumerState<A4ManualDimensionsScreen> {
  late TextEditingController _widthController;
  late TextEditingController _lengthController;
  late TextEditingController _heightController;

  @override
  void initState() {
    super.initState();
    final measurement = ref.read(measurementProvider);
    _widthController =
        TextEditingController(text: measurement.width?.toString() ?? '');
    _lengthController =
        TextEditingController(text: measurement.length?.toString() ?? '');
    _heightController =
        TextEditingController(text: measurement.height?.toString() ?? '');
  }

  @override
  void dispose() {
    _widthController.dispose();
    _lengthController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  bool get _isValid =>
      _widthController.text.isNotEmpty &&
      _lengthController.text.isNotEmpty &&
      _heightController.text.isNotEmpty &&
      double.tryParse(_widthController.text) != null &&
      double.tryParse(_lengthController.text) != null &&
      double.tryParse(_heightController.text) != null;

  @override
  Widget build(BuildContext context) {
    final measurement = ref.watch(measurementProvider);
    final area = measurement.area;
    final volume = measurement.volume;

    return Scaffold(
      appBar: AppBar(title: const Text('Room Dimensions')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(DesignTokens.spacing24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Enter room dimensions',
                style: DesignTokens.headingMedium.copyWith(
                  color: DesignTokens.text,
                ),
              ),
              const SizedBox(height: DesignTokens.spacing16),
              Text(
                'Measure in meters (m)',
                style: DesignTokens.bodyMedium.copyWith(
                  color: DesignTokens.textSecondary,
                ),
              ),
              const SizedBox(height: DesignTokens.spacing32),
              _DimensionInput(
                label: 'Width (m)',
                controller: _widthController,
                onChanged: (_) => setState(() {}),
              ),
              const SizedBox(height: DesignTokens.spacing16),
              _DimensionInput(
                label: 'Length (m)',
                controller: _lengthController,
                onChanged: (_) => setState(() {}),
              ),
              const SizedBox(height: DesignTokens.spacing16),
              _DimensionInput(
                label: 'Height (m)',
                controller: _heightController,
                onChanged: (_) => setState(() {}),
              ),
              const SizedBox(height: DesignTokens.spacing32),
              if (_isValid) ...[
                Container(
                  padding: const EdgeInsets.all(DesignTokens.spacing16),
                  decoration: BoxDecoration(
                    color: DesignTokens.success.withValues(alpha: 0.1),
                    borderRadius:
                        BorderRadius.circular(DesignTokens.radiusLarge),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Calculated Values:',
                        style: DesignTokens.labelMedium.copyWith(
                          color: DesignTokens.success,
                        ),
                      ),
                      const SizedBox(height: DesignTokens.spacing12),
                      _CalcRow('Floor Area:', area != null
                          ? '${area.toStringAsFixed(2)} m²'
                          : 'N/A'),
                      _CalcRow('Volume:', volume != null
                          ? '${volume.toStringAsFixed(2)} m³'
                          : 'N/A'),
                    ],
                  ),
                ),
                const SizedBox(height: DesignTokens.spacing24),
              ],
              ElevatedButton(
                onPressed: _isValid
                    ? () {
                        ref.read(measurementProvider.notifier).setDimensions(
                          double.parse(_widthController.text),
                          double.parse(_lengthController.text),
                          double.parse(_heightController.text),
                        );
                        context.push('/measurement/a8');
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: DesignTokens.primary,
                  padding: const EdgeInsets.symmetric(
                    vertical: DesignTokens.spacing12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(DesignTokens.radiusLarge),
                  ),
                ),
                child: Text(
                  'Review Measurement',
                  style: DesignTokens.bodyLarge.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DimensionInput extends StatelessWidget {
  const _DimensionInput({
    required this.label,
    required this.controller,
    required this.onChanged,
  });

  final String label;
  final TextEditingController controller;
  final Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(DesignTokens.radiusLarge),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: DesignTokens.spacing16,
          vertical: DesignTokens.spacing12,
        ),
      ),
    );
  }
}

class _CalcRow extends StatelessWidget {
  const _CalcRow(this.label, this.value);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: DesignTokens.spacing8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: DesignTokens.bodyMedium.copyWith(
              color: DesignTokens.text,
            ),
          ),
          Text(
            value,
            style: DesignTokens.bodyMedium.copyWith(
              fontWeight: FontWeight.w600,
              color: DesignTokens.success,
            ),
          ),
        ],
      ),
    );
  }
}
