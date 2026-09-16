import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../config/design_tokens.dart';
import '../../l10n/app_localizations.dart';

/// Shows the A3 "+" bottom sheet, dimming the screen behind it per spec.
Future<void> showNewProjectSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    barrierColor: const Color(0x801E2439),
    builder: (_) => const NewProjectSheet(),
  );
}

/// A3: "+" bottom sheet — the three entry paths into a new project's
/// measurement flow. Presented as a modal bottom sheet over the dimmed
/// home screen (per spec: "Home dimmed behind (blur + scrim)").
class NewProjectSheet extends StatelessWidget {
  const NewProjectSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.fromLTRB(
        DesignTokens.screenPaddingHorizontal,
        DesignTokens.spacingMd,
        DesignTokens.screenPaddingHorizontal,
        DesignTokens.spacingXl,
      ),
      decoration: const BoxDecoration(
        color: DesignTokens.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(DesignTokens.radiusSheet),
          topRight: Radius.circular(DesignTokens.radiusSheet),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 44,
              height: 5,
              margin: const EdgeInsets.only(bottom: DesignTokens.spacingLg),
              decoration: BoxDecoration(
                color: DesignTokens.borderGray,
                borderRadius: BorderRadius.circular(DesignTokens.radiusFull),
              ),
            ),
          ),
          Text(l10n.newProjectTitle, style: DesignTokens.heading3),
          const SizedBox(height: DesignTokens.spacingXs),
          Text(
            l10n.newProjectSubtitle,
            style: DesignTokens.body2.copyWith(color: DesignTokens.textGray),
          ),
          const SizedBox(height: DesignTokens.spacingLg),
          _EntryOption(
            iconBackground: const Color(0xFFEDE7FB),
            icon: Icons.view_in_ar,
            iconColor: DesignTokens.primaryBlue,
            title: l10n.newProjectWizardTitle,
            description: l10n.newProjectWizardDesc,
            onTap: () {
              Navigator.of(context).pop();
              context.push('/wizard');
            },
          ),
          const SizedBox(height: DesignTokens.spacingMd),
          _EntryOption(
            iconBackground: DesignTokens.borderGrayAlt,
            icon: Icons.radar,
            iconColor: DesignTokens.primaryBlue,
            title: l10n.newProjectLidarTitle,
            description: l10n.newProjectLidarDesc,
            onTap: () {
              Navigator.of(context).pop();
              context.push('/scanning/roomplan');
            },
          ),
          const SizedBox(height: DesignTokens.spacingMd),
          _EntryOption(
            iconBackground: const Color(0xFFFFF1E7),
            icon: Icons.camera_alt_outlined,
            iconColor: DesignTokens.accentOrange,
            title: l10n.newProjectPhotoTitle,
            description: l10n.newProjectPhotoDesc,
            onTap: () {
              Navigator.of(context).pop();
              context.push('/scanning/photo');
            },
          ),
          const SizedBox(height: DesignTokens.spacingMd),
          _EntryOption(
            iconBackground: const Color(0xFFEAF7F0),
            icon: Icons.draw_outlined,
            iconColor: DesignTokens.successGreen,
            title: l10n.newProjectDrawTitle,
            description: l10n.newProjectDrawDesc,
            onTap: () {
              Navigator.of(context).pop();
              context.push('/setup/draw');
            },
          ),
        ],
      ),
    );
  }
}

class _EntryOption extends StatelessWidget {
  const _EntryOption({
    required this.iconBackground,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.description,
    required this.onTap,
  });

  final Color iconBackground;
  final IconData icon;
  final Color iconColor;
  final String title;
  final String description;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(DesignTokens.radiusXl),
      child: Container(
        padding: const EdgeInsets.all(DesignTokens.spacingMd),
        decoration: BoxDecoration(
          color: const Color(0xFFF7F8FA),
          borderRadius: BorderRadius.circular(DesignTokens.radiusXl),
          border: Border.all(color: const Color(0xFFEDEFF3)),
        ),
        child: Row(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: iconBackground,
                borderRadius: BorderRadius.circular(DesignTokens.radiusLg),
              ),
              child: Icon(icon, color: iconColor, size: DesignTokens.iconMd),
            ),
            const SizedBox(width: DesignTokens.spacingMd),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: DesignTokens.subtitle2),
                  const SizedBox(height: DesignTokens.spacingXs),
                  Text(
                    description,
                    style: DesignTokens.caption.copyWith(
                      color: DesignTokens.textGray,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: DesignTokens.textMuted),
          ],
        ),
      ),
    );
  }
}
