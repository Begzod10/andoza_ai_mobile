import 'package:flutter_test/flutter_test.dart';
import 'package:tamir_uy_mobile_flutter/models/api/api.dart';

/// Fixture is a REAL response captured from the running backend on 2026-08-05
/// (POST /wallpapers multipart upload), verifying the Phase 5 wallpaper model.
void main() {
  group('Wallpaper', () {
    test('parses a real upload response', () {
      final w = Wallpaper.fromJson({
        'id': '20a9c08a-b9dd-412e-80f3-475b114f38f2',
        'name': 'test_wp.png',
        'url':
            'http://localhost:8000/media/wallpapers/ba5da3bc-6d94-4058-b4a3-a98559767789.png',
        'content_type': 'image/png',
        'size_bytes': 166,
        'created_at': '2026-08-05T19:42:51.713043Z',
      });

      expect(w.name, 'test_wp.png');
      expect(w.contentType, 'image/png');
      expect(w.sizeBytes, 166);
      // The URL is absolute so it loads straight into Image.network / a texture.
      expect(w.url, startsWith('http://'));
    });

    test('parses a list of wallpapers', () {
      final list = [
        {
          'id': '20a9c08a-b9dd-412e-80f3-475b114f38f2',
          'name': 'test_wp.png',
          'url': 'http://localhost:8000/media/wallpapers/x.png',
          'content_type': 'image/png',
          'size_bytes': 166,
          'created_at': '2026-08-05T19:42:51.713043Z',
        },
      ].map(Wallpaper.fromJson).toList();

      expect(list, hasLength(1));
      expect(list.single.contentType, 'image/png');
    });
  });
}
