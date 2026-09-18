import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../providers/room_persistence_provider.dart';

/// Deferral shim for the native "fake 3D" design/electrical screens (paint &
/// wallpaper, top-down plan, electrical placement). Those screens only ever
/// rendered a flat perspective placeholder ([RoomPerspectiveView]) — the REAL
/// 3D editing lives in the web Studio embedded via [StudioWebViewScreen]. Rather
/// than strand the user on the placeholder, this view ensures the active room is
/// persisted to the backend (the `/studio/{roomId}` route needs the backend room
/// id, not the local client id) and then **replaces** itself with the Studio.
///
/// It uses `pushReplacement` (not `push`) so the deferred screen leaves no entry
/// in the back stack: returning from the Studio lands on whatever preceded it
/// (e.g. the B3 decoration rail), never on this shim — which would otherwise
/// re-fire the redirect in a loop.
///
/// If no room can be persisted (unauthenticated / backend unreachable), it falls
/// back to the real smeta flow at `/estimation/e1`, which works offline against
/// the locally-computed estimate.
class StudioRedirectView extends ConsumerStatefulWidget {
  const StudioRedirectView({super.key});

  @override
  ConsumerState<StudioRedirectView> createState() => _StudioRedirectViewState();
}

class _StudioRedirectViewState extends ConsumerState<StudioRedirectView> {
  bool _navigated = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _redirect());
  }

  Future<void> _redirect() async {
    if (_navigated) return;
    await ref.read(roomPersistenceProvider.notifier).ensurePersisted();
    if (!mounted || _navigated) return;
    _navigated = true;
    final roomId = ref.read(roomPersistenceProvider).valueOrNull?.roomId;
    context.pushReplacement(
      roomId != null ? '/studio/$roomId' : '/estimation/e1',
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
