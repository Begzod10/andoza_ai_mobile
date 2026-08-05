import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../config/app_config.dart';
import '../../config/design_tokens.dart';
import '../../models/user_model.dart';
import '../../providers/auth_provider.dart';

/// Embeds the web "Studio" (React/Three.js 3D room editor) in a WebView for a
/// given backend [roomId].
///
/// Auth bridge: the web app authenticates via an HttpOnly `token` cookie
/// (sent to the API with `credentials: "include"`) and gates its routes on a
/// Zustand `uy-tamir-auth` localStorage flag. This screen reproduces both from
/// the mobile session — it sets the cookie for the shared host (cookies ignore
/// port, so one cookie covers both the :5173 frontend and :8000 API) and seeds
/// the localStorage flag before navigating to `/studio/{roomId}`.
class StudioWebViewScreen extends ConsumerStatefulWidget {
  const StudioWebViewScreen({required this.roomId, super.key});

  final String roomId;

  @override
  ConsumerState<StudioWebViewScreen> createState() =>
      _StudioWebViewScreenState();
}

class _StudioWebViewScreenState extends ConsumerState<StudioWebViewScreen> {
  late final WebViewController _controller;
  bool _seeded = false;
  bool _loading = true;
  String? _error;

  String get _studioUrl => '${AppConfig.studioBaseUrl}/studio/${widget.roomId}';

  @override
  void initState() {
    super.initState();
    _bootstrap();
  }

  Future<void> _bootstrap() async {
    final auth = ref.read(authStateProvider);
    if (auth is! AuthAuthenticated) {
      setState(() {
        _loading = false;
        _error = 'Studio ochish uchun tizimga kiring.';
      });
      return;
    }

    final host = Uri.parse(AppConfig.studioBaseUrl).host;

    // 1. Set the auth cookie for the shared host so the frontend's
    //    credentialed API calls are authenticated.
    await WebViewCookieManager().setCookie(
      WebViewCookie(name: 'token', value: auth.token, domain: host, path: '/'),
    );

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(DesignTokens.white)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (_) async {
            // 2. On the first load of the origin, seed the auth flag then
            //    navigate to the studio route (now past the RequireAuth guard).
            if (!_seeded) {
              _seeded = true;
              await _controller.runJavaScript(_authSeedJs(auth.user));
              await _controller.loadRequest(Uri.parse(_studioUrl));
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
      )
      // First load: the origin root establishes the origin so localStorage is
      // writable. It may bounce to /login (not yet seeded) — that's expected.
      ..loadRequest(Uri.parse(AppConfig.studioBaseUrl));

    setState(() {});
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
        title: const Text('3D Studio'),
        backgroundColor: DesignTokens.white,
      ),
      body: Stack(
        children: [
          if (_error == null) WebViewWidget(controller: _controller),
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
    });
    _bootstrap();
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
