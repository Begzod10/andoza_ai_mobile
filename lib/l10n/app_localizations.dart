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

  /// Brand wordmark (no space). Shown on the splash screen and the Home status pill.
  ///
  /// In uz, this message translates to:
  /// **'AndozaAI'**
  String get brandName;

  /// Accessibility label for the center orange FAB in the bottom nav that opens the new-project sheet.
  ///
  /// In uz, this message translates to:
  /// **'Yangi loyiha qo\'shish'**
  String get navAddProject;

  /// Login (phone-OTP step): heading and the phone-number field label.
  ///
  /// In uz, this message translates to:
  /// **'Telefon raqam'**
  String get loginPhoneLabel;

  /// Login (phone-OTP step): subtitle under the heading explaining a phone number is required to log in.
  ///
  /// In uz, this message translates to:
  /// **'Loginiga uchun telefon raqam talab qilinadi'**
  String get loginPhoneSubtitle;

  /// Login (phone-OTP step): placeholder text inside the phone-number input.
  ///
  /// In uz, this message translates to:
  /// **'90 123 45 67'**
  String get loginPhoneHint;

  /// Login (phone-OTP step): helper note that the SMS code goes to the entered number.
  ///
  /// In uz, this message translates to:
  /// **'Sms kod shu raqamga yuboriladi'**
  String get loginPhoneSmsHint;

  /// Login (phone-OTP step): primary button that requests the OTP code.
  ///
  /// In uz, this message translates to:
  /// **'OTP Yuborish'**
  String get loginSendOtp;

  /// Login (phone-OTP step): informational tip box about the 6-digit code and retrying if SMS is delayed.
  ///
  /// In uz, this message translates to:
  /// **'📱 Siz kiritgan raqamga 6 xonali kod yuboriladi. Agar SMS kelmaydigan bo\'lsa, 2-3 minutdan keyin qayta urinib ko\'ring.'**
  String get loginOtpInfoBox;

  /// Login (phone-OTP step): outlined button switching to the username/password login form.
  ///
  /// In uz, this message translates to:
  /// **'🔐 Username bilan kirish'**
  String get loginWithUsername;

  /// Login (OTP code step): heading confirming the code was sent.
  ///
  /// In uz, this message translates to:
  /// **'✓ Kod yuborildi'**
  String get loginCodeSentTitle;

  /// Login (OTP code step): sentence fragment following the phone number ('... we will send a 6-digit code to <number>').
  ///
  /// In uz, this message translates to:
  /// **' raqamiga 6 xonali kod yuboramiz'**
  String get loginCodeSentSuffix;

  /// Login (OTP code step): primary button that verifies the entered code.
  ///
  /// In uz, this message translates to:
  /// **'Tasdiqlash'**
  String get loginVerify;

  /// Login (OTP code step): button to resend the code once the cooldown elapses.
  ///
  /// In uz, this message translates to:
  /// **'Qayta yuborish'**
  String get loginResend;

  /// Login (OTP code step): resend button label during the cooldown, showing remaining seconds.
  ///
  /// In uz, this message translates to:
  /// **'Qayta yuborish ({seconds} s)'**
  String loginResendCountdown(int seconds);

  /// Login (OTP code step): text button with a left arrow returning to the phone-entry step.
  ///
  /// In uz, this message translates to:
  /// **'← Orqaga'**
  String get loginBackArrow;

  /// Login (username step): heading and submit button label ('Sign in').
  ///
  /// In uz, this message translates to:
  /// **'Kirish'**
  String get loginSignIn;

  /// Login/register: placeholder text for the username field.
  ///
  /// In uz, this message translates to:
  /// **'Username'**
  String get loginUsernameHint;

  /// Login/register: placeholder text for the password field.
  ///
  /// In uz, this message translates to:
  /// **'Parol'**
  String get loginPasswordLabel;

  /// Login (username step): prompt preceding the register link ('No account? ').
  ///
  /// In uz, this message translates to:
  /// **'Akkauntingiz yo\'qmi? '**
  String get loginNoAccount;

  /// Register: link, heading and submit button label ('Sign up').
  ///
  /// In uz, this message translates to:
  /// **'Ro\'yxatdan o\'tish'**
  String get loginRegister;

  /// Register: placeholder for the optional name field.
  ///
  /// In uz, this message translates to:
  /// **'Ism (ixtiyoriy)'**
  String get loginNameHint;

  /// Register: placeholder for the confirm-password field.
  ///
  /// In uz, this message translates to:
  /// **'Parolni tasdiqlang'**
  String get loginConfirmPasswordHint;

  /// Register: prompt preceding the sign-in link ('Already have an account? ').
  ///
  /// In uz, this message translates to:
  /// **'Allaqachon akkauntingiz bormi? '**
  String get loginHaveAccount;

  /// Login: 'or' divider between the OTP and username entry points.
  ///
  /// In uz, this message translates to:
  /// **'yoki'**
  String get loginOr;

  /// Login: large greeting above the auth card ('Hello').
  ///
  /// In uz, this message translates to:
  /// **'👋 Salom'**
  String get loginGreeting;

  /// Login: welcome subtitle under the greeting.
  ///
  /// In uz, this message translates to:
  /// **'Andoza AI-ga xush kelibsiz'**
  String get loginWelcomeSubtitle;

  /// Login: app-version footnote below the auth card.
  ///
  /// In uz, this message translates to:
  /// **'AndozaAI v1.0.0'**
  String get loginVersion;

  /// Login error: the entered phone number is invalid, with an example format.
  ///
  /// In uz, this message translates to:
  /// **'Telefon raqam noto\'g\'ri. Masalan: 90 123 45 67'**
  String get loginErrorInvalidPhone;

  /// Login error: a generic server failure, asking the user to retry.
  ///
  /// In uz, this message translates to:
  /// **'Serverda xatolik. Qayta urinib ko\'ring.'**
  String get loginErrorServer;

  /// Login error: the entered OTP code is wrong or expired.
  ///
  /// In uz, this message translates to:
  /// **'Kod noto\'g\'ri yoki eskirgan.'**
  String get loginErrorInvalidCode;

  /// Login error: username and password are both required.
  ///
  /// In uz, this message translates to:
  /// **'Username va parol majburiy.'**
  String get loginErrorCredentialsRequired;

  /// Login error: the username or password is incorrect.
  ///
  /// In uz, this message translates to:
  /// **'Username yoki parol noto\'g\'ri.'**
  String get loginErrorWrongCredentials;

  /// Register error: username must be at least 3 characters.
  ///
  /// In uz, this message translates to:
  /// **'Username kamida 3 ta belgidan iborat bo\'lishi kerak.'**
  String get loginErrorUsernameShort;

  /// Register error: password must be at least 6 characters.
  ///
  /// In uz, this message translates to:
  /// **'Parol kamida 6 ta belgidan iborat bo\'lishi kerak.'**
  String get loginErrorPasswordShort;

  /// Register error: the two passwords do not match.
  ///
  /// In uz, this message translates to:
  /// **'Parollar mos kelmadi.'**
  String get loginErrorPasswordMismatch;

  /// Register error: the chosen username is already taken.
  ///
  /// In uz, this message translates to:
  /// **'Bu username allaqachon band.'**
  String get loginErrorUsernameTaken;

  /// Register error: a generic registration failure.
  ///
  /// In uz, this message translates to:
  /// **'Ro\'yxatdan o\'tishda xato yuz berdi.'**
  String get loginErrorRegisterFailed;

  /// Home header: small 'Welcome' label above the user's name.
  ///
  /// In uz, this message translates to:
  /// **'Xush kelibsiz'**
  String get homeWelcome;

  /// Home header: personalized greeting when the user's name is known.
  ///
  /// In uz, this message translates to:
  /// **'Salom, {name}! 👋'**
  String homeGreetingNamed(String name);

  /// Home header: greeting fallback when the user's name is unknown.
  ///
  /// In uz, this message translates to:
  /// **'Salom! 👋'**
  String get homeGreeting;

  /// Home: onboarding story-circle label opening the 'how it works' guide.
  ///
  /// In uz, this message translates to:
  /// **'Qanday ishlaydi?'**
  String get homeStoryHowItWorks;

  /// Home: onboarding story-circle label opening the demo guide.
  ///
  /// In uz, this message translates to:
  /// **'Demo qo\'llanma'**
  String get homeStoryDemoGuide;

  /// Home: onboarding story-circle label opening the demo.
  ///
  /// In uz, this message translates to:
  /// **'Demo'**
  String get homeStoryDemo;

  /// Home empty state: title prompting the user to add their first room.
  ///
  /// In uz, this message translates to:
  /// **'Birinchi xonangizni qo\'shing'**
  String get homeEmptyTitle;

  /// Home empty state: message noting there are no projects yet.
  ///
  /// In uz, this message translates to:
  /// **'Hali loyiha yo\'q — yangi loyiha boshlang'**
  String get homeEmptyMessage;

  /// Home empty state: button that starts a new project.
  ///
  /// In uz, this message translates to:
  /// **'+ Loyiha qo\'shish'**
  String get homeEmptyAction;

  /// Home: section title above the quick-action grid.
  ///
  /// In uz, this message translates to:
  /// **'Tezkor amallar'**
  String get homeQuickActions;

  /// Home quick action: scan a room.
  ///
  /// In uz, this message translates to:
  /// **'Xonani skanlash'**
  String get homeQuickScan;

  /// Home quick action: cost estimate.
  ///
  /// In uz, this message translates to:
  /// **'Smeta'**
  String get homeQuickEstimate;

  /// Home quick action: dealers/shops.
  ///
  /// In uz, this message translates to:
  /// **'Dilerlar'**
  String get homeQuickDealers;

  /// Home (with projects): error-view title when the project list fails to load.
  ///
  /// In uz, this message translates to:
  /// **'Loyihalarni yuklab bo\'lmadi'**
  String get homeProjectsLoadError;

  /// Home (with projects): 'Your projects' section title.
  ///
  /// In uz, this message translates to:
  /// **'Loyihalaringiz'**
  String get homeYourProjects;

  /// Home (with projects): 'See all' link opening the full project list.
  ///
  /// In uz, this message translates to:
  /// **'Barchasi'**
  String get homeSeeAll;

  /// Home (with projects): progress legend for stages that already existed and are not counted.
  ///
  /// In uz, this message translates to:
  /// **'Mavjud (hisoblanmaydi)'**
  String get homeLegendExisting;

  /// Home (with projects): progress legend for stages still needed (the delta).
  ///
  /// In uz, this message translates to:
  /// **'Kerak (delta)'**
  String get homeLegendNeeded;

  /// Home (with projects): resume CTA that continues the active project in the 3D Studio.
  ///
  /// In uz, this message translates to:
  /// **'Davom etish'**
  String get homeResume;

  /// Home (with projects): snackbar shown when resuming a project that has no room yet.
  ///
  /// In uz, this message translates to:
  /// **'Bu loyihada hali xona yo\'q'**
  String get homeNoRoomYet;

  /// Home (with projects): renovation stage progress label ('Stage N/8').
  ///
  /// In uz, this message translates to:
  /// **'Bosqich {current}/8'**
  String homeStageProgress(int current);

  /// Home (with projects): stage label noting which named stages already existed.
  ///
  /// In uz, this message translates to:
  /// **'Bosqich {current}/8 · ✓ {names} mavjud edi'**
  String homeStageProgressExcluded(int current, String names);

  /// Home (with projects): compact stage label noting how many stages already existed.
  ///
  /// In uz, this message translates to:
  /// **'Bosqich {current}/8 · ✓ {count} bosqich mavjud edi'**
  String homeStageProgressExcludedCount(int current, int count);

  /// Home (with projects): title of the stage-picker bottom sheet ('Choose a stage').
  ///
  /// In uz, this message translates to:
  /// **'Bosqichni tanlang'**
  String get homeStagePickerTitle;

  /// Home (with projects): a single stage option row in the stage picker.
  ///
  /// In uz, this message translates to:
  /// **'Bosqich {index}/8 · {label}'**
  String homeStageOption(int index, String label);

  /// Home (with projects): snackbar shown when saving the selected stage fails.
  ///
  /// In uz, this message translates to:
  /// **'Bosqichni saqlab bo\'lmadi'**
  String get homeStageSaveError;

  /// Renovation stage name: plastering (suvoq).
  ///
  /// In uz, this message translates to:
  /// **'suvoq'**
  String get stageSuvoq;

  /// Renovation stage name: putty/finishing (shpaklovka).
  ///
  /// In uz, this message translates to:
  /// **'shpaklovka'**
  String get stageShpaklovka;

  /// Renovation stage name: paint/wallpaper (bo'yoq/oboi).
  ///
  /// In uz, this message translates to:
  /// **'bo\'yoq/oboi'**
  String get stageBoyoqOboi;

  /// Renovation stage name: flooring (pol).
  ///
  /// In uz, this message translates to:
  /// **'pol'**
  String get stagePol;

  /// Renovation stage name: furniture (mebel).
  ///
  /// In uz, this message translates to:
  /// **'mebel'**
  String get stageMebel;

  /// Renovation stage name: electrical (elektr).
  ///
  /// In uz, this message translates to:
  /// **'elektr'**
  String get stageElektr;

  /// Renovation stage name: lighting (yorug'lik).
  ///
  /// In uz, this message translates to:
  /// **'yorug\'lik'**
  String get stageYoruglik;

  /// Renovation stage name: plumbing (santexnika).
  ///
  /// In uz, this message translates to:
  /// **'santexnika'**
  String get stageSantexnika;
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
