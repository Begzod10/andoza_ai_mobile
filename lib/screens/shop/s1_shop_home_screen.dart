import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/design_tokens.dart';
import '../../models/shop_model.dart';
import '../../providers/cart_provider.dart';
import '../../providers/shop_provider.dart';
import '../../utils/currency.dart';

/// S1: Do'kon bosh — search, project-linked banner ("SIZNING
/// LOYIHANGIZ"), category chips, 2-col product grid with "Loyihada" tags
/// for items the active project actually needs.
class S1ShopHomeScreen extends ConsumerStatefulWidget {
  const S1ShopHomeScreen({super.key});

  @override
  ConsumerState<S1ShopHomeScreen> createState() => _S1ShopHomeScreenState();
}

class _S1ShopHomeScreenState extends ConsumerState<S1ShopHomeScreen> {
  ShopCategory? _filter;
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final catalog = ref.watch(shopCatalogProvider);
    final cartCount = ref.watch(cartLineCountProvider);
    final projectItems = catalog.where((p) => p.isInProject).toList();

    final products = catalog.where((p) {
      if (_filter != null && p.category != _filter) return false;
      if (_query.isNotEmpty &&
          !p.name.toLowerCase().contains(_query.toLowerCase())) {
        return false;
      }
      return true;
    }).toList();

    return Scaffold(
      backgroundColor: DesignTokens.backgroundLight,
      appBar: AppBar(
        backgroundColor: DesignTokens.backgroundLight,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text('Do\'kon', style: DesignTokens.heading3),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart_outlined),
                onPressed: () => context.push('/shop/s5'),
              ),
              if (cartCount > 0)
                Positioned(
                  right: 6,
                  top: 6,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5,
                      vertical: 1,
                    ),
                    decoration: const BoxDecoration(
                      color: DesignTokens.accentOrange,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '$cartCount',
                      style: const TextStyle(
                        color: DesignTokens.white,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: DesignTokens.spacingSm),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(DesignTokens.screenPaddingHorizontal),
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: DesignTokens.spacingMd,
            ),
            decoration: BoxDecoration(
              color: DesignTokens.white,
              borderRadius: BorderRadius.circular(DesignTokens.radiusFull),
              boxShadow: [DesignTokens.shadowCard],
            ),
            child: TextField(
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Material qidirish...',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) => setState(() => _query = value),
              onSubmitted: (value) =>
                  context.push('/shop/search', extra: value),
            ),
          ),
          const SizedBox(height: DesignTokens.spacingMd),
          _ProjectBanner(projectItemCount: projectItems.length),
          const SizedBox(height: DesignTokens.spacingLg),
          SizedBox(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _CategoryChip(
                  label: 'Barchasi',
                  selected: _filter == null,
                  onTap: () => setState(() => _filter = null),
                ),
                for (final category in ShopCategory.values)
                  Padding(
                    padding: const EdgeInsets.only(
                      left: DesignTokens.spacingSm,
                    ),
                    child: _CategoryChip(
                      label: category.label,
                      selected: _filter == category,
                      onTap: () => setState(() => _filter = category),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: DesignTokens.spacingLg),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: products.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: DesignTokens.spacingMd,
              crossAxisSpacing: DesignTokens.spacingMd,
              childAspectRatio: 0.72,
            ),
            itemBuilder: (context, index) {
              final product = products[index];
              return _ProductCard(
                product: product,
                onTap: () => context.push('/shop/s3', extra: product),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ProjectBanner extends StatelessWidget {
  const _ProjectBanner({required this.projectItemCount});

  final int projectItemCount;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(DesignTokens.radiusLg),
      onTap: () => context.push('/shop/s2'),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(DesignTokens.spacingLg),
        decoration: BoxDecoration(
          color: DesignTokens.primaryBlue,
          borderRadius: BorderRadius.circular(DesignTokens.radiusLg),
          boxShadow: [DesignTokens.shadowElevated],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'SIZNING LOYIHANGIZ',
              style: DesignTokens.caption.copyWith(
                color: DesignTokens.white.withValues(alpha: 0.7),
                fontWeight: FontWeight.bold,
                letterSpacing: 1.0,
              ),
            ),
            const SizedBox(height: DesignTokens.spacingXs),
            Text(
              'Mehmonxona loyihangiz uchun',
              style: DesignTokens.subtitle1.copyWith(color: DesignTokens.white),
            ),
            const SizedBox(height: DesignTokens.spacingXs),
            Text(
              projectItemCount > 0
                  ? '$projectItemCount turdagi material kerak'
                  : 'Loyiha materiallari hisoblanmoqda',
              style: DesignTokens.body2.copyWith(
                color: DesignTokens.white.withValues(alpha: 0.85),
              ),
            ),
            const SizedBox(height: DesignTokens.spacingSm),
            Text(
              'Hammasini ko\'rish →',
              style: DesignTokens.body2.copyWith(
                color: DesignTokens.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  const _CategoryChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      onSelected: (_) => onTap(),
      backgroundColor: DesignTokens.white,
      selectedColor: DesignTokens.primaryBlue,
      labelStyle: DesignTokens.caption.copyWith(
        color: selected ? DesignTokens.white : DesignTokens.textDark,
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  const _ProductCard({required this.product, required this.onTap});

  final Product product;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
      child: Container(
        padding: const EdgeInsets.all(DesignTokens.spacingSm),
        decoration: BoxDecoration(
          color: DesignTokens.white,
          borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
          border: Border.all(color: DesignTokens.borderGray),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                AspectRatio(
                  aspectRatio: 1.3,
                  child: Container(
                    decoration: BoxDecoration(
                      color: DesignTokens.borderGrayAlt,
                      borderRadius: BorderRadius.circular(
                        DesignTokens.radiusSm,
                      ),
                    ),
                    child: const Icon(
                      Icons.image_outlined,
                      color: DesignTokens.textMuted,
                    ),
                  ),
                ),
                if (product.isInProject)
                  Positioned(
                    left: 4,
                    top: 4,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: DesignTokens.primaryBlue,
                        borderRadius: BorderRadius.circular(
                          DesignTokens.radiusSm,
                        ),
                      ),
                      child: Text(
                        'Loyihada',
                        style: DesignTokens.caption.copyWith(
                          color: DesignTokens.white,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: DesignTokens.spacingSm),
            Text(
              product.name,
              style: DesignTokens.body2.copyWith(color: DesignTokens.textDark),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              product.brand,
              style: DesignTokens.caption.copyWith(
                color: DesignTokens.textGray,
              ),
            ),
            const Spacer(),
            Text(
              '${formatSom(product.pricePerUnit)} / ${product.unit}',
              style: DesignTokens.subtitle2.copyWith(
                color: DesignTokens.primaryBlue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
