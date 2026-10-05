import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/design_tokens.dart';
import '../../l10n/app_localizations.dart';
import '../../models/shop_model.dart';
import '../../providers/cart_provider.dart';
import '../../providers/shop_provider.dart';
import '../../utils/currency.dart';
import '../../widgets/design/room_thumbnail.dart';

/// S2: Loyiha materiallari — the screen where the app's intelligence
/// shows: a room picker (any room across the user's apartments, not just
/// whichever one was last active — see shop_provider.dart's
/// [selectedShopRoomIdProvider]), a green banner stating the app computed
/// everything from that room's real state, then the required materials
/// grouped by renovation stage (never a stage the room's starting condition
/// already excludes) — each with an image, a checkbox, and a price, so the
/// user can deselect items before adding the rest to the cart.
class S2ProjectMaterialsScreen extends ConsumerStatefulWidget {
  const S2ProjectMaterialsScreen({super.key});

  @override
  ConsumerState<S2ProjectMaterialsScreen> createState() =>
      _S2ProjectMaterialsScreenState();
}

class _S2ProjectMaterialsScreenState
    extends ConsumerState<S2ProjectMaterialsScreen> {
  // productId -> selected. Absent means selected (default-on), matching the
  // "everything needed" starting point the old "add all" button assumed.
  final Set<String> _deselected = {};

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final groups = ref.watch(projectMaterialsProvider);
    final (area, stageCount) = ref.watch(projectMaterialsSummaryProvider);
    final catalog = ref.watch(shopCatalogProvider);
    final productById = {for (final p in catalog) p.id: p};
    final rooms = ref.watch(selectableRoomsProvider);
    final selectedRoomId = ref.watch(selectedShopRoomIdProvider);

    final allItems = [for (final g in groups) ...g.items];
    final selectedItems =
        allItems.where((i) => !_deselected.contains(i.productId)).toList();
    final selectedTotal = selectedItems.fold<int>(0, (sum, item) {
      final product = productById[item.productId];
      if (product == null) return sum;
      return sum + (product.pricePerUnit * item.quantity).round();
    });

    return Scaffold(
      backgroundColor: DesignTokens.backgroundLight,
      appBar: AppBar(
        backgroundColor: DesignTokens.backgroundLight,
        elevation: 0,
        title: Text(l10n.shopMaterialsTitle, style: DesignTokens.heading3),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(
                DesignTokens.screenPaddingHorizontal,
              ),
              children: [
                if (rooms.isNotEmpty) ...[
                  Text(
                    l10n.shopSelectRoomLabel,
                    style: DesignTokens.caption.copyWith(
                      color: DesignTokens.textGray,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: DesignTokens.spacingSm),
                  SizedBox(
                    height: 56,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: rooms.length,
                      separatorBuilder: (_, _) =>
                          const SizedBox(width: DesignTokens.spacingSm),
                      itemBuilder: (context, i) {
                        final r = rooms[i];
                        // Null selectedRoomId means "no explicit pick yet" —
                        // that state still visually resolves to whichever
                        // room _computeAreas() falls back to, but no chip is
                        // highlighted for it since the user hasn't chosen.
                        final selected = r.room.id == selectedRoomId;
                        return _RoomChip(
                          room: r,
                          selected: selected,
                          onTap: () {
                            ref
                                .read(selectedShopRoomIdProvider.notifier)
                                .state = r.room.id;
                            setState(() => _deselected.clear());
                          },
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: DesignTokens.spacingLg),
                ],
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(DesignTokens.spacingMd),
                  decoration: BoxDecoration(
                    color: DesignTokens.successGreen.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
                    border: Border.all(
                      color: DesignTokens.successGreen.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.auto_awesome,
                        color: DesignTokens.successGreen,
                      ),
                      const SizedBox(width: DesignTokens.spacingSm),
                      Expanded(
                        child: Text(
                          l10n.shopMaterialsAutoCalc(
                            area.toStringAsFixed(1),
                            stageCount,
                          ),
                          style: DesignTokens.body2.copyWith(
                            color: DesignTokens.textDark,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: DesignTokens.spacingLg),
                for (final group in groups) ...[
                  Text(group.stageLabel, style: DesignTokens.subtitle1),
                  const SizedBox(height: DesignTokens.spacingSm),
                  for (final item in group.items) ...[
                    _MaterialRow(
                      item: item,
                      product: productById[item.productId],
                      selected: !_deselected.contains(item.productId),
                      onToggle: () => setState(() {
                        if (!_deselected.add(item.productId)) {
                          _deselected.remove(item.productId);
                        }
                      }),
                    ),
                    const SizedBox(height: DesignTokens.spacingSm),
                  ],
                  const SizedBox(height: DesignTokens.spacingMd),
                ],
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(DesignTokens.spacingMd),
            decoration: const BoxDecoration(
              color: DesignTokens.white,
              boxShadow: [DesignTokens.shadowNavBar],
            ),
            child: SafeArea(
              top: false,
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.shopSelectedCount(selectedItems.length),
                          style: DesignTokens.caption.copyWith(
                            color: DesignTokens.textGray,
                          ),
                        ),
                        Text(
                          formatSom(selectedTotal),
                          style: DesignTokens.subtitle1,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: DesignTokens.spacingMd),
                  ElevatedButton(
                    onPressed: selectedItems.isEmpty
                        ? null
                        : () {
                            final cart = ref.read(cartProvider.notifier);
                            for (final item in selectedItems) {
                              final product = productById[item.productId];
                              if (product == null) continue;
                              final dealer =
                                  bestDealer(dealersForProduct(product));
                              cart.add(
                                product,
                                dealer,
                                quantity: item.quantity,
                              );
                            }
                            context.push('/shop/s5');
                          },
                    child: Text(l10n.shopAddAllToCart),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RoomChip extends StatelessWidget {
  const _RoomChip({
    required this.room,
    required this.selected,
    required this.onTap,
  });

  final SelectableRoom room;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: DesignTokens.spacingSm,
          vertical: DesignTokens.spacingXs,
        ),
        decoration: BoxDecoration(
          color: selected ? DesignTokens.primaryBlue : DesignTokens.white,
          borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
          border: Border.all(
            color: selected
                ? DesignTokens.primaryBlue
                : DesignTokens.borderGray,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 28,
              height: 28,
              child: RoomThumbnail(
                height: 28,
                borderRadius: 8,
                detailed: false,
                imageUrl: room.room.thumbnailUrl,
              ),
            ),
            const SizedBox(width: DesignTokens.spacingSm),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  room.room.name,
                  style: DesignTokens.caption.copyWith(
                    fontWeight: FontWeight.bold,
                    color: selected
                        ? DesignTokens.white
                        : DesignTokens.textDark,
                  ),
                ),
                Text(
                  room.apartmentName,
                  style: DesignTokens.caption.copyWith(
                    fontSize: 10,
                    color: selected
                        ? DesignTokens.white.withValues(alpha: 0.7)
                        : DesignTokens.textGray,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _MaterialRow extends StatelessWidget {
  const _MaterialRow({
    required this.item,
    required this.product,
    required this.selected,
    required this.onToggle,
  });

  final StageMaterialItem item;
  final Product? product;
  final bool selected;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: selected ? 1 : 0.45,
      child: Container(
        padding: const EdgeInsets.all(DesignTokens.spacingSm),
        decoration: BoxDecoration(
          color: DesignTokens.white,
          borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
          border: Border.all(color: DesignTokens.borderGray),
        ),
        child: Row(
          children: [
            Semantics(
              button: true,
              checked: selected,
              child: InkWell(
                onTap: onToggle,
                borderRadius: BorderRadius.circular(DesignTokens.radiusSm),
                child: Container(
                  width: 22,
                  height: 22,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: selected
                        ? DesignTokens.primaryBlue
                        : DesignTokens.white,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: selected
                          ? DesignTokens.primaryBlue
                          : DesignTokens.borderGray,
                      width: 2,
                    ),
                  ),
                  child: selected
                      ? const Icon(
                          Icons.check,
                          size: 14,
                          color: DesignTokens.white,
                        )
                      : null,
                ),
              ),
            ),
            const SizedBox(width: DesignTokens.spacingSm),
            ClipRRect(
              borderRadius: BorderRadius.circular(DesignTokens.radiusSm),
              child: SizedBox(
                width: 36,
                height: 36,
                child: product?.imageUrl != null
                    ? Image.network(
                        product!.imageUrl!,
                        fit: BoxFit.cover,
                        errorBuilder: (_, _, _) => const _MaterialImageFallback(),
                      )
                    : const _MaterialImageFallback(),
              ),
            ),
            const SizedBox(width: DesignTokens.spacingSm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: DesignTokens.body2.copyWith(
                      color: DesignTokens.textDark,
                    ),
                  ),
                  Text(
                    '${formatQuantity(item.quantity)} ${item.unit}',
                    style: DesignTokens.caption.copyWith(
                      color: DesignTokens.textGray,
                    ),
                  ),
                ],
              ),
            ),
            if (product != null)
              Text(
                formatSom(product!.pricePerUnit),
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

class _MaterialImageFallback extends StatelessWidget {
  const _MaterialImageFallback();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: DesignTokens.borderGrayAlt,
      child: const Icon(
        Icons.inventory_2_outlined,
        size: 18,
        color: DesignTokens.textMuted,
      ),
    );
  }
}
