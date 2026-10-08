import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../config/design_tokens.dart';
import '../../l10n/app_localizations.dart';
import '../../models/business_profile.dart';
import '../../providers/business_provider.dart';
import '../../utils/error_mapper.dart';

/// "Portfolio": the usta's own photos of finished work. Add from camera or
/// gallery (with an optional caption), long-press a photo to delete it.
class UstaPortfolioScreen extends ConsumerStatefulWidget {
  const UstaPortfolioScreen({super.key});

  @override
  ConsumerState<UstaPortfolioScreen> createState() => _UstaPortfolioScreenState();
}

class _UstaPortfolioScreenState extends ConsumerState<UstaPortfolioScreen> {
  bool _busy = false;

  void _snack(String text) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }

  Future<void> _add() async {
    final l10n = AppLocalizations.of(context)!;
    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      builder: (ctx) => SafeArea(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          ListTile(
            leading: const Icon(Icons.photo_camera_outlined),
            title: Text(l10n.addProductCamera),
            onTap: () => Navigator.pop(ctx, ImageSource.camera),
          ),
          ListTile(
            leading: const Icon(Icons.photo_library_outlined),
            title: Text(l10n.addProductGallery),
            onTap: () => Navigator.pop(ctx, ImageSource.gallery),
          ),
        ]),
      ),
    );
    if (source == null) return;
    final picked = await ImagePicker().pickImage(source: source, maxWidth: 1600, imageQuality: 88);
    if (picked == null || !mounted) return;

    final caption = TextEditingController();
    final go = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.ustaPortfolioAdd),
        content: TextField(
          controller: caption,
          maxLength: 200,
          decoration: InputDecoration(labelText: l10n.ustaPortfolioCaption),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: Text(l10n.shopProductCancel)),
          FilledButton(onPressed: () => Navigator.pop(ctx, true), child: Text(l10n.ustaPortfolioUpload)),
        ],
      ),
    );
    final text = caption.text;
    caption.dispose();
    if (go != true || !mounted) return;

    setState(() => _busy = true);
    try {
      final bytes = await picked.readAsBytes();
      await ref.read(businessRepositoryProvider).addPortfolioItem(
            bytes,
            picked.name.isEmpty ? 'photo.jpg' : picked.name,
            _contentType(picked),
            caption: text,
          );
      ref.invalidate(myPortfolioProvider);
    } catch (e) {
      _snack(mapErrorWithServerDetail(e));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  String _contentType(XFile f) {
    final mime = f.mimeType;
    if (mime == 'image/png' || mime == 'image/webp' || mime == 'image/jpeg') return mime!;
    final n = f.name.toLowerCase();
    if (n.endsWith('.png')) return 'image/png';
    if (n.endsWith('.webp')) return 'image/webp';
    return 'image/jpeg';
  }

  Future<void> _delete(PortfolioItem item) async {
    final l10n = AppLocalizations.of(context)!;
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        content: Text(l10n.ustaPortfolioDeleteConfirm),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: Text(l10n.shopProductCancel)),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: TextButton.styleFrom(foregroundColor: DesignTokens.errorRed),
            child: Text(l10n.shopProductDelete),
          ),
        ],
      ),
    );
    if (ok != true || !mounted) return;
    try {
      await ref.read(businessRepositoryProvider).deletePortfolioItem(item.id);
      ref.invalidate(myPortfolioProvider);
    } catch (e) {
      _snack(mapErrorWithServerDetail(e));
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: DesignTokens.backgroundLight,
      appBar: AppBar(
        backgroundColor: DesignTokens.backgroundLight,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.canPop() ? context.pop() : context.go('/business'),
        ),
        title: Text(l10n.ustaPortfolioTitle, style: DesignTokens.heading3),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _busy ? null : _add,
        icon: _busy
            ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2))
            : const Icon(Icons.add_a_photo_outlined),
        label: Text(l10n.ustaPortfolioAdd),
      ),
      body: RefreshIndicator(
        onRefresh: () async => ref.invalidate(myPortfolioProvider),
        child: ref.watch(myPortfolioProvider).when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (_, _) => ListView(children: [
                Padding(
                  padding: const EdgeInsets.all(DesignTokens.spacingLg),
                  child: Text(l10n.ustaPortfolioLoadFailed, textAlign: TextAlign.center),
                ),
              ]),
              data: (items) => items.isEmpty
                  ? ListView(children: [
                      Padding(
                        padding: const EdgeInsets.all(DesignTokens.spacingLg),
                        child: Text(l10n.ustaPortfolioEmpty,
                            textAlign: TextAlign.center,
                            style: DesignTokens.body2.copyWith(color: DesignTokens.textGray)),
                      ),
                    ])
                  : GridView.builder(
                      padding: const EdgeInsets.fromLTRB(
                          DesignTokens.screenPaddingHorizontal,
                          DesignTokens.spacingSm,
                          DesignTokens.screenPaddingHorizontal,
                          96),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: DesignTokens.spacingSm,
                        crossAxisSpacing: DesignTokens.spacingSm,
                      ),
                      itemCount: items.length,
                      itemBuilder: (_, i) => _PortfolioTile(item: items[i], onDelete: () => _delete(items[i])),
                    ),
            ),
      ),
    );
  }
}

class _PortfolioTile extends StatelessWidget {
  const _PortfolioTile({required this.item, required this.onDelete});

  final PortfolioItem item;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return GestureDetector(
      onLongPress: onDelete,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
        child: Stack(fit: StackFit.expand, children: [
          Image.network(
            item.imageUrl,
            fit: BoxFit.cover,
            errorBuilder: (_, _, _) => const ColoredBox(
              color: DesignTokens.white,
              child: Icon(Icons.image_not_supported_outlined, color: DesignTokens.textMuted),
            ),
          ),
          if ((item.caption ?? '').isNotEmpty)
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: ColoredBox(
                color: Colors.black54,
                child: Padding(
                  padding: const EdgeInsets.all(6),
                  child: Text(item.caption!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: DesignTokens.caption.copyWith(color: Colors.white)),
                ),
              ),
            ),
          Positioned(
            top: 2,
            right: 2,
            child: IconButton(
              tooltip: l10n.shopProductDelete,
              visualDensity: VisualDensity.compact,
              style: IconButton.styleFrom(backgroundColor: Colors.black45),
              icon: const Icon(Icons.delete_outline, color: Colors.white, size: 20),
              onPressed: onDelete,
            ),
          ),
        ]),
      ),
    );
  }
}
