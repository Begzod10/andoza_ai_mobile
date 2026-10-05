import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:path_provider/path_provider.dart';
import '../../config/design_tokens.dart';
import '../../l10n/app_localizations.dart';

const _prefsKeyNotificationsEnabled = 'settings_notifications_enabled';
const _prefsKeyEmailDigest = 'settings_email_digest';
const _prefsKeyMarketingEmails = 'settings_marketing_emails';
const _prefsKeyUnitSystem = 'settings_unit_system';
const _prefsKeyTheme = 'settings_theme';
const _prefsKeyAutoSave = 'settings_auto_save';
const _prefsKeyLargeText = 'settings_large_text';
const _prefsKeyCloudSync = 'settings_cloud_sync';

/// E9: App Preferences & Settings
/// Customize app behavior, notifications, and display settings
class E9PreferencesSettingsScreen extends ConsumerStatefulWidget {
  const E9PreferencesSettingsScreen({super.key});

  @override
  ConsumerState<E9PreferencesSettingsScreen> createState() =>
      _E9PreferencesSettingsScreenState();
}

class _E9PreferencesSettingsScreenState
    extends ConsumerState<E9PreferencesSettingsScreen> {
  bool _notificationsEnabled = true;
  bool _emailDigest = true;
  bool _marketingEmails = false;
  String _unitSystem = 'metric';
  String _theme = 'light';
  bool _autoSave = true;
  bool _largeText = false;
  bool _cloudSync = true;
  bool _clearingCache = false;
  String? _appVersion;
  String? _buildNumber;

  @override
  void initState() {
    super.initState();
    _loadPersistedPrefs();
    _loadPackageInfo();
  }

  Future<void> _loadPersistedPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    if (!mounted) return;
    setState(() {
      _notificationsEnabled =
          prefs.getBool(_prefsKeyNotificationsEnabled) ?? true;
      _emailDigest = prefs.getBool(_prefsKeyEmailDigest) ?? true;
      _marketingEmails = prefs.getBool(_prefsKeyMarketingEmails) ?? false;
      _unitSystem = prefs.getString(_prefsKeyUnitSystem) ?? 'metric';
      _theme = prefs.getString(_prefsKeyTheme) ?? 'light';
      _autoSave = prefs.getBool(_prefsKeyAutoSave) ?? true;
      _largeText = prefs.getBool(_prefsKeyLargeText) ?? false;
      _cloudSync = prefs.getBool(_prefsKeyCloudSync) ?? true;
    });
  }

  Future<void> _loadPackageInfo() async {
    final packageInfo = await PackageInfo.fromPlatform();
    if (!mounted) return;
    setState(() {
      _appVersion = packageInfo.version;
      _buildNumber = packageInfo.buildNumber;
    });
  }

  Future<void> _setNotificationsEnabled(bool value) async {
    setState(() => _notificationsEnabled = value);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_prefsKeyNotificationsEnabled, value);
  }

  Future<void> _setEmailDigest(bool value) async {
    setState(() => _emailDigest = value);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_prefsKeyEmailDigest, value);
  }

  Future<void> _setMarketingEmails(bool value) async {
    setState(() => _marketingEmails = value);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_prefsKeyMarketingEmails, value);
  }

  Future<void> _setUnitSystem(String? value) async {
    final unitSystem = value ?? 'metric';
    setState(() => _unitSystem = unitSystem);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefsKeyUnitSystem, unitSystem);
  }

  Future<void> _setTheme(String? value) async {
    final theme = value ?? 'light';
    setState(() => _theme = theme);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefsKeyTheme, theme);
  }

  Future<void> _setAutoSave(bool value) async {
    setState(() => _autoSave = value);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_prefsKeyAutoSave, value);
  }

  Future<void> _setLargeText(bool value) async {
    setState(() => _largeText = value);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_prefsKeyLargeText, value);
  }

  Future<void> _setCloudSync(bool value) async {
    setState(() => _cloudSync = value);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_prefsKeyCloudSync, value);
    if (!mounted) return;
    final l10n = AppLocalizations.of(context)!;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          value
              ? l10n.settingsCloudSyncEnabledMessage
              : l10n.settingsCloudSyncDisabledMessage,
        ),
      ),
    );
  }

  Future<void> _clearCache() async {
    setState(() => _clearingCache = true);
    final l10n = AppLocalizations.of(context)!;
    try {
      final tempDir = await getTemporaryDirectory();
      if (await tempDir.exists()) {
        await for (final entity in tempDir.list()) {
          try {
            await entity.delete(recursive: true);
          } catch (_) {
            // Skip files still in use; not fatal for a cache clear.
          }
        }
      }
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.settingsCacheClearedMessage)),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.settingsCacheClearFailedMessage(e.toString()))),
      );
    } finally {
      if (mounted) setState(() => _clearingCache = false);
    }
  }

  Future<void> _openUrl(String url) async {
    final l10n = AppLocalizations.of(context)!;
    final uri = Uri.parse(url);
    final ok = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!ok && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.settingsLinkOpenFailedMessage(url))),
      );
    }
  }

  void _checkForUpdates() {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.settingsUpdatesDialogTitle),
        content: Text(l10n.settingsUpdatesDialogBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(l10n.settingsUpdatesDialogOk),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settingsScreenTitle),
        automaticallyImplyLeading: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Notifications
            Padding(
              padding: const EdgeInsets.all(DesignTokens.spacing16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.settingsNotificationsSectionTitle,
                    style: DesignTokens.subtitle1.copyWith(
                      color: DesignTokens.text,
                    ),
                  ),
                  const SizedBox(height: DesignTokens.spacing12),
                  _SwitchTile(
                    title: l10n.settingsPushNotificationsTitle,
                    subtitle: l10n.settingsPushNotificationsSubtitle,
                    value: _notificationsEnabled,
                    onChanged: _setNotificationsEnabled,
                  ),
                  const SizedBox(height: DesignTokens.spacing12),
                  _SwitchTile(
                    title: l10n.settingsEmailDigestTitle,
                    subtitle: l10n.settingsEmailDigestSubtitle,
                    value: _emailDigest,
                    onChanged: _setEmailDigest,
                  ),
                  const SizedBox(height: DesignTokens.spacing12),
                  _SwitchTile(
                    title: l10n.settingsMarketingEmailsTitle,
                    subtitle: l10n.settingsMarketingEmailsSubtitle,
                    value: _marketingEmails,
                    onChanged: _setMarketingEmails,
                  ),
                ],
              ),
            ),
            const Divider(color: DesignTokens.border),

            // Units & Display
            Padding(
              padding: const EdgeInsets.all(DesignTokens.spacing16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.settingsUnitsDisplaySectionTitle,
                    style: DesignTokens.subtitle1.copyWith(
                      color: DesignTokens.text,
                    ),
                  ),
                  const SizedBox(height: DesignTokens.spacing12),
                  _DropdownTile(
                    title: l10n.settingsMeasurementUnitsTitle,
                    value: _unitSystem,
                    items: [l10n.settingsUnitMetric, l10n.settingsUnitImperial],
                    values: const ['metric', 'imperial'],
                    onChanged: _setUnitSystem,
                  ),
                  const SizedBox(height: DesignTokens.spacing12),
                  _DropdownTile(
                    title: l10n.settingsThemeTitle,
                    value: _theme,
                    items: [
                      l10n.settingsThemeLight,
                      l10n.settingsThemeDark,
                      l10n.settingsThemeSystem,
                    ],
                    values: const ['light', 'dark', 'system'],
                    onChanged: _setTheme,
                  ),
                  const SizedBox(height: DesignTokens.spacing12),
                  _SwitchTile(
                    title: l10n.settingsLargeTextTitle,
                    subtitle: l10n.settingsLargeTextSubtitle,
                    value: _largeText,
                    onChanged: _setLargeText,
                  ),
                ],
              ),
            ),
            const Divider(color: DesignTokens.border),

            // Project Settings
            Padding(
              padding: const EdgeInsets.all(DesignTokens.spacing16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.settingsProjectSettingsSectionTitle,
                    style: DesignTokens.subtitle1.copyWith(
                      color: DesignTokens.text,
                    ),
                  ),
                  const SizedBox(height: DesignTokens.spacing12),
                  _SwitchTile(
                    title: l10n.settingsAutoSaveTitle,
                    subtitle: l10n.settingsAutoSaveSubtitle,
                    value: _autoSave,
                    onChanged: _setAutoSave,
                  ),
                  const SizedBox(height: DesignTokens.spacing12),
                  _SwitchTile(
                    title: l10n.settingsCloudSyncTitle,
                    subtitle: l10n.settingsCloudSyncSubtitle,
                    value: _cloudSync,
                    onChanged: _setCloudSync,
                  ),
                  const SizedBox(height: DesignTokens.spacing12),
                  _ActionTile(
                    title: l10n.settingsClearCacheTitle,
                    subtitle: _clearingCache
                        ? l10n.settingsClearingCacheInProgress
                        : l10n.settingsClearCacheSubtitle,
                    icon: Icons.delete_outline,
                    onTap: _clearingCache ? () {} : _clearCache,
                  ),
                ],
              ),
            ),
            const Divider(color: DesignTokens.border),

            // Privacy & Security
            Padding(
              padding: const EdgeInsets.all(DesignTokens.spacing16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.settingsPrivacySecuritySectionTitle,
                    style: DesignTokens.subtitle1.copyWith(
                      color: DesignTokens.text,
                    ),
                  ),
                  const SizedBox(height: DesignTokens.spacing12),
                  _ActionTile(
                    title: l10n.settingsPrivacyPolicyTitle,
                    subtitle: l10n.settingsPrivacyPolicySubtitle,
                    icon: Icons.privacy_tip_outlined,
                    onTap: () => _openUrl('https://andoza.ai/privacy'),
                  ),
                  const SizedBox(height: DesignTokens.spacing12),
                  _ActionTile(
                    title: l10n.settingsTermsOfServiceTitle,
                    subtitle: l10n.settingsTermsOfServiceSubtitle,
                    icon: Icons.description_outlined,
                    onTap: () => _openUrl('https://andoza.ai/terms'),
                  ),
                ],
              ),
            ),
            const Divider(color: DesignTokens.border),

            // About
            Padding(
              padding: const EdgeInsets.all(DesignTokens.spacing16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.settingsAboutSectionTitle,
                    style: DesignTokens.subtitle1.copyWith(
                      color: DesignTokens.text,
                    ),
                  ),
                  const SizedBox(height: DesignTokens.spacing12),
                  Container(
                    padding: const EdgeInsets.all(DesignTokens.spacing12),
                    decoration: BoxDecoration(
                      border: Border.all(color: DesignTokens.border),
                      borderRadius: BorderRadius.circular(
                        DesignTokens.radiusMd,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              l10n.settingsAppVersionLabel,
                              style: DesignTokens.bodyMedium.copyWith(
                                color: DesignTokens.text,
                              ),
                            ),
                            Text(
                              _appVersion ?? '…',
                              style: DesignTokens.bodyMedium.copyWith(
                                color: DesignTokens.textSecondary,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: DesignTokens.spacing12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              l10n.settingsBuildNumberLabel,
                              style: DesignTokens.bodyMedium.copyWith(
                                color: DesignTokens.text,
                              ),
                            ),
                            Text(
                              _buildNumber ?? '…',
                              style: DesignTokens.bodyMedium.copyWith(
                                color: DesignTokens.textSecondary,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: DesignTokens.spacing12),
                        Center(
                          child: TextButton(
                            onPressed: _checkForUpdates,
                            child: Text(l10n.settingsCheckForUpdatesButton),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: DesignTokens.spacing32),
          ],
        ),
      ),
    );
  }
}

class _SwitchTile extends StatelessWidget {
  const _SwitchTile({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  final String title;
  final String subtitle;
  final bool value;
  final Function(bool) onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(DesignTokens.spacing12),
      decoration: BoxDecoration(
        border: Border.all(color: DesignTokens.border),
        borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: DesignTokens.subtitle2.copyWith(
                    color: DesignTokens.text,
                  ),
                ),
                const SizedBox(height: DesignTokens.spacing4),
                Text(
                  subtitle,
                  style: DesignTokens.caption.copyWith(
                    color: DesignTokens.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeThumbColor: DesignTokens.primaryBlue,
          ),
        ],
      ),
    );
  }
}

class _DropdownTile extends StatelessWidget {
  const _DropdownTile({
    required this.title,
    required this.value,
    required this.items,
    required this.values,
    required this.onChanged,
  });

  final String title;
  final String value;
  final List<String> items;
  final List<String> values;
  final Function(String?) onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: DesignTokens.spacing12,
        vertical: DesignTokens.spacing8,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: DesignTokens.border),
        borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: DesignTokens.subtitle2.copyWith(color: DesignTokens.text),
          ),
          DropdownButton<String>(
            value: value,
            underline: const SizedBox(),
            items: List.generate(
              items.length,
              (i) => DropdownMenuItem(value: values[i], child: Text(items[i])),
            ),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}

class _ActionTile extends StatelessWidget {
  const _ActionTile({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(DesignTokens.spacing12),
        decoration: BoxDecoration(
          border: Border.all(color: DesignTokens.border),
          borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
        ),
        child: Row(
          children: [
            Icon(icon, color: DesignTokens.primaryBlue),
            const SizedBox(width: DesignTokens.spacing12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: DesignTokens.subtitle2.copyWith(
                      color: DesignTokens.text,
                    ),
                  ),
                  const SizedBox(height: DesignTokens.spacing4),
                  Text(
                    subtitle,
                    style: DesignTokens.caption.copyWith(
                      color: DesignTokens.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: DesignTokens.textSecondary),
          ],
        ),
      ),
    );
  }
}
