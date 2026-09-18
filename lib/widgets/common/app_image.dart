import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../config/design_tokens.dart';

/// Shared network-image widget backed by [CachedNetworkImage].
///
/// Replaces raw `Image.network` (memory-only cache, re-downloads on every
/// cold scroll) with an on-disk cache, behind one widget so call sites stay
/// clean. Renders a neutral placeholder while loading and a neutral
/// broken-image container on failure; both can be overridden per site (e.g.
/// avatar sites pass their initials fallback).
class AppImage extends StatelessWidget {
  const AppImage({
    super.key,
    required this.url,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.placeholder,
    this.errorWidget,
  });

  final String url;
  final double? width;
  final double? height;
  final BoxFit fit;

  /// When provided, the image (and its placeholder/error states) is clipped
  /// with a [ClipRRect] of this radius. For circular clipping, wrap [AppImage]
  /// in a [ClipOval] at the call site and leave this null.
  final BorderRadius? borderRadius;

  /// Optional override for the loading state. Defaults to a subtle neutral
  /// container with a small centered spinner (matching the old loadingBuilder).
  final Widget? placeholder;

  /// Optional override for the error state. Defaults to a neutral container
  /// with a broken-image icon (matching the old errorBuilder).
  final Widget? errorWidget;

  @override
  Widget build(BuildContext context) {
    final Widget image = CachedNetworkImage(
      imageUrl: url,
      width: width,
      height: height,
      fit: fit,
      placeholder: (context, _) => placeholder ?? _defaultPlaceholder(),
      // errorWidget renders synchronously when the download fails, so it never
      // hangs a widget test that mounts these screens with no live network.
      errorWidget: (context, _, _) => errorWidget ?? _defaultError(),
    );

    if (borderRadius != null) {
      return ClipRRect(borderRadius: borderRadius!, child: image);
    }
    return image;
  }

  Widget _defaultPlaceholder() => Container(
    width: width,
    height: height,
    color: DesignTokens.borderGrayAlt,
    child: const Center(
      child: SizedBox(
        width: 18,
        height: 18,
        child: CircularProgressIndicator(strokeWidth: 2),
      ),
    ),
  );

  Widget _defaultError() => Container(
    width: width,
    height: height,
    color: DesignTokens.borderGrayAlt,
    child: const Center(
      child: Icon(Icons.image_outlined, color: DesignTokens.textMuted),
    ),
  );
}
