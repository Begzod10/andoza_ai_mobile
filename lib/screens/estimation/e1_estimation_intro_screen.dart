import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/design_tokens.dart';
import '../../models/api/api.dart' show DeltaResponse, RoomStateValue;
import '../../models/design_selection_model.dart';
import '../../models/estimate_model.dart';
import '../../providers/apartment_provider.dart';
import '../../providers/estimate_api_provider.dart';
import '../../providers/estimate_provider.dart';
import '../../providers/room_persistence_provider.dart';
import '../../providers/room_provider.dart';
import '../../services/pdf_share_service.dart';
import '../../utils/currency.dart';

const _stageLabels = {
  RenovationStage.suvoq: 'Suvoq',
  RenovationStage.shpaklovka: 'Shpaklovka',
  RenovationStage.boyoqOboi: 'Bo\'yoq/Oboi',
  RenovationStage.pol: 'Pol',
  RenovationStage.mebel: 'Mebel',
  RenovationStage.elektr: 'Elektr montaj',
  RenovationStage.yoruglik: 'Yorug\'lik',
  RenovationStage.santexnika: 'Santexnika',
};

/// E1: Remont smetasi — money appears for the first time here. Big blue
/// total card (Materiallar/Ishchi kuchi split), a green delta-savings
/// banner computed from actually-excluded stages (never hardcoded), and
/// a stage list where excluded stages render gray/struck-through/
/// "hisoblanmadi" — all driven by the real [estimateProvider].
class E1EstimationIntroScreen extends ConsumerStatefulWidget {
  const E1EstimationIntroScreen({super.key});

  @override
  ConsumerState<E1EstimationIntroScreen> createState() =>
      _E1EstimationIntroScreenState();
}

class _E1EstimationIntroScreenState
    extends ConsumerState<E1EstimationIntroScreen> {
  bool _downloadingPdf = false;

  @override
  void initState() {
    super.initState();
    // Persist the captured room to the backend so "tejaldingiz" can reflect the
    // real server delta. Fire-and-forget: the UI shows the local estimate while
    // this runs and falls back to it if the backend is unreachable.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(roomPersistenceProvider.notifier).ensurePersisted();
    });
  }

  /// Downloads the server-generated smeta PDF for the persisted room and opens
  /// the share sheet. Requires the room to be persisted (Phase 2 bridge).
  Future<void> _downloadPdf(String roomId, String roomName) async {
    setState(() => _downloadingPdf = true);
    final messenger = ScaffoldMessenger.of(context);
    try {
      final bytes =
          await ref.read(estimateRepositoryProvider).downloadPdf(roomId);
      await sharePdfBytes(
        bytes,
        fileName: 'smeta_${roomName.replaceAll(' ', '_')}',
        shareText: 'AndozaAI smeta — $roomName',
      );
    } catch (e) {
      messenger.showSnackBar(
        SnackBar(content: Text('PDF yuklab bo\'lmadi: $e')),
      );
    } finally {
      if (mounted) setState(() => _downloadingPdf = false);
    }
  }

  /// The stage label to show in the savings banner when using the backend
  /// delta — the first completed stage beyond raw (korobka).
  String _backendSavingsLabel(DeltaResponse delta) {
    final done = delta.completedStages
        .where((s) => s.stage != RoomStateValue.xom)
        .toList();
    return done.isNotEmpty ? done.first.labelUz : 'Ba\'zi ishlar';
  }

  @override
  Widget build(BuildContext context) {
    final estimate = ref.watch(estimateProvider);
    final room = ref.watch(activeRoomProvider);
    final materials = estimateMaterialsTotal(estimate);
    final labor = estimateLaborTotal(estimate);
    final localSavings = estimateSavingsTotal(estimate);
    final savingsStage = estimate.stages.firstWhere(
      (s) => s.isExcluded,
      orElse: () => estimate.stages.first,
    );

    // Prefer the backend's authoritative delta once the room is persisted;
    // otherwise fall back to the local computation.
    final persisted = ref.watch(roomPersistenceProvider).valueOrNull;
    final roomId = persisted?.roomId;
    final backendDelta = roomId == null
        ? null
        : ref.watch(roomDeltaProvider(roomId)).valueOrNull;
    final backendSavings = backendDelta?.deltaSavingsUzs;
    final useBackend = backendSavings != null && backendSavings > 0;
    final savings = useBackend ? backendSavings.toDouble() : localSavings;
    final savingsLabel = useBackend
        ? _backendSavingsLabel(backendDelta!)
        : (_stageLabels[savingsStage.name] ?? 'Bosqich');

    // Real server smeta total once the room is persisted; the header keeps
    // showing the local total until then (and if the backend is unreachable).
    final backendEstimate = roomId == null
        ? null
        : ref.watch(estimatePreviewProvider(roomId)).valueOrNull;
    final displayTotal =
        backendEstimate?.totalUzs.toDouble() ?? estimate.totalPrice;

    return Scaffold(
      backgroundColor: DesignTokens.backgroundLight,
      appBar: AppBar(
        backgroundColor: DesignTokens.backgroundLight,
        elevation: 0,
        title: Text(
          'Remont smetasi · ${room?.name ?? 'Mehmonxona'}'
          '${room != null ? ' · ${room.dimensions.width.toStringAsFixed(1)} × ${room.dimensions.length.toStringAsFixed(1)} m' : ''}',
          style: DesignTokens.subtitle2,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.tune),
            tooltip: 'Smeta sozlash',
            onPressed: () => context.push('/estimation/e3'),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(
                DesignTokens.screenPaddingHorizontal,
              ),
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(DesignTokens.spacingLg),
                  decoration: BoxDecoration(
                    color: DesignTokens.primaryBlue,
                    borderRadius: BorderRadius.circular(DesignTokens.radiusLg),
                    boxShadow: [DesignTokens.shadowElevated],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Taxminiy umumiy narx',
                        style: DesignTokens.body2.copyWith(
                          color: DesignTokens.white.withValues(alpha: 0.75),
                        ),
                      ),
                      Text(
                        formatSom(displayTotal.round()),
                        style: DesignTokens.heading1.copyWith(
                          color: DesignTokens.white,
                        ),
                      ),
                      const SizedBox(height: DesignTokens.spacingMd),
                      Row(
                        children: [
                          Expanded(
                            child: _TotalColumn(
                              label: 'Materiallar',
                              value: formatSom(materials.round()),
                            ),
                          ),
                          Expanded(
                            child: _TotalColumn(
                              label: 'Ishchi kuchi',
                              value: formatSom(labor.round()),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                if (savings > 0) ...[
                  const SizedBox(height: DesignTokens.spacingMd),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(DesignTokens.spacingMd),
                    decoration: BoxDecoration(
                      color: DesignTokens.successGreen.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(
                        DesignTokens.radiusMd,
                      ),
                      border: Border.all(
                        color: DesignTokens.successGreen.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.savings_outlined,
                          color: DesignTokens.successGreen,
                        ),
                        const SizedBox(width: DesignTokens.spacingSm),
                        Expanded(
                          child: Text(
                            '$savingsLabel allaqachon bor '
                            'edi — ${formatSom(savings.round())} tejaldingiz',
                            style: DesignTokens.body2.copyWith(
                              color: DesignTokens.successGreen,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                const SizedBox(height: DesignTokens.spacingLg),
                for (final stage in estimate.stages) ...[
                  _StageRow(
                    stage: stage,
                    onTap: stage.isExcluded
                        ? null
                        : () => context.push('/estimation/e2', extra: stage),
                  ),
                  const SizedBox(height: DesignTokens.spacingSm),
                ],
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(DesignTokens.spacingMd),
            decoration: BoxDecoration(
              color: DesignTokens.white,
              boxShadow: [DesignTokens.shadowNavBar],
            ),
            child: SafeArea(
              top: false,
              child: Column(
                children: [
                  if (roomId != null) ...[
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: _downloadingPdf
                            ? null
                            : () => _downloadPdf(
                                  roomId,
                                  room?.name ?? 'Xona',
                                ),
                        icon: _downloadingPdf
                            ? const SizedBox(
                                width: 16,
                                height: 16,
                                child:
                                    CircularProgressIndicator(strokeWidth: 2),
                              )
                            : const Icon(Icons.picture_as_pdf_outlined),
                        label: Text(
                          _downloadingPdf
                              ? 'Tayyorlanmoqda…'
                              : 'PDF smetani yuklab olish',
                        ),
                      ),
                    ),
                    const SizedBox(height: DesignTokens.spacingSm),
                  ],
                  SizedBox(
                    width: double.infinity,
                    height: DesignTokens.buttonHeightLarge,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: DesignTokens.accentOrange,
                      ),
                      onPressed: () => context.push('/shop/s5'),
                      child: const Text('Do\'konlardan xarid qilish'),
                    ),
                  ),
                  const SizedBox(height: DesignTokens.spacingSm),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () => context.push('/masters/u1'),
                      child: const Text('Ustaga yuborish'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TotalColumn extends StatelessWidget {
  const _TotalColumn({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: DesignTokens.caption.copyWith(
            color: DesignTokens.white.withValues(alpha: 0.7),
          ),
        ),
        Text(
          value,
          style: DesignTokens.subtitle2.copyWith(color: DesignTokens.white),
        ),
      ],
    );
  }
}

class _StageRow extends StatelessWidget {
  const _StageRow({required this.stage, required this.onTap});

  final EstimateStage stage;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final label = _stageLabels[stage.name] ?? stage.name.name;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
      child: Container(
        padding: const EdgeInsets.all(DesignTokens.spacingMd),
        decoration: BoxDecoration(
          color: DesignTokens.white,
          borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
          border: Border.all(color: DesignTokens.borderGray),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: DesignTokens.body2.copyWith(
                  color: stage.isExcluded
                      ? DesignTokens.textMuted
                      : DesignTokens.textDark,
                ),
              ),
            ),
            if (stage.isExcluded)
              Text(
                'sizda mavjud — hisoblanmadi',
                style: DesignTokens.caption.copyWith(
                  color: DesignTokens.textMuted,
                ),
              )
            else
              const Icon(Icons.chevron_right, color: DesignTokens.textMuted),
            const SizedBox(width: DesignTokens.spacingSm),
            Text(
              stage.isExcluded ? '0 so\'m' : formatSom(stage.subtotal.round()),
              style: DesignTokens.subtitle2.copyWith(
                color: stage.isExcluded
                    ? DesignTokens.textMuted
                    : DesignTokens.primaryBlue,
                decoration: stage.isExcluded
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
