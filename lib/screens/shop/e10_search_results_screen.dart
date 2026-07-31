import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../config/design_tokens.dart';
import '../../models/shop_model.dart';
import '../../providers/cart_provider.dart';
import '../../providers/shop_provider.dart';
import '../../utils/currency.dart';

enum _ResultFilter { all, forMyProject, cheapest, rating }

/// E10: Qidiruv natijalari — active search with clear, filter chips
/// (Barchasi · Loyihamga mos · Eng arzon · Reyting), result count, rows
/// with "Loyihada" tags and a quick + to cart. Reuses Batch S's real
/// catalog/cart providers rather than a separate mock dataset.
class E10SearchResultsScreen extends ConsumerStatefulWidget {
  const E10SearchResultsScreen({this.initialQuery = '', super.key});

  final String initialQuery;

  @override
  ConsumerState<E10SearchResultsScreen> createState() =>
      _E10SearchResultsScreenState();
}

class _E10SearchResultsScreenState
    extends ConsumerState<E10SearchResultsScreen> {
  late final _controller = TextEditingController(text: widget.initialQuery);
  _ResultFilter _filter = _ResultFilter.all;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final catalog = ref.watch(shopCatalogProvider);
    final query = _controller.text.trim().toLowerCase();

    var results = query.isEmpty
        ? catalog
        : catalog.where((p) => p.name.toLowerCase().contains(query)).toList();

    results = switch (_filter) {
      _ResultFilter.all => results,
      _ResultFilter.forMyProject =>
        results.where((p) => p.isInProject).toList(),
      _ResultFilter.cheapest => [
        ...results,
      ]..sort((a, b) => a.pricePerUnit.compareTo(b.pricePerUnit)),
      _ResultFilter.rating => results,
    };

    return Scaffold(
      backgroundColor: DesignTokens.backgroundLight,
      appBar: AppBar(
        backgroundColor: DesignTokens.backgroundLight,
        elevation: 0,
        title: Text('Qidiruv natijalari', style: DesignTokens.subtitle1),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(DesignTokens.screenPaddingHorizontal),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: DesignTokens.spacingMd,
              ),
              decoration: BoxDecoration(
                color: DesignTokens.white,
                borderRadius: BorderRadius.circular(DesignTokens.radiusFull),
                border: Border.all(color: DesignTokens.borderGray),
              ),
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Material qidirish...',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: _controller.text.isEmpty
                      ? null
                      : IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () => setState(_controller.clear),
                        ),
                ),
                onChanged: (_) => setState(() {}),
              ),
            ),
          ),
          SizedBox(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(
                horizontal: DesignTokens.screenPaddingHorizontal,
              ),
              children: [
                _FilterChip(
                  label: 'Barchasi',
                  selected: _filter == _ResultFilter.all,
                  onTap: () => setState(() => _filter = _ResultFilter.all),
                ),
                _FilterChip(
                  label: 'Loyihamga mos',
                  selected: _filter == _ResultFilter.forMyProject,
                  onTap: () =>
                      setState(() => _filter = _ResultFilter.forMyProject),
                ),
                _FilterChip(
                  label: 'Eng arzon',
                  selected: _filter == _ResultFilter.cheapest,
                  onTap: () => setState(() => _filter = _ResultFilter.cheapest),
                ),
                _FilterChip(
                  label: 'Reyting',
                  selected: _filter == _ResultFilter.rating,
                  onTap: () => setState(() => _filter = _ResultFilter.rating),
                ),
              ],
            ),
          ),
          const SizedBox(height: DesignTokens.spacingSm),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: DesignTokens.screenPaddingHorizontal,
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '${results.length} ta natija',
                style: DesignTokens.caption.copyWith(
                  color: DesignTokens.textGray,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(
                DesignTokens.screenPaddingHorizontal,
              ),
              itemCount: results.length,
              separatorBuilder: (_, _) =>
                  const SizedBox(height: DesignTokens.spacingSm),
              itemBuilder: (context, index) =>
                  _ResultRow(product: results[index]),
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: DesignTokens.spacingSm),
      child: ChoiceChip(
        label: Text(label),
        selected: selected,
        onSelected: (_) => onTap(),
        backgroundColor: DesignTokens.white,
        selectedColor: DesignTokens.primaryBlue,
        labelStyle: DesignTokens.caption.copyWith(
          color: selected ? DesignTokens.white : DesignTokens.textDark,
        ),
      ),
    );
  }
}

class _ResultRow extends ConsumerWidget {
  const _ResultRow({required this.product});

  final Product product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(DesignTokens.spacingSm),
      decoration: BoxDecoration(
        color: DesignTokens.white,
        borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
        border: Border.all(color: DesignTokens.borderGray),
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: DesignTokens.borderGrayAlt,
              borderRadius: BorderRadius.circular(DesignTokens.radiusSm),
            ),
            child: const Icon(
              Icons.image_outlined,
              color: DesignTokens.textMuted,
            ),
          ),
          const SizedBox(width: DesignTokens.spacingSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        product.name,
                        style: DesignTokens.body2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (product.isInProject) ...[
                      const SizedBox(width: DesignTokens.spacingXs),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 5,
                          vertical: 1,
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
                    ],
                  ],
                ),
                Text(
                  '${formatSom(product.pricePerUnit)} / ${product.unit}',
                  style: DesignTokens.caption.copyWith(
                    color: DesignTokens.primaryBlue,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.add_circle_outline,
              color: DesignTokens.primaryBlue,
            ),
            onPressed: () {
              final dealer = bestDealer(dealersForProduct(product));
              ref.read(cartProvider.notifier).add(product, dealer);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Savatga qo\'shildi')),
              );
            },
          ),
        ],
      ),
    );
  }
}
