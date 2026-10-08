/// The catalog image to show for a material, or null when there is none worth
/// showing. The seed catalog points every material at `picsum.photos`, which
/// serves random stock photos (a cloud for "Laminat", a railway for tiles);
/// until real product pictures exist those are hidden and the screens fall
/// back to their neutral image placeholder.
String? catalogImageUrl(String? raw) {
  final url = raw?.trim();
  if (url == null || url.isEmpty) return null;
  final host = Uri.tryParse(url)?.host.toLowerCase();
  if (host == null || host.isEmpty) return null;
  if (host == 'picsum.photos' || host.endsWith('.picsum.photos')) return null;
  return url;
}
