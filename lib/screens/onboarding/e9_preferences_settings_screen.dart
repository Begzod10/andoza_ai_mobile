import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../config/design_tokens.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Preferences'),
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
                    'Notifications',
                    style: DesignTokens.subtitle1.copyWith(
                      color: DesignTokens.text,
                    ),
                  ),
                  const SizedBox(height: DesignTokens.spacing12),
                  _SwitchTile(
                    title: 'Push Notifications',
                    subtitle: 'Get updates about projects and contractors',
                    value: _notificationsEnabled,
                    onChanged: (v) =>
                        setState(() => _notificationsEnabled = v),
                  ),
                  const SizedBox(height: DesignTokens.spacing12),
                  _SwitchTile(
                    title: 'Email Digest',
                    subtitle: 'Weekly summary of your projects',
                    value: _emailDigest,
                    onChanged: (v) =>
                        setState(() => _emailDigest = v),
                  ),
                  const SizedBox(height: DesignTokens.spacing12),
                  _SwitchTile(
                    title: 'Marketing Emails',
                    subtitle: 'News about new features and offers',
                    value: _marketingEmails,
                    onChanged: (v) =>
                        setState(() => _marketingEmails = v),
                  ),
                ],
              ),
            ),
            Divider(color: DesignTokens.border),

            // Units & Display
            Padding(
              padding: const EdgeInsets.all(DesignTokens.spacing16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Units & Display',
                    style: DesignTokens.subtitle1.copyWith(
                      color: DesignTokens.text,
                    ),
                  ),
                  const SizedBox(height: DesignTokens.spacing12),
                  _DropdownTile(
                    title: 'Measurement Units',
                    value: _unitSystem,
                    items: ['Metric (m²)', 'Imperial (ft²)'],
                    values: ['metric', 'imperial'],
                    onChanged: (v) =>
                        setState(() => _unitSystem = v ?? 'metric'),
                  ),
                  const SizedBox(height: DesignTokens.spacing12),
                  _DropdownTile(
                    title: 'Theme',
                    value: _theme,
                    items: ['Light', 'Dark', 'System'],
                    values: ['light', 'dark', 'system'],
                    onChanged: (v) =>
                        setState(() => _theme = v ?? 'light'),
                  ),
                  const SizedBox(height: DesignTokens.spacing12),
                  _SwitchTile(
                    title: 'Large Text',
                    subtitle: 'Increase text size for better readability',
                    value: false,
                    onChanged: (v) {},
                  ),
                ],
              ),
            ),
            Divider(color: DesignTokens.border),

            // Project Settings
            Padding(
              padding: const EdgeInsets.all(DesignTokens.spacing16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Project Settings',
                    style: DesignTokens.subtitle1.copyWith(
                      color: DesignTokens.text,
                    ),
                  ),
                  const SizedBox(height: DesignTokens.spacing12),
                  _SwitchTile(
                    title: 'Auto-Save Projects',
                    subtitle: 'Automatically save your work as you progress',
                    value: _autoSave,
                    onChanged: (v) =>
                        setState(() => _autoSave = v),
                  ),
                  const SizedBox(height: DesignTokens.spacing12),
                  _SwitchTile(
                    title: 'Cloud Sync',
                    subtitle: 'Sync projects across all your devices',
                    value: true,
                    onChanged: (v) {},
                  ),
                  const SizedBox(height: DesignTokens.spacing12),
                  _ActionTile(
                    title: 'Clear Cache',
                    subtitle: 'Free up storage space',
                    icon: Icons.delete_outline,
                    onTap: () {},
                  ),
                ],
              ),
            ),
            Divider(color: DesignTokens.border),

            // Privacy & Security
            Padding(
              padding: const EdgeInsets.all(DesignTokens.spacing16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Privacy & Security',
                    style: DesignTokens.subtitle1.copyWith(
                      color: DesignTokens.text,
                    ),
                  ),
                  const SizedBox(height: DesignTokens.spacing12),
                  _ActionTile(
                    title: 'Privacy Policy',
                    subtitle: 'Read our privacy policy',
                    icon: Icons.privacy_tip_outlined,
                    onTap: () {},
                  ),
                  const SizedBox(height: DesignTokens.spacing12),
                  _ActionTile(
                    title: 'Terms of Service',
                    subtitle: 'Review terms and conditions',
                    icon: Icons.description_outlined,
                    onTap: () {},
                  ),
                ],
              ),
            ),
            Divider(color: DesignTokens.border),

            // About
            Padding(
              padding: const EdgeInsets.all(DesignTokens.spacing16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'About',
                    style: DesignTokens.subtitle1.copyWith(
                      color: DesignTokens.text,
                    ),
                  ),
                  const SizedBox(height: DesignTokens.spacing12),
                  Container(
                    padding: const EdgeInsets.all(DesignTokens.spacing12),
                    decoration: BoxDecoration(
                      border: Border.all(color: DesignTokens.border),
                      borderRadius:
                          BorderRadius.circular(DesignTokens.radiusMd),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'App Version',
                              style: DesignTokens.bodyMedium.copyWith(
                                color: DesignTokens.text,
                              ),
                            ),
                            Text(
                              '1.0.0',
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
                              'Build Number',
                              style: DesignTokens.bodyMedium.copyWith(
                                color: DesignTokens.text,
                              ),
                            ),
                            Text(
                              '2026.07.31',
                              style: DesignTokens.bodyMedium.copyWith(
                                color: DesignTokens.textSecondary,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: DesignTokens.spacing12),
                        Center(
                          child: TextButton(
                            onPressed: () {},
                            child: const Text('Check for Updates'),
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
            activeColor: DesignTokens.primaryBlue,
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
            style: DesignTokens.subtitle2.copyWith(
              color: DesignTokens.text,
            ),
          ),
          DropdownButton<String>(
            value: value,
            underline: const SizedBox(),
            items: List.generate(
              items.length,
              (i) => DropdownMenuItem(
                value: values[i],
                child: Text(items[i]),
              ),
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
            Icon(
              Icons.chevron_right,
              color: DesignTokens.textSecondary,
            ),
          ],
        ),
      ),
    );
  }
}
