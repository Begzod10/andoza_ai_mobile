import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tamir_uy_mobile_flutter/l10n/app_localizations.dart';
import 'package:tamir_uy_mobile_flutter/models/shop_model.dart';
import 'package:tamir_uy_mobile_flutter/providers/estimate_provider.dart';
import 'package:tamir_uy_mobile_flutter/providers/masters_provider.dart';

void main() {
  final uz = lookupAppLocalizations(const Locale('uz'));
  final ru = lookupAppLocalizations(const Locale('ru'));
  final en = lookupAppLocalizations(const Locale('en'));

  test('shop category labels follow the locale', () {
    expect(ShopCategory.boyoq.label(uz), "Bo'yoq");
    expect(ShopCategory.boyoq.label(ru), 'Краска');
    expect(ShopCategory.santexnika.label(en), 'Plumbing');
  });

  test('trade labels follow the locale', () {
    expect(Trade.elektrik.label(uz), 'Elektrik');
    expect(Trade.elektrik.label(ru), 'Электрик');
    expect(Trade.santexnik.label(en), 'Plumber');
  });

  test('quality tier labels follow the locale', () {
    expect(QualityTier.ekonom.label(ru), 'Эконом');
    expect(QualityTier.premium.label(en), 'Premium');
  });

  test('every enum value has a non-empty label in every locale', () {
    for (final l10n in [uz, ru, en]) {
      for (final c in ShopCategory.values) {
        expect(c.label(l10n), isNotEmpty);
      }
      for (final t in Trade.values) {
        expect(t.label(l10n), isNotEmpty);
      }
      for (final q in QualityTier.values) {
        expect(q.label(l10n), isNotEmpty);
      }
    }
  });
}
