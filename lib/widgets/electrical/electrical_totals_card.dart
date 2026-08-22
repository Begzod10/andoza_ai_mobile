import 'package:flutter/material.dart';
import '../../config/design_tokens.dart';
import '../../models/electrical_model.dart';
import '../../providers/electrical_provider.dart';

/// D9: Elektr natijasi — real computed totals (wire length per device
/// type, device count), quantities only, no prices anywhere on this card.
class ElectricalTotalsCard extends StatelessWidget {
  const ElectricalTotalsCard({required this.layout, super.key});

  final ElectricalLayout layout;

  int get _deviceCount =>
      layout.devices.where((d) => d.type != DeviceType.breaker).length;
  int get _switchCount =>
      layout.devices.where((d) => d.type == DeviceType.lightSwitch).length;
  int get _lightCount =>
      layout.devices.where((d) => d.type == DeviceType.light).length;
  double get _totalWireMeters => computeTotalWireLengthMeters(layout);
  double get _socketWireMeters =>
      computeWireLengthMetersFor(layout, DeviceType.outlet);
  double get _switchWireMeters =>
      computeWireLengthMetersFor(layout, DeviceType.lightSwitch);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(DesignTokens.spacingMd),
      decoration: BoxDecoration(
        border: Border.all(color: DesignTokens.borderGray),
        borderRadius: BorderRadius.circular(DesignTokens.radiusLg),
        color: DesignTokens.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Elektr hisoblandi', style: DesignTokens.subtitle1),
          const SizedBox(height: DesignTokens.spacingMd),
          Row(
            children: [
              Expanded(
                child: _StatTile(
                  label: 'jami sim',
                  value: '${_totalWireMeters.toStringAsFixed(2)} m',
                ),
              ),
              const SizedBox(width: DesignTokens.spacingMd),
              Expanded(
                child: _StatTile(label: 'ta qurilma', value: '$_deviceCount'),
              ),
            ],
          ),
          const SizedBox(height: DesignTokens.spacingMd),
          Table(
            columnWidths: const {
              0: FlexColumnWidth(2),
              1: FlexColumnWidth(1),
              2: FlexColumnWidth(1.5),
            },
            children: [
              _headerRow(),
              for (final device in layout.devices.where(
                (d) => d.type != DeviceType.breaker,
              ))
                _deviceRow(device),
            ],
          ),
          const SizedBox(height: DesignTokens.spacingMd),
          Wrap(
            spacing: DesignTokens.spacingSm,
            runSpacing: DesignTokens.spacingSm,
            children: [
              _chip(
                'Rozetka simlari ${_socketWireMeters.toStringAsFixed(2)} m',
              ),
              _chip('Kalit simlari ${_switchWireMeters.toStringAsFixed(2)} m'),
              _chip('$_switchCount kalit · $_lightCount yoritish'),
            ],
          ),
        ],
      ),
    );
  }

  TableRow _headerRow() {
    return TableRow(
      children: [
        _headerCell('Qurilma'),
        _headerCell('Devor'),
        _headerCell('Balandlik'),
      ],
    );
  }

  Widget _headerCell(String text) => Padding(
    padding: const EdgeInsets.symmetric(vertical: DesignTokens.spacingXs),
    child: Text(
      text,
      style: DesignTokens.caption.copyWith(
        fontWeight: FontWeight.w700,
        color: DesignTokens.textGray,
      ),
    ),
  );

  TableRow _deviceRow(ElectricalDevice device) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: DesignTokens.spacingXs),
          child: Text(_deviceLabel(device.type), style: DesignTokens.caption),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: DesignTokens.spacingXs),
          child: Text(device.wallId, style: DesignTokens.caption),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: DesignTokens.spacingXs),
          child: Text(
            '${device.heightCm.toStringAsFixed(0)} sm',
            style: DesignTokens.caption,
          ),
        ),
      ],
    );
  }

  String _deviceLabel(DeviceType type) => switch (type) {
    DeviceType.outlet => 'Rozetka',
    DeviceType.lightSwitch => 'Kalit',
    DeviceType.light => 'Yoritish',
    DeviceType.breaker => 'Qutisi',
  };

  Widget _chip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: DesignTokens.spacingSm,
        vertical: DesignTokens.spacingXs,
      ),
      decoration: BoxDecoration(
        color: DesignTokens.primaryTint,
        borderRadius: BorderRadius.circular(DesignTokens.radiusFull),
      ),
      child: Text(
        label,
        style: DesignTokens.caption.copyWith(color: DesignTokens.primaryBlue),
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(DesignTokens.spacingMd),
      decoration: BoxDecoration(
        color: DesignTokens.primaryTint,
        borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: DesignTokens.heading3.copyWith(
              color: DesignTokens.primaryBlue,
            ),
          ),
          const SizedBox(height: DesignTokens.spacingXs),
          Text(
            label,
            style: DesignTokens.caption.copyWith(color: DesignTokens.textGray),
          ),
        ],
      ),
    );
  }
}
