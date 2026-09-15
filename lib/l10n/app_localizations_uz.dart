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

  @override
  String get commonYes => 'Ha';

  @override
  String get commonNo => 'Yo\'q';

  @override
  String get shopCartTooltip => 'Savatcha';

  @override
  String get shopSearchHint => 'Material qidirish...';

  @override
  String get shopFilterAll => 'Barchasi';

  @override
  String get shopProjectBannerLabel => 'SIZNING LOYIHANGIZ';

  @override
  String get shopProjectBannerTitle => 'Mehmonxona loyihangiz uchun';

  @override
  String shopProjectBannerCount(int count) {
    return '$count turdagi material kerak';
  }

  @override
  String get shopProjectBannerCalculating =>
      'Loyiha materiallari hisoblanmoqda';

  @override
  String get shopSeeAllArrow => 'Hammasini ko\'rish →';

  @override
  String get shopInProjectTag => 'Loyihada';

  @override
  String get shopMaterialsTitle => 'Loyiha materiallari';

  @override
  String shopMaterialsAutoCalc(String area, int count) {
    return 'App loyihangiz asosida avtomatik hisobladi — $area m², $count bosqich';
  }

  @override
  String get shopAddAllToCart => 'Hammasini savatga';

  @override
  String get shopOfficialDealer => '✓ Rasmiy diler';

  @override
  String shopProjectNeed(String quantity, String unit) {
    return 'Loyihangiz uchun ~$quantity $unit kerak';
  }

  @override
  String get shopQuantityLabel => 'Miqdor:';

  @override
  String get shopSpecCoverage => 'Qoplama';

  @override
  String get shopSpecDryingTime => 'Quriish vaqti';

  @override
  String get shopSpecWashable => 'Yuvilishi';

  @override
  String shopWhereToBuy(String name) {
    return 'Qayerdan olish — $name';
  }

  @override
  String get shopAddedToCart => 'Savatga qo\'shildi';

  @override
  String shopAddToCartPrice(String price) {
    return 'Savatga qo\'shish · $price';
  }

  @override
  String get shopDealerCompareTitle => 'Diler taqqoslash';

  @override
  String get shopFilterCheapest => 'Eng arzon';

  @override
  String get shopFilterOfficial => 'Rasmiy diler';

  @override
  String get shopFilterFastest => 'Eng tez';

  @override
  String get shopBestRibbon => 'ENG YAXSHI';

  @override
  String shopDeliveryDays(String district, int days) {
    return '$district · $days kunda yetkazish';
  }

  @override
  String get shopSelect => 'Tanlash';

  @override
  String get shopCartTitle => 'Savat';

  @override
  String get shopCartEmpty => 'Savat bo\'sh';

  @override
  String get shopMaterials => 'Materiallar';

  @override
  String get shopDelivery => 'Yetkazish';

  @override
  String get shopGrandTotal => 'Umumiy summa';

  @override
  String get shopCheckout => 'Buyurtmani rasmiylashtirish';

  @override
  String get shopCheckoutTitle => 'To\'lov';

  @override
  String get shopDeliveryAddress => 'Yetkazish manzili';

  @override
  String get shopAddressHint => 'Manzil';

  @override
  String get shopPhoneHint => 'Telefon raqami';

  @override
  String get shopPaymentMethod => 'To\'lov usuli';

  @override
  String get shopOrderSummary => 'Buyurtma xulosasi';

  @override
  String get shopAmountDue => 'To\'lanadi';

  @override
  String get shopPay => 'To\'lash';

  @override
  String shopOrderSaveError(String error) {
    return 'Buyurtmani serverga saqlashda xatolik: $error';
  }

  @override
  String get shopOrderStatusTitle => 'Buyurtma holati';

  @override
  String get shopOrderContents => 'Buyurtma tarkibi';

  @override
  String get shopTotal => 'Jami';

  @override
  String get shopMasterNotified => 'Usta xabardor qilindi';

  @override
  String get shopHandToMaster => 'Ustaga topshirish';

  @override
  String get shopBackToShop => 'Do\'konga qaytish';

  @override
  String get shopSearchResultsTitle => 'Qidiruv natijalari';

  @override
  String get shopFilterForProject => 'Loyihamga mos';

  @override
  String get shopFilterRating => 'Reyting';

  @override
  String shopResultCount(int count) {
    return '$count ta natija';
  }

  @override
  String get commonVerifiedBadge => '✓ Tasdiqlangan';

  @override
  String get mastersSearchHint => 'Qanday usta kerak?';

  @override
  String mastersRatingReviews(String rating, int count) {
    return '$rating ($count sharh)';
  }

  @override
  String mastersAreaDistance(String area, String distance) {
    return '$area · ~$distance km';
  }

  @override
  String get mastersViewProfile => 'Profilni ko\'rish';

  @override
  String get mastersStatRating => 'reyting';

  @override
  String get mastersStatReviews => 'sharh';

  @override
  String get mastersStatJobs => 'ishlar';

  @override
  String get mastersPortfolio => 'Portfolio';

  @override
  String get mastersServices => 'Xizmatlar';

  @override
  String mastersServiceTrade(String trade) {
    return '$trade ishlari';
  }

  @override
  String get mastersServiceConsultation => 'Konsultatsiya';

  @override
  String get mastersLocation => 'Joylashuv';

  @override
  String get mastersSendEstimate => 'Smetani yuborish';

  @override
  String get mastersSendMessage => 'Xabar yozish';

  @override
  String mastersSendConfirmTitle(String name) {
    return 'Loyihangizni $name akaga yuborasizmi?';
  }

  @override
  String get mastersProjectSummaryTitle => 'Mehmonxona ta\'miri';

  @override
  String mastersProjectSummaryValue(String area, String price) {
    return '$area m² · $price';
  }

  @override
  String get mastersCommentHint => 'Izoh (ixtiyoriy)';

  @override
  String get mastersEstimateNote =>
      'Usta smetani ko\'rib, o\'z narxini taklif qiladi';

  @override
  String get mastersEstimateSent => 'Smeta yuborildi';

  @override
  String get mastersSend => 'Yuborish';

  @override
  String get profileDefaultName => 'Foydalanuvchi';

  @override
  String get profileComingSoon => 'Tez kunda';

  @override
  String get profileStatProjects => 'loyiha';

  @override
  String get profileStatOrders => 'buyurtma';

  @override
  String get profileStatSaved => 'tejaldi';

  @override
  String profileSavedMln(String amount) {
    return '$amount mln';
  }

  @override
  String get profileMenuProjects => 'Loyihalarim';

  @override
  String get profileMenuOrders => 'Buyurtmalarim';

  @override
  String get profileMenuSavedDesigns => 'Saqlangan dizaynlar';

  @override
  String get profileMenuAddresses => 'Manzillarim';

  @override
  String get profileMenuPaymentMethods => 'To\'lov usullari';

  @override
  String get profileMenuLanguage => 'Til';

  @override
  String get profileMenuSettings => 'Sozlamalar';

  @override
  String get profileMenuHelp => 'Yordam';

  @override
  String get profileMenuLogout => 'Chiqish';

  @override
  String get profileLanguageUzbek => 'O\'zbekcha';

  @override
  String get profileNewProject => 'Yangi loyiha';

  @override
  String get profileFilterOngoing => 'Davom etayotgan';

  @override
  String get profileFilterFinished => 'Tugagan';

  @override
  String get profileProjectsEmptyTitle => 'Hali loyiha yo\'q';

  @override
  String get profileProjectsEmptyMessage => 'Birinchi loyihangizni boshlang';

  @override
  String get profileProjectsEmptyAction => '+ Yangi loyiha';

  @override
  String profileProjectMeta(int count, String location, String date) {
    return '$count xona · $location · $date';
  }

  @override
  String get profileOrdersEmptyTitle => 'Buyurtma yo\'q';

  @override
  String get profileOrdersEmptyMessage =>
      'Do\'kondan xarid qilganingizda shu yerda ko\'rinadi';

  @override
  String get profileSavedDesignsEmptyTitle => 'Saqlangan dizayn yo\'q';

  @override
  String get profileSavedDesignsEmptyMessage =>
      'Yoqqan dizaynlaringizni shu yerda saqlab qo\'ying';

  @override
  String get onboardingSkip => 'O\'tkazib yuborish';

  @override
  String get onboardingStart => 'Boshlash';

  @override
  String get onboardingMeasureTitle => 'Xonangizni o\'lchang';

  @override
  String get onboardingMeasureBody =>
      'Telefon kamerasi yoki LiDAR yordamida xonangiz o\'lchamlarini aniq oling.';

  @override
  String get onboardingDeltaTitle => 'Hozirgi holatdan boshlaymiz';

  @override
  String get onboardingDeltaBody =>
      'Xonangizda allaqachon bor narsalar uchun to\'lamaysiz — faqat kerakli qismini hisoblaymiz.';

  @override
  String get onboardingDeltaCurrent => 'Hozirgi';

  @override
  String get onboardingDeltaPill => 'faqat FARQ hisoblanadi';

  @override
  String get onboardingDecorateTitle => '3D\'da bezang';

  @override
  String get onboardingDecorateBody =>
      'Materiallarni to\'g\'ridan-to\'g\'ri xonaning 3D ko\'rinishiga sudrab, natijani darhol ko\'ring.';

  @override
  String get onboardingPriceTitle => 'Narxni ko\'ring, materialni oling';

  @override
  String get onboardingPriceBody =>
      'Aniq smeta oling va kerakli materiallarni to\'g\'ridan-to\'g\'ri ilovadan xarid qiling.';

  @override
  String get onboardingPriceSaved => 'Tejaldingiz 4.2 mln';

  @override
  String get onboardingDemoTitle => 'Demo qo\'llanma';

  @override
  String get onboardingDemoStep1 =>
      'Xona qo\'shish — LiDAR, 360° yoki qo\'lda o\'lchash';

  @override
  String get onboardingDemoStep2 => 'Xonaning hozirgi holatini tanlash';

  @override
  String get onboardingDemoStep3 => 'Rail bilan devor, pol va mebelni bezash';

  @override
  String get onboardingDemoStep4 =>
      'Elektr va santexnikani oxirida rejalashtirish';

  @override
  String get onboardingDemoStep5 =>
      'Smetani ko\'rish va materiallarni sotib olish';

  @override
  String get onboardingDemoWatchVideo => 'Videoni ko\'rish';

  @override
  String get onboardingDemoTryMyself => 'O\'zim sinab ko\'raman';

  @override
  String get commonBackTo3d => '3D\'ga qaytish';

  @override
  String get designSurfaceFloorHeading => 'Pol';

  @override
  String get designSurfaceCeilingHeading => 'Shift';

  @override
  String get designFloorRaw => 'Xom beton';

  @override
  String get designFloorPlastered => 'Styajka';

  @override
  String get designFloorPuttied => 'Qoplama bor';

  @override
  String get designCeilingRaw => 'Xom';

  @override
  String get designCeilingPlastered => 'Suvoq';

  @override
  String get designCeilingPuttied => 'Tayyor';

  @override
  String designRoomEntryIntro(String condition) {
    return 'Xonangiz shu holatda — $condition. Endi bosqichma-bosqich bezaymiz.';
  }

  @override
  String get designToastShpaklovkaAdded => '✓ Shpaklovka qo\'shildi';

  @override
  String get designStageBoyoqOboi => 'Bo\'yoq/Oboi bosqichi';

  @override
  String get designRailTabBoyoq => 'Bo\'yoq';

  @override
  String get designDragHint => 'Materialni barmog\'ingiz bilan devorga sudrang';

  @override
  String get designNextStage => 'Keyingi bosqich →';

  @override
  String get interiorToastFloorApplied => '✓ Polga qo\'llanildi';

  @override
  String get interiorStagePol => 'Pol bosqichi';

  @override
  String get interiorRailTabKafel => 'Kafel';

  @override
  String get interiorRailTabLaminat => 'Laminat';

  @override
  String get interiorRailTabParket => 'Parket';

  @override
  String get interiorRailTabBeton => 'Beton';

  @override
  String get interiorStageMebel => 'Mebel bosqichi';

  @override
  String get interiorRailTabMehmonxona => 'Mehmonxona';

  @override
  String get interiorRailTabOshxona => 'Oshxona';

  @override
  String get interiorRailTabYotoqxona => 'Yotoqxona';

  @override
  String get interiorRailTabVanna => 'Vanna';

  @override
  String get interiorWalkthroughHint =>
      'Polda yurish mumkin — barmoq bilan suring';

  @override
  String get interiorGoToPlan => 'Rejaga o\'tish →';

  @override
  String get interiorDecorationComplete => 'Bezash yakunlandi';

  @override
  String get interiorGoToElectrical => 'Elektrga o\'tish →';

  @override
  String get interiorWallpaperAdded => '✓ Oboy kutubxonaga qo\'shildi';

  @override
  String interiorUploadFailed(String error) {
    return 'Yuklab bo\'lmadi: $error';
  }

  @override
  String get interiorWallpaperLibrary => 'Oboy kutubxonasi';

  @override
  String get interiorUploading => 'Yuklanmoqda…';

  @override
  String get interiorUploadImage => 'Rasm yuklash';

  @override
  String get interiorNoWallpapers =>
      'Hali oboy yo\'q — birinchi bo\'lib rasm yuklang';

  @override
  String get electricalWireRouting => 'Sim yo\'nalishi';

  @override
  String get electricalView2d => '2D reja';

  @override
  String get electricalView3d => '3D';

  @override
  String get electricalViewBoth => 'Ikkalasi';

  @override
  String get electricalRecomputeRoute => 'Trassani qayta hisoblash';

  @override
  String get electricalNext => 'Keyingi →';

  @override
  String get electricalResult => 'Elektr natijasi';

  @override
  String get electricalFinish => 'Yakunlash →';

  @override
  String get electricalProjectReady => 'Loyihangiz tayyor';

  @override
  String get electricalViewEstimate => 'Smetani ko\'rish →';

  @override
  String get estimateTitlePrefix => 'Remont smetasi';

  @override
  String get estimateDefaultRoomName => 'Mehmonxona';

  @override
  String estimatePdfFailed(String error) {
    return 'PDF yuklab bo\'lmadi: $error';
  }

  @override
  String get estimateSomeWork => 'Ba\'zi ishlar';

  @override
  String get estimateStageFallback => 'Bosqich';

  @override
  String get estimateAdjust => 'Smeta sozlash';

  @override
  String get estimateApproxTotal => 'Taxminiy umumiy narx';

  @override
  String get estimateLabor => 'Ishchi kuchi';

  @override
  String estimateSavingsBanner(String label, String amount) {
    return '$label allaqachon bor edi — $amount tejaldingiz';
  }

  @override
  String get estimateExcludedNote => 'sizda mavjud — hisoblanmadi';

  @override
  String get estimateZeroSom => '0 so\'m';

  @override
  String get estimatePreparingPdf => 'Tayyorlanmoqda…';

  @override
  String get estimateBuyFromShops => 'Do\'konlardan xarid qilish';

  @override
  String get estimateSendToMaster => 'Ustaga yuborish';

  @override
  String get estimateMaterialsTotal => 'Materiallar jami';

  @override
  String get estimateStageTotal => 'Bosqich jami';

  @override
  String get estimateAddMaterialsToCart => 'Materiallarni savatga';

  @override
  String get estimateQualityLevel => 'Sifat darajasi';

  @override
  String get estimateExcludeLabor => 'Ishchi kuchini qo\'shmaslik';

  @override
  String get estimateDiySubtitle =>
      'O\'zim bajaraman — faqat materiallar hisoblanadi';

  @override
  String estimateDeltaSavings(String stage) {
    return 'Delta tejash ($stage)';
  }

  @override
  String get estimateNewTotal => 'Yangi jami';

  @override
  String get estimateSaveEstimate => 'Smetani saqlash';

  @override
  String get studioAiDesigner => 'AI dizayner';

  @override
  String get studioAiApplied => '✓ AI o\'zgarishlari qo\'llanildi';

  @override
  String studioApplyFailed(String error) {
    return 'Qo\'llab bo\'lmadi: $error';
  }

  @override
  String get studioAiHint =>
      'Masalan: \"Devorlarni iliq bej rangga bo\'ya va divan qo\'sh\"';

  @override
  String get studioGenerating => 'Ishlanmoqda…';

  @override
  String get studioGenerate => 'Yaratish';

  @override
  String studioActionLabel(String name) {
    return 'Amal: $name';
  }

  @override
  String studioDoneLabel(String name) {
    return 'Bajarildi: $name';
  }

  @override
  String studioAiNoResponse(String message) {
    return 'AI hozircha javob berolmadi.\n$message';
  }

  @override
  String studioChangeCeiling(String height) {
    return 'Shift balandligi: $height m';
  }

  @override
  String studioChangeSurfaces(int count) {
    return '$count ta yuza materiali';
  }

  @override
  String studioChangeWalls(int count) {
    return '$count ta devor o\'lchami';
  }

  @override
  String studioChangeFurniture(int count) {
    return '$count ta mebel';
  }

  @override
  String studioChangeLights(int count) {
    return '$count ta chiroq';
  }

  @override
  String get studioApply => 'Qo\'llash';

  @override
  String get studioLoginRequired => 'Studio ochish uchun tizimga kiring.';

  @override
  String studioLoadFailed(String error) {
    return 'Studio yuklanmadi: $error';
  }

  @override
  String get actionAdd => 'Qo\'shish';

  @override
  String get actionPrev => 'Ortga';

  @override
  String get actionOk => 'OK';

  @override
  String get actionCancelShort => 'Bekor';

  @override
  String get roomDefaultName => 'Xona';

  @override
  String get ceilingHeightLabel => 'Shift balandligi';

  @override
  String get measureLength => 'Uzunlik';

  @override
  String get furnitureDelete => 'O\'chirish';

  @override
  String get furnitureRotate => 'Aylantirish';

  @override
  String get electricalTotalsTitle => 'Elektr hisoblandi';

  @override
  String get electricalTotalsWireLabel => 'jami sim';

  @override
  String get electricalTotalsDeviceLabel => 'ta qurilma';

  @override
  String electricalTotalsSocketWires(String meters) {
    return 'Rozetka simlari $meters m';
  }

  @override
  String electricalTotalsSwitchWires(String meters) {
    return 'Kalit simlari $meters m';
  }

  @override
  String electricalTotalsSwitchLightSummary(int switches, int lights) {
    return '$switches kalit · $lights yoritish';
  }

  @override
  String get electricalTotalsColDevice => 'Qurilma';

  @override
  String get electricalTotalsColWall => 'Devor';

  @override
  String get electricalTotalsColHeight => 'Balandlik';

  @override
  String get dimensionsTitle => 'Xona o\'lchamlari';

  @override
  String get dimensionsTabManual => 'Qo\'lda kiritish';

  @override
  String get dimensionsTabUpload => 'Plan yuklash';

  @override
  String dimensionsTotalSummary(int count, String area) {
    return 'Jami: $count xona · $area m²';
  }

  @override
  String get dimensionsNextMeasure => 'Keyingi: devorlarni o\'lchash';

  @override
  String get dimensionsConvert3d => '3D ga aylantirish';

  @override
  String get dimensionsAddRoom => '+ Xona qo\'shish';

  @override
  String dimensionsRoomDefaultName(int number) {
    return 'Xona $number';
  }

  @override
  String get dimensionsRoomNameLabel => 'Xona nomi';

  @override
  String get dimensionsLengthLabel => 'Uzunlik (m)';

  @override
  String get dimensionsWidthLabel => 'Kenglik (m)';

  @override
  String get dimensionsHeightLabel => 'Balandlik (m)';

  @override
  String get dimensionsUploadTitle => 'Floorplan rasmini yuklang';

  @override
  String get dimensionsUploadHint =>
      'PNG yoki JPG · maksimal 10 MB\nYoki bu yerga sudrab tashlang';

  @override
  String get dimensionsChooseFile => 'Fayl tanlash';

  @override
  String get dimensionsUploadNote =>
      'Aniq natija uchun o\'lchamlar ko\'rsatilgan plan yuklang';

  @override
  String get openingAddTitle => 'Eshik/Deraza qo\'shish';

  @override
  String get openingAddSpaced => 'Eshik / Deraza qo\'shish';

  @override
  String get openingTypeDoor => 'Eshik';

  @override
  String get openingTypeWindow => 'Deraza';

  @override
  String get openingTypeBalcony => 'Balkon eshigi';

  @override
  String get openingSizeLabel => 'O\'lcham (sm)';

  @override
  String get openingSizeOther => 'Boshqa o\'lcham…';

  @override
  String get openingPositionLabel => 'Devor bo\'ylab joylashuvi';

  @override
  String get openingAddToWall => 'Devorga qo\'shish';

  @override
  String get newProjectTitle => 'Yangi loyiha';

  @override
  String get newProjectSubtitle => 'Xonani qanday qo\'shmoqchisiz?';

  @override
  String get newProjectWizardTitle => '3D Sehrgar';

  @override
  String get newProjectWizardDesc =>
      'Interaktiv 3D ko\'rinishda xona o\'lchamlarini kiriting';

  @override
  String get newProjectLidarTitle => 'LiDAR skaner';

  @override
  String get newProjectLidarDesc =>
      'Xonani LiDAR yordamida skanerlang va avtomatik 3D model oling';

  @override
  String get newProjectPhotoTitle => '360° Foto skan';

  @override
  String get newProjectPhotoDesc =>
      'Xonani 360° rasmga oling — ilova nuqtalarni o\'zi belgilaydi';

  @override
  String get newProjectDrawTitle => 'O\'zingiz chizing';

  @override
  String get newProjectDrawDesc =>
      'Xonani barmog\'ingiz bilan chizing — o\'lchamlar chizganingizga qarab o\'zi hisoblanadi';

  @override
  String get summarySavedTitle => 'O\'lchamlar saqlandi!';

  @override
  String get summaryStatFloor => 'pol';

  @override
  String get summaryStatWallNet => 'devor (netto)';

  @override
  String get summaryStatPerimeter => 'perimetr';

  @override
  String get summaryStatOpenings => 'eshik/deraza';

  @override
  String summaryOpeningsCount(int count) {
    return '$count ta';
  }

  @override
  String get summaryOpeningsNote =>
      'Eshik/derazalar avtomatik ayirilgan (netto)';

  @override
  String get summaryAddRoom => '+ Yangi xona qo\'shish';

  @override
  String get wizardTitle => 'Yangi xona';

  @override
  String get wizardCeilingQuestion => 'Shiftning balandligi?';

  @override
  String get wizardCeilingHint => 'Odatda 2.5–3.2 metr oralig\'ida';

  @override
  String get wizardExactValue => 'Aniq qiymat (m)';

  @override
  String wizardWallTitle(String letter) {
    return '$letter devor';
  }

  @override
  String get wizardWallSubtitle => 'Uzunligini kiriting';

  @override
  String get wizardSummarySubtitle =>
      'Xona parametrlari muvaffaqiyatli qayd etildi';

  @override
  String get wizardStatFloor => 'POL MAYDONI';

  @override
  String get wizardStatWallNet => 'DEVOR MAYDONI (NETTO)';

  @override
  String get wizardStatPerimeter => 'PERIMETR';

  @override
  String get wizardStatOpenings => 'ESHIK/DERAZALAR';

  @override
  String get wizardViewSmeta => 'Smeta ko\'rish';

  @override
  String get wizardOpening => 'Ochilmoqda…';

  @override
  String get wizardStartDesign => 'Bezashni boshlash';

  @override
  String get measureOpenings => 'Eshik / derazalar';

  @override
  String measureFromLeft(String offset) {
    return 'Chapdan $offset m';
  }

  @override
  String get lidarScanning => 'Skanerlanyapti...';

  @override
  String get lidarMoveHint => 'Telefonni sekin harakatlantiring';

  @override
  String get lidarLabelWall => 'devor';

  @override
  String get lidarLabelDoor => 'eshik';

  @override
  String get lidarLabelWindow => 'deraza';

  @override
  String photoPointsCount(int captured, int total) {
    return '$captured/$total nuqta';
  }

  @override
  String get photoTurnHint => 'Telefonni keyingi nuqtaga burang';

  @override
  String get photoCapture => 'Suratga olish';

  @override
  String get scanReviewTitle => 'Skan natijasi';

  @override
  String scanReviewDetected(String value) {
    return 'Aniqlangan: $value';
  }

  @override
  String scanReviewWalls(int count) {
    return 'Devorlar ($count)';
  }

  @override
  String scanReviewWall(int number) {
    return 'Devor $number';
  }

  @override
  String scanReviewObjects(int count) {
    return 'Topilgan buyumlar ($count)';
  }

  @override
  String get scanReviewNoObjects => 'Buyum topilmadi';

  @override
  String get scanReviewRescan => 'Qayta skanerlash';

  @override
  String get scanReviewSaveFailed =>
      'Xonani saqlab bo\'lmadi. Internetni tekshiring.';

  @override
  String scanReviewError(String error) {
    return 'Xatolik: $error';
  }

  @override
  String get scanBusy => 'Skaner allaqachon ishlayapti.';

  @override
  String get scanFailedRetry => 'Skanerlashda xatolik. Qayta urinib ko\'ring.';

  @override
  String scanErrorPrefixed(String message) {
    return 'Xatolik: $message';
  }

  @override
  String get scanNotDetected => 'Xona aniqlanmadi. Qayta urinib ko\'ring.';

  @override
  String get scanLidarUnavailableTitle => 'LiDAR mavjud emas';

  @override
  String get scanLidarUnavailableBody =>
      'LiDAR skaner faqat iPhone 12 Pro, 13 Pro, 14 Pro, 15 Pro, 16 Pro yoki iPad Pro\'da ishlaydi. Xonani boshqa usulda qo\'shing:';

  @override
  String get scanInProgress => 'Xona skanerlanmoqda…';

  @override
  String get drawTitle => 'Xonani chizing';

  @override
  String get drawModeManual => 'Qo\'lda';

  @override
  String get drawModeVisual => 'Vizual';

  @override
  String get drawHintRaw =>
      'Xom chizma. \"Toza\"ga qaytish uchun tugmani bosing.';

  @override
  String get drawHintShapeReady =>
      'Shakl tayyor! Burchaklarni surib o\'lchamni o\'zgartiring.';

  @override
  String get drawHintFreehand => 'Xona shaklini barmog\'ingiz bilan chizing.';

  @override
  String get drawHintMarkCorners =>
      'Xona burchaklarini belgilang (kamida 3 ta).';

  @override
  String drawHintMorePoints(int count) {
    return 'Yana $count ta nuqta qo\'ying.';
  }

  @override
  String get drawHintClose =>
      'Yopish uchun birinchi nuqtaga bosing yoki \"Yopish\".';

  @override
  String get drawToggleClean => 'Toza';

  @override
  String get drawToggleRaw => 'Xom';

  @override
  String get drawRedo => 'Oldinga';

  @override
  String get drawClear => 'Tozalash';

  @override
  String get drawWallLength => 'Devor uzunligi';

  @override
  String get drawAreaWarning => 'Diqqat: yuza odatiy oraliqdan tashqarida';

  @override
  String drawTitleRect(String width, String length, String height) {
    return 'Xona: $width × $length × $height m';
  }

  @override
  String drawTitlePolygon(int corners, String width, String length) {
    return 'Ko\'pburchak · $corners devor · $width×$length m';
  }
}
