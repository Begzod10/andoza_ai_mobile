import 'package:flutter_test/flutter_test.dart';
import 'package:tamir_uy_mobile_flutter/models/api/api.dart';
import 'package:tamir_uy_mobile_flutter/providers/apartment_provider.dart';

RoomOut _room({Map<String, dynamic>? design, Map<String, dynamic>? surfaces}) =>
    RoomOut(
      id: 'r',
      apartmentId: 'a',
      name: 'Xona',
      state: design == null ? null : {'designState': design},
      surfaces: surfaces,
      updatedAt: DateTime(2026),
    );

void main() {
  test('a floor type with no floor product is flagged', () {
    expect(
      floorChosenButUnpriced(
        _room(design: {'floorConfigured': true, 'floorType': 'parket'}),
      ),
      isTrue,
    );
  });

  test('a floor product, no floor type, or an untouched floor is not', () {
    expect(
      floorChosenButUnpriced(_room(
        design: {'floorConfigured': true, 'floorType': 'parket'},
        surfaces: {'floor': 'mat-1'},
      )),
      isFalse,
    );
    expect(
      floorChosenButUnpriced(_room(design: {'floorConfigured': true})),
      isFalse,
    );
    expect(
      floorChosenButUnpriced(_room(design: {'floorType': 'parket'})),
      isFalse,
    );
    expect(floorChosenButUnpriced(_room()), isFalse);
  });
}
