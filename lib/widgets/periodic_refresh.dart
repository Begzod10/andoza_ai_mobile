import 'dart:async';

import 'package:flutter/widgets.dart';

/// Calls [onTick] every [interval] while it is mounted and visible. The timer
/// is cancelled on dispose, and ticks are skipped while the subtree is hidden
/// (e.g. an inactive tab kept alive by the shell), so nothing polls in the
/// background.
class PeriodicRefresh extends StatefulWidget {
  const PeriodicRefresh({
    required this.onTick,
    required this.child,
    this.interval = const Duration(seconds: 30),
    super.key,
  });

  final VoidCallback onTick;
  final Widget child;
  final Duration interval;

  @override
  State<PeriodicRefresh> createState() => _PeriodicRefreshState();
}

class _PeriodicRefreshState extends State<PeriodicRefresh> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(widget.interval, (_) {
      if (!mounted || !TickerMode.valuesOf(context).enabled) return;
      widget.onTick();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
