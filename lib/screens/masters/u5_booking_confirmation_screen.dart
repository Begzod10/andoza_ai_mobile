import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../config/design_tokens.dart';
import '../../l10n/app_localizations.dart';
import '../../providers/business_provider.dart';
import '../../providers/estimate_provider.dart';
import '../../providers/room_provider.dart';
import '../../providers/masters_provider.dart';
import '../../utils/currency.dart';

/// U5: send-smeta sheet — "Loyihangizni [ism]ga yuborasizmi?" The
/// project-summary figure is the real [estimateProvider] total (backfilled
/// from Step 6's placeholder once Step 11's pricing layer landed).
class U5BookingConfirmationScreen extends ConsumerStatefulWidget {
  const U5BookingConfirmationScreen({this.master, super.key});

  final MockMaster? master;

  @override
  ConsumerState<U5BookingConfirmationScreen> createState() =>
      _U5BookingConfirmationScreenState();
}

class _U5BookingConfirmationScreenState
    extends ConsumerState<U5BookingConfirmationScreen> {
  final _commentController = TextEditingController();
  bool _sending = false;

  static final _uuid = RegExp(
    r'^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$',
    caseSensitive: false,
  );

  /// Sends the request to the usta for real (`POST /leads`); the server adds
  /// the room's latest estimate. An unsaved room has a local id the server
  /// would refuse, so it is left out and the usta gets the request without it.
  Future<void> _send(MockMaster m) async {
    final l10n = AppLocalizations.of(context)!;
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);
    final roomId = ref.read(activeRoomProvider)?.id;
    setState(() => _sending = true);
    try {
      await ref.read(businessRepositoryProvider).sendLead(
            m.master.id,
            roomId: roomId != null && _uuid.hasMatch(roomId) ? roomId : null,
          );
      navigator.pop();
      messenger.showSnackBar(SnackBar(content: Text(l10n.mastersEstimateSent)));
    } catch (_) {
      if (mounted) setState(() => _sending = false);
      messenger.showSnackBar(SnackBar(content: Text(l10n.mastersSendFailed)));
    }
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final m = widget.master ?? ref.watch(mockMastersProvider).first;
    final estimate = ref.watch(estimateProvider);

    return Scaffold(
      backgroundColor: DesignTokens.backgroundLight,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(DesignTokens.screenPaddingHorizontal),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.mastersSendConfirmTitle(m.master.name.split(' ').first),
                style: DesignTokens.heading3,
              ),
              const SizedBox(height: DesignTokens.spacingLg),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(DesignTokens.spacingMd),
                decoration: BoxDecoration(
                  color: DesignTokens.white,
                  borderRadius: BorderRadius.circular(DesignTokens.radiusLg),
                  border: Border.all(color: DesignTokens.borderGray),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.mastersProjectSummaryTitle,
                      style: DesignTokens.subtitle2,
                    ),
                    const SizedBox(height: DesignTokens.spacingXs),
                    Text(
                      l10n.mastersProjectSummaryValue(
                        estimate.roomArea.toStringAsFixed(1),
                        formatSom(estimate.totalPrice.round()),
                      ),
                      style: DesignTokens.body2.copyWith(
                        color: DesignTokens.textGray,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: DesignTokens.spacingLg),
              TextField(
                controller: _commentController,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: l10n.mastersCommentHint,
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: DesignTokens.spacingSm),
              Text(
                l10n.mastersEstimateNote,
                style: DesignTokens.caption.copyWith(
                  color: DesignTokens.textGray,
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: DesignTokens.buttonHeightLarge,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: DesignTokens.accentOrange,
                  ),
                  onPressed: _sending ? null : () => _send(m),
                  child: Text(l10n.mastersSend),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
