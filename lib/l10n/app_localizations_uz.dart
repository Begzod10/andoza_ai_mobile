// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Uzbek (`uz`).
class AppLocalizationsUz extends AppLocalizations {
  AppLocalizationsUz([String locale = 'uz']) : super(locale);

  @override
  String get appTitle => 'Andoza AI';

  @override
  String get actionRetry => 'Qayta urinish';

  @override
  String get actionBack => 'Orqaga';

  @override
  String get actionNext => 'Keyingi';

  @override
  String get actionContinue => 'Davom etish';

  @override
  String get actionCancel => 'Bekor qilish';

  @override
  String get actionSave => 'Saqlash';

  @override
  String get actionClose => 'Yopish';

  @override
  String get actionDone => 'Tayyor';

  @override
  String get actionFinish => 'Yakunlash';

  @override
  String get navHome => 'Uy';

  @override
  String get navShop => 'Do\'kon';

  @override
  String get navMasters => 'Ustalar';

  @override
  String get navProfile => 'Profil';

  @override
  String get loginEmailHint => 'Email';

  @override
  String get loginPasswordHint => 'Password';

  @override
  String get loginShowPassword => 'Show password';

  @override
  String get loginHidePassword => 'Hide password';

  @override
  String get loginButton => 'Login';

  @override
  String get loginEmptyFields => 'Please fill in all fields';

  @override
  String get b1Question => 'Xonangiz hozir qaysi holatda?';

  @override
  String get b1DontKnowDifference => 'Farqini bilmayapsizmi? →';

  @override
  String get b1FloorCeilingDifferent => 'Pol yoki shift boshqacha bo\'lsa →';

  @override
  String get b1EnterRoom => 'Xonaga kirish';

  @override
  String get brandName => 'AndozaAI';

  @override
  String get navAddProject => 'Yangi loyiha qo\'shish';

  @override
  String get loginPhoneLabel => 'Telefon raqam';

  @override
  String get loginPhoneSubtitle =>
      'Loginiga uchun telefon raqam talab qilinadi';

  @override
  String get loginPhoneHint => '90 123 45 67';

  @override
  String get loginPhoneSmsHint => 'Sms kod shu raqamga yuboriladi';

  @override
  String get loginSendOtp => 'OTP Yuborish';

  @override
  String get loginOtpInfoBox =>
      '📱 Siz kiritgan raqamga 6 xonali kod yuboriladi. Agar SMS kelmaydigan bo\'lsa, 2-3 minutdan keyin qayta urinib ko\'ring.';

  @override
  String get loginWithUsername => '🔐 Username bilan kirish';

  @override
  String get loginCodeSentTitle => '✓ Kod yuborildi';

  @override
  String get loginCodeSentSuffix => ' raqamiga 6 xonali kod yuboramiz';

  @override
  String get loginVerify => 'Tasdiqlash';

  @override
  String get loginResend => 'Qayta yuborish';

  @override
  String loginResendCountdown(int seconds) {
    return 'Qayta yuborish ($seconds s)';
  }

  @override
  String get loginBackArrow => '← Orqaga';

  @override
  String get loginSignIn => 'Kirish';

  @override
  String get loginUsernameHint => 'Username';

  @override
  String get loginPasswordLabel => 'Parol';

  @override
  String get loginNoAccount => 'Akkauntingiz yo\'qmi? ';

  @override
  String get loginRegister => 'Ro\'yxatdan o\'tish';

  @override
  String get loginNameHint => 'Ism (ixtiyoriy)';

  @override
  String get loginConfirmPasswordHint => 'Parolni tasdiqlang';

  @override
  String get loginHaveAccount => 'Allaqachon akkauntingiz bormi? ';

  @override
  String get loginOr => 'yoki';

  @override
  String get loginGreeting => '👋 Salom';

  @override
  String get loginWelcomeSubtitle => 'Andoza AI-ga xush kelibsiz';

  @override
  String get loginVersion => 'AndozaAI v1.0.0';

  @override
  String get loginErrorInvalidPhone =>
      'Telefon raqam noto\'g\'ri. Masalan: 90 123 45 67';

  @override
  String get loginErrorServer => 'Serverda xatolik. Qayta urinib ko\'ring.';

  @override
  String get loginErrorInvalidCode => 'Kod noto\'g\'ri yoki eskirgan.';

  @override
  String get loginErrorCredentialsRequired => 'Username va parol majburiy.';

  @override
  String get loginErrorWrongCredentials => 'Username yoki parol noto\'g\'ri.';

  @override
  String get loginErrorUsernameShort =>
      'Username kamida 3 ta belgidan iborat bo\'lishi kerak.';

  @override
  String get loginErrorPasswordShort =>
      'Parol kamida 6 ta belgidan iborat bo\'lishi kerak.';

  @override
  String get loginErrorPasswordMismatch => 'Parollar mos kelmadi.';

  @override
  String get loginErrorUsernameTaken => 'Bu username allaqachon band.';

  @override
  String get loginErrorRegisterFailed =>
      'Ro\'yxatdan o\'tishda xato yuz berdi.';

  @override
  String get homeWelcome => 'Xush kelibsiz';

  @override
  String homeGreetingNamed(String name) {
    return 'Salom, $name! 👋';
  }

  @override
  String get homeGreeting => 'Salom! 👋';

  @override
  String get homeStoryHowItWorks => 'Qanday ishlaydi?';

  @override
  String get homeStoryDemoGuide => 'Demo qo\'llanma';

  @override
  String get homeStoryDemo => 'Demo';

  @override
  String get homeEmptyTitle => 'Birinchi xonangizni qo\'shing';

  @override
  String get homeEmptyMessage => 'Hali loyiha yo\'q — yangi loyiha boshlang';

  @override
  String get homeEmptyAction => '+ Loyiha qo\'shish';

  @override
  String get homeQuickActions => 'Tezkor amallar';

  @override
  String get homeQuickScan => 'Xonani skanlash';

  @override
  String get homeQuickEstimate => 'Smeta';

  @override
  String get homeQuickDealers => 'Dilerlar';

  @override
  String get homeProjectsLoadError => 'Loyihalarni yuklab bo\'lmadi';

  @override
  String get homeYourProjects => 'Loyihalaringiz';

  @override
  String get homeSeeAll => 'Barchasi';

  @override
  String get homeLegendExisting => 'Mavjud (hisoblanmaydi)';

  @override
  String get homeLegendNeeded => 'Kerak (delta)';

  @override
  String get homeResume => 'Davom etish';

  @override
  String get homeNoRoomYet => 'Bu loyihada hali xona yo\'q';

  @override
  String homeStageProgress(int current) {
    return 'Bosqich $current/8';
  }

  @override
  String homeStageProgressExcluded(int current, String names) {
    return 'Bosqich $current/8 · ✓ $names mavjud edi';
  }

  @override
  String homeStageProgressExcludedCount(int current, int count) {
    return 'Bosqich $current/8 · ✓ $count bosqich mavjud edi';
  }

  @override
  String get homeStagePickerTitle => 'Bosqichni tanlang';

  @override
  String homeStageOption(int index, String label) {
    return 'Bosqich $index/8 · $label';
  }

  @override
  String get homeStageSaveError => 'Bosqichni saqlab bo\'lmadi';

  @override
  String get stageSuvoq => 'suvoq';

  @override
  String get stageShpaklovka => 'shpaklovka';

  @override
  String get stageBoyoqOboi => 'bo\'yoq/oboi';

  @override
  String get stagePol => 'pol';

  @override
  String get stageMebel => 'mebel';

  @override
  String get stageElektr => 'elektr';

  @override
  String get stageYoruglik => 'yorug\'lik';

  @override
  String get stageSantexnika => 'santexnika';
}
