import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../config/design_tokens.dart';
import '../../models/api/api.dart';
import '../../providers/ai_provider.dart';
import '../../providers/apartment_provider.dart';
import '../../providers/estimate_api_provider.dart';

/// "AI dizayner" sheet: the user types a natural-language request, the backend
/// agent streams its reasoning + tool calls (SSE), and on completion proposes a
/// patch the user can Apply or Discard.
///
/// Requires a backend room id (the room must be persisted first — see the
/// room-persistence bridge). Real generation needs a valid LLM key configured
/// server-side; without it the stream emits an error, which this sheet shows.
class AiBuilderSheet extends ConsumerStatefulWidget {
  const AiBuilderSheet({required this.roomId, super.key});

  final String roomId;

  static Future<void> show(BuildContext context, String roomId) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: DesignTokens.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => AiBuilderSheet(roomId: roomId),
    );
  }

  @override
  ConsumerState<AiBuilderSheet> createState() => _AiBuilderSheetState();
}

class _AiBuilderSheetState extends ConsumerState<AiBuilderSheet> {
  final _promptController = TextEditingController();
  final _log = <AiBuildEvent>[];
  StreamSubscription<AiBuildEvent>? _sub;
  bool _running = false;
  bool _applying = false;
  AiDone? _result;
  String? _error;

  @override
  void dispose() {
    _sub?.cancel();
    _promptController.dispose();
    super.dispose();
  }

  void _start() {
    final prompt = _promptController.text.trim();
    if (prompt.isEmpty || _running) return;
    setState(() {
      _running = true;
      _result = null;
      _error = null;
      _log.clear();
    });

    _sub = ref.read(aiRepositoryProvider).build(widget.roomId, prompt).listen(
      (event) {
        if (!mounted) return;
        setState(() {
          if (event is AiDone) {
            _result = event;
            _running = false;
          } else if (event is AiError) {
            _error = event.message;
            _running = false;
          } else if (event is! AiUnknown) {
            _log.add(event);
          }
        });
      },
      onError: (Object e) {
        if (!mounted) return;
        setState(() {
          _error = e.toString();
          _running = false;
        });
      },
      onDone: () {
        if (!mounted) return;
        if (_running) setState(() => _running = false);
      },
    );
  }

  /// Applies the parts of the patch that map to the room record: ceiling height
  /// and per-surface materials (the drivers of the smeta). Furniture/lights and
  /// wall-length changes are surfaced in the summary but persisted by their own
  /// flows / the 3D Studio, so they aren't written here.
  Future<void> _apply(AiPatch patch) async {
    setState(() => _applying = true);
    final messenger = ScaffoldMessenger.of(context);
    try {
      final repo = ref.read(apartmentRepositoryProvider);
      final patchSurfaces = patch.surfaces;
      final hasRoomEdits = patch.ceilingH != null ||
          (patchSurfaces != null && patchSurfaces.isNotEmpty);
      if (hasRoomEdits) {
        // Merge the AI's surface picks into the room's existing surfaces (a bare
        // `surfaces:` on PATCH replaces the whole map, which would wipe walls
        // the user already painted). Only fetch/merge when surfaces change.
        Map<String, dynamic>? mergedSurfaces;
        if (patchSurfaces != null && patchSurfaces.isNotEmpty) {
          final current = await repo.getRoom(widget.roomId);
          mergedSurfaces = {...?current.surfaces, ...patchSurfaces};
        }
        await repo.updateRoom(
          widget.roomId,
          ceilingH: patch.ceilingH,
          surfaces: mergedSurfaces,
        );
        // Refresh the smeta/delta so the change is reflected.
        ref.invalidate(roomDeltaProvider(widget.roomId));
        ref.invalidate(estimatePreviewProvider(widget.roomId));
      }
      if (mounted) {
        messenger.showSnackBar(
          const SnackBar(content: Text('✓ AI o\'zgarishlari qo\'llanildi')),
        );
        Navigator.of(context).pop();
      }
    } catch (e) {
      messenger.showSnackBar(SnackBar(content: Text('Qo\'llab bo\'lmadi: $e')));
    } finally {
      if (mounted) setState(() => _applying = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final insets = MediaQuery.of(context).viewInsets.bottom;
    return Padding(
      padding: EdgeInsets.only(bottom: insets),
      child: DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.75,
        maxChildSize: 0.95,
        builder: (context, scrollController) {
          return Padding(
            padding: const EdgeInsets.all(DesignTokens.spacingMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Row(
                  children: [
                    Icon(Icons.auto_awesome, color: DesignTokens.primaryBlue),
                    SizedBox(width: DesignTokens.spacingSm),
                    Text('AI dizayner', style: DesignTokens.subtitle1),
                  ],
                ),
                const SizedBox(height: DesignTokens.spacingMd),
                TextField(
                  controller: _promptController,
                  minLines: 2,
                  maxLines: 4,
                  enabled: !_running,
                  decoration: const InputDecoration(
                    hintText:
                        'Masalan: "Devorlarni iliq bej rangga bo\'ya va divan qo\'sh"',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: DesignTokens.spacingSm),
                SizedBox(
                  height: DesignTokens.buttonHeightLarge,
                  child: FilledButton.icon(
                    onPressed: _running ? null : _start,
                    icon: _running
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(
                                strokeWidth: 2, color: Colors.white),
                          )
                        : const Icon(Icons.auto_awesome),
                    label: Text(_running ? 'Ishlanmoqda…' : 'Yaratish'),
                  ),
                ),
                const SizedBox(height: DesignTokens.spacingMd),
                Expanded(
                  child: ListView(
                    controller: scrollController,
                    children: [
                      for (final e in _log) _EventTile(event: e),
                      if (_error != null) _ErrorTile(message: _error!),
                      if (_result != null)
                        _ResultCard(
                          result: _result!,
                          applying: _applying,
                          onApply: _result!.patch == null
                              ? null
                              : () => _apply(_result!.patch!),
                          onDiscard: () => Navigator.of(context).pop(),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _EventTile extends StatelessWidget {
  const _EventTile({required this.event});
  final AiBuildEvent event;

  @override
  Widget build(BuildContext context) {
    final (icon, text) = switch (event) {
      AiThinking(:final text) => (Icons.psychology_outlined, text),
      AiToolCall(:final name) => (Icons.build_outlined, 'Amal: $name'),
      AiToolResult(:final name, :final summary) => (
          Icons.check_circle_outline,
          summary ?? 'Bajarildi: $name',
        ),
      _ => (Icons.info_outline, ''),
    };
    if (text.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: DesignTokens.spacing4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: DesignTokens.textMuted),
          const SizedBox(width: DesignTokens.spacingSm),
          Expanded(
            child: Text(text, style: DesignTokens.body2),
          ),
        ],
      ),
    );
  }
}

class _ErrorTile extends StatelessWidget {
  const _ErrorTile({required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: DesignTokens.spacingSm),
      padding: const EdgeInsets.all(DesignTokens.spacingMd),
      decoration: BoxDecoration(
        color: Colors.red.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
        border: Border.all(color: Colors.red.withValues(alpha: 0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.error_outline, color: Colors.red, size: 20),
          const SizedBox(width: DesignTokens.spacingSm),
          Expanded(
            child: Text(
              'AI hozircha javob berolmadi.\n$message',
              style: DesignTokens.caption.copyWith(color: Colors.red.shade900),
            ),
          ),
        ],
      ),
    );
  }
}

class _ResultCard extends StatelessWidget {
  const _ResultCard({
    required this.result,
    required this.applying,
    required this.onApply,
    required this.onDiscard,
  });

  final AiDone result;
  final bool applying;
  final VoidCallback? onApply;
  final VoidCallback onDiscard;

  @override
  Widget build(BuildContext context) {
    final patch = result.patch;
    final changes = <String>[
      if (patch?.ceilingH != null)
        'Shift balandligi: ${patch!.ceilingH!.toStringAsFixed(2)} m',
      if (patch?.surfaces != null && patch!.surfaces!.isNotEmpty)
        '${patch.surfaces!.length} ta yuza materiali',
      if (patch?.wallLengths != null && patch!.wallLengths!.isNotEmpty)
        '${patch.wallLengths!.length} ta devor o\'lchami',
      if (patch?.furniture != null && patch!.furniture!.isNotEmpty)
        '${patch.furniture!.length} ta mebel',
      if (patch?.lights != null && patch!.lights!.isNotEmpty)
        '${patch.lights!.length} ta chiroq',
    ];
    return Container(
      margin: const EdgeInsets.only(top: DesignTokens.spacingSm),
      padding: const EdgeInsets.all(DesignTokens.spacingMd),
      decoration: BoxDecoration(
        color: DesignTokens.primaryBlue.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
        border: Border.all(color: DesignTokens.primaryBlue.withValues(alpha: 0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(result.summary, style: DesignTokens.body1),
          if (changes.isNotEmpty) ...[
            const SizedBox(height: DesignTokens.spacingSm),
            for (final c in changes)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Text('• $c', style: DesignTokens.caption),
              ),
          ],
          const SizedBox(height: DesignTokens.spacingMd),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: applying ? null : onDiscard,
                  child: const Text('Bekor qilish'),
                ),
              ),
              const SizedBox(width: DesignTokens.spacingSm),
              Expanded(
                child: FilledButton(
                  onPressed: (onApply == null || applying) ? null : onApply,
                  child: applying
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                              strokeWidth: 2, color: Colors.white),
                        )
                      : const Text('Qo\'llash'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
