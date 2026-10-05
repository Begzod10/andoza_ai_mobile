import 'package:flutter_test/flutter_test.dart';
import 'package:tamir_uy_mobile_flutter/models/business_profile.dart';

void main() {
  group('ModerationStatus.parse', () {
    test('reads the three server states', () {
      expect(ModerationStatus.parse('pending'), ModerationStatus.pending);
      expect(ModerationStatus.parse('approved'), ModerationStatus.approved);
      expect(ModerationStatus.parse('rejected'), ModerationStatus.rejected);
    });

    test('treats anything it does not know as pending — not live, not rejected', () {
      expect(ModerationStatus.parse('archived'), ModerationStatus.pending);
      expect(ModerationStatus.parse(null), ModerationStatus.pending);
    });
  });

  group('AccountRoles', () {
    test('a plain user has no business', () {
      expect(AccountRoles.plainUser.roles, ['user']);
      expect(AccountRoles.plainUser.hasBusiness, isFalse);
    });

    test('parses roles and the state of each business', () {
      final r = AccountRoles.fromJson({
        'roles': ['user', 'shop_owner', 'usta'],
        'store_status': 'pending',
        'store_name': 'Mebel Plus',
        'usta_status': 'rejected',
        'usta_name': 'Aziz usta',
      });
      expect(r.isShopOwner, isTrue);
      expect(r.isUsta, isTrue);
      expect(r.storeStatus, ModerationStatus.pending);
      expect(r.ustaStatus, ModerationStatus.rejected);
      expect(r.storeName, 'Mebel Plus');
    });

    test('a missing business stays null rather than defaulting to a status', () {
      final r = AccountRoles.fromJson({'roles': ['user']});
      expect(r.storeStatus, isNull);
      expect(r.ustaStatus, isNull);
    });
  });

  group('UstaProfile', () {
    test('parses the server shape, including the trade and prices', () {
      final u = UstaProfile.fromJson({
        'id': 'u1',
        'name': 'Aziz usta',
        'category': 'elektrik_loyihachi',
        'district': 'Chilonzor',
        'phone': '+998901234567',
        'price_min': 150000,
        'price_max': 300000,
        'rating': 4.5,
        'jobs_count': 12,
        'verified': true,
        'status': 'approved',
        'moderation_note': null,
      });
      expect(u.trade, UstaTrade.elektrikLoyihachi);
      expect(u.priceMin, 150000);
      expect(u.rating, 4.5);
      expect(u.verified, isTrue);
      expect(u.status, ModerationStatus.approved);
    });

    test('an unknown trade is null, not a crash', () {
      expect(UstaTrade.parse('dasturchi'), isNull);
    });

    test('every trade round-trips through its wire value', () {
      for (final t in UstaTrade.values) {
        expect(UstaTrade.parse(t.wire), t);
      }
    });
  });
}
