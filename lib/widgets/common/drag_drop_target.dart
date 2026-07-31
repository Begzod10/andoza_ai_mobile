import 'package:flutter/material.dart';
import '../../config/design_tokens.dart';

/// Wraps a draggable item with visual feedback and drop target
class DragDropTarget<T extends Object> extends StatefulWidget {
  const DragDropTarget({
    required this.data,
    required this.child,
    required this.onDropped,
    this.childWhenDragging,
    this.feedback,
    this.onDragStarted,
    this.onDraggableCanceled,
    super.key,
  });

  final T data;
  final Widget child;
  final Function(T, Offset) onDropped;
  final Widget? childWhenDragging;
  final Widget? feedback;
  final VoidCallback? onDragStarted;
  final VoidCallback? onDraggableCanceled;

  @override
  State<DragDropTarget<T>> createState() => _DragDropTargetState<T>();
}

class _DragDropTargetState<T extends Object> extends State<DragDropTarget<T>> {
  bool _isDropZoneActive = false;
  Offset _dropPosition = Offset.zero;

  @override
  Widget build(BuildContext context) {
    return Draggable<T>(
      data: widget.data,
      feedback: widget.feedback ?? _DefaultFeedback(child: widget.child),
      childWhenDragging: widget.childWhenDragging ??
          Opacity(
            opacity: 0.5,
            child: widget.child,
          ),
      onDragStarted: widget.onDragStarted,
      onDraggableCanceled: (velocity, offset) {
        setState(() => _isDropZoneActive = false);
        widget.onDraggableCanceled?.call();
      },
      child: DragTarget<T>(
        onWillAccept: (data) {
          setState(() => _isDropZoneActive = true);
          return true;
        },
        onLeave: (data) {
          setState(() => _isDropZoneActive = false);
        },
        onAccept: (data) {
          setState(() => _isDropZoneActive = false);
          widget.onDropped(data, _dropPosition);
        },
        builder: (context, candidateData, rejectedData) {
          return Container(
            decoration: _isDropZoneActive
                ? BoxDecoration(
                    border: Border.all(
                      color: DesignTokens.primaryBlue,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(8),
                    color: DesignTokens.primaryBlue.withValues(alpha: 0.1),
                  )
                : null,
            child: widget.child,
          );
        },
      ),
    );
  }
}

class _DefaultFeedback extends StatelessWidget {
  const _DefaultFeedback({
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Opacity(
        opacity: 0.7,
        child: Transform.scale(
          scale: 1.1,
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}

/// Helper for tracking drag gestures on canvas
class DraggablePositionTracker extends StatefulWidget {
  const DraggablePositionTracker({
    required this.child,
    required this.onPositionChanged,
    super.key,
  });

  final Widget child;
  final ValueChanged<Offset> onPositionChanged;

  @override
  State<DraggablePositionTracker> createState() =>
      _DraggablePositionTrackerState();
}

class _DraggablePositionTrackerState extends State<DraggablePositionTracker> {
  late Offset _currentPosition;

  @override
  void initState() {
    super.initState();
    _currentPosition = Offset.zero;
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerMove: (event) {
        setState(() {
          _currentPosition = event.position;
          widget.onPositionChanged(_currentPosition);
        });
      },
      child: widget.child,
    );
  }
}
