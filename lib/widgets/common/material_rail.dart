import 'package:flutter/material.dart';
import '../../config/design_tokens.dart';

/// Collapsible right rail for material/finish selection
class MaterialRail extends StatefulWidget {
  const MaterialRail({
    required this.items,
    required this.onSelected,
    this.selectedId,
    super.key,
  });

  final List<MaterialItem> items;
  final ValueChanged<String> onSelected;
  final String? selectedId;

  @override
  State<MaterialRail> createState() => _MaterialRailState();
}

class _MaterialRailState extends State<MaterialRail>
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
            left: BorderSide(color: DesignTokens.border),
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
                  _isExpanded ? Icons.close : Icons.format_paint_outlined,
                  color: DesignTokens.textSecondary,
                ),
              ),
            ),
            // Material list
            Expanded(
              child: _isExpanded
                  ? ListView.builder(
                      itemCount: widget.items.length,
                      itemBuilder: (context, index) {
                        final item = widget.items[index];
                        final isSelected = item.id == widget.selectedId;
                        return _MaterialItemTile(
                          item: item,
                          isSelected: isSelected,
                          onTap: () => widget.onSelected(item.id),
                        );
                      },
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}

class _MaterialItemTile extends StatelessWidget {
  const _MaterialItemTile({
    required this.item,
    required this.isSelected,
    required this.onTap,
  });

  final MaterialItem item;
  final bool isSelected;
  final VoidCallback onTap;

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
          color: isSelected ? DesignTokens.primary.withValues(alpha: 0.1) : null,
          border: Border(
            left: BorderSide(
              color: isSelected ? DesignTokens.primary : Colors.transparent,
              width: 3,
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.name,
              style: DesignTokens.bodyMedium.copyWith(
                color: isSelected ? DesignTokens.primary : DesignTokens.text,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            const SizedBox(height: DesignTokens.spacing4),
            Text(
              item.description,
              style: DesignTokens.caption.copyWith(
                color: DesignTokens.textSecondary,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

class MaterialItem {
  MaterialItem({
    required this.id,
    required this.name,
    required this.description,
    this.imageUrl,
  });

  final String id;
  final String name;
  final String description;
  final String? imageUrl;
}
