import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../config/app_config.dart';
import '../../config/design_tokens.dart';
import '../../models/user_model.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/common/error_view.dart';

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

  /// Convenience constructor for a specific room's 3D Studio. An optional
  /// [phase] (a web `PhaseKey`, e.g. `shpaklovka`/`boyoq`) is forwarded as a
  /// `?phase=` query param so the studio opens on that renovation stage.
  // ignore: prefer_const_constructors_in_immutables
  StudioWebViewScreen.studio({required String roomId, String? phase, Key? key})
      : this(
          path: phase != null && phase.isNotEmpty
              ? '/studio/$roomId?phase=$phase'
              : '/studio/$roomId',
          title: '3D Studio',
          key: key,
        );

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
  // True once the studio route itself has finished loading. Until then, any
  // bounce to /login is the expected pre-seed guard redirect and must be
  // ignored; only a /login navigation *after* this point means the web
  // session ended or the user exited, and should return us to the native app.
  bool _studioReady = false;
  // Guards against firing the return-to-app navigation more than once.
  bool _exiting = false;
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
          // The WebView is meant to host ONLY the 3D Studio. Intercept a *hard*
          // navigation that leaves the studio (e.g. the web app's back button →
          // /projects, or `window.location = '/login'` on session end): cancel
          // it and pop back to the native app instead of stranding the user on
          // a web page inside the WebView. Studio sub-pages (the tabs, e.g.
          // /studio/{id}/mebelirovka) stay in the WebView.
          onNavigationRequest: (request) {
            if (_studioReady &&
                request.isMainFrame &&
                _hasLeftStudio(request.url)) {
              _returnToApp();
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
          // Client-side (SPA / React Router) navigations — the studio back
          // button (→ /projects), an in-app logout (→ /login), etc. — don't
          // fire a navigation request, they only change the URL. Catch them
          // here so leaving the studio still returns the user to the native app.
          onUrlChange: (change) {
            if (_studioReady && _hasLeftStudio(change.url)) {
              _returnToApp();
            }
          },
          onPageFinished: (url) async {
            // On the first load of the origin, seed the auth flag then navigate
            // to the studio route (now past the RequireAuth guard).
            if (!_seeded) {
              _seeded = true;
              // The field is assigned before any page load fires this callback.
              await _controller!.runJavaScript(_authSeedJs(auth.user));
              await _controller!.loadRequest(Uri.parse(_targetUrl));
              return;
            }
            // Arm the leave-studio exit ONLY once an actual studio page has
            // finished loading. During bootstrap the origin root bounces
            // through '/', /projects and /login (multiple pageFinished events);
            // those must not arm the exit, or the next bounce would pop us
            // straight back out before the studio ever renders.
            if (!_hasLeftStudio(url) && !_studioReady) {
              _studioReady = true;
            }
            if (mounted && _loading) setState(() => _loading = false);
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

  /// Whether [url] is a page *outside* the 3D Studio, i.e. the web app has
  /// navigated away from it (back to `/projects`, `/login` on session end,
  /// the `/apartments/...` menu entry, …). The studio route itself and its
  /// tabs (`/studio`, `/studio/{id}`, `/studio/{id}/{tab}`) return false so
  /// in-studio navigation stays in the WebView. A null/empty URL returns
  /// false so a spurious url change never triggers an exit.
  bool _hasLeftStudio(String? url) {
    if (url == null) return false;
    final path = Uri.tryParse(url)?.path ?? '';
    if (path.isEmpty) return false;
    return path != '/studio' && !path.startsWith('/studio/');
  }

  /// Leave the WebView and return to the native app. Pops the studio route
  /// when it was pushed (e.g. from E1); otherwise (entered via `context.go`
  /// from the wizard) falls back to the native home. Runs at most once, and is
  /// deferred so it never mutates navigation from inside a WebView callback.
  void _returnToApp() {
    if (_exiting || !mounted) return;
    _exiting = true;
    Future.microtask(() {
      if (!mounted) return;
      if (context.canPop()) {
        context.pop();
      } else {
        context.go('/');
      }
    });
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
          if (_error != null)
            ErrorView(
              message: _error!,
              onRetry: _retry,
              icon: Icons.view_in_ar_outlined,
            ),
        ],
      ),
    );
  }

  void _retry() {
    setState(() {
      _error = null;
      _loading = true;
      _seeded = false;
      _studioReady = false;
      _exiting = false;
      _controller = null;
    });
    _init();
  }
}
