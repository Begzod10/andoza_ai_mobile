import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/design_tokens.dart';

/// S1: Shop Home
/// Main shop interface with featured products and category browsing
class S1ShopHomeScreen extends ConsumerStatefulWidget {
  const S1ShopHomeScreen({super.key});

  @override
  ConsumerState<S1ShopHomeScreen> createState() => _S1ShopHomeScreenState();
}

class _S1ShopHomeScreenState extends ConsumerState<S1ShopHomeScreen> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shop Materials'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined),
            onPressed: () => context.go('/shop/s5'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Search bar
            Padding(
              padding: const EdgeInsets.all(DesignTokens.spacing16),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search materials...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: DesignTokens.spacing12,
                    vertical: DesignTokens.spacing12,
                  ),
                ),
                onChanged: (value) => setState(() => _searchQuery = value),
              ),
            ),

            // Categories section
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: DesignTokens.spacing16,
              ),
              child: Text(
                'Shop by Category',
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
              child: GridView.count(
                crossAxisCount: 3,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: DesignTokens.spacing12,
                crossAxisSpacing: DesignTokens.spacing12,
                children: [
                  _CategoryCard(
                    icon: Icons.format_paint_outlined,
                    label: 'Paint',
                    onTap: () => context.go('/shop/s2?category=paint'),
                  ),
                  _CategoryCard(
                    icon: Icons.square_foot,
                    label: 'Flooring',
                    onTap: () => context.go('/shop/s2?category=flooring'),
                  ),
                  _CategoryCard(
                    icon: Icons.lightbulb_outline,
                    label: 'Lighting',
                    onTap: () => context.go('/shop/s2?category=lighting'),
                  ),
                  _CategoryCard(
                    icon: Icons.power_outlined,
                    label: 'Electrical',
                    onTap: () => context.go('/shop/s2?category=electrical'),
                  ),
                  _CategoryCard(
                    icon: Icons.plumbing,
                    label: 'Plumbing',
                    onTap: () => context.go('/shop/s2?category=plumbing'),
                  ),
                  _CategoryCard(
                    icon: Icons.construction_outlined,
                    label: 'Tools',
                    onTap: () => context.go('/shop/s2?category=tools'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: DesignTokens.spacing32),

            // Featured products section
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: DesignTokens.spacing16,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Featured Products',
                    style: DesignTokens.subtitle1.copyWith(
                      color: DesignTokens.text,
                    ),
                  ),
                  TextButton(
                    onPressed: () => context.go('/shop/s2'),
                    child: const Text('View All'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: DesignTokens.spacing12),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: DesignTokens.spacing16,
              ),
              child: Column(
                children: [
                  _ProductCard(
                    name: 'Premium Ceramic Tiles',
                    price: 850,
                    unit: 'per m²',
                    rating: 4.8,
                    onTap: () => context.go('/shop/s4'),
                  ),
                  const SizedBox(height: DesignTokens.spacing12),
                  _ProductCard(
                    name: 'Matte Wall Paint (1L)',
                    price: 180,
                    unit: 'per liter',
                    rating: 4.6,
                    onTap: () => context.go('/shop/s4'),
                  ),
                  const SizedBox(height: DesignTokens.spacing12),
                  _ProductCard(
                    name: 'LED Ceiling Light 60W',
                    price: 45000,
                    unit: 'per unit',
                    rating: 4.7,
                    onTap: () => context.go('/shop/s4'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: DesignTokens.spacing32),

            // Promo banner
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: DesignTokens.spacing16,
              ),
              child: Container(
                padding: const EdgeInsets.all(DesignTokens.spacing16),
                decoration: BoxDecoration(
                  color: DesignTokens.accentOrange.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
                  border: Border.all(
                    color: DesignTokens.accentOrange.withValues(alpha: 0.3),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Bulk Order Discount',
                      style: DesignTokens.heading3.copyWith(
                        color: DesignTokens.accentOrange,
                      ),
                    ),
                    const SizedBox(height: DesignTokens.spacing8),
                    Text(
                      'Get 10-15% off on orders above 100,000 UZS',
                      style: DesignTokens.bodyMedium.copyWith(
                        color: DesignTokens.textSecondary,
                      ),
                    ),
                    const SizedBox(height: DesignTokens.spacing12),
                    ElevatedButton(
                      onPressed: () => context.go('/shop/s2'),
                      child: const Text('Shop Now'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: DesignTokens.spacing32),
          ],
        ),
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  const _CategoryCard({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: DesignTokens.border),
          borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 32, color: DesignTokens.primaryBlue),
            const SizedBox(height: DesignTokens.spacing8),
            Text(
              label,
              style: DesignTokens.caption.copyWith(color: DesignTokens.text),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  const _ProductCard({
    required this.name,
    required this.price,
    required this.unit,
    required this.rating,
    required this.onTap,
  });

  final String name;
  final int price;
  final String unit;
  final double rating;
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
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: DesignTokens.primaryBlue.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(DesignTokens.radiusSm),
              ),
              child: Icon(
                Icons.image_outlined,
                color: DesignTokens.textSecondary,
                size: 32,
              ),
            ),
            const SizedBox(width: DesignTokens.spacing12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: DesignTokens.subtitle2.copyWith(
                      color: DesignTokens.text,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: DesignTokens.spacing4),
                  Row(
                    children: [
                      Icon(
                        Icons.star_outlined,
                        size: 14,
                        color: DesignTokens.accentOrange,
                      ),
                      const SizedBox(width: DesignTokens.spacing4),
                      Text(
                        '$rating',
                        style: DesignTokens.caption.copyWith(
                          color: DesignTokens.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: DesignTokens.spacing4),
                  Text(
                    '$price UZS $unit',
                    style: DesignTokens.subtitle2.copyWith(
                      color: DesignTokens.primaryBlue,
                      fontWeight: FontWeight.bold,
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
