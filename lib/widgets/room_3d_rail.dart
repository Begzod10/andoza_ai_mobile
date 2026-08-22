import 'package:flutter/material.dart';
import '../config/design_tokens.dart';

/// One selectable item in a [Room3DRail] tab (a paint swatch, a floor
/// material, a furniture piece, an electrical device, etc.).
class RailItem {
  const RailItem({
    required this.id,
    required this.label,
    this.color,
    this.icon,
  });

  final String id;
  final String label;
  final Color? color;
  final IconData? icon;
}

/// One tab of a [Room3DRail], e.g. "Bo'yoq" / "Oboy" / "Kafel".
class RailTab {
  const RailTab({required this.label, required this.items});

  final String label;
  final List<RailItem> items;
}

/// Collapsible right rail used for every in-3D-room material/device
/// selection (Batch B3 onward, Batch C decoration, Batch D electrical) —
/// per spec's "Recurring patterns": "~84px wide, rounded left corners,
/// small tabs on top, vertical swatch/device column, collapse '›' tab."
/// Built on [material_rail.dart]'s single-list collapse/expand pattern,
/// extended here for multiple tabs so later batches don't need to fork it.
class Room3DRail extends StatefulWidget {
  const Room3DRail({
    required this.tabs,
    required this.onItemSelected,
    this.selectedItemId,
    this.initiallyExpanded = false,
    super.key,
  });

  final List<RailTab> tabs;
  final ValueChanged<RailItem> onItemSelected;
  final String? selectedItemId;
  final bool initiallyExpanded;

  @override
  State<Room3DRail> createState() => _Room3DRailState();
}

class _Room3DRailState extends State<Room3DRail>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late bool _isExpanded;
  int _activeTab = 0;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.initiallyExpanded;
    _controller = AnimationController(
      duration: DesignTokens.animationNormal,
      vsync: this,
      value: _isExpanded ? 1 : 0,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() => _isExpanded = !_isExpanded);
    if (_isExpanded) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final width = 84.0 + (196.0 * _controller.value);
        return Container(
          width: width,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.96),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(DesignTokens.radiusLg),
              bottomLeft: Radius.circular(DesignTokens.radiusLg),
            ),
            boxShadow: const [DesignTokens.shadowCard],
          ),
          child: child,
        );
      },
      child: Column(
        children: [
          InkWell(
            onTap: _toggle,
            child: SizedBox(
              height: 44,
              child: Icon(
                _isExpanded ? Icons.chevron_right : Icons.chevron_left,
                color: DesignTokens.textGray,
              ),
            ),
          ),
          if (_isExpanded) ...[
            if (widget.tabs.length > 1)
              SizedBox(
                height: 36,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(
                    horizontal: DesignTokens.spacingSm,
                  ),
                  children: [
                    for (var i = 0; i < widget.tabs.length; i++)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: DesignTokens.spacingXs,
                        ),
                        child: ChoiceChip(
                          label: Text(widget.tabs[i].label),
                          selected: _activeTab == i,
                          onSelected: (_) => setState(() => _activeTab = i),
                          labelStyle: DesignTokens.caption.copyWith(
                            color: _activeTab == i
                                ? DesignTokens.primaryBlue
                                : DesignTokens.textGray,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(DesignTokens.spacingSm),
                children: [
                  for (final item in widget.tabs[_activeTab].items)
                    _RailItemTile(
                      item: item,
                      selected: item.id == widget.selectedItemId,
                      onTap: () => widget.onItemSelected(item),
                    ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _RailItemTile extends StatelessWidget {
  const _RailItemTile({
    required this.item,
    required this.selected,
    required this.onTap,
  });

  final RailItem item;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Draggable<RailItem>(
      data: item,
      feedback: Material(
        color: Colors.transparent,
        child: _swatch(opacity: 0.85),
      ),
      childWhenDragging: Opacity(opacity: 0.3, child: _swatch()),
      child: GestureDetector(onTap: onTap, child: _swatch()),
    );
  }

  Widget _swatch({double opacity = 1}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: DesignTokens.spacingXs),
      child: Opacity(
        opacity: opacity,
        child: Column(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: item.color ?? DesignTokens.borderGrayAlt,
                borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
                border: Border.all(
                  color: selected
                      ? DesignTokens.primaryBlue
                      : Colors.transparent,
                  width: 3,
                ),
              ),
              child: item.icon != null
                  ? Icon(item.icon, color: DesignTokens.textDark)
                  : null,
            ),
            const SizedBox(height: DesignTokens.spacingXs),
            Text(
              item.label,
              style: DesignTokens.caption,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
