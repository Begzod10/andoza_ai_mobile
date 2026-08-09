import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../config/app_config.dart';
import '../../config/design_tokens.dart';
import '../../models/user_model.dart';
import '../../providers/auth_provider.dart';

/// Embeds a web page from the React/Three.js frontend (the 3D Studio or the
/// room-capture wizard) in a WebView, authenticated as the current mobile user.
///
/// [path] is the frontend route to open once auth is bridged, e.g.
/// `/studio/{roomId}` or `/wizard`. [title] is the app-bar label.
///
/// Auth bridge: the web app authenticates via an HttpOnly `token` cookie
/// (sent to the API with `credentials: "include"`) and gates its routes on a
/// Zustand `uy-tamir-auth` localStorage flag. This screen reproduces both from
/// the mobile session — it sets the cookie for the shared host (cookies ignore
/// port, so one cookie covers both the :5173 frontend and :8000 API) and seeds
/// the localStorage flag before navigating to [path].
class StudioWebViewScreen extends ConsumerStatefulWidget {
  const StudioWebViewScreen({
    required this.path,
    this.title = '3D Studio',
    super.key,
  });

  /// Convenience constructor for a specific room's 3D Studio.
  // ignore: prefer_const_constructors_in_immutables
  StudioWebViewScreen.studio({required String roomId, Key? key})
      : this(path: '/studio/$roomId', title: '3D Studio', key: key);

  /// The frontend route to open (e.g. `/wizard`, `/studio/{roomId}`).
  final String path;
  final String title;

  @override
  ConsumerState<StudioWebViewScreen> createState() =>
      _StudioWebViewScreenState();
}

class _StudioWebViewScreenState extends ConsumerState<StudioWebViewScreen> {
  // Nullable + built synchronously in _init before any await, so build() never
  // reads it uninitialised (a late field would throw LateInitializationError on
  // the first frame, before the async cookie/setup completes).
  WebViewController? _controller;
  bool _seeded = false;
  bool _loading = true;
  String? _error;

  String get _targetUrl => '${AppConfig.studioBaseUrl}${widget.path}';

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() {
    final auth = ref.read(authStateProvider);
    if (auth is! AuthAuthenticated) {
      setState(() {
        _loading = false;
        _error = 'Studio ochish uchun tizimga kiring.';
      });
      return;
    }

    // Construct the controller synchronously so build() always has one; the
    // first load is kicked off from _bootstrap once the cookie is set.
    final controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(DesignTokens.white)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (_) async {
            // On the first load of the origin, seed the auth flag then navigate
            // to the studio route (now past the RequireAuth guard).
            if (!_seeded) {
              _seeded = true;
              // The field is assigned before any page load fires this callback.
              await _controller!.runJavaScript(_authSeedJs(auth.user));
              await _controller!.loadRequest(Uri.parse(_targetUrl));
              return;
            }
            if (mounted) setState(() => _loading = false);
          },
          onWebResourceError: (err) {
            // Ignore sub-resource errors; only surface a hard main-frame fail.
            if (err.isForMainFrame ?? true) {
              if (mounted) {
                setState(() {
                  _loading = false;
                  _error = 'Studio yuklanmadi: ${err.description}';
                });
              }
            }
          },
        ),
      );
    setState(() => _controller = controller);
    _bootstrap(auth, controller);
  }

  Future<void> _bootstrap(
    AuthAuthenticated auth,
    WebViewController controller,
  ) async {
    final host = Uri.parse(AppConfig.studioBaseUrl).host;

    // Set the auth cookie for the shared host so the frontend's credentialed
    // API calls are authenticated (cookies ignore port, so one cookie covers
    // both the frontend and the API when they share a host — the default). If
    // STUDIO_BASE_URL is pointed at a different host than the API, this cookie
    // won't reach the API and its calls will 401. Only the access token is
    // seeded (no refresh_token cookie), so a session outliving the token's TTL
    // would drop auth; fine for a normal editing session.
    await WebViewCookieManager().setCookie(
      WebViewCookie(name: 'token', value: auth.token, domain: host, path: '/'),
    );

    // First load: the origin root establishes the origin so localStorage is
    // writable. It may bounce to /login (not yet seeded) — that's expected.
    await controller.loadRequest(Uri.parse(AppConfig.studioBaseUrl));
  }

  /// JS that writes the Zustand `uy-tamir-auth` persisted state so the web
  /// app's route guard sees an authenticated session.
  String _authSeedJs(User user) {
    final payload = jsonEncode({
      'state': {
        'user': {
          'id': user.id,
          'phone': user.phone,
          'username': user.username,
          'name': user.name,
          'created_at': DateTime.now().toUtc().toIso8601String(),
        },
        'isAuthenticated': true,
      },
      'version': 0,
    });
    // jsonEncode again to safely embed as a JS string literal.
    return "localStorage.setItem('uy-tamir-auth', ${jsonEncode(payload)});";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: DesignTokens.white,
      ),
      body: Stack(
        children: [
          if (_error == null && _controller != null)
            WebViewWidget(controller: _controller!),
          if (_loading && _error == null)
            const Center(child: CircularProgressIndicator()),
          if (_error != null) _ErrorView(message: _error!, onRetry: _retry),
        ],
      ),
    );
  }

  void _retry() {
    setState(() {
      _error = null;
      _loading = true;
      _seeded = false;
      _controller = null;
    });
    _init();
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(DesignTokens.spacingLg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.view_in_ar_outlined,
                size: 48, color: DesignTokens.textMuted),
            const SizedBox(height: DesignTokens.spacingMd),
            Text(message, textAlign: TextAlign.center),
            const SizedBox(height: DesignTokens.spacingMd),
            OutlinedButton(onPressed: onRetry, child: const Text('Qayta urinish')),
          ],
        ),
      ),
    );
  }
}
