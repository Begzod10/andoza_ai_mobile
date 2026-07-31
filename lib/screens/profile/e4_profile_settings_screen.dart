import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/design_tokens.dart';

/// E4: Profile & Account Settings
/// User profile information and account management
class E4ProfileSettingsScreen extends ConsumerStatefulWidget {
  const E4ProfileSettingsScreen({super.key});

  @override
  ConsumerState<E4ProfileSettingsScreen> createState() =>
      _E4ProfileSettingsScreenState();
}

class _E4ProfileSettingsScreenState
    extends ConsumerState<E4ProfileSettingsScreen> {
  final _nameController = TextEditingController(text: 'Dilshod Rakhimov');
  final _emailController = TextEditingController(
    text: 'dilshod.rakhimov@example.com',
  );
  final _phoneController = TextEditingController(text: '+998 99 123 45 67');
  bool _isSaving = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _saveChanges() async {
    setState(() => _isSaving = true);
    await Future.delayed(const Duration(milliseconds: 500));
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully')),
      );
      setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Settings'),
        automaticallyImplyLeading: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Profile picture section
            Padding(
              padding: const EdgeInsets.all(DesignTokens.spacing16),
              child: Center(
                child: Column(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: DesignTokens.primaryBlue.withValues(alpha: 0.1),
                      ),
                      child: Icon(
                        Icons.person,
                        color: DesignTokens.primaryBlue,
                        size: 60,
                      ),
                    ),
                    const SizedBox(height: DesignTokens.spacing12),
                    TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.camera_alt_outlined),
                      label: const Text('Change Photo'),
                    ),
                  ],
                ),
              ),
            ),

            // Personal information
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: DesignTokens.spacing16,
              ),
              child: Text(
                'Personal Information',
                style: DesignTokens.subtitle1.copyWith(
                  color: DesignTokens.text,
                ),
              ),
            ),
            const SizedBox(height: DesignTokens.spacing12),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: DesignTokens.spacing16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Full Name',
                    style: DesignTokens.bodyMedium.copyWith(
                      color: DesignTokens.text,
                    ),
                  ),
                  const SizedBox(height: DesignTokens.spacing8),
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          DesignTokens.radiusMd,
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: DesignTokens.spacing12,
                        vertical: DesignTokens.spacing12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: DesignTokens.spacing16),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: DesignTokens.spacing16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Email Address',
                    style: DesignTokens.bodyMedium.copyWith(
                      color: DesignTokens.text,
                    ),
                  ),
                  const SizedBox(height: DesignTokens.spacing8),
                  TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          DesignTokens.radiusMd,
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: DesignTokens.spacing12,
                        vertical: DesignTokens.spacing12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: DesignTokens.spacing16),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: DesignTokens.spacing16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Phone Number',
                    style: DesignTokens.bodyMedium.copyWith(
                      color: DesignTokens.text,
                    ),
                  ),
                  const SizedBox(height: DesignTokens.spacing8),
                  TextField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          DesignTokens.radiusMd,
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: DesignTokens.spacing12,
                        vertical: DesignTokens.spacing12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: DesignTokens.spacing24),

            // Account settings
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: DesignTokens.spacing16,
              ),
              child: Text(
                'Account Settings',
                style: DesignTokens.subtitle1.copyWith(
                  color: DesignTokens.text,
                ),
              ),
            ),
            const SizedBox(height: DesignTokens.spacing12),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: DesignTokens.spacing16,
              ),
              child: Column(
                children: [
                  _SettingsTile(
                    icon: Icons.lock_outlined,
                    title: 'Change Password',
                    subtitle: 'Update your password',
                    onTap: () {},
                  ),
                  const SizedBox(height: DesignTokens.spacing12),
                  _SettingsTile(
                    icon: Icons.notifications_outlined,
                    title: 'Notifications',
                    subtitle: 'Manage notification preferences',
                    onTap: () {},
                  ),
                  const SizedBox(height: DesignTokens.spacing12),
                  _SettingsTile(
                    icon: Icons.privacy_tip_outlined,
                    title: 'Privacy & Security',
                    subtitle: 'Control your privacy settings',
                    onTap: () {},
                  ),
                ],
              ),
            ),
            const SizedBox(height: DesignTokens.spacing24),

            // Danger zone
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: DesignTokens.spacing16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Danger Zone',
                    style: DesignTokens.subtitle1.copyWith(color: Colors.red),
                  ),
                  const SizedBox(height: DesignTokens.spacing12),
                  OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.red),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: DesignTokens.spacing12,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.logout, color: Colors.red),
                          const SizedBox(width: DesignTokens.spacing8),
                          Text(
                            'Sign Out',
                            style: DesignTokens.bodyMedium.copyWith(
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: DesignTokens.spacing12),
                  OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.red),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: DesignTokens.spacing12,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.delete_outline, color: Colors.red),
                          const SizedBox(width: DesignTokens.spacing8),
                          Text(
                            'Delete Account',
                            style: DesignTokens.bodyMedium.copyWith(
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: DesignTokens.spacing32),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(DesignTokens.spacing16),
        child: ElevatedButton(
          onPressed: _isSaving ? () {} : _saveChanges,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: DesignTokens.spacing12,
            ),
            child: _isSaving
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text('Save Changes'),
          ),
        ),
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
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
            Icon(Icons.chevron_right, color: DesignTokens.textSecondary),
          ],
        ),
      ),
    );
  }
}
