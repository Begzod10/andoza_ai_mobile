import '../../l10n/app_localizations.dart';
import '../../models/business_profile.dart';

String tradeLabel(AppLocalizations l10n, UstaTrade t) => switch (t) {
      UstaTrade.elektrik => l10n.tradeElektrik,
      UstaTrade.elektrikLoyihachi => l10n.tradeElektrikLoyihachi,
      UstaTrade.santexnik => l10n.tradeSantexnik,
      UstaTrade.malyar => l10n.tradeMalyar,
      UstaTrade.oboy => l10n.tradeOboy,
      UstaTrade.laminat => l10n.tradeLaminat,
      UstaTrade.brigada => l10n.tradeBrigada,
    };

String statusLabel(AppLocalizations l10n, ModerationStatus s) => switch (s) {
      ModerationStatus.pending => l10n.businessStatusPending,
      ModerationStatus.approved => l10n.businessStatusApproved,
      ModerationStatus.rejected => l10n.businessStatusRejected,
    };
