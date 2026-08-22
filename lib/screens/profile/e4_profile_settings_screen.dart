import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/design_tokens.dart';
import '../../providers/auth_provider.dart';
import '../../providers/estimate_provider.dart';
import '../../providers/orders_provider.dart';
import '../home/home_empty_screen.dart';

/// E4: Profil bosh — avatar, name, verified badge, three stat cards, and
/// the profile menu list. The "tejaldi" savings figure is the real
/// [estimateProvider] total (backfilled from Step 8's placeholder once
/// Step 11's pricing layer landed).
class E4ProfileSettingsScreen extends ConsumerWidget {
  const E4ProfileSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserProvider);
    final name = currentUser.maybeWhen(
      data: (user) => user?.firstName ?? user?.name ?? user?.username,
      orElse: () => null,
    );
    final phone = currentUser.maybeWhen(
      data: (user) => user?.phone,
      orElse: () => null,
    );
    final projectCount = ref.watch(projectsProvider).maybeWhen(
      data: (projects) => projects.length,
      orElse: () => 0,
    );
    final orderCount = ref.watch(serverOrdersProvider).maybeWhen(
      data: (data) => data.length,
      orElse: () => ref.watch(ordersProvider).length,
    );
    final savings = estimateSavingsTotal(ref.watch(estimateProvider));

    return Scaffold(
      backgroundColor: DesignTokens.backgroundLight,
      appBar: AppBar(
        backgroundColor: DesignTokens.backgroundLight,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text('Profil', style: DesignTokens.heading3),
      ),
      body: ListView(
        padding: const EdgeInsets.all(DesignTokens.screenPaddingHorizontal),
        children: [
          Center(
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 44,
                  backgroundColor: DesignTokens.primaryBlue,
                  child: Icon(
                    Icons.person,
                    color: DesignTokens.white,
                    size: 44,
                  ),
                ),
                const SizedBox(height: DesignTokens.spacingMd),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(name ?? 'Foydalanuvchi', style: DesignTokens.heading3),
                    const SizedBox(width: DesignTokens.spacingXs),
                    InkWell(
                      onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Tez kunda')),
                      ),
                      child: const Icon(
                        Icons.edit_outlined,
                        size: 18,
                        color: DesignTokens.textGray,
                      ),
                    ),
                  ],
                ),
                if (phone != null)
                  Text(
                    phone,
                    style: DesignTokens.body2.copyWith(
                      color: DesignTokens.textGray,
                    ),
                  ),
                const SizedBox(height: DesignTokens.spacingXs),
                Text(
                  '✓ Tasdiqlangan',
                  style: DesignTokens.caption.copyWith(
                    color: DesignTokens.successGreen,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: DesignTokens.spacingLg),
          Row(
            children: [
              Expanded(
                child: _StatCard(value: '$projectCount', label: 'loyiha'),
              ),
              const SizedBox(width: DesignTokens.spacingSm),
              Expanded(
                child: _StatCard(value: '$orderCount', label: 'buyurtma'),
              ),
              const SizedBox(width: DesignTokens.spacingSm),
              Expanded(
                child: _StatCard(
                  value: '${(savings / 1000000).toStringAsFixed(1)} mln',
                  label: 'tejaldi',
                ),
              ),
            ],
          ),
          const SizedBox(height: DesignTokens.spacingLg),
          _MenuTile(
            icon: Icons.architecture_outlined,
            label: 'Loyihalarim',
            onTap: () => context.push('/profile/e5'),
          ),
          _MenuTile(
            icon: Icons.shopping_bag_outlined,
            label: 'Buyurtmalarim',
            onTap: () => context.push('/profile/e6'),
          ),
          _MenuTile(
            icon: Icons.bookmark_border,
            label: 'Saqlangan dizaynlar',
            onTap: () => context.push('/profile/e11'),
          ),
          _MenuTile(
            icon: Icons.location_on_outlined,
            label: 'Manzillarim',
            onTap: () => ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('Tez kunda'))),
          ),
          _MenuTile(
            icon: Icons.credit_card_outlined,
            label: 'To\'lov usullari',
            onTap: () => context.push('/shop/s6'),
          ),
          _MenuTile(
            icon: Icons.language_outlined,
            label: 'Til',
            onTap: () => ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('O\'zbekcha'))),
          ),
          _MenuTile(
            icon: Icons.settings_outlined,
            label: 'Sozlamalar',
            onTap: () => context.push('/profile/settings'),
          ),
          _MenuTile(
            icon: Icons.help_outline,
            label: 'Yordam',
            onTap: () => context.push('/onboarding/e8'),
          ),
          const SizedBox(height: DesignTokens.spacingSm),
          _MenuTile(
            icon: Icons.logout,
            label: 'Chiqish',
            isDestructive: true,
            onTap: () => ref.read(authStateProvider.notifier).logout(),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: DesignTokens.spacingMd),
      decoration: BoxDecoration(
        color: DesignTokens.white,
        borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
        border: Border.all(color: DesignTokens.borderGray),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: DesignTokens.subtitle1.copyWith(
              color: DesignTokens.primaryBlue,
            ),
          ),
          Text(
            label,
            style: DesignTokens.caption.copyWith(color: DesignTokens.textGray),
          ),
        ],
      ),
    );
  }
}

class _MenuTile extends StatelessWidget {
  const _MenuTile({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isDestructive = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isDestructive;

  @override
  Widget build(BuildContext context) {
    final color = isDestructive ? DesignTokens.errorRed : DesignTokens.textDark;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: DesignTokens.spacingSm),
        child: Row(
          children: [
            Icon(
              icon,
              color: isDestructive
                  ? DesignTokens.errorRed
                  : DesignTokens.textGray,
            ),
            const SizedBox(width: DesignTokens.spacingMd),
            Expanded(
              child: Text(
                label,
                style: DesignTokens.body2.copyWith(color: color),
              ),
            ),
            if (!isDestructive)
              const Icon(Icons.chevron_right, color: DesignTokens.textMuted),
          ],
        ),
      ),
    );
  }
}
