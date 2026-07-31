import 'package:flutter/material.dart';
import '../../config/design_tokens.dart';
import '../../models/electrical_model.dart';

/// Collapsible left rail for device/fixture selection
class DeviceRail extends StatefulWidget {
  const DeviceRail({
    required this.deviceTypes,
    required this.onDeviceSelected,
    super.key,
  });

  final List<DeviceType> deviceTypes;
  final ValueChanged<DeviceType> onDeviceSelected;

  @override
  State<DeviceRail> createState() => _DeviceRailState();
}

class _DeviceRailState extends State<DeviceRail>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleExpand() {
    if (_isExpanded) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
    setState(() => _isExpanded = !_isExpanded);
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: Tween<double>(begin: 0.8, end: 1.0).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeOut),
      ),
      child: Container(
        width: _isExpanded ? 280 : 60,
        decoration: BoxDecoration(
          border: Border(
            right: BorderSide(color: DesignTokens.border),
          ),
        ),
        child: Column(
          children: [
            // Toggle button
            Container(
              height: 60,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: DesignTokens.border),
                ),
              ),
              child: InkWell(
                onTap: _toggleExpand,
                child: Icon(
                  _isExpanded ? Icons.close : Icons.developer_mode_outlined,
                  color: DesignTokens.textSecondary,
                ),
              ),
            ),
            // Device list
            Expanded(
              child: _isExpanded
                  ? ListView.builder(
                      itemCount: widget.deviceTypes.length,
                      itemBuilder: (context, index) {
                        final type = widget.deviceTypes[index];
                        return _DeviceItemTile(
                          type: type,
                          onTap: () => widget.onDeviceSelected(type),
                        );
                      },
                    )
                  : SizedBox(
                      width: 60,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: widget.deviceTypes
                            .map(
                              (type) => Tooltip(
                                message: _getLabel(type),
                                child: Icon(
                                  _getIcon(type),
                                  color: DesignTokens.textSecondary,
                                  size: 24,
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getIcon(DeviceType type) {
    switch (type) {
      case DeviceType.outlet:
        return Icons.outlet;
      case DeviceType.lightSwitch:
        return Icons.toggle_on_outlined;
      case DeviceType.light:
        return Icons.lightbulb_outline;
      case DeviceType.breaker:
        return Icons.miscellaneous_services_outlined;
    }
  }

  String _getLabel(DeviceType type) {
    switch (type) {
      case DeviceType.outlet:
        return 'Outlet';
      case DeviceType.lightSwitch:
        return 'Switch';
      case DeviceType.light:
        return 'Light';
      case DeviceType.breaker:
        return 'Breaker';
    }
  }
}

class _DeviceItemTile extends StatelessWidget {
  const _DeviceItemTile({
    required this.type,
    required this.onTap,
  });

  final DeviceType type;
  final VoidCallback onTap;

  IconData get _icon {
    switch (type) {
      case DeviceType.outlet:
        return Icons.outlet;
      case DeviceType.lightSwitch:
        return Icons.toggle_on_outlined;
      case DeviceType.light:
        return Icons.lightbulb_outline;
      case DeviceType.breaker:
        return Icons.miscellaneous_services_outlined;
    }
  }

  String get _label {
    switch (type) {
      case DeviceType.outlet:
        return 'Outlet';
      case DeviceType.lightSwitch:
        return 'Switch';
      case DeviceType.light:
        return 'Light';
      case DeviceType.breaker:
        return 'Breaker';
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: DesignTokens.spacing12,
          vertical: DesignTokens.spacing16,
        ),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: DesignTokens.border,
              width: 0.5,
            ),
          ),
        ),
        child: Row(
          children: [
            Icon(
              _icon,
              color: DesignTokens.primaryBlue,
              size: 24,
            ),
            const SizedBox(width: DesignTokens.spacing12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _label,
                    style: DesignTokens.bodyMedium.copyWith(
                      color: DesignTokens.text,
                    ),
                  ),
                  const SizedBox(height: DesignTokens.spacing4),
                  Text(
                    'Tap to place',
                    style: DesignTokens.caption.copyWith(
                      color: DesignTokens.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.add_circle_outline,
              color: DesignTokens.textSecondary,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
