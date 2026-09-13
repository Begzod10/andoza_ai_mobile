import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';

import '../../config/design_tokens.dart';
import '../../features/room_scan/room_scan_converter.dart';
import '../../features/room_scan/room_scan_service.dart';
import 'room_scan_review_page.dart';

/// Drives the RoomPlan (LiDAR) capture: probe support → present the native
/// scanner → convert → hand off to [RoomScanReviewPage]. Reached from the
/// "LiDAR skaner" entry in the "Yangi loyiha" sheet (route `/scanning/roomplan`).
///
/// On an unsupported device (Android, non-Pro iPhone, iOS < 16) it explains the
/// requirement and offers the Photo / Draw fallbacks, then leaves.
class RoomScanScreen extends ConsumerStatefulWidget {
  const RoomScanScreen({super.key});

  @override
  ConsumerState<RoomScanScreen> createState() => _RoomScanScreenState();
}

class _RoomScanScreenState extends ConsumerState<RoomScanScreen> {
  static final Logger _logger = Logger();
  bool _busy = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _start());
  }

  Future<void> _start() async {
    final svc = ref.read(roomScanServiceProvider);
    final support = await svc.checkSupport();
    if (!mounted) return;
    _logger.i('roomscan support: ${support.supported} (${support.reason})');
    if (!support.supported) {
      final choice = await _showUnsupportedSheet();
      if (!mounted) return;
      switch (choice) {
        case 'photo':
          context.pushReplacement('/scanning/photo');
        case 'draw':
          context.pushReplacement('/setup/draw');
        default:
          context.pop();
      }
      return;
    }
    await _scan(svc);
  }

  Future<void> _scan(RoomScanService svc) async {
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      final result = await svc.scan();
      if (!mounted) return;
      if (result == null) {
        _logger.i('roomscan cancelled by user');
        context.pop();
        return;
      }
      final draft = RoomScanConverter.toRoomDraft(result.room);
      if (!draft.plan.isValid) {
        setState(() => _error =
            draft.plan.invalidReason ?? 'Xona aniqlanmadi. Qayta urinib ko\'ring.');
        return;
      }
      _logger.i('roomscan → review (corners=${draft.plan.corners.length}, '
          'objects=${draft.objects.length})');
      context.pushReplacement(
        '/scanning/roomplan/review',
        extra: RoomScanReviewArgs(draft: draft, scan: result),
      );
    } on RoomScanException catch (e) {
      _logger.e('roomscan failed', error: e);
      if (mounted) setState(() => _error = _messageFor(e));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  String _messageFor(RoomScanException e) {
    switch (e.code) {
      case 'busy':
        return 'Skaner allaqachon ishlayapti.';
      case 'scan_failed':
        return 'Skanerlashda xatolik. Qayta urinib ko\'ring.';
      default:
        return 'Xatolik: ${e.message}';
    }
  }

  Future<String?> _showUnsupportedSheet() {
    return showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: DesignTokens.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(DesignTokens.radiusSheet)),
      ),
      builder: (sheetCtx) => Padding(
        padding: const EdgeInsets.fromLTRB(
          DesignTokens.screenPaddingHorizontal,
          DesignTokens.spacingLg,
          DesignTokens.screenPaddingHorizontal,
          DesignTokens.spacingXl,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('LiDAR mavjud emas', style: DesignTokens.heading3),
            const SizedBox(height: DesignTokens.spacingSm),
            Text(
              'LiDAR skaner faqat iPhone 12 Pro, 13 Pro, 14 Pro, 15 Pro, 16 Pro '
              'yoki iPad Pro’da ishlaydi. Xonani boshqa usulda qo\'shing:',
              style: DesignTokens.body2.copyWith(color: DesignTokens.textGray),
            ),
            const SizedBox(height: DesignTokens.spacingLg),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: () => Navigator.of(sheetCtx).pop('photo'),
                icon: const Icon(Icons.camera_alt_outlined),
                label: const Text('360° Foto skan'),
              ),
            ),
            const SizedBox(height: DesignTokens.spacingSm),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () => Navigator.of(sheetCtx).pop('draw'),
                icon: const Icon(Icons.draw_outlined),
                label: const Text('O\'zingiz chizing'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('LiDAR skaner')),
      body: Center(
        child: _error != null
            ? Padding(
                padding: const EdgeInsets.all(DesignTokens.spacingXl),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.error_outline, size: 48, color: DesignTokens.textMuted),
                    const SizedBox(height: DesignTokens.spacingMd),
                    Text(_error!, textAlign: TextAlign.center, style: DesignTokens.body2),
                    const SizedBox(height: DesignTokens.spacingLg),
                    FilledButton(
                      onPressed: () => _scan(ref.read(roomScanServiceProvider)),
                      child: const Text('Qayta urinish'),
                    ),
                    TextButton(
                      onPressed: () => context.pop(),
                      child: const Text('Bekor qilish'),
                    ),
                  ],
                ),
              )
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (_busy) const CircularProgressIndicator(),
                  const SizedBox(height: DesignTokens.spacingMd),
                  Text('Xona skanerlanmoqda…',
                      style: DesignTokens.body2.copyWith(color: DesignTokens.textGray)),
                ],
              ),
      ),
    );
  }
}
