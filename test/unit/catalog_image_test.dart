import 'package:flutter_test/flutter_test.dart';
import 'package:tamir_uy_mobile_flutter/utils/catalog_image.dart';

void main() {
  test('random stock photos from the seed catalog are hidden', () {
    expect(catalogImageUrl('https://picsum.photos/seed/laminat/600/400'), isNull);
    expect(catalogImageUrl('https://i.picsum.photos/id/12/600/400.jpg'), isNull);
  });

  test('a real product picture is kept, an empty one is none', () {
    expect(catalogImageUrl('https://cdn.example.uz/laminat.jpg'), 'https://cdn.example.uz/laminat.jpg');
    expect(catalogImageUrl(null), isNull);
    expect(catalogImageUrl('  '), isNull);
    expect(catalogImageUrl('not a url'), isNull);
  });
}
