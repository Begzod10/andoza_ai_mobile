import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_uz.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('uz')];

  /// Product name. Shown as the login screen heading and used as the app's brand label.
  ///
  /// In uz, this message translates to:
  /// **'Andoza AI'**
  String get appTitle;

  /// Retry. Button on error views that re-attempts the failed action.
  ///
  /// In uz, this message translates to:
  /// **'Qayta urinish'**
  String get actionRetry;

  /// Back. Navigates to the previous screen/step.
  ///
  /// In uz, this message translates to:
  /// **'Orqaga'**
  String get actionBack;

  /// Next. Advances to the next screen/step.
  ///
  /// In uz, this message translates to:
  /// **'Keyingi'**
  String get actionNext;

  /// Continue. Proceeds with the current flow.
  ///
  /// In uz, this message translates to:
  /// **'Davom etish'**
  String get actionContinue;

  /// Cancel. Dismisses a dialog/sheet without applying changes.
  ///
  /// In uz, this message translates to:
  /// **'Bekor qilish'**
  String get actionCancel;

  /// Save. Persists the current changes/selection.
  ///
  /// In uz, this message translates to:
  /// **'Saqlash'**
  String get actionSave;

  /// Close. Dismisses a sheet, dialog or overlay.
  ///
  /// In uz, this message translates to:
  /// **'Yopish'**
  String get actionClose;

  /// Done. Confirms completion of a step/action.
  ///
  /// In uz, this message translates to:
  /// **'Tayyor'**
  String get actionDone;

  /// Finish. Completes a multi-step flow.
  ///
  /// In uz, this message translates to:
  /// **'Yakunlash'**
  String get actionFinish;

  /// Bottom navigation tab: Home.
  ///
  /// In uz, this message translates to:
  /// **'Uy'**
  String get navHome;

  /// Bottom navigation tab: Shop (materials marketplace).
  ///
  /// In uz, this message translates to:
  /// **'Do\'kon'**
  String get navShop;

  /// Bottom navigation tab: Masters (craftsman marketplace).
  ///
  /// In uz, this message translates to:
  /// **'Ustalar'**
  String get navMasters;

  /// Bottom navigation tab: Profile.
  ///
  /// In uz, this message translates to:
  /// **'Profil'**
  String get navProfile;

  /// Login screen: hint text for the email/username field.
  ///
  /// In uz, this message translates to:
  /// **'Email'**
  String get loginEmailHint;

  /// Login screen: hint text for the password field.
  ///
  /// In uz, this message translates to:
  /// **'Password'**
  String get loginPasswordHint;

  /// Login screen: tooltip on the eye icon that reveals the password.
  ///
  /// In uz, this message translates to:
  /// **'Show password'**
  String get loginShowPassword;

  /// Login screen: tooltip on the eye icon that masks the password.
  ///
  /// In uz, this message translates to:
  /// **'Hide password'**
  String get loginHidePassword;

  /// Login screen: submit button label.
  ///
  /// In uz, this message translates to:
  /// **'Login'**
  String get loginButton;

  /// Login screen: snackbar shown when the user submits with an empty email or password.
  ///
  /// In uz, this message translates to:
  /// **'Please fill in all fields'**
  String get loginEmptyFields;

  /// B1 room-condition step: the single question asking the room's current baseline surface condition.
  ///
  /// In uz, this message translates to:
  /// **'Xonangiz hozir qaysi holatda?'**
  String get b1Question;

  /// B1 room-condition step: link opening the floor/ceiling help sheet for users unsure of the difference.
  ///
  /// In uz, this message translates to:
  /// **'Farqini bilmayapsizmi? →'**
  String get b1DontKnowDifference;

  /// B1 room-condition step: link to override floor/ceiling condition when they differ from the walls.
  ///
  /// In uz, this message translates to:
  /// **'Pol yoki shift boshqacha bo\'lsa →'**
  String get b1FloorCeilingDifferent;

  /// B1 room-condition step: primary button that saves the condition and enters the room designer.
  ///
  /// In uz, this message translates to:
  /// **'Xonaga kirish'**
  String get b1EnterRoom;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['uz'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'uz':
      return AppLocalizationsUz();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
