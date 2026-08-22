import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../config/design_tokens.dart';
import '../../models/api/api.dart';
import '../../providers/wallpaper_provider.dart';
import '../../widgets/common/error_view.dart';

/// Bottom sheet for the shared wallpaper library: browse every uploaded
/// wallpaper as a thumbnail grid and contribute a new one from the gallery.
/// Selecting a wallpaper returns it to the caller (via [Navigator.pop]) so the
/// decoration screen can apply it to a wall.
class WallpaperLibrarySheet extends ConsumerStatefulWidget {
  const WallpaperLibrarySheet({super.key});

  /// Opens the sheet and resolves to the chosen [Wallpaper], or null if
  /// dismissed without a selection.
  static Future<Wallpaper?> show(BuildContext context) {
    return showModalBottomSheet<Wallpaper>(
      context: context,
      isScrollControlled: true,
      backgroundColor: DesignTokens.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => const WallpaperLibrarySheet(),
    );
  }

  @override
  ConsumerState<WallpaperLibrarySheet> createState() =>
      _WallpaperLibrarySheetState();
}

class _WallpaperLibrarySheetState extends ConsumerState<WallpaperLibrarySheet> {
  bool _uploading = false;

  Future<void> _pickAndUpload() async {
    final messenger = ScaffoldMessenger.of(context);
    try {
      final picked = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxWidth: 2048,
        imageQuality: 90,
      );
      if (picked == null) return;
      setState(() => _uploading = true);

      final bytes = await picked.readAsBytes();
      final contentType = _contentTypeFor(picked.name, picked.mimeType);
      await ref.read(wallpaperRepositoryProvider).upload(
            bytes: bytes,
            filename: picked.name,
            contentType: contentType,
          );
      // Refresh the shared library so the new wallpaper appears.
      ref.invalidate(wallpapersProvider);
      messenger.showSnackBar(
        const SnackBar(content: Text('✓ Oboy kutubxonaga qo\'shildi')),
      );
    } catch (e) {
      messenger.showSnackBar(
        SnackBar(content: Text('Yuklab bo\'lmadi: $e')),
      );
    } finally {
      if (mounted) setState(() => _uploading = false);
    }
  }

  String _contentTypeFor(String name, String? mimeType) {
    if (mimeType != null && mimeType.startsWith('image/')) return mimeType;
    final lower = name.toLowerCase();
    if (lower.endsWith('.png')) return 'image/png';
    if (lower.endsWith('.webp')) return 'image/webp';
    if (lower.endsWith('.gif')) return 'image/gif';
    if (lower.endsWith('.heic')) return 'image/heic';
    return 'image/jpeg';
  }

  @override
  Widget build(BuildContext context) {
    final wallpapers = ref.watch(wallpapersProvider);
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.7,
      maxChildSize: 0.92,
      builder: (context, scrollController) {
        return Padding(
          padding: const EdgeInsets.all(DesignTokens.spacingMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  const Text('Oboy kutubxonasi', style: DesignTokens.subtitle1),
                  const Spacer(),
                  FilledButton.icon(
                    onPressed: _uploading ? null : _pickAndUpload,
                    icon: _uploading
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.upload_outlined, size: 18),
                    label: Text(_uploading ? 'Yuklanmoqda…' : 'Rasm yuklash'),
                  ),
                ],
              ),
              const SizedBox(height: DesignTokens.spacingMd),
              Expanded(
                child: wallpapers.when(
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (e, _) => Center(
                    child: Padding(
                      padding: const EdgeInsets.all(DesignTokens.spacingLg),
                      child: InlineErrorView(
                        error: e,
                        onRetry: () => ref.invalidate(wallpapersProvider),
                      ),
                    ),
                  ),
                  data: (items) => items.isEmpty
                      ? const Center(
                          child: Text(
                            'Hali oboy yo\'q — birinchi bo\'lib rasm yuklang',
                          ),
                        )
                      : GridView.builder(
                          controller: scrollController,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: DesignTokens.spacingSm,
                            mainAxisSpacing: DesignTokens.spacingSm,
                          ),
                          itemCount: items.length,
                          itemBuilder: (context, i) =>
                              _WallpaperTile(wallpaper: items[i]),
                        ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _WallpaperTile extends StatelessWidget {
  const _WallpaperTile({required this.wallpaper});

  final Wallpaper wallpaper;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).pop(wallpaper),
      borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
        child: Image.network(
          wallpaper.url,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, progress) => progress == null
              ? child
              : Container(
                  color: DesignTokens.borderGray,
                  child: const Center(
                    child: SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  ),
                ),
          errorBuilder: (context, err, stack) => Container(
            color: DesignTokens.borderGray,
            child: const Icon(Icons.broken_image_outlined),
          ),
        ),
      ),
    );
  }
}
