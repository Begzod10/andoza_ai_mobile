import 'package:flutter/material.dart';

import '../../config/design_tokens.dart';
import '../../l10n/app_localizations.dart';
import '../../geometry/room_geometry.dart';
import '../../models/api/api.dart';
import '../../models/room_plan.dart';
import '../../utils/currency.dart';

/// Shows the post-scan summary (smeta) as a modal sheet.
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
        scrollController: scrollController,
        onContinue: () => Navigator.of(sheetCtx).pop(),
      ),
    ),
  );
}

/// The sheet body: room headline, smeta breakdown, CTA.
///
/// Split out from [showRoomScanSummarySheet] so it can be pumped directly in a
/// widget test without driving a modal route.
class RoomScanSummaryContent extends StatelessWidget {
  const RoomScanSummaryContent({
    required this.plan,
    required this.onContinue,
    this.estimate,
    this.scrollController,
    super.key,
  });

  final RoomPlan plan;
  final Estimate? estimate;
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
