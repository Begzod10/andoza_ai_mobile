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

  /// Secondary button returning to the 3D view (C9 decoration-complete and D10 final-confirmation).
  ///
  /// In uz, this message translates to:
  /// **'3D\'ga qaytish'**
  String get commonBackTo3d;

  /// B1-alt surface sheet: heading above the floor condition options.
  ///
  /// In uz, this message translates to:
  /// **'Pol'**
  String get designSurfaceFloorHeading;

  /// B1-alt surface sheet: heading above the ceiling condition options.
  ///
  /// In uz, this message translates to:
  /// **'Shift'**
  String get designSurfaceCeilingHeading;

  /// B1-alt surface sheet: floor option for raw concrete.
  ///
  /// In uz, this message translates to:
  /// **'Xom beton'**
  String get designFloorRaw;

  /// B1-alt surface sheet: floor option for screed (styajka).
  ///
  /// In uz, this message translates to:
  /// **'Styajka'**
  String get designFloorPlastered;

  /// B1-alt surface sheet: floor option meaning a covering already exists.
  ///
  /// In uz, this message translates to:
  /// **'Qoplama bor'**
  String get designFloorPuttied;

  /// B1-alt surface sheet: ceiling option for raw/bare.
  ///
  /// In uz, this message translates to:
  /// **'Xom'**
  String get designCeilingRaw;

  /// B1-alt surface sheet: ceiling option for plastered (suvoq).
  ///
  /// In uz, this message translates to:
  /// **'Suvoq'**
  String get designCeilingPlastered;

  /// B1-alt surface sheet: ceiling option for finished/ready.
  ///
  /// In uz, this message translates to:
  /// **'Tayyor'**
  String get designCeilingPuttied;

  /// B2 room entry: intro card stating the room's current baseline condition and that decoration proceeds step by step.
  ///
  /// In uz, this message translates to:
  /// **'Xonangiz shu holatda — {condition}. Endi bosqichma-bosqich bezaymiz.'**
  String designRoomEntryIntro(String condition);

  /// B3 decoration rail: success toast after applying a paint/putty swatch to the wall.
  ///
  /// In uz, this message translates to:
  /// **'✓ Shpaklovka qo\'shildi'**
  String get designToastShpaklovkaAdded;

  /// B3 decoration rail: stage-progress label for the paint/wallpaper stage.
  ///
  /// In uz, this message translates to:
  /// **'Bo\'yoq/Oboi bosqichi'**
  String get designStageBoyoqOboi;

  /// B3 decoration rail: rail tab label for paint swatches.
  ///
  /// In uz, this message translates to:
  /// **'Bo\'yoq'**
  String get designRailTabBoyoq;

  /// B3 decoration rail: one-time onboarding hint to drag a material onto the wall with your finger.
  ///
  /// In uz, this message translates to:
  /// **'Materialni barmog\'ingiz bilan devorga sudrang'**
  String get designDragHint;

  /// Decoration flow: primary button advancing to the next renovation stage (B3, C4, C5).
  ///
  /// In uz, this message translates to:
  /// **'Keyingi bosqich →'**
  String get designNextStage;

  /// C4 floor selection: success toast after applying a floor material.
  ///
  /// In uz, this message translates to:
  /// **'✓ Polga qo\'llanildi'**
  String get interiorToastFloorApplied;

  /// C4 floor selection: stage-progress label for the flooring stage.
  ///
  /// In uz, this message translates to:
  /// **'Pol bosqichi'**
  String get interiorStagePol;

  /// C4 floor selection: rail tab label for tile (kafel) floors.
  ///
  /// In uz, this message translates to:
  /// **'Kafel'**
  String get interiorRailTabKafel;

  /// C4 floor selection: rail tab label for laminate floors.
  ///
  /// In uz, this message translates to:
  /// **'Laminat'**
  String get interiorRailTabLaminat;

  /// C4 floor selection: rail tab label for parquet floors.
  ///
  /// In uz, this message translates to:
  /// **'Parket'**
  String get interiorRailTabParket;

  /// C4 floor selection: rail tab label for concrete (beton) floors.
  ///
  /// In uz, this message translates to:
  /// **'Beton'**
  String get interiorRailTabBeton;

  /// C5 furniture placement: stage label for the furniture stage.
  ///
  /// In uz, this message translates to:
  /// **'Mebel bosqichi'**
  String get interiorStageMebel;

  /// C5 furniture placement: room rail tab for the living room.
  ///
  /// In uz, this message translates to:
  /// **'Mehmonxona'**
  String get interiorRailTabMehmonxona;

  /// C5 furniture placement: room rail tab for the kitchen.
  ///
  /// In uz, this message translates to:
  /// **'Oshxona'**
  String get interiorRailTabOshxona;

  /// C5 furniture placement: room rail tab for the bedroom.
  ///
  /// In uz, this message translates to:
  /// **'Yotoqxona'**
  String get interiorRailTabYotoqxona;

  /// C5 furniture placement: room rail tab for the bathroom.
  ///
  /// In uz, this message translates to:
  /// **'Vanna'**
  String get interiorRailTabVanna;

  /// C7 walkthrough: hint pill explaining you can walk on the floor by dragging with a finger.
  ///
  /// In uz, this message translates to:
  /// **'Polda yurish mumkin — barmoq bilan suring'**
  String get interiorWalkthroughHint;

  /// C7 walkthrough: button switching to the top-down plan view.
  ///
  /// In uz, this message translates to:
  /// **'Rejaga o\'tish →'**
  String get interiorGoToPlan;

  /// C9 decoration complete: success title ('Decoration finished').
  ///
  /// In uz, this message translates to:
  /// **'Bezash yakunlandi'**
  String get interiorDecorationComplete;

  /// C9 decoration complete: primary button moving on to the electrical stage.
  ///
  /// In uz, this message translates to:
  /// **'Elektrga o\'tish →'**
  String get interiorGoToElectrical;

  /// Wallpaper library sheet: snackbar confirming an uploaded wallpaper was added to the library.
  ///
  /// In uz, this message translates to:
  /// **'✓ Oboy kutubxonaga qo\'shildi'**
  String get interiorWallpaperAdded;

  /// Wallpaper library sheet: snackbar shown when the wallpaper upload fails.
  ///
  /// In uz, this message translates to:
  /// **'Yuklab bo\'lmadi: {error}'**
  String interiorUploadFailed(String error);

  /// Wallpaper library sheet: title ('Wallpaper library').
  ///
  /// In uz, this message translates to:
  /// **'Oboy kutubxonasi'**
  String get interiorWallpaperLibrary;

  /// Wallpaper library sheet: upload button label while an image is uploading.
  ///
  /// In uz, this message translates to:
  /// **'Yuklanmoqda…'**
  String get interiorUploading;

  /// Wallpaper library sheet: upload button label ('Upload image').
  ///
  /// In uz, this message translates to:
  /// **'Rasm yuklash'**
  String get interiorUploadImage;

  /// Wallpaper library sheet: empty-state message inviting the user to upload the first wallpaper.
  ///
  /// In uz, this message translates to:
  /// **'Hali oboy yo\'q — birinchi bo\'lib rasm yuklang'**
  String get interiorNoWallpapers;

  /// D8 electrical summary: app bar title ('Wire routing').
  ///
  /// In uz, this message translates to:
  /// **'Sim yo\'nalishi'**
  String get electricalWireRouting;

  /// D8 electrical summary: view-toggle chip for the 2D plan.
  ///
  /// In uz, this message translates to:
  /// **'2D reja'**
  String get electricalView2d;

  /// D8 electrical summary: view-toggle chip for the 3D view.
  ///
  /// In uz, this message translates to:
  /// **'3D'**
  String get electricalView3d;

  /// D8 electrical summary: view-toggle chip showing both 2D and 3D ('Both').
  ///
  /// In uz, this message translates to:
  /// **'Ikkalasi'**
  String get electricalViewBoth;

  /// D8 electrical summary: button to recompute the wire routing.
  ///
  /// In uz, this message translates to:
  /// **'Trassani qayta hisoblash'**
  String get electricalRecomputeRoute;

  /// D8 electrical summary: primary button advancing to the electrical result (D9).
  ///
  /// In uz, this message translates to:
  /// **'Keyingi →'**
  String get electricalNext;

  /// D9 electrical result: app bar title ('Electrical result').
  ///
  /// In uz, this message translates to:
  /// **'Elektr natijasi'**
  String get electricalResult;

  /// D9 electrical result: primary button finishing the electrical flow (to D10).
  ///
  /// In uz, this message translates to:
  /// **'Yakunlash →'**
  String get electricalFinish;

  /// D10 final confirmation: success title ('Your project is ready').
  ///
  /// In uz, this message translates to:
  /// **'Loyihangiz tayyor'**
  String get electricalProjectReady;

  /// D10 final confirmation: primary button opening the cost estimate (E1).
  ///
  /// In uz, this message translates to:
  /// **'Smetani ko\'rish →'**
  String get electricalViewEstimate;

  /// E1 estimation: app bar title prefix, followed by the room name and dimensions ('Renovation estimate').
  ///
  /// In uz, this message translates to:
  /// **'Remont smetasi'**
  String get estimateTitlePrefix;

  /// E1 estimation: fallback room name shown in the title when the room has none ('Living room').
  ///
  /// In uz, this message translates to:
  /// **'Mehmonxona'**
  String get estimateDefaultRoomName;

  /// E1 estimation: snackbar shown when downloading the smeta PDF fails.
  ///
  /// In uz, this message translates to:
  /// **'PDF yuklab bo\'lmadi: {error}'**
  String estimatePdfFailed(String error);

  /// E1 estimation: fallback label in the savings banner for already-done work ('Some work').
  ///
  /// In uz, this message translates to:
  /// **'Ba\'zi ishlar'**
  String get estimateSomeWork;

  /// E1 estimation: generic fallback stage label in the savings banner ('Stage').
  ///
  /// In uz, this message translates to:
  /// **'Bosqich'**
  String get estimateStageFallback;

  /// Estimate adjust: E1 tooltip and E3 app bar title ('Adjust estimate').
  ///
  /// In uz, this message translates to:
  /// **'Smeta sozlash'**
  String get estimateAdjust;

  /// E1 estimation: label above the big total price card ('Approximate total price').
  ///
  /// In uz, this message translates to:
  /// **'Taxminiy umumiy narx'**
  String get estimateApproxTotal;

  /// Estimate: labour cost column/summary label ('Labour') (E1, E2, E3).
  ///
  /// In uz, this message translates to:
  /// **'Ishchi kuchi'**
  String get estimateLabor;

  /// E1 estimation: green savings banner stating a stage already existed and how much was saved.
  ///
  /// In uz, this message translates to:
  /// **'{label} allaqachon bor edi — {amount} tejaldingiz'**
  String estimateSavingsBanner(String label, String amount);

  /// E1 estimation: note on an excluded stage row ('you already have it — not counted').
  ///
  /// In uz, this message translates to:
  /// **'sizda mavjud — hisoblanmadi'**
  String get estimateExcludedNote;

  /// E1 estimation: struck-through price shown for excluded stages ('0 som').
  ///
  /// In uz, this message translates to:
  /// **'0 so\'m'**
  String get estimateZeroSom;

  /// E1 estimation: PDF button label while the PDF is being prepared.
  ///
  /// In uz, this message translates to:
  /// **'Tayyorlanmoqda…'**
  String get estimatePreparingPdf;

  /// E1 estimation: primary button to buy materials from shops.
  ///
  /// In uz, this message translates to:
  /// **'Do\'konlardan xarid qilish'**
  String get estimateBuyFromShops;

  /// E1 estimation: secondary button to send the estimate to a craftsman.
  ///
  /// In uz, this message translates to:
  /// **'Ustaga yuborish'**
  String get estimateSendToMaster;

  /// E2 material costs: materials subtotal row label ('Materials total').
  ///
  /// In uz, this message translates to:
  /// **'Materiallar jami'**
  String get estimateMaterialsTotal;

  /// E2 material costs: sticky stage total label ('Stage total').
  ///
  /// In uz, this message translates to:
  /// **'Bosqich jami'**
  String get estimateStageTotal;

  /// E2 material costs: button adding this stage's materials to the cart.
  ///
  /// In uz, this message translates to:
  /// **'Materiallarni savatga'**
  String get estimateAddMaterialsToCart;

  /// E3 labor costs: section title above the quality-tier options ('Quality level').
  ///
  /// In uz, this message translates to:
  /// **'Sifat darajasi'**
  String get estimateQualityLevel;

  /// E3 labor costs: DIY switch title ('Don't include labour').
  ///
  /// In uz, this message translates to:
  /// **'Ishchi kuchini qo\'shmaslik'**
  String get estimateExcludeLabor;

  /// E3 labor costs: DIY switch subtitle ('I'll do it myself — only materials are counted').
  ///
  /// In uz, this message translates to:
  /// **'O\'zim bajaraman — faqat materiallar hisoblanadi'**
  String get estimateDiySubtitle;

  /// E3 labor costs: summary row for the delta savings from an excluded stage.
  ///
  /// In uz, this message translates to:
  /// **'Delta tejash ({stage})'**
  String estimateDeltaSavings(String stage);

  /// E3 labor costs: sticky new total label ('New total').
  ///
  /// In uz, this message translates to:
  /// **'Yangi jami'**
  String get estimateNewTotal;

  /// E3 labor costs: primary button saving the estimate and returning to E1.
  ///
  /// In uz, this message translates to:
  /// **'Smetani saqlash'**
  String get estimateSaveEstimate;

  /// AI designer: E1 button and AI builder sheet header ('AI designer').
  ///
  /// In uz, this message translates to:
  /// **'AI dizayner'**
  String get studioAiDesigner;

  /// AI builder sheet: snackbar confirming the AI's changes were applied.
  ///
  /// In uz, this message translates to:
  /// **'✓ AI o\'zgarishlari qo\'llanildi'**
  String get studioAiApplied;

  /// AI builder sheet: snackbar shown when applying the AI patch fails.
  ///
  /// In uz, this message translates to:
  /// **'Qo\'llab bo\'lmadi: {error}'**
  String studioApplyFailed(String error);

  /// AI builder sheet: example prompt hint in the request text field.
  ///
  /// In uz, this message translates to:
  /// **'Masalan: \"Devorlarni iliq bej rangga bo\'ya va divan qo\'sh\"'**
  String get studioAiHint;

  /// AI builder sheet: generate button label while the AI is working.
  ///
  /// In uz, this message translates to:
  /// **'Ishlanmoqda…'**
  String get studioGenerating;

  /// AI builder sheet: generate button label ('Generate').
  ///
  /// In uz, this message translates to:
  /// **'Yaratish'**
  String get studioGenerate;

  /// AI builder sheet: streamed event row for a tool call the agent made.
  ///
  /// In uz, this message translates to:
  /// **'Amal: {name}'**
  String studioActionLabel(String name);

  /// AI builder sheet: streamed event row for a completed tool result.
  ///
  /// In uz, this message translates to:
  /// **'Bajarildi: {name}'**
  String studioDoneLabel(String name);

  /// AI builder sheet: error tile shown when the AI could not respond, followed by the error detail.
  ///
  /// In uz, this message translates to:
  /// **'AI hozircha javob berolmadi.\n{message}'**
  String studioAiNoResponse(String message);

  /// AI builder sheet: proposed change line for the new ceiling height in meters.
  ///
  /// In uz, this message translates to:
  /// **'Shift balandligi: {height} m'**
  String studioChangeCeiling(String height);

  /// AI builder sheet: proposed change line for how many surface materials changed.
  ///
  /// In uz, this message translates to:
  /// **'{count} ta yuza materiali'**
  String studioChangeSurfaces(int count);

  /// AI builder sheet: proposed change line for how many wall dimensions changed.
  ///
  /// In uz, this message translates to:
  /// **'{count} ta devor o\'lchami'**
  String studioChangeWalls(int count);

  /// AI builder sheet: proposed change line for how many furniture items changed.
  ///
  /// In uz, this message translates to:
  /// **'{count} ta mebel'**
  String studioChangeFurniture(int count);

  /// AI builder sheet: proposed change line for how many lights changed.
  ///
  /// In uz, this message translates to:
  /// **'{count} ta chiroq'**
  String studioChangeLights(int count);

  /// AI builder sheet: button applying the AI's proposed changes ('Apply').
  ///
  /// In uz, this message translates to:
  /// **'Qo\'llash'**
  String get studioApply;

  /// Studio WebView: error shown when opening the studio while unauthenticated ('Log in to open the studio').
  ///
  /// In uz, this message translates to:
  /// **'Studio ochish uchun tizimga kiring.'**
  String get studioLoginRequired;

  /// Studio WebView: error shown when the studio page fails to load.
  ///
  /// In uz, this message translates to:
  /// **'Studio yuklanmadi: {error}'**
  String studioLoadFailed(String error);

  /// Generic 'Add' button label used in the add-room dialog.
  ///
  /// In uz, this message translates to:
  /// **'Qo\'shish'**
  String get actionAdd;

  /// Previous-step button label ('Back') in the wall-measurement and 3D wizard step navigation.
  ///
  /// In uz, this message translates to:
  /// **'Ortga'**
  String get actionPrev;

  /// Generic OK confirmation button in the draw-room wall-length dialog.
  ///
  /// In uz, this message translates to:
  /// **'OK'**
  String get actionOk;

  /// Short cancel button ('Cancel') in the draw-room wall-length dialog.
  ///
  /// In uz, this message translates to:
  /// **'Bekor'**
  String get actionCancelShort;

  /// Fallback room name used when the user leaves the room-name field empty.
  ///
  /// In uz, this message translates to:
  /// **'Xona'**
  String get roomDefaultName;

  /// Label above the ceiling-height control on the scan-review and draw-room screens.
  ///
  /// In uz, this message translates to:
  /// **'Shift balandligi'**
  String get ceilingHeightLabel;

  /// Label for the wall-length value/slider on the wall-measurement and 3D wizard steps.
  ///
  /// In uz, this message translates to:
  /// **'Uzunlik'**
  String get measureLength;

  /// Furniture edit card: button that removes the furniture item.
  ///
  /// In uz, this message translates to:
  /// **'O\'chirish'**
  String get furnitureDelete;

  /// Furniture edit card: button that rotates the furniture item 90 degrees.
  ///
  /// In uz, this message translates to:
  /// **'Aylantirish'**
  String get furnitureRotate;

  /// Electrical totals card heading ('Electrical computed').
  ///
  /// In uz, this message translates to:
  /// **'Elektr hisoblandi'**
  String get electricalTotalsTitle;

  /// Electrical totals card stat label: total wire length.
  ///
  /// In uz, this message translates to:
  /// **'jami sim'**
  String get electricalTotalsWireLabel;

  /// Electrical totals card stat label: device count.
  ///
  /// In uz, this message translates to:
  /// **'ta qurilma'**
  String get electricalTotalsDeviceLabel;

  /// Electrical totals chip: socket wire length in metres.
  ///
  /// In uz, this message translates to:
  /// **'Rozetka simlari {meters} m'**
  String electricalTotalsSocketWires(String meters);

  /// Electrical totals chip: switch wire length in metres.
  ///
  /// In uz, this message translates to:
  /// **'Kalit simlari {meters} m'**
  String electricalTotalsSwitchWires(String meters);

  /// Electrical totals chip summarising switch and light counts.
  ///
  /// In uz, this message translates to:
  /// **'{switches} kalit · {lights} yoritish'**
  String electricalTotalsSwitchLightSummary(int switches, int lights);

  /// Electrical totals table column header: device.
  ///
  /// In uz, this message translates to:
  /// **'Qurilma'**
  String get electricalTotalsColDevice;

  /// Electrical totals table column header: wall.
  ///
  /// In uz, this message translates to:
  /// **'Devor'**
  String get electricalTotalsColWall;

  /// Electrical totals table column header: height.
  ///
  /// In uz, this message translates to:
  /// **'Balandlik'**
  String get electricalTotalsColHeight;

  /// Dimensions-entry screen app bar title ('Room dimensions').
  ///
  /// In uz, this message translates to:
  /// **'Xona o\'lchamlari'**
  String get dimensionsTitle;

  /// Dimensions-entry segmented tab: manual entry.
  ///
  /// In uz, this message translates to:
  /// **'Qo\'lda kiritish'**
  String get dimensionsTabManual;

  /// Dimensions-entry segmented tab: floorplan upload.
  ///
  /// In uz, this message translates to:
  /// **'Plan yuklash'**
  String get dimensionsTabUpload;

  /// Dimensions-entry footer summarising total rooms and area.
  ///
  /// In uz, this message translates to:
  /// **'Jami: {count} xona · {area} m²'**
  String dimensionsTotalSummary(int count, String area);

  /// Dimensions-entry primary CTA in manual mode ('Next: measure walls').
  ///
  /// In uz, this message translates to:
  /// **'Keyingi: devorlarni o\'lchash'**
  String get dimensionsNextMeasure;

  /// Dimensions-entry primary CTA in upload mode ('Convert to 3D').
  ///
  /// In uz, this message translates to:
  /// **'3D ga aylantirish'**
  String get dimensionsConvert3d;

  /// Dimensions-entry add-room tile label.
  ///
  /// In uz, this message translates to:
  /// **'+ Xona qo\'shish'**
  String get dimensionsAddRoom;

  /// Default pre-filled name for a newly added room in the dimensions dialog.
  ///
  /// In uz, this message translates to:
  /// **'Xona {number}'**
  String dimensionsRoomDefaultName(int number);

  /// Add-room dialog: room name field label.
  ///
  /// In uz, this message translates to:
  /// **'Xona nomi'**
  String get dimensionsRoomNameLabel;

  /// Add-room dialog: length field label.
  ///
  /// In uz, this message translates to:
  /// **'Uzunlik (m)'**
  String get dimensionsLengthLabel;

  /// Add-room dialog: width field label.
  ///
  /// In uz, this message translates to:
  /// **'Kenglik (m)'**
  String get dimensionsWidthLabel;

  /// Add-room dialog: height field label.
  ///
  /// In uz, this message translates to:
  /// **'Balandlik (m)'**
  String get dimensionsHeightLabel;

  /// Floorplan upload tab: upload area heading.
  ///
  /// In uz, this message translates to:
  /// **'Floorplan rasmini yuklang'**
  String get dimensionsUploadTitle;

  /// Floorplan upload tab: file-format and drag hint.
  ///
  /// In uz, this message translates to:
  /// **'PNG yoki JPG · maksimal 10 MB\nYoki bu yerga sudrab tashlang'**
  String get dimensionsUploadHint;

  /// Floorplan upload tab: choose-file button.
  ///
  /// In uz, this message translates to:
  /// **'Fayl tanlash'**
  String get dimensionsChooseFile;

  /// Floorplan upload tab: note advising a dimensioned plan for accuracy.
  ///
  /// In uz, this message translates to:
  /// **'Aniq natija uchun o\'lchamlar ko\'rsatilgan plan yuklang'**
  String get dimensionsUploadNote;

  /// Door/window sheet title and the wall-measurement add-opening button ('Add door/window').
  ///
  /// In uz, this message translates to:
  /// **'Eshik/Deraza qo\'shish'**
  String get openingAddTitle;

  /// Add door/window button label on the 3D wizard wall step (spaced variant).
  ///
  /// In uz, this message translates to:
  /// **'Eshik / Deraza qo\'shish'**
  String get openingAddSpaced;

  /// Door/window sheet type chip: door.
  ///
  /// In uz, this message translates to:
  /// **'Eshik'**
  String get openingTypeDoor;

  /// Door/window sheet type chip: window.
  ///
  /// In uz, this message translates to:
  /// **'Deraza'**
  String get openingTypeWindow;

  /// Door/window sheet type chip: balcony door.
  ///
  /// In uz, this message translates to:
  /// **'Balkon eshigi'**
  String get openingTypeBalcony;

  /// Door/window sheet: size (cm) section label.
  ///
  /// In uz, this message translates to:
  /// **'O\'lcham (sm)'**
  String get openingSizeLabel;

  /// Door/window sheet: custom-size chip ('Other size…').
  ///
  /// In uz, this message translates to:
  /// **'Boshqa o\'lcham…'**
  String get openingSizeOther;

  /// Door/window sheet: position-along-wall slider label.
  ///
  /// In uz, this message translates to:
  /// **'Devor bo\'ylab joylashuvi'**
  String get openingPositionLabel;

  /// Door/window sheet: confirm button that adds the opening to the wall.
  ///
  /// In uz, this message translates to:
  /// **'Devorga qo\'shish'**
  String get openingAddToWall;

  /// New-project bottom sheet title.
  ///
  /// In uz, this message translates to:
  /// **'Yangi loyiha'**
  String get newProjectTitle;

  /// New-project bottom sheet subtitle ('How do you want to add the room?').
  ///
  /// In uz, this message translates to:
  /// **'Xonani qanday qo\'shmoqchisiz?'**
  String get newProjectSubtitle;

  /// New-project entry: 3D wizard title.
  ///
  /// In uz, this message translates to:
  /// **'3D Sehrgar'**
  String get newProjectWizardTitle;

  /// New-project entry: 3D wizard description.
  ///
  /// In uz, this message translates to:
  /// **'Interaktiv 3D ko\'rinishda xona o\'lchamlarini kiriting'**
  String get newProjectWizardDesc;

  /// New-project entry and scan screen app bar: LiDAR scanner title.
  ///
  /// In uz, this message translates to:
  /// **'LiDAR skaner'**
  String get newProjectLidarTitle;

  /// New-project entry: LiDAR scanner description.
  ///
  /// In uz, this message translates to:
  /// **'Xonani LiDAR yordamida skanerlang va avtomatik 3D model oling'**
  String get newProjectLidarDesc;

  /// New-project entry and unsupported-LiDAR fallback: 360° photo scan title.
  ///
  /// In uz, this message translates to:
  /// **'360° Foto skan'**
  String get newProjectPhotoTitle;

  /// New-project entry: 360° photo scan description.
  ///
  /// In uz, this message translates to:
  /// **'Xonani 360° rasmga oling — ilova nuqtalarni o\'zi belgilaydi'**
  String get newProjectPhotoDesc;

  /// New-project entry and unsupported-LiDAR fallback: draw-it-yourself title.
  ///
  /// In uz, this message translates to:
  /// **'O\'zingiz chizing'**
  String get newProjectDrawTitle;

  /// New-project entry: draw-it-yourself description.
  ///
  /// In uz, this message translates to:
  /// **'Xonani barmog\'ingiz bilan chizing — o\'lchamlar chizganingizga qarab o\'zi hisoblanadi'**
  String get newProjectDrawDesc;

  /// Room summary / wizard summary celebratory heading ('Dimensions saved!').
  ///
  /// In uz, this message translates to:
  /// **'O\'lchamlar saqlandi!'**
  String get summarySavedTitle;

  /// Room summary stat card label: floor area.
  ///
  /// In uz, this message translates to:
  /// **'pol'**
  String get summaryStatFloor;

  /// Room summary stat card label: net wall area.
  ///
  /// In uz, this message translates to:
  /// **'devor (netto)'**
  String get summaryStatWallNet;

  /// Room summary stat card label: perimeter.
  ///
  /// In uz, this message translates to:
  /// **'perimetr'**
  String get summaryStatPerimeter;

  /// Room summary stat card label: openings (doors/windows).
  ///
  /// In uz, this message translates to:
  /// **'eshik/deraza'**
  String get summaryStatOpenings;

  /// Room summary / wizard openings count value (e.g. '3 ta').
  ///
  /// In uz, this message translates to:
  /// **'{count} ta'**
  String summaryOpeningsCount(int count);

  /// Room summary note explaining openings are auto-subtracted (net).
  ///
  /// In uz, this message translates to:
  /// **'Eshik/derazalar avtomatik ayirilgan (netto)'**
  String get summaryOpeningsNote;

  /// Room summary: secondary action to add another room.
  ///
  /// In uz, this message translates to:
  /// **'+ Yangi xona qo\'shish'**
  String get summaryAddRoom;

  /// 3D room wizard app bar title ('New room').
  ///
  /// In uz, this message translates to:
  /// **'Yangi xona'**
  String get wizardTitle;

  /// 3D wizard ceiling step question ('Ceiling height?').
  ///
  /// In uz, this message translates to:
  /// **'Shiftning balandligi?'**
  String get wizardCeilingQuestion;

  /// 3D wizard ceiling step hint ('Usually between 2.5–3.2 metres').
  ///
  /// In uz, this message translates to:
  /// **'Odatda 2.5–3.2 metr oralig\'ida'**
  String get wizardCeilingHint;

  /// 3D wizard ceiling step: exact-value field label.
  ///
  /// In uz, this message translates to:
  /// **'Aniq qiymat (m)'**
  String get wizardExactValue;

  /// 3D wizard wall step heading, e.g. 'A devor'.
  ///
  /// In uz, this message translates to:
  /// **'{letter} devor'**
  String wizardWallTitle(String letter);

  /// 3D wizard wall step subtitle ('Enter its length').
  ///
  /// In uz, this message translates to:
  /// **'Uzunligini kiriting'**
  String get wizardWallSubtitle;

  /// 3D wizard summary subtitle confirming the room parameters were recorded.
  ///
  /// In uz, this message translates to:
  /// **'Xona parametrlari muvaffaqiyatli qayd etildi'**
  String get wizardSummarySubtitle;

  /// 3D wizard summary stat: floor area (uppercase).
  ///
  /// In uz, this message translates to:
  /// **'POL MAYDONI'**
  String get wizardStatFloor;

  /// 3D wizard summary stat: net wall area (uppercase).
  ///
  /// In uz, this message translates to:
  /// **'DEVOR MAYDONI (NETTO)'**
  String get wizardStatWallNet;

  /// 3D wizard summary stat: perimeter (uppercase).
  ///
  /// In uz, this message translates to:
  /// **'PERIMETR'**
  String get wizardStatPerimeter;

  /// 3D wizard summary stat: openings (uppercase).
  ///
  /// In uz, this message translates to:
  /// **'ESHIK/DERAZALAR'**
  String get wizardStatOpenings;

  /// 3D wizard summary primary CTA ('View estimate').
  ///
  /// In uz, this message translates to:
  /// **'Smeta ko\'rish'**
  String get wizardViewSmeta;

  /// 3D wizard summary: loading label while the studio is opening.
  ///
  /// In uz, this message translates to:
  /// **'Ochilmoqda…'**
  String get wizardOpening;

  /// 3D wizard summary secondary CTA ('Start decorating').
  ///
  /// In uz, this message translates to:
  /// **'Bezashni boshlash'**
  String get wizardStartDesign;

  /// Wall-measurement screen: openings list section label.
  ///
  /// In uz, this message translates to:
  /// **'Eshik / derazalar'**
  String get measureOpenings;

  /// Wall-measurement opening row: offset from the wall's left edge.
  ///
  /// In uz, this message translates to:
  /// **'Chapdan {offset} m'**
  String measureFromLeft(String offset);

  /// LiDAR scanning screen: 'Scanning...' status.
  ///
  /// In uz, this message translates to:
  /// **'Skanerlanyapti...'**
  String get lidarScanning;

  /// LiDAR scanning screen hint: 'Move the phone slowly'.
  ///
  /// In uz, this message translates to:
  /// **'Telefonni sekin harakatlantiring'**
  String get lidarMoveHint;

  /// LiDAR scanning found-stat label: wall (used as '{count} devor').
  ///
  /// In uz, this message translates to:
  /// **'devor'**
  String get lidarLabelWall;

  /// LiDAR scanning found-stat label: door.
  ///
  /// In uz, this message translates to:
  /// **'eshik'**
  String get lidarLabelDoor;

  /// LiDAR scanning found-stat label: window.
  ///
  /// In uz, this message translates to:
  /// **'deraza'**
  String get lidarLabelWindow;

  /// 360° photo scan: captured / total points counter.
  ///
  /// In uz, this message translates to:
  /// **'{captured}/{total} nuqta'**
  String photoPointsCount(int captured, int total);

  /// 360° photo scan hint: 'Turn the phone to the next point'.
  ///
  /// In uz, this message translates to:
  /// **'Telefonni keyingi nuqtaga burang'**
  String get photoTurnHint;

  /// 360° photo scan: capture button ('Take photo').
  ///
  /// In uz, this message translates to:
  /// **'Suratga olish'**
  String get photoCapture;

  /// Room-scan review page app bar title ('Scan result').
  ///
  /// In uz, this message translates to:
  /// **'Skan natijasi'**
  String get scanReviewTitle;

  /// Room-scan review: detected ceiling height.
  ///
  /// In uz, this message translates to:
  /// **'Aniqlangan: {value}'**
  String scanReviewDetected(String value);

  /// Room-scan review: walls section header with count.
  ///
  /// In uz, this message translates to:
  /// **'Devorlar ({count})'**
  String scanReviewWalls(int count);

  /// Room-scan review: per-wall row label, e.g. 'Devor 1'.
  ///
  /// In uz, this message translates to:
  /// **'Devor {number}'**
  String scanReviewWall(int number);

  /// Room-scan review: detected-objects section header with count.
  ///
  /// In uz, this message translates to:
  /// **'Topilgan buyumlar ({count})'**
  String scanReviewObjects(int count);

  /// Room-scan review: shown when no objects were detected.
  ///
  /// In uz, this message translates to:
  /// **'Buyum topilmadi'**
  String get scanReviewNoObjects;

  /// Room-scan review: re-scan button.
  ///
  /// In uz, this message translates to:
  /// **'Qayta skanerlash'**
  String get scanReviewRescan;

  /// Room-scan review: header of the compact 'what we detected' summary shown under the 2-D preview.
  ///
  /// In uz, this message translates to:
  /// **'Nimalar aniqlandi'**
  String get scanReviewSummaryTitle;

  /// Room-scan review summary chip label: walls.
  ///
  /// In uz, this message translates to:
  /// **'Devor'**
  String get scanReviewSummaryWalls;

  /// Room-scan review summary chip label: doors.
  ///
  /// In uz, this message translates to:
  /// **'Eshik'**
  String get scanReviewSummaryDoors;

  /// Room-scan review summary chip label: windows.
  ///
  /// In uz, this message translates to:
  /// **'Deraza'**
  String get scanReviewSummaryWindows;

  /// Room-scan review summary chip label: detected objects.
  ///
  /// In uz, this message translates to:
  /// **'Buyum'**
  String get scanReviewSummaryObjects;

  /// Room-scan review summary: warning that some detected items carry a low RoomPlan confidence.
  ///
  /// In uz, this message translates to:
  /// **'{count} ta element past aniqlikda o\'lchandi — o\'lchamlarni tekshiring.'**
  String scanReviewSummaryLowConfidence(int count);

  /// Room-scan review summary hint shown when zero doors or zero windows were detected.
  ///
  /// In uz, this message translates to:
  /// **'Eshik yoki deraza topilmadi. Shisha va ochiq eshiklar ko\'pincha aniqlanmaydi.'**
  String get scanReviewSummaryNoOpenings;

  /// Room-scan review summary hint: second line telling the user how to improve the scan.
  ///
  /// In uz, this message translates to:
  /// **'Yaqinroqdan, sekinroq qayta skanerlang.'**
  String get scanReviewSummaryRescanHint;

  /// Room-scan review: snackbar when the room could not be saved.
  ///
  /// In uz, this message translates to:
  /// **'Xonani saqlab bo\'lmadi. Internetni tekshiring.'**
  String get scanReviewSaveFailed;

  /// Room-scan review: snackbar shown in the studio when the scan artifact (mesh/USDZ) upload failed; the room itself was still created.
  ///
  /// In uz, this message translates to:
  /// **'Skan fayllari yuklanmadi: {error} Xona saqlandi, keyinroq qayta skanerlashingiz mumkin.'**
  String scanReviewUploadFailed(String error);

  /// Room-scan review: snackbar shown in the studio when uploading the generated floor-plan thumbnail failed; the room itself was still created and only its project-card preview stays empty.
  ///
  /// In uz, this message translates to:
  /// **'Xona ko\'rinishi yuklanmadi: {error} Loyiha kartasi rasmsiz ko\'rinadi.'**
  String scanReviewThumbnailFailed(String error);

  /// Room-scan review: generic error snackbar with detail.
  ///
  /// In uz, this message translates to:
  /// **'Xatolik: {error}'**
  String scanReviewError(String error);

  /// Post-scan summary sheet title.
  ///
  /// In uz, this message translates to:
  /// **'Xona saqlandi'**
  String get scanSummaryTitle;

  /// Post-scan summary: room headline (area, ceiling height, wall count).
  ///
  /// In uz, this message translates to:
  /// **'{area} m² · shift {height} · {walls} ta devor'**
  String scanSummaryRoomLine(String area, String height, int walls);

  /// Post-scan summary: estimate section title.
  ///
  /// In uz, this message translates to:
  /// **'Taxminiy smeta'**
  String get scanSummaryEstimateTitle;

  /// Post-scan summary: min-max range under the estimate total.
  ///
  /// In uz, this message translates to:
  /// **'Oraliq: {min} — {max}'**
  String scanSummaryRange(String min, String max);

  /// Post-scan summary: part of the total coming from exactly priced lines.
  ///
  /// In uz, this message translates to:
  /// **'Aniq: {value}'**
  String scanSummaryExactTotal(String value);

  /// Post-scan summary: part of the total coming from approximate lines.
  ///
  /// In uz, this message translates to:
  /// **'Taxminiy: {value}'**
  String scanSummaryApproxTotal(String value);

  /// Post-scan summary: badge marking an approximate estimate line.
  ///
  /// In uz, this message translates to:
  /// **'taxminiy'**
  String get scanSummaryApproxBadge;

  /// Post-scan summary: explains what the approximate badge means.
  ///
  /// In uz, this message translates to:
  /// **'\"Taxminiy\" belgili qatorlar aniq o\'lchovga emas, o\'rtacha me\'yorga asoslangan.'**
  String get scanSummaryApproxNote;

  /// Post-scan summary: estimate preview request failed (non-blocking snackbar).
  ///
  /// In uz, this message translates to:
  /// **'Smetani hisoblab bo\'lmadi: {error} Uni studiyada ochishingiz mumkin.'**
  String scanSummaryEstimateFailed(String error);

  /// Post-scan summary: electrical section title.
  ///
  /// In uz, this message translates to:
  /// **'Elektr rejasi'**
  String get scanSummaryElectricalTitle;

  /// Post-scan summary: total wiring length in metres.
  ///
  /// In uz, this message translates to:
  /// **'Kabel: {value} m'**
  String scanSummaryWiring(String value);

  /// Electrical device name (socket), used in a count list.
  ///
  /// In uz, this message translates to:
  /// **'rozetka'**
  String get scanSummaryDeviceSocket;

  /// Electrical device name (switch), used in a count list.
  ///
  /// In uz, this message translates to:
  /// **'kalit'**
  String get scanSummaryDeviceSwitch;

  /// Electrical device name (light), used in a count list.
  ///
  /// In uz, this message translates to:
  /// **'chiroq'**
  String get scanSummaryDeviceLight;

  /// Electrical device name (panel), used in a count list.
  ///
  /// In uz, this message translates to:
  /// **'elektr qutisi'**
  String get scanSummaryDevicePanel;

  /// Electrical device name (mounting box), used in a count list.
  ///
  /// In uz, this message translates to:
  /// **'podrozetnik'**
  String get scanSummaryDeviceBox;

  /// Electrical device name for a type this app version does not know.
  ///
  /// In uz, this message translates to:
  /// **'boshqa nuqta'**
  String get scanSummaryDeviceOther;

  /// Post-scan summary: one 'N device' entry in the electrical device list.
  ///
  /// In uz, this message translates to:
  /// **'{count} {name}'**
  String scanSummaryDeviceCount(int count, String name);

  /// Post-scan summary: the electrical plan was auto-generated, not confirmed.
  ///
  /// In uz, this message translates to:
  /// **'Elektr nuqtalari skan asosida taxminan joylashtirildi — studiyada tahrirlashingiz mumkin.'**
  String get scanSummaryElectricalApprox;

  /// Post-scan summary: primary CTA opening the studio.
  ///
  /// In uz, this message translates to:
  /// **'Studiyaga o\'tish'**
  String get scanSummaryContinue;

  /// Room-scan screen error: a scan is already running.
  ///
  /// In uz, this message translates to:
  /// **'Skaner allaqachon ishlayapti.'**
  String get scanBusy;

  /// Room-scan screen error: scanning failed, try again.
  ///
  /// In uz, this message translates to:
  /// **'Skanerlashda xatolik. Qayta urinib ko\'ring.'**
  String get scanFailedRetry;

  /// Room-scan screen error with underlying message.
  ///
  /// In uz, this message translates to:
  /// **'Xatolik: {message}'**
  String scanErrorPrefixed(String message);

  /// Room-scan screen error: no valid room detected.
  ///
  /// In uz, this message translates to:
  /// **'Xona aniqlanmadi. Qayta urinib ko\'ring.'**
  String get scanNotDetected;

  /// Unsupported-device sheet title ('LiDAR not available').
  ///
  /// In uz, this message translates to:
  /// **'LiDAR mavjud emas'**
  String get scanLidarUnavailableTitle;

  /// Unsupported-device sheet body explaining LiDAR requirements and offering alternatives.
  ///
  /// In uz, this message translates to:
  /// **'LiDAR skaner faqat iPhone 12 Pro, 13 Pro, 14 Pro, 15 Pro, 16 Pro yoki iPad Pro\'da ishlaydi. Xonani boshqa usulda qo\'shing:'**
  String get scanLidarUnavailableBody;

  /// Room-scan screen: 'Scanning the room…' progress label.
  ///
  /// In uz, this message translates to:
  /// **'Xona skanerlanmoqda…'**
  String get scanInProgress;

  /// Draw-room screen app bar title and the finish button's disabled fallback ('Draw the room').
  ///
  /// In uz, this message translates to:
  /// **'Xonani chizing'**
  String get drawTitle;

  /// Draw-room mode chip: freehand ('By hand').
  ///
  /// In uz, this message translates to:
  /// **'Qo\'lda'**
  String get drawModeManual;

  /// Draw-room mode chip: polygon ('Visual').
  ///
  /// In uz, this message translates to:
  /// **'Vizual'**
  String get drawModeVisual;

  /// Draw-room hint shown while viewing the raw (unsmoothed) sketch.
  ///
  /// In uz, this message translates to:
  /// **'Xom chizma. \"Toza\"ga qaytish uchun tugmani bosing.'**
  String get drawHintRaw;

  /// Draw-room hint once the shape is closed.
  ///
  /// In uz, this message translates to:
  /// **'Shakl tayyor! Burchaklarni surib o\'lchamni o\'zgartiring.'**
  String get drawHintShapeReady;

  /// Draw-room hint in freehand mode.
  ///
  /// In uz, this message translates to:
  /// **'Xona shaklini barmog\'ingiz bilan chizing.'**
  String get drawHintFreehand;

  /// Draw-room hint in polygon mode before any corners are placed.
  ///
  /// In uz, this message translates to:
  /// **'Xona burchaklarini belgilang (kamida 3 ta).'**
  String get drawHintMarkCorners;

  /// Draw-room hint prompting for more corner points.
  ///
  /// In uz, this message translates to:
  /// **'Yana {count} ta nuqta qo\'ying.'**
  String drawHintMorePoints(int count);

  /// Draw-room hint on how to close the polygon.
  ///
  /// In uz, this message translates to:
  /// **'Yopish uchun birinchi nuqtaga bosing yoki \"Yopish\".'**
  String get drawHintClose;

  /// Draw-room hint bar toggle: show cleaned/smoothed shape ('Clean').
  ///
  /// In uz, this message translates to:
  /// **'Toza'**
  String get drawToggleClean;

  /// Draw-room hint bar toggle: show raw shape ('Raw').
  ///
  /// In uz, this message translates to:
  /// **'Xom'**
  String get drawToggleRaw;

  /// Draw-room hint bar redo button tooltip ('Redo').
  ///
  /// In uz, this message translates to:
  /// **'Oldinga'**
  String get drawRedo;

  /// Draw-room hint bar clear button tooltip ('Clear').
  ///
  /// In uz, this message translates to:
  /// **'Tozalash'**
  String get drawClear;

  /// Draw-room wall-length dialog title.
  ///
  /// In uz, this message translates to:
  /// **'Devor uzunligi'**
  String get drawWallLength;

  /// Draw-room bottom panel warning when the area is outside the usual range.
  ///
  /// In uz, this message translates to:
  /// **'Diqqat: yuza odatiy oraliqdan tashqarida'**
  String get drawAreaWarning;

  /// Draw-room bottom panel title for a rectangle-like room.
  ///
  /// In uz, this message translates to:
  /// **'Xona: {width} × {length} × {height} m'**
  String drawTitleRect(String width, String length, String height);

  /// Draw-room bottom panel title for a polygonal room.
  ///
  /// In uz, this message translates to:
  /// **'Ko\'pburchak · {corners} devor · {width}×{length} m'**
  String drawTitlePolygon(int corners, String width, String length);

  /// Accessibility label for the icon-only button that decreases an item quantity.
  ///
  /// In uz, this message translates to:
  /// **'Miqdorni kamaytirish'**
  String get a11yQuantityDecrease;

  /// Accessibility label for the icon-only button that increases an item quantity.
  ///
  /// In uz, this message translates to:
  /// **'Miqdorni oshirish'**
  String get a11yQuantityIncrease;

  /// Accessibility label for the icon-only button that removes a line item from the cart.
  ///
  /// In uz, this message translates to:
  /// **'Savatdan olib tashlash'**
  String get a11yRemoveFromCart;

  /// Accessibility label for the icon-only button that adds a product to the cart.
  ///
  /// In uz, this message translates to:
  /// **'Savatga qo\'shish'**
  String get a11yAddToCart;

  /// Accessibility label for the icon-only call button in the order status screen.
  ///
  /// In uz, this message translates to:
  /// **'Qo\'ng\'iroq qilish'**
  String get a11yCallDealer;

  /// Accessibility label for the icon-only message button in the order status screen.
  ///
  /// In uz, this message translates to:
  /// **'Xabar yuborish'**
  String get a11yMessageDealer;

  /// Accessibility label for the icon-only edit button next to the profile name.
  ///
  /// In uz, this message translates to:
  /// **'Profilni tahrirlash'**
  String get a11yEditProfile;

  /// Accessibility label for the button that switches the masters map to the list view.
  ///
  /// In uz, this message translates to:
  /// **'Ro\'yxat ko\'rinishi'**
  String get a11yMastersListView;
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
