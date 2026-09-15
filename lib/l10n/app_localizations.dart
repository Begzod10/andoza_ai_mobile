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

  /// Generic affirmative ('Yes'). Used for boolean spec values.
  ///
  /// In uz, this message translates to:
  /// **'Ha'**
  String get commonYes;

  /// Generic negative ('No'). Used for boolean spec values.
  ///
  /// In uz, this message translates to:
  /// **'Yo\'q'**
  String get commonNo;

  /// S1 shop home: tooltip on the cart icon button in the app bar.
  ///
  /// In uz, this message translates to:
  /// **'Savatcha'**
  String get shopCartTooltip;

  /// Shop: placeholder text in the material search field (S1 and E10).
  ///
  /// In uz, this message translates to:
  /// **'Material qidirish...'**
  String get shopSearchHint;

  /// Shop: filter/category chip for 'All' (S1 categories, S4 and E10 filters).
  ///
  /// In uz, this message translates to:
  /// **'Barchasi'**
  String get shopFilterAll;

  /// S1 shop home: small uppercase eyebrow label on the project banner ('YOUR PROJECT').
  ///
  /// In uz, this message translates to:
  /// **'SIZNING LOYIHANGIZ'**
  String get shopProjectBannerLabel;

  /// S1 shop home: project banner title line ('For your living-room project').
  ///
  /// In uz, this message translates to:
  /// **'Mehmonxona loyihangiz uchun'**
  String get shopProjectBannerTitle;

  /// S1 shop home: project banner line stating how many material types are needed.
  ///
  /// In uz, this message translates to:
  /// **'{count} turdagi material kerak'**
  String shopProjectBannerCount(int count);

  /// S1 shop home: project banner line while the required materials are still being computed.
  ///
  /// In uz, this message translates to:
  /// **'Loyiha materiallari hisoblanmoqda'**
  String get shopProjectBannerCalculating;

  /// S1 shop home: 'See all →' link on the project banner opening the materials list.
  ///
  /// In uz, this message translates to:
  /// **'Hammasini ko\'rish →'**
  String get shopSeeAllArrow;

  /// Shop: small tag on product cards/rows marking an item the active project needs (S1 and E10).
  ///
  /// In uz, this message translates to:
  /// **'Loyihada'**
  String get shopInProjectTag;

  /// S2 project materials: app bar title ('Project materials').
  ///
  /// In uz, this message translates to:
  /// **'Loyiha materiallari'**
  String get shopMaterialsTitle;

  /// S2 project materials: green banner stating the app auto-computed area and stage count from the project.
  ///
  /// In uz, this message translates to:
  /// **'App loyihangiz asosida avtomatik hisobladi — {area} m², {count} bosqich'**
  String shopMaterialsAutoCalc(String area, int count);

  /// S2 project materials: sticky button that adds every required material to the cart.
  ///
  /// In uz, this message translates to:
  /// **'Hammasini savatga'**
  String get shopAddAllToCart;

  /// S3 product detail: badge shown when the product is sold by an official dealer.
  ///
  /// In uz, this message translates to:
  /// **'✓ Rasmiy diler'**
  String get shopOfficialDealer;

  /// S3 product detail: recommendation line stating the computed quantity the project needs; a coverage note may be appended.
  ///
  /// In uz, this message translates to:
  /// **'Loyihangiz uchun ~{quantity} {unit} kerak'**
  String shopProjectNeed(String quantity, String unit);

  /// S3 product detail: label preceding the quantity stepper ('Quantity:').
  ///
  /// In uz, this message translates to:
  /// **'Miqdor:'**
  String get shopQuantityLabel;

  /// S3 product detail: spec row label for coverage.
  ///
  /// In uz, this message translates to:
  /// **'Qoplama'**
  String get shopSpecCoverage;

  /// S3 product detail: spec row label for drying time.
  ///
  /// In uz, this message translates to:
  /// **'Quriish vaqti'**
  String get shopSpecDryingTime;

  /// S3 product detail: spec row label for whether the product is washable.
  ///
  /// In uz, this message translates to:
  /// **'Yuvilishi'**
  String get shopSpecWashable;

  /// S3 product detail: row opening the dealer comparison, naming the default dealer.
  ///
  /// In uz, this message translates to:
  /// **'Qayerdan olish — {name}'**
  String shopWhereToBuy(String name);

  /// Shop: snackbar confirming an item was added to the cart (S3, S4, E10).
  ///
  /// In uz, this message translates to:
  /// **'Savatga qo\'shildi'**
  String get shopAddedToCart;

  /// S3 product detail: add-to-cart button label with the computed line price.
  ///
  /// In uz, this message translates to:
  /// **'Savatga qo\'shish · {price}'**
  String shopAddToCartPrice(String price);

  /// S4 dealer comparison: app bar title ('Compare dealers').
  ///
  /// In uz, this message translates to:
  /// **'Diler taqqoslash'**
  String get shopDealerCompareTitle;

  /// Shop: filter chip for cheapest offers (S4 and E10).
  ///
  /// In uz, this message translates to:
  /// **'Eng arzon'**
  String get shopFilterCheapest;

  /// S4 dealer comparison: filter chip for official dealers only.
  ///
  /// In uz, this message translates to:
  /// **'Rasmiy diler'**
  String get shopFilterOfficial;

  /// S4 dealer comparison: filter chip for fastest delivery.
  ///
  /// In uz, this message translates to:
  /// **'Eng tez'**
  String get shopFilterFastest;

  /// S4 dealer comparison: green ribbon marking the best (cheapest) dealer offer ('BEST').
  ///
  /// In uz, this message translates to:
  /// **'ENG YAXSHI'**
  String get shopBestRibbon;

  /// S4 dealer comparison: dealer subtitle showing district and delivery time in days.
  ///
  /// In uz, this message translates to:
  /// **'{district} · {days} kunda yetkazish'**
  String shopDeliveryDays(String district, int days);

  /// S4 dealer comparison: button that selects a dealer offer and adds it to the cart.
  ///
  /// In uz, this message translates to:
  /// **'Tanlash'**
  String get shopSelect;

  /// S5 cart: app bar title ('Cart').
  ///
  /// In uz, this message translates to:
  /// **'Savat'**
  String get shopCartTitle;

  /// S5 cart: empty-state message when the cart has no items.
  ///
  /// In uz, this message translates to:
  /// **'Savat bo\'sh'**
  String get shopCartEmpty;

  /// Shop: summary row label for the materials subtotal (S5 and S6).
  ///
  /// In uz, this message translates to:
  /// **'Materiallar'**
  String get shopMaterials;

  /// Shop: summary/row label for the delivery fee (S5 dealer block, S5 and S6 summaries).
  ///
  /// In uz, this message translates to:
  /// **'Yetkazish'**
  String get shopDelivery;

  /// S5 cart: grand-total label in the footer ('Total').
  ///
  /// In uz, this message translates to:
  /// **'Umumiy summa'**
  String get shopGrandTotal;

  /// S5 cart: primary button proceeding to checkout ('Place order').
  ///
  /// In uz, this message translates to:
  /// **'Buyurtmani rasmiylashtirish'**
  String get shopCheckout;

  /// S6 checkout: app bar title ('Payment').
  ///
  /// In uz, this message translates to:
  /// **'To\'lov'**
  String get shopCheckoutTitle;

  /// S6 checkout: section title above the delivery-address fields.
  ///
  /// In uz, this message translates to:
  /// **'Yetkazish manzili'**
  String get shopDeliveryAddress;

  /// S6 checkout: hint text in the address field.
  ///
  /// In uz, this message translates to:
  /// **'Manzil'**
  String get shopAddressHint;

  /// S6 checkout: hint text in the phone-number field.
  ///
  /// In uz, this message translates to:
  /// **'Telefon raqami'**
  String get shopPhoneHint;

  /// S6 checkout: section title above the payment-method tiles.
  ///
  /// In uz, this message translates to:
  /// **'To\'lov usuli'**
  String get shopPaymentMethod;

  /// S6 checkout: section title above the order summary.
  ///
  /// In uz, this message translates to:
  /// **'Buyurtma xulosasi'**
  String get shopOrderSummary;

  /// S6 checkout: label for the total amount due in the sticky footer.
  ///
  /// In uz, this message translates to:
  /// **'To\'lanadi'**
  String get shopAmountDue;

  /// S6 checkout: primary button that places the order ('Pay').
  ///
  /// In uz, this message translates to:
  /// **'To\'lash'**
  String get shopPay;

  /// S6 checkout: snackbar shown when persisting the placed order to the server fails.
  ///
  /// In uz, this message translates to:
  /// **'Buyurtmani serverga saqlashda xatolik: {error}'**
  String shopOrderSaveError(String error);

  /// S7 order confirmation: app bar title ('Order status').
  ///
  /// In uz, this message translates to:
  /// **'Buyurtma holati'**
  String get shopOrderStatusTitle;

  /// S7 order confirmation: section title above the ordered items list.
  ///
  /// In uz, this message translates to:
  /// **'Buyurtma tarkibi'**
  String get shopOrderContents;

  /// S7 order confirmation: total label ('Total').
  ///
  /// In uz, this message translates to:
  /// **'Jami'**
  String get shopTotal;

  /// S7 order confirmation: snackbar confirming the craftsman was notified.
  ///
  /// In uz, this message translates to:
  /// **'Usta xabardor qilindi'**
  String get shopMasterNotified;

  /// S7 order confirmation: secondary button that notifies the craftsman the materials arrived.
  ///
  /// In uz, this message translates to:
  /// **'Ustaga topshirish'**
  String get shopHandToMaster;

  /// S7 order confirmation: text button returning to the shop home ('Back to shop').
  ///
  /// In uz, this message translates to:
  /// **'Do\'konga qaytish'**
  String get shopBackToShop;

  /// E10 search results: app bar title ('Search results').
  ///
  /// In uz, this message translates to:
  /// **'Qidiruv natijalari'**
  String get shopSearchResultsTitle;

  /// E10 search results: filter chip limiting results to items matching the active project.
  ///
  /// In uz, this message translates to:
  /// **'Loyihamga mos'**
  String get shopFilterForProject;

  /// E10 search results: filter chip sorting by rating.
  ///
  /// In uz, this message translates to:
  /// **'Reyting'**
  String get shopFilterRating;

  /// E10 search results: count of matching results.
  ///
  /// In uz, this message translates to:
  /// **'{count} ta natija'**
  String shopResultCount(int count);

  /// Verified badge label shown on a master profile (U4) and the user profile (E4).
  ///
  /// In uz, this message translates to:
  /// **'✓ Tasdiqlangan'**
  String get commonVerifiedBadge;

  /// U1 masters map: search field hint ('What kind of master do you need?').
  ///
  /// In uz, this message translates to:
  /// **'Qanday usta kerak?'**
  String get mastersSearchHint;

  /// U1/U2 master pin sheet: rating followed by review count.
  ///
  /// In uz, this message translates to:
  /// **'{rating} ({count} sharh)'**
  String mastersRatingReviews(String rating, int count);

  /// Masters: approximate area name plus distance in km.
  ///
  /// In uz, this message translates to:
  /// **'{area} · ~{distance} km'**
  String mastersAreaDistance(String area, String distance);

  /// U1/U2 master pin sheet: button to open the full master profile.
  ///
  /// In uz, this message translates to:
  /// **'Profilni ko\'rish'**
  String get mastersViewProfile;

  /// U4 master profile: stat card label for rating.
  ///
  /// In uz, this message translates to:
  /// **'reyting'**
  String get mastersStatRating;

  /// U4 master profile: stat card label for reviews.
  ///
  /// In uz, this message translates to:
  /// **'sharh'**
  String get mastersStatReviews;

  /// U4 master profile: stat card label for completed jobs.
  ///
  /// In uz, this message translates to:
  /// **'ishlar'**
  String get mastersStatJobs;

  /// U4 master profile: portfolio section title.
  ///
  /// In uz, this message translates to:
  /// **'Portfolio'**
  String get mastersPortfolio;

  /// U4 master profile: services section title.
  ///
  /// In uz, this message translates to:
  /// **'Xizmatlar'**
  String get mastersServices;

  /// U4 master profile: service row naming the master's trade works.
  ///
  /// In uz, this message translates to:
  /// **'{trade} ishlari'**
  String mastersServiceTrade(String trade);

  /// U4 master profile: consultation service row.
  ///
  /// In uz, this message translates to:
  /// **'Konsultatsiya'**
  String get mastersServiceConsultation;

  /// U4 master profile: location section title.
  ///
  /// In uz, this message translates to:
  /// **'Joylashuv'**
  String get mastersLocation;

  /// U4 master profile: primary button to send the estimate to the master.
  ///
  /// In uz, this message translates to:
  /// **'Smetani yuborish'**
  String get mastersSendEstimate;

  /// U4 master profile: secondary button to write a message.
  ///
  /// In uz, this message translates to:
  /// **'Xabar yozish'**
  String get mastersSendMessage;

  /// U5 send-smeta sheet: personalized confirmation title.
  ///
  /// In uz, this message translates to:
  /// **'Loyihangizni {name} akaga yuborasizmi?'**
  String mastersSendConfirmTitle(String name);

  /// U5 send-smeta sheet: project summary card title.
  ///
  /// In uz, this message translates to:
  /// **'Mehmonxona ta\'miri'**
  String get mastersProjectSummaryTitle;

  /// U5 send-smeta sheet: project summary area and price.
  ///
  /// In uz, this message translates to:
  /// **'{area} m² · {price}'**
  String mastersProjectSummaryValue(String area, String price);

  /// U5 send-smeta sheet: optional comment field hint.
  ///
  /// In uz, this message translates to:
  /// **'Izoh (ixtiyoriy)'**
  String get mastersCommentHint;

  /// U5 send-smeta sheet: note explaining the master will review and propose a price.
  ///
  /// In uz, this message translates to:
  /// **'Usta smetani ko\'rib, o\'z narxini taklif qiladi'**
  String get mastersEstimateNote;

  /// U5 send-smeta sheet: snackbar shown after the estimate is sent.
  ///
  /// In uz, this message translates to:
  /// **'Smeta yuborildi'**
  String get mastersEstimateSent;

  /// U5 send-smeta sheet: primary send button.
  ///
  /// In uz, this message translates to:
  /// **'Yuborish'**
  String get mastersSend;

  /// E4 profile: fallback display name when the user has no name ('User').
  ///
  /// In uz, this message translates to:
  /// **'Foydalanuvchi'**
  String get profileDefaultName;

  /// E4 profile: snackbar for not-yet-available features ('Coming soon').
  ///
  /// In uz, this message translates to:
  /// **'Tez kunda'**
  String get profileComingSoon;

  /// E4 profile: stat card label for project count.
  ///
  /// In uz, this message translates to:
  /// **'loyiha'**
  String get profileStatProjects;

  /// E4 profile: stat card label for order count.
  ///
  /// In uz, this message translates to:
  /// **'buyurtma'**
  String get profileStatOrders;

  /// E4 profile: stat card label for total money saved.
  ///
  /// In uz, this message translates to:
  /// **'tejaldi'**
  String get profileStatSaved;

  /// E4 profile: saved amount in millions of som.
  ///
  /// In uz, this message translates to:
  /// **'{amount} mln'**
  String profileSavedMln(String amount);

  /// E4 profile menu / E5 title: 'My projects'.
  ///
  /// In uz, this message translates to:
  /// **'Loyihalarim'**
  String get profileMenuProjects;

  /// E4 profile menu / E6 title: 'My orders'.
  ///
  /// In uz, this message translates to:
  /// **'Buyurtmalarim'**
  String get profileMenuOrders;

  /// E4 profile menu / E11 title: 'Saved designs'.
  ///
  /// In uz, this message translates to:
  /// **'Saqlangan dizaynlar'**
  String get profileMenuSavedDesigns;

  /// E4 profile menu: 'My addresses'.
  ///
  /// In uz, this message translates to:
  /// **'Manzillarim'**
  String get profileMenuAddresses;

  /// E4 profile menu: 'Payment methods'.
  ///
  /// In uz, this message translates to:
  /// **'To\'lov usullari'**
  String get profileMenuPaymentMethods;

  /// E4 profile menu: 'Language'.
  ///
  /// In uz, this message translates to:
  /// **'Til'**
  String get profileMenuLanguage;

  /// E4 profile menu: 'Settings'.
  ///
  /// In uz, this message translates to:
  /// **'Sozlamalar'**
  String get profileMenuSettings;

  /// E4 profile menu: 'Help'.
  ///
  /// In uz, this message translates to:
  /// **'Yordam'**
  String get profileMenuHelp;

  /// E4 profile menu: 'Log out'.
  ///
  /// In uz, this message translates to:
  /// **'Chiqish'**
  String get profileMenuLogout;

  /// E4 profile: snackbar showing the current language ('Uzbek').
  ///
  /// In uz, this message translates to:
  /// **'O\'zbekcha'**
  String get profileLanguageUzbek;

  /// E5 projects: FAB label to start a new project ('New project').
  ///
  /// In uz, this message translates to:
  /// **'Yangi loyiha'**
  String get profileNewProject;

  /// E5 projects: filter chip / status badge for ongoing projects.
  ///
  /// In uz, this message translates to:
  /// **'Davom etayotgan'**
  String get profileFilterOngoing;

  /// E5 projects: filter chip / status badge for finished projects.
  ///
  /// In uz, this message translates to:
  /// **'Tugagan'**
  String get profileFilterFinished;

  /// E5 projects: empty state title ('No projects yet').
  ///
  /// In uz, this message translates to:
  /// **'Hali loyiha yo\'q'**
  String get profileProjectsEmptyTitle;

  /// E5 projects: empty state message ('Start your first project').
  ///
  /// In uz, this message translates to:
  /// **'Birinchi loyihangizni boshlang'**
  String get profileProjectsEmptyMessage;

  /// E5 projects: empty state action button ('+ New project').
  ///
  /// In uz, this message translates to:
  /// **'+ Yangi loyiha'**
  String get profileProjectsEmptyAction;

  /// E5 projects: project card metadata line (rooms, location, date).
  ///
  /// In uz, this message translates to:
  /// **'{count} xona · {location} · {date}'**
  String profileProjectMeta(int count, String location, String date);

  /// E6 orders: empty state title ('No orders').
  ///
  /// In uz, this message translates to:
  /// **'Buyurtma yo\'q'**
  String get profileOrdersEmptyTitle;

  /// E6 orders: empty state message ('Your shop purchases appear here').
  ///
  /// In uz, this message translates to:
  /// **'Do\'kondan xarid qilganingizda shu yerda ko\'rinadi'**
  String get profileOrdersEmptyMessage;

  /// E11 saved designs: empty state title ('No saved designs').
  ///
  /// In uz, this message translates to:
  /// **'Saqlangan dizayn yo\'q'**
  String get profileSavedDesignsEmptyTitle;

  /// E11 saved designs: empty state message ('Save designs you like here').
  ///
  /// In uz, this message translates to:
  /// **'Yoqqan dizaynlaringizni shu yerda saqlab qo\'ying'**
  String get profileSavedDesignsEmptyMessage;

  /// E7 onboarding: skip button ('Skip').
  ///
  /// In uz, this message translates to:
  /// **'O\'tkazib yuborish'**
  String get onboardingSkip;

  /// E7 onboarding: final-slide start button ('Get started').
  ///
  /// In uz, this message translates to:
  /// **'Boshlash'**
  String get onboardingStart;

  /// E7 onboarding slide 1 title ('Measure your room').
  ///
  /// In uz, this message translates to:
  /// **'Xonangizni o\'lchang'**
  String get onboardingMeasureTitle;

  /// E7 onboarding slide 1 body.
  ///
  /// In uz, this message translates to:
  /// **'Telefon kamerasi yoki LiDAR yordamida xonangiz o\'lchamlarini aniq oling.'**
  String get onboardingMeasureBody;

  /// E7 onboarding slide 2 title ('We start from the current state').
  ///
  /// In uz, this message translates to:
  /// **'Hozirgi holatdan boshlaymiz'**
  String get onboardingDeltaTitle;

  /// E7 onboarding slide 2 body.
  ///
  /// In uz, this message translates to:
  /// **'Xonangizda allaqachon bor narsalar uchun to\'lamaysiz — faqat kerakli qismini hisoblaymiz.'**
  String get onboardingDeltaBody;

  /// E7 onboarding slide 2: 'Current' state swatch label.
  ///
  /// In uz, this message translates to:
  /// **'Hozirgi'**
  String get onboardingDeltaCurrent;

  /// E7 onboarding slide 2: pill emphasizing only the difference is charged.
  ///
  /// In uz, this message translates to:
  /// **'faqat FARQ hisoblanadi'**
  String get onboardingDeltaPill;

  /// E7 onboarding slide 3 title ('Decorate in 3D').
  ///
  /// In uz, this message translates to:
  /// **'3D\'da bezang'**
  String get onboardingDecorateTitle;

  /// E7 onboarding slide 3 body.
  ///
  /// In uz, this message translates to:
  /// **'Materiallarni to\'g\'ridan-to\'g\'ri xonaning 3D ko\'rinishiga sudrab, natijani darhol ko\'ring.'**
  String get onboardingDecorateBody;

  /// E7 onboarding slide 4 title ('See the price, get the materials').
  ///
  /// In uz, this message translates to:
  /// **'Narxni ko\'ring, materialni oling'**
  String get onboardingPriceTitle;

  /// E7 onboarding slide 4 body.
  ///
  /// In uz, this message translates to:
  /// **'Aniq smeta oling va kerakli materiallarni to\'g\'ridan-to\'g\'ri ilovadan xarid qiling.'**
  String get onboardingPriceBody;

  /// E7 onboarding slide 4: example savings figure.
  ///
  /// In uz, this message translates to:
  /// **'Tejaldingiz 4.2 mln'**
  String get onboardingPriceSaved;

  /// E8 tutorial: app bar title ('Demo guide').
  ///
  /// In uz, this message translates to:
  /// **'Demo qo\'llanma'**
  String get onboardingDemoTitle;

  /// E8 tutorial: step 1.
  ///
  /// In uz, this message translates to:
  /// **'Xona qo\'shish — LiDAR, 360° yoki qo\'lda o\'lchash'**
  String get onboardingDemoStep1;

  /// E8 tutorial: step 2.
  ///
  /// In uz, this message translates to:
  /// **'Xonaning hozirgi holatini tanlash'**
  String get onboardingDemoStep2;

  /// E8 tutorial: step 3.
  ///
  /// In uz, this message translates to:
  /// **'Rail bilan devor, pol va mebelni bezash'**
  String get onboardingDemoStep3;

  /// E8 tutorial: step 4.
  ///
  /// In uz, this message translates to:
  /// **'Elektr va santexnikani oxirida rejalashtirish'**
  String get onboardingDemoStep4;

  /// E8 tutorial: step 5.
  ///
  /// In uz, this message translates to:
  /// **'Smetani ko\'rish va materiallarni sotib olish'**
  String get onboardingDemoStep5;

  /// E8 tutorial: video placeholder caption ('Watch the video').
  ///
  /// In uz, this message translates to:
  /// **'Videoni ko\'rish'**
  String get onboardingDemoWatchVideo;

  /// E8 tutorial: button to try the app directly ('I'll try it myself').
  ///
  /// In uz, this message translates to:
  /// **'O\'zim sinab ko\'raman'**
  String get onboardingDemoTryMyself;
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
