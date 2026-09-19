import 'package:flutter/material.dart';

import '../../config/design_tokens.dart';
import '../../l10n/app_localizations.dart';
import '../../geometry/room_geometry.dart';
import '../../models/api/api.dart';
import '../../models/room_plan.dart';
import '../../utils/currency.dart';

/// Shows the post-scan summary (smeta + electrical plan) as a modal sheet.
///
/// Presented between saving a scanned room and opening the studio, so the user
/// sees numbers for the room they just walked instead of landing in an empty
/// editor. The sheet is deliberately dismissible: both the CTA and a swipe-down
/// lead to the studio, so nothing here can strand a user whose room is already
/// persisted.
Future<void> showRoomScanSummarySheet(
  BuildContext context, {
  required RoomPlan plan,
  Estimate? estimate,
  ElectricalPlan? electrical,
}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: DesignTokens.white,
    shape: const RoundedRectangleBorder(
      borderRadius:
          BorderRadius.vertical(top: Radius.circular(DesignTokens.radiusSheet)),
    ),
    builder: (sheetCtx) => DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.75,
      maxChildSize: 0.92,
      builder: (_, scrollController) => RoomScanSummaryContent(
        plan: plan,
        estimate: estimate,
        electrical: electrical,
        scrollController: scrollController,
        onContinue: () => Navigator.of(sheetCtx).pop(),
      ),
    ),
  );
}

/// The sheet body: room headline, smeta breakdown, electrical plan, CTA.
///
/// Split out from [showRoomScanSummarySheet] so it can be pumped directly in a
/// widget test without driving a modal route.
class RoomScanSummaryContent extends StatelessWidget {
  const RoomScanSummaryContent({
    required this.plan,
    required this.onContinue,
    this.estimate,
    this.electrical,
    this.scrollController,
    super.key,
  });

  final RoomPlan plan;
  final Estimate? estimate;
  final ElectricalPlan? electrical;
  final ScrollController? scrollController;
  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final est = estimate;
    return Column(
      children: [
        Expanded(
          child: ListView(
            controller: scrollController,
            padding: const EdgeInsets.fromLTRB(
              DesignTokens.screenPaddingHorizontal,
              DesignTokens.spacingLg,
              DesignTokens.screenPaddingHorizontal,
              DesignTokens.spacingMd,
            ),
            children: [
              Text(l10n.scanSummaryTitle, style: DesignTokens.heading3),
              const SizedBox(height: DesignTokens.spacingXs),
              Text(
                l10n.scanSummaryRoomLine(
                  plan.areaM2.toStringAsFixed(1),
                  formatLength(plan.ceilingHeightM),
                  plan.walls.length,
                ),
                style: DesignTokens.body2,
              ),
              if (est != null) ...[
                const SizedBox(height: DesignTokens.spacingLg),
                _EstimateSection(estimate: est),
              ],
              // Omitted entirely when the backend has no plan for this room yet
              // (an older backend, or auto-generation that found nothing).
              if (_deviceCounts.isNotEmpty || _wiringMeters != null) ...[
                const SizedBox(height: DesignTokens.spacingLg),
                _ElectricalSection(
                  counts: _deviceCounts,
                  wiringMeters: _wiringMeters,
                  // The smeta is the only place that knows whether the device counts
                  // are real; fall back to "approximate" when there is no smeta.
                  confirmed: est?.electricalConfirmed ?? false,
                ),
              ],
            ],
          ),
        ),
        SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              DesignTokens.screenPaddingHorizontal,
              0,
              DesignTokens.screenPaddingHorizontal,
              DesignTokens.spacingMd,
            ),
            child: SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: onContinue,
                child: Text(l10n.scanSummaryContinue),
              ),
            ),
          ),
        ),
      ],
    );
  }

  double? get _wiringMeters => electrical?.wiringMeters;

  /// Device totals by type, honouring each device's [ElectricalDeviceOut.count]
  /// (the backend groups identical adjacent devices into one row).
  Map<ElectricalDeviceType, int> get _deviceCounts {
    final counts = <ElectricalDeviceType, int>{};
    for (final d in electrical?.devices ?? const <ElectricalDeviceOut>[]) {
      counts[d.type] = (counts[d.type] ?? 0) + d.count;
    }
    return counts;
  }
}

/// Smeta block: headline total, min–max range, the exact/approximate split and
/// the line breakdown.
class _EstimateSection extends StatelessWidget {
  const _EstimateSection({required this.estimate});

  final Estimate estimate;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final hasApprox = estimate.lines.any((l) => l.isApproximate);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.scanSummaryEstimateTitle, style: DesignTokens.subtitle2),
        const SizedBox(height: DesignTokens.spacingSm),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(DesignTokens.spacingMd),
          decoration: BoxDecoration(
            color: DesignTokens.primaryTint,
            borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(formatSom(estimate.totalUzs), style: DesignTokens.heading2),
              const SizedBox(height: DesignTokens.spacingXs),
              Text(
                l10n.scanSummaryRange(
                  formatSom(estimate.totalMin),
                  formatSom(estimate.totalMax),
                ),
                style: DesignTokens.caption,
              ),
              // The backend splits the total on purpose: how much of the price
              // is actually pinned down matters more to the user than the
              // headline figure. Only worth showing once a split exists.
              if (estimate.totalExactUzs > 0 ||
                  estimate.totalApproxUzs > 0) ...[
                const SizedBox(height: DesignTokens.spacingSm),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        l10n.scanSummaryExactTotal(
                          formatSom(estimate.totalExactUzs),
                        ),
                        style: DesignTokens.caption
                            .copyWith(color: DesignTokens.textDark),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        l10n.scanSummaryApproxTotal(
                          formatSom(estimate.totalApproxUzs),
                        ),
                        style: DesignTokens.caption,
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
        const SizedBox(height: DesignTokens.spacingSm),
        for (final line in estimate.lines) _EstimateLineRow(line: line),
        if (hasApprox) ...[
          const SizedBox(height: DesignTokens.spacingSm),
          Text(
            l10n.scanSummaryApproxNote,
            style: DesignTokens.caption.copyWith(color: DesignTokens.textMuted),
          ),
        ],
      ],
    );
  }
}

/// One smeta line: label (+ "taxminiy" badge), the formula the backend used,
/// its subtotal and any warning the backend attached.
class _EstimateLineRow extends StatelessWidget {
  const _EstimateLineRow({required this.line});

  final EstimateLine line;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final warning = line.warning;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: DesignTokens.spacingXs),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Wrap(
                  spacing: DesignTokens.spacingXs,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text(line.label, style: DesignTokens.body2),
                    if (line.isApproximate)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: DesignTokens.spacingSm,
                          vertical: 1,
                        ),
                        decoration: BoxDecoration(
                          color: DesignTokens.warningYellow,
                          borderRadius:
                              BorderRadius.circular(DesignTokens.radiusFull),
                        ),
                        child: Text(
                          l10n.scanSummaryApproxBadge,
                          style: DesignTokens.caption
                              .copyWith(color: DesignTokens.textDark),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(width: DesignTokens.spacingSm),
              Text(
                formatSom(line.totalUzs),
                style: DesignTokens.body2.copyWith(
                  color: DesignTokens.textDark,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Text(
            line.formula,
            style: DesignTokens.caption.copyWith(color: DesignTokens.textMuted),
          ),
          if (warning != null && warning.isNotEmpty)
            Text(
              warning,
              style:
                  DesignTokens.caption.copyWith(color: DesignTokens.textGray),
            ),
        ],
      ),
    );
  }
}

/// Electrical block: device counts by type plus the total wiring length.
class _ElectricalSection extends StatelessWidget {
  const _ElectricalSection({
    required this.counts,
    required this.wiringMeters,
    required this.confirmed,
  });

  final Map<ElectricalDeviceType, int> counts;
  final double? wiringMeters;
  final bool confirmed;

  /// Stable, human-sensible ordering — the map's own iteration order follows
  /// whatever order the backend happened to return devices in.
  static const List<ElectricalDeviceType> _order = [
    ElectricalDeviceType.socket,
    ElectricalDeviceType.switch_,
    ElectricalDeviceType.panel,
    ElectricalDeviceType.light,
    ElectricalDeviceType.box,
    ElectricalDeviceType.unknown,
  ];

  String _name(AppLocalizations l10n, ElectricalDeviceType t) => switch (t) {
        ElectricalDeviceType.socket => l10n.scanSummaryDeviceSocket,
        ElectricalDeviceType.switch_ => l10n.scanSummaryDeviceSwitch,
        ElectricalDeviceType.light => l10n.scanSummaryDeviceLight,
        ElectricalDeviceType.panel => l10n.scanSummaryDevicePanel,
        ElectricalDeviceType.box => l10n.scanSummaryDeviceBox,
        ElectricalDeviceType.unknown => l10n.scanSummaryDeviceOther,
      };

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final metres = wiringMeters;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.scanSummaryElectricalTitle, style: DesignTokens.subtitle2),
        const SizedBox(height: DesignTokens.spacingSm),
        Wrap(
          spacing: DesignTokens.spacingSm,
          runSpacing: DesignTokens.spacingXs,
          children: [
            for (final type in _order)
              if ((counts[type] ?? 0) > 0)
                _DevicePill(
                  label: l10n.scanSummaryDeviceCount(
                    counts[type]!,
                    _name(l10n, type),
                  ),
                ),
          ],
        ),
        if (metres != null && metres > 0) ...[
          const SizedBox(height: DesignTokens.spacingSm),
          Text(
            l10n.scanSummaryWiring(formatQuantity(metres)),
            style: DesignTokens.body2,
          ),
        ],
        if (!confirmed) ...[
          const SizedBox(height: DesignTokens.spacingSm),
          Text(
            l10n.scanSummaryElectricalApprox,
            style: DesignTokens.caption.copyWith(color: DesignTokens.textGray),
          ),
        ],
      ],
    );
  }
}

/// One "N rozetka" pill in the electrical block.
class _DevicePill extends StatelessWidget {
  const _DevicePill({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: DesignTokens.spacingSm,
        vertical: DesignTokens.spacingXs,
      ),
      decoration: BoxDecoration(
        color: DesignTokens.white,
        borderRadius: BorderRadius.circular(DesignTokens.radiusFull),
        border: Border.all(color: DesignTokens.borderGray),
      ),
      child: Text(
        label,
        style: DesignTokens.body2.copyWith(color: DesignTokens.textDark),
      ),
    );
  }
}
