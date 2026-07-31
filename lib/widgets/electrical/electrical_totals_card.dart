import 'package:flutter/material.dart';
import '../../config/design_tokens.dart';
import '../../models/electrical_model.dart';

/// Card displaying electrical totals and per-category subtotals
class ElectricalTotalsCard extends StatelessWidget {
  const ElectricalTotalsCard({required this.layout, super.key});

  final ElectricalLayout layout;

  int get _socketCount =>
      layout.devices.where((d) => d.type == DeviceType.outlet).length;
  int get _switchCount =>
      layout.devices.where((d) => d.type == DeviceType.lightSwitch).length;
  int get _lightCount =>
      layout.devices.where((d) => d.type == DeviceType.light).length;
  int get _wiringLength =>
      layout.wires.fold<int>(0, (sum, w) => sum + (w.to.dx.toInt()));
  int get _pipeLength =>
      layout.pipes.fold<int>(0, (sum, p) => sum + (p.to.dx.toInt()));

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(DesignTokens.spacing16),
      decoration: BoxDecoration(
        border: Border.all(color: DesignTokens.border),
        borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
        color: DesignTokens.surface,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Electrical Summary',
            style: DesignTokens.subtitle1.copyWith(color: DesignTokens.text),
          ),
          const SizedBox(height: DesignTokens.spacing16),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: DesignTokens.spacing12,
            crossAxisSpacing: DesignTokens.spacing12,
            children: [
              _StatTile(
                label: 'Sockets',
                value: '$_socketCount',
                icon: Icons.power_outlined,
              ),
              _StatTile(
                label: 'Switches',
                value: '$_switchCount',
                icon: Icons.light_mode_outlined,
              ),
              _StatTile(
                label: 'Lights',
                value: '$_lightCount',
                icon: Icons.lightbulb_outline,
              ),
              _StatTile(
                label: 'Wiring',
                value: '${_wiringLength}m',
                icon: Icons.cable,
              ),
            ],
          ),
          if (layout.pipes.isNotEmpty) ...[
            const SizedBox(height: DesignTokens.spacing16),
            const Divider(),
            const SizedBox(height: DesignTokens.spacing12),
            Text(
              'Plumbing Summary',
              style: DesignTokens.subtitle1.copyWith(color: DesignTokens.text),
            ),
            const SizedBox(height: DesignTokens.spacing12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _StatTile(
                  label: 'Pipe Length',
                  value: '${_pipeLength}m',
                  icon: Icons.plumbing,
                ),
                _StatTile(
                  label: 'Hot Water',
                  value:
                      '${layout.pipes.where((p) => p.type == PipeType.hot).length}',
                  icon: Icons.local_fire_department_outlined,
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({
    required this.label,
    required this.value,
    required this.icon,
  });

  final String label;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(DesignTokens.spacing12),
      decoration: BoxDecoration(
        color: DesignTokens.primaryBlue.withValues(alpha: 0.05),
        border: Border.all(
          color: DesignTokens.primaryBlue.withValues(alpha: 0.2),
        ),
        borderRadius: BorderRadius.circular(DesignTokens.radiusSm),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: DesignTokens.primaryBlue, size: 24),
          const SizedBox(height: DesignTokens.spacing8),
          Text(
            value,
            style: DesignTokens.heading3.copyWith(
              color: DesignTokens.primaryBlue,
            ),
          ),
          const SizedBox(height: DesignTokens.spacing4),
          Text(
            label,
            style: DesignTokens.caption.copyWith(
              color: DesignTokens.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
