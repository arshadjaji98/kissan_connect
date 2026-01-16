// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Urdu (`ur`).
class AppLocalizationsUr extends AppLocalizations {
  AppLocalizationsUr([String locale = 'ur']) : super(locale);

  @override
  String get selectLanguage => 'زبان منتخب کریں';

  @override
  String get choosePreferredLanguage => 'اپنی پسندیدہ زبان منتخب کریں';

  @override
  String languageChangedTo(Object language) {
    return 'زبان تبدیل ہو گئی: $language';
  }

  @override
  String get english => 'انگریزی';

  @override
  String get urdu => 'اردو';

  @override
  String get cancel => 'منسوخ کریں';

  @override
  String get save => 'محفوظ کریں';

  @override
  String get welcome => 'خوش آمدید';

  @override
  String get sign_up => 'سائن اپ کریں';

  @override
  String get login => 'لاگ ان';

  @override
  String get full_name => 'پورا نام';

  @override
  String get email => 'ای میل';

  @override
  String get password => 'پاس ورڈ';

  @override
  String get confirm_password => 'پاس ورڈ کی تصدیق کریں';

  @override
  String get farm_location => 'آپ کے فارم کا مقام';

  @override
  String get farm_land_area => 'فارم کی زمین کا رقبہ';

  @override
  String get select_crops => 'اپنے اگائے گئے فصلیں منتخب کریں';

  @override
  String get already_have_account => 'کیا آپ کے پاس پہلے سے اکاؤنٹ ہے؟ لاگ ان کریں';

  @override
  String get signup_success_message => 'سائن اپ کامیاب! ہوم اسکرین پر منتقل ہو رہا ہے...';

  @override
  String get email_already_in_use_code => 'یہ ای میل پہلے سے استعمال میں ہے';

  @override
  String get email_already_in_use_message => 'یہ ای میل پہلے سے رجسٹرڈ ہے۔ براہ کرم کوئی دوسرا ای میل استعمال کریں یا لاگ ان کریں۔';

  @override
  String get invalid_email_code => 'غلط ای میل';

  @override
  String get invalid_email_message => 'براہ کرم درست ای میل پتہ درج کریں۔';

  @override
  String get weak_password_message => 'پاس ورڈ بہت کمزور ہے۔ براہ کرم کم از کم 8 حروف استعمال کریں۔';

  @override
  String get operation_not_allowed_code => 'یہ عمل اجازت یافتہ نہیں';

  @override
  String get operation_not_allowed_message => 'ای میل/پاس ورڈ اکاؤنٹس فعال نہیں ہیں۔ براہ کرم سپورٹ سے رابطہ کریں۔';

  @override
  String get network_request_failed_code => 'انٹرنیٹ کنکشن میں مسئلہ';

  @override
  String get network_error_message => 'نیٹ ورک کی خرابی۔ براہ کرم اپنے انٹرنیٹ کنکشن کو چیک کریں۔';

  @override
  String get signup_error_message => 'سائن اپ کے دوران ایک خرابی پیش آئی:';

  @override
  String get unexpected_error_message => 'ایک غیر متوقع خرابی پیش آگئی۔ دوبارہ کوشش کریں۔';

  @override
  String get please_enter => 'براہ کرم درج کریں';

  @override
  String get required => 'ضروری';

  @override
  String get passwords_do_not_match => 'پاس ورڈ مماثل نہیں ہیں';

  @override
  String get minimum_8_characters => 'کم از کم 8 حروف';

  @override
  String get tagline => 'بہتر کاشتکاری کے لیے ہماری کمیونٹی میں شامل ہوں';

  @override
  String get area => 'رقبہ';

  @override
  String get selectMultipleCrops => 'آپ ایک سے زیادہ فصلیں منتخب کر سکتے ہیں';

  @override
  String get sugarcane => 'گنا';

  @override
  String get maize => 'مکئی';

  @override
  String get vegetables => 'سبزیاں';

  @override
  String get welcome_back => 'واپسی پر خوش آمدید';

  @override
  String get signin_continue => 'کسان کنیکٹ میں داخل ہونے کے لیے سائن ان کریں';

  @override
  String get enter_email => 'اپنا ای میل درج کریں';

  @override
  String get please_enter_email => 'براہ کرم اپنا ای میل درج کریں';

  @override
  String get please_enter_valid_email => 'براہ کرم درست ای میل درج کریں';

  @override
  String get enter_password => 'اپنا پاس ورڈ درج کریں';

  @override
  String get please_enter_password => 'براہ کرم اپنا پاس ورڈ درج کریں';

  @override
  String get password_min_8 => 'پاس ورڈ کم از کم 8 حروف کا ہونا چاہیے';

  @override
  String get remember_me => 'مجھے یاد رکھیں';

  @override
  String get forgot_password => 'پاس ورڈ بھول گئے؟';

  @override
  String get log_in => 'لاگ ان';

  @override
  String get or_continue_with => 'یا اس کے ساتھ جاری رکھیں';

  @override
  String get dont_have_account => 'کیا آپ کے پاس اکاؤنٹ نہیں ہے؟';

  @override
  String get login_user_data_missing => 'لاگ ان کامیاب لیکن صارف کا ڈیٹا دستیاب نہیں۔ دوبارہ کوشش کریں۔';

  @override
  String get user_not_found_code => 'user-not-found';

  @override
  String get user_not_found_message => 'اس ای میل کے ساتھ کوئی اکاؤنٹ نہیں ملا۔';

  @override
  String get wrong_password_code => 'غلط پاس ورڈ';

  @override
  String get wrong_password_message => 'غلط پاس ورڈ۔ دوبارہ کوشش کریں۔';

  @override
  String get invalid_credential_code => 'غلط معلومات';

  @override
  String get invalid_credential_message => 'غلط ای میل یا پاس ورڈ۔';

  @override
  String get user_disabled_code => 'اکاؤنٹ بند کر دیا گیا ہے';

  @override
  String get user_disabled_message => 'یہ اکاؤنٹ غیر فعال ہے۔';

  @override
  String get too_many_requests_code => 'بہت زیادہ درخواستیں بھیج دی گئی ہیں';

  @override
  String get too_many_requests_message => 'لاگ ان کی کوششیں بہت زیادہ ہیں۔ بعد میں دوبارہ کوشش کریں۔';

  @override
  String get login_failed => 'لاگ ان ناکام:';

  @override
  String get login_error => 'لاگ ان میں خرابی:';

  @override
  String get unexpected_error => 'ایک غیر متوقع خرابی پیش آگئی۔ دوبارہ کوشش کریں۔';

  @override
  String get name => 'نام';

  @override
  String get display_name => 'ڈسپلے نام';

  @override
  String get farmer => 'کسان';

  @override
  String get location => 'مقام';

  @override
  String get user_not_logined_in => 'صارف لاگ ان نہیں ہے۔';

  @override
  String get error_fetching_user_location => 'صارف کا مقام حاصل کرنے میں خرابی:';

  @override
  String get error_fetching_weather => 'موسم کا ڈیٹا حاصل کرنے میں خرابی:';

  @override
  String get unable_to_fetch_weather_data_please_check_internet => 'موسم کا ڈیٹا حاصل نہیں ہو سکا۔ براہ کرم انٹرنیٹ کنکشن چیک کریں۔';

  @override
  String get failed_to_load_weather_data => 'موسم کا ڈیٹا لوڈ کرنے میں ناکامی۔';

  @override
  String get address => 'پتہ';

  @override
  String get your_location => 'آپ کا مقام';

  @override
  String get selected_crops => 'منتخب فصلیں';

  @override
  String get crops => 'فصلیں';

  @override
  String get primary_crop => 'اہم فصل';

  @override
  String get error_fetching_user_data => 'صارف کا ڈیٹا لانے میں خرابی:';

  @override
  String get error_creating_default_user => 'ڈیفالٹ صارف دستاویز بنانے میں خرابی:';

  @override
  String get reset_password => 'پاس ورڈ ری سیٹ کریں';

  @override
  String get enter_email_first => 'براہ کرم پہلے اپنا ای میل درج کریں۔';

  @override
  String get ok => 'ٹھیک ہے';

  @override
  String get password_reset_sent_title => 'پاس ورڈ ری سیٹ ای میل بھیجی گئی';

  @override
  String get password_reset_sent_message => 'ایک پاس ورڈ ری سیٹ لنک ای میل پر بھیجا گیا ہے۔ براہ کرم ان باکس چیک کریں۔';

  @override
  String get error => 'خرابی';

  @override
  String get password_reset_failed => 'ری سیٹ ای میل بھیجنے میں ناکامی۔ براہ کرم ای میل چیک کریں اور دوبارہ کوشش کریں۔';

  @override
  String password_sent_to_email(Object email) {
    return 'ایک پاس ورڈ ای میل پر بھیجا گیا ہے، براہ کرم ان باکس چیک کریں۔';
  }

  @override
  String get app_name => 'کسان کنیکٹ';

  @override
  String get weather_data_unavailable => 'موسم کا ڈیٹا دستیاب نہیں';

  @override
  String get retry => 'دوبارہ کوشش کریں';

  @override
  String get approximate => 'تقریبی';

  @override
  String get feels_like => 'محسوس ہوتا ہے';

  @override
  String get clear => 'صاف';

  @override
  String get partlyCloudy => 'جزوی طور پر ابرا ہوا';

  @override
  String get cloudy => 'ابر آلود';

  @override
  String get fog => 'دھند';

  @override
  String get drizzle => 'باریک بارش';

  @override
  String get rain => 'بارش';

  @override
  String get snow => 'برف';

  @override
  String get thunderstorm => 'گرج چمک کا طوفان';

  @override
  String get clearSky => 'صاف آسمان';

  @override
  String get mainlyClear => 'زیادہ تر صاف';

  @override
  String get overcast => 'ابر آلود';

  @override
  String get depositingRimeFog => 'جمنے والی دھند';

  @override
  String get lightDrizzle => 'ہلکی بارش';

  @override
  String get moderateDrizzle => 'معتدل بارش';

  @override
  String get denseDrizzle => 'کثیف بارش';

  @override
  String get slightRain => 'ہلکی بارش';

  @override
  String get moderateRain => 'معتدل بارش';

  @override
  String get heavyRain => 'شدید بارش';

  @override
  String get slightSnow => 'ہلکی برفباری';

  @override
  String get moderateSnow => 'معتدل برفباری';

  @override
  String get heavySnow => 'شدید برفباری';

  @override
  String get thunderstormWithHail => 'گرج چمک کے ساتھ اولے';

  @override
  String get mist => 'دھند';

  @override
  String get smoke => 'دھواں';

  @override
  String get haze => 'کہر';

  @override
  String get dust => 'گرد و غبار';

  @override
  String get foggy => 'دھندلا';

  @override
  String get weather_data_error => 'موسم کے ڈیٹا میں خرابی';

  @override
  String get recommendations_for => ' کی سفارشات ';

  @override
  String get tap_to_change => 'تبدیل کرنے کے لیے ٹیپ کریں';

  @override
  String get you_grow => 'آپ اگاتے ہیں';

  @override
  String get high_alert => 'اعلی انتباہ';

  @override
  String get moderate_alert => 'درمیانہ انتباہ';

  @override
  String get is_high_risk => 'اعلی خطرہ ہے';

  @override
  String get high_risk => 'زیادہ خطرہ!';

  @override
  String get low_risk => 'کم خطرہ';

  @override
  String get moderate_risk => 'درمیانہ خطرہ';

  @override
  String get standard_application_needed => 'معیاری استعمال درکار ہے';

  @override
  String get no_adjustment_needed => 'کسی تبدیلی کی ضرورت نہیں';

  @override
  String get vegetative => 'سبزیاتی مرحلہ';

  @override
  String get flowering => 'پھول آنے کا مرحلہ';

  @override
  String get fruiting => 'پھل لگنے کا مرحلہ';

  @override
  String get tillering => 'شاخیں نکلنے کا مرحلہ';

  @override
  String get silking => 'ریشہ نکلنے کا مرحلہ';

  @override
  String get jointing => 'گانٹھ بننے کا مرحلہ';

  @override
  String get reduced_due_to_high_temperature => 'Reduced due to high temperature';

  @override
  String get slightly_increased_due_to_optimal_temp => 'اچھی درجہ حرارت کی وجہ سے تھوڑا اضافہ ہو رہا ہے';

  @override
  String get increased_due_to_favorable_conditions => 'پسندیدہ شرائط کی وجہ سے اضافہ ہو رہا ہے';

  @override
  String get increased_before_expected_rain => 'متوقع بارش سے پہلے اضافہ ہو رہا ہے';

  @override
  String get weather_conditions_favorable => 'موسم کے حالات کیڑوں کی سرگرمی کے لیے سازگار ہیں۔';

  @override
  String get pest_attack_prediction => 'کیڑے کے حملے کی پیش گوئی';

  @override
  String get pest_prevention_guide => 'کیڑوں سے بچاؤ کا رہنما';

  @override
  String get no_message_available => 'کوئی پیغام دستیاب نہیں';

  @override
  String get aphids => 'مہو';

  @override
  String get army_worm => 'آرمی کیڑا';

  @override
  String get rust_fungus => 'زنگ کی بیماری';

  @override
  String get hessian_fly => 'ہیسیئن مکھی';

  @override
  String get bollworm => 'بال ورم';

  @override
  String get whitefly => 'سفید مکھی';

  @override
  String get spider_mites => 'سرخ مکڑی';

  @override
  String get min => 'کم از کم';

  @override
  String get max => 'زیادہ سے زیادہ';

  @override
  String get various_pests => 'مختلف کیڑے';

  @override
  String get stem_borer => 'تنے کا کیڑا';

  @override
  String get leaf_folder => 'پتے لپیٹنے والا کیڑا';

  @override
  String get blast_fungus => 'بلاسٹ بیماری';

  @override
  String get brown_plant_hopper => 'بھورا پلانٹ ہوپر';

  @override
  String get corn_borer => 'مکئی کا تنے والا کیڑا';

  @override
  String get armyworm => 'آرمی کیڑا';

  @override
  String get earworm => 'بھٹے کا کیڑا';

  @override
  String get corn_leaf_aphid => 'مکئی کے پتے کی مہو';

  @override
  String warm_weather_increases_nutrients(Object crop) {
    return 'گرم موسم $crop کے لیے غذائی اجزاء کی دستیابی بڑھاتا ہے';
  }

  @override
  String cold_weather_slows_growth(Object crop) {
    return 'سرد درجہ حرارت $crop کی نشوونما اور غذائی اجزاء کے جذب کو سست کر دیتا ہے';
  }

  @override
  String optimal_temp_for_fertilizer(Object crop) {
    return '$crop کے لیے کھاد ڈالنے کا موزوں درجہ حرارت';
  }

  @override
  String adjustment_increased_for_rain(Object adjustment) {
    return '$adjustment، بارش کی وجہ سے اضافہ کیا گیا';
  }

  @override
  String rain_helps_nutrient_absorption(Object crop, Object reason) {
    return '$reason۔ بارش $crop کو غذائی اجزاء بہتر طریقے سے جذب کرنے میں مدد دے گی';
  }

  @override
  String adjustment_reduced_for_dryness(Object adjustment) {
    return '$adjustment، خشکی کی وجہ سے کم کیا گیا';
  }

  @override
  String dryness_requires_irrigation(Object crop, Object reason) {
    return '$reason۔ $crop کو کھاد کے بعد آبپاشی کی ضرورت ہو سکتی ہے';
  }

  @override
  String reason_with_growth_stage(Object growthStage, Object reason) {
    return '$reason۔ موجودہ نشوونما کا مرحلہ: $growthStage';
  }

  @override
  String get current_growth_rate => 'موجودہ نمو کی شرح:';

  @override
  String get temperature_optimal_for => 'درجہ حرارت مثالی ہے';

  @override
  String natural_rainfall_sufficient_two(Object crop) {
    return 'قدرتی بارش $crop کے لیے کافی نمی فراہم کرے گی';
  }

  @override
  String storm_adequate_rainfall_two(Object crop) {
    return '$crop کے لیے طوفانی بارش کافی ہوگی، پانی کھڑا ہونے سے بچائیں';
  }

  @override
  String high_evaporation_requires_more_water(Object crop, Object evap) {
    return 'زیادہ بخارات کی شرح ($evap ملی میٹر فی دن) $crop کے لیے زیادہ بار آبپاشی کی ضرورت ہے';
  }

  @override
  String dry_warm_requires_careful_irrigation(Object crop) {
    return 'خشک اور گرم حالات میں $crop کے لیے محتاط آبپاشی ضروری ہے';
  }

  @override
  String moderate_conditions_regular_irrigation_two(Object crop, Object stage) {
    return 'درمیانی حالات میں $crop کے لیے باقاعدہ آبپاشی برقرار رکھیں ($stage مرحلہ)';
  }

  @override
  String get high_risk_pests => '🚨 اعلی خطرے کے کیڑے:';

  @override
  String get temperature_extremes => 'درجۂ حرارت کے انتھائی حالات کیڑوں کی سرگرمی کو کم کر سکتے ہیں';

  @override
  String get rain_reduction => 'بارش کچھ کیڑوں کی آبادی کو کم کر سکتی ہے';

  @override
  String get sunny_conditions_favor_pest_development => 'دھوپ والا موسم کیڑوں کی افزائش کے لیے موزوں ہوتا ہے';

  @override
  String get varies_with_conditions => 'شرائط کے مطابق مختلف ہوتا ہے';

  @override
  String get moderate_risk_pests => '⚠️ درمیانے خطرے کے کیڑے:';

  @override
  String get aphids_description => 'چھوٹے رسیلے کیڑے جو پتیوں کو زرد اور گھماؤ پیدا کرتے ہیں۔';

  @override
  String get aphids_active_season => 'بہار اور گرمی';

  @override
  String get army_worm_description => 'کیڑے جو پتوں کو کھاتے ہیں اور پوری فصل کو نقصان پہنچا سکتے ہیں۔';

  @override
  String get army_worm_active_season => 'گرمی اور مانسون';

  @override
  String get bollworm_description => 'لارو جو کپاس کے پھولوں میں سوراخ کرتے ہیں، نمایاں نقصان پہنچاتے ہیں۔';

  @override
  String get bollworm_active_season => 'پھولنے کا موسم';

  @override
  String get stem_borer_description => 'لارو جو تنے میں سرایت کرتے ہیں، پودے مرجھا سکتے ہیں۔';

  @override
  String get stem_borer_active_season => 'پورے اگانے کے موسم میں';

  @override
  String get whitefly_description => 'چھوٹے سفید کیڑے جو رسی نکالتے ہیں اور وائرل بیماریاں منتقل کرتے ہیں۔';

  @override
  String get whitefly_active_season => 'گرم اور خشک حالات';

  @override
  String get rust_fungus_description => 'پتیوں اور تنوں پر زنگ نما دھبے پیدا کرنے والا فنگس۔';

  @override
  String get rust_fungus_active_season => 'ٹھنڈی، مرطوب حالات';

  @override
  String get hessian_fly_description => 'چھوٹی مکھیوں کے لارو جو گندم کے تنوں کو کھاتے ہیں اور نشوونما روک دیتے ہیں۔';

  @override
  String get hessian_fly_active_season => 'خزاں اور بہار';

  @override
  String get spider_mites_description => 'چھوٹے مکڑی نما کیڑے جو پودوں کا رس چوستے ہیں اور زرد دھبے پیدا کرتے ہیں۔';

  @override
  String get spider_mites_active_season => 'گرم، خشک موسم';

  @override
  String get leaf_folder_description => 'لارو جو چاول کے پتوں کو موڑ کر اندر سے کھاتے ہیں، فوٹو سنتھیس کم ہو جاتی ہے۔';

  @override
  String get leaf_folder_active_season => 'گیلا موسم';

  @override
  String get blast_fungus_description => 'پتیوں، گلوں اور دانوں پر زخم پیدا کرنے والا فنگس۔';

  @override
  String get blast_fungus_active_season => 'زیادہ نمی والے حالات';

  @override
  String get humidity => 'نمی';

  @override
  String get wind => 'ہوا';

  @override
  String get high_temperature_alert => 'زیادہ درجہ حرارت کا انتباہ';

  @override
  String get hourly_forecast_not_availale => 'گھنٹہ وار موسم کی پیش گوئی دستیاب نہیں';

  @override
  String get now => 'ابھی';

  @override
  String get seven_day_forecast_not_available => '7 دن کی موسم کی پیش گوئی دستیاب نہیں';

  @override
  String get weather_forecast => 'موسم کی پیش گوئی';

  @override
  String get todays_forecast => 'آج کا موسم';

  @override
  String get seven_days_forecast => '7 دن کا موسم';

  @override
  String get sun => 'اتوار';

  @override
  String get mon => 'پیر';

  @override
  String get tue => 'منگل';

  @override
  String get wed => 'بدھ';

  @override
  String get thu => 'جمعرات';

  @override
  String get fri => 'جمعہ';

  @override
  String get sat => 'ہفتہ';

  @override
  String get am => 'صبح';

  @override
  String get pm => 'شام';

  @override
  String get brown_plant_hopper_description => 'رس چوسنے والے کیڑے جو ہاپر برن پیدا کرتے ہیں اور وائرس منتقل کرتے ہیں۔';

  @override
  String get brown_plant_hopper_active_season => 'گیلا موسم';

  @override
  String get corn_borer_description => 'لارو جو مکئی کے تنوں اور بھٹوں میں سوراخ کرتے ہیں اور پیداوار کم کرتے ہیں۔';

  @override
  String get corn_borer_active_season => 'گرمی کے مہینے';

  @override
  String get earworm_description => 'کیڑے جو مکئی کے بھٹوں کو کھاتے ہیں اور دانے خراب کرتے ہیں۔';

  @override
  String get earworm_active_season => 'ریشم نکلنے سے کٹائی تک';

  @override
  String get corn_leaf_aphid_description => 'ایفڈ جو پتوں اور بھٹوں پر جمع ہو جاتے ہیں اور پودے کی طاقت کم کرتے ہیں۔';

  @override
  String get corn_leaf_aphid_active_season => 'ٹھنڈا موسم';

  @override
  String get prevention_measures_title => 'حفاظتی اقدامات';

  @override
  String get wheat_prevention_1 => 'معیاری بیماری سے پاک بیج استعمال کریں';

  @override
  String get wheat_prevention_2 => 'دالوں کے ساتھ فصلوں کی گردش کریں';

  @override
  String get wheat_prevention_3 => 'ابتدائی پتہ لگانے کے لیے کھیتوں کا باقاعدہ معائنہ کریں';

  @override
  String get wheat_prevention_4 => 'نیم پر مبنی حیاتیاتی کیڑے مار ادویات استعمال کریں';

  @override
  String get wheat_prevention_5 => 'متاثرہ پودوں کو ہٹا کر تلف کریں';

  @override
  String get wheat_prevention_6 => 'ہوا کی بہتر گردش کے لیے مناسب فاصلہ رکھیں';

  @override
  String get cotton_prevention_1 => 'سفید مکھیوں کے لیے پیلے اسٹکی ٹریپس لگائیں';

  @override
  String get cotton_prevention_2 => 'بال ورمز کے لیے فیرومون ٹریپس استعمال کریں';

  @override
  String get cotton_prevention_3 => 'گلِ مہندی کے ساتھ مخلوط کاشت کریں';

  @override
  String get cotton_prevention_4 => 'پہلی علامت پر تجویز کردہ کیڑے مار دوا لگائیں';

  @override
  String get cotton_prevention_5 => 'کٹائی کے بعد فصل کی باقیات ہٹا دیں';

  @override
  String get cotton_prevention_6 => 'دستیاب ہونے پر مزاحم اقسام استعمال کریں';

  @override
  String get regular_field_monitoring => 'کھیت کی باقاعدہ نگرانی';

  @override
  String get use_organic_pesticides => 'قدرتی کیڑے مار ادویات استعمال کریں';

  @override
  String get practice_crop_rotation => 'فصلوں کی گردش کریں';

  @override
  String get maintain_field_hygiene => 'کھیت کی صفائی برقرار رکھیں';

  @override
  String get use_resistant_varieties => 'مضبوط اقسام استعمال کریں';

  @override
  String get consult_local_agriculature_expert => 'مقامی زراعت کے ماہر سے مشورہ کریں';

  @override
  String get rice_prevention_1 => 'کھیتوں میں پانی کی مناسب سطح برقرار رکھیں';

  @override
  String get rice_prevention_2 => 'نگرانی کے لیے لائٹ ٹریپس استعمال کریں';

  @override
  String get rice_prevention_3 => 'قدرتی دشمن جیسے مکڑیاں چھوڑیں';

  @override
  String get rice_prevention_4 => 'ٹیلرنگ مرحلے پر تجویز کردہ کیڑے مار دوا لگائیں';

  @override
  String get rice_prevention_5 => 'علاقے میں ہم وقتانہ بوائی کریں';

  @override
  String get rice_prevention_6 => 'کھیتوں کے ارد گرد جڑی بوٹیاں ہٹا دیں';

  @override
  String get corn_prevention_1 => 'کیڑوں کے عروج سے بچنے کے لیے جلد بوائی کریں';

  @override
  String get corn_prevention_2 => 'مزاحم ہائبرڈ اقسام استعمال کریں';

  @override
  String get corn_prevention_3 => 'کٹائی کے بعد گہری ہل چلائیں';

  @override
  String get corn_prevention_4 => 'بوائی کے وقت زمین میں کیڑے مار دوا استعمال کریں';

  @override
  String get corn_prevention_5 => 'پتوں پر انڈوں کے ڈھیروں کی نگرانی کریں';

  @override
  String get corn_prevention_6 => 'حیاتیاتی کنٹرول کے عوامل استعمال کریں';

  @override
  String get pest_activity_favorable => 'کیڑوں کی سرگرمی کے لیے موسم کے حالات سازگار ہیں۔';

  @override
  String get tap_for_prevention_guide => 'حفاظتی گائیڈ کے لیے ٹیپ کریں';

  @override
  String get fertilizer_guide_for => 'کھاد کی رہنمائی';

  @override
  String get tap_for_details => 'تفصیلات کے لیے ٹیپ کریں';

  @override
  String get optimal_irrigation_needed_for => 'ضروری مثالی آبپاشی';

  @override
  String get critical_growth_stage_guide => ' فصل حساس ترقی کے مرحلے میں ہے۔ رہنمائی کے لیے ٹیپ کریں۔';

  @override
  String get you => 'آپ کی';

  @override
  String get logout => 'لاگ آؤٹ';

  @override
  String get error_logout => 'لاگ آؤٹ میں خرابی:';

  @override
  String get home => 'ہوم';

  @override
  String get weather => 'موسم';

  @override
  String get crop_guide => 'فصل کی رہنمائی';

  @override
  String get marketplace => 'مارکیٹ پلیس';

  @override
  String get unknown => 'نامعلوم';

  @override
  String get crop => 'فصل';

  @override
  String get fertilizer_guide => 'کھاد کی رہنمائی';

  @override
  String get fertilizer_recommendation => 'کھاد کی سفارش';

  @override
  String get no_reason_provided => 'کوئی وجہ فراہم نہیں کی گئی';

  @override
  String get optimal_application_rate => 'مثالی لاگو کرنے کی شرح';

  @override
  String get adjustment => 'ترمیم';

  @override
  String get none => 'کوئی نہیں';

  @override
  String get nitrogen => 'نائٹروجن';

  @override
  String get phosphorus => 'فاسفورس';

  @override
  String get potassium => 'پوٹاشیم';

  @override
  String get micronutrients => 'خرد غذائی اجزاء';

  @override
  String get active_in => '🕒چل رہا ہے: ';

  @override
  String get application_guide => '📋 لگانے کی رہنمائی';

  @override
  String get general => 'عام';

  @override
  String get recommended_fertilizer_types => '🧪 تجویز کردہ کھاد کی اقسام';

  @override
  String get no_description_available => 'کوئی تفصیل دستیاب نہیں';

  @override
  String get various_seasons => 'مختلف موسم';

  @override
  String get best_application_timing => '⏰ بہترین لگانے کا وقت';

  @override
  String get irrigation_guide => 'آبپاشی کی رہنمائی';

  @override
  String get irrigation_recommendation => 'آبپاشی کی سفارش';

  @override
  String get delay_irrigation_rain_expected => 'آبپاشی مؤخر کریں - بارش متوقع ہے';

  @override
  String get natural_rainfall_sufficient => 'قدرتی بارش کافی نمی فراہم کرے گی';

  @override
  String get low => 'کم';

  @override
  String get delay_irrigation_heavy_rain => 'آبپاشی مؤخر کریں - شدید بارش متوقع';

  @override
  String get storm_adequate_rainfall => 'طوفان کافی بارش فراہم کرے گا، پانی کھڑا نہ ہونے دیں';

  @override
  String get increase_irrigation_frequency => 'آبپاشی کی تعدد بڑھائیں';

  @override
  String get high_evaporation_more_watering => 'زیادہ بخارات کی وجہ سے زیادہ پانی کی ضرورت';

  @override
  String get high => 'زیادہ';

  @override
  String get reduce_irrigation_frequency => 'آبپاشی کی تعدد کم کریں';

  @override
  String get low_evaporation_less_water => 'کم بخارات، کم پانی کی ضرورت';

  @override
  String get monitor_soil_moisture => 'مٹی کی نمی کا قریب سے معائنہ کریں';

  @override
  String get dry_warm_conditions => 'خشک، گرم حالات میں محتاط پانی کی دیکھ بھال ضروری';

  @override
  String get medium => 'درمیانہ';

  @override
  String get normal_irrigation_schedule => 'معمول کا آبپاشی شیڈول';

  @override
  String get moderate_conditions_regular_irrigation => 'درمیانی حالت - باقاعدہ آبپاشی برقرار رکھیں';

  @override
  String get wheat => 'گندم';

  @override
  String get apply_one_third_nitrogen_sowing => 'بوائی کے وقت نائٹروجن کا 1/3 لگائیں';

  @override
  String get apply_remaining_nitrogen_splits => 'بقیہ نائٹروجن دو حصوں میں ٹیلرنگ اور جوائنٹنگ کے دوران لگائیں';

  @override
  String get mix_fertilizers_thoroughly => 'کھاد کو اچھی طرح مکس کریں';

  @override
  String get apply_when_soil_moist => 'جب مٹی میں مناسب نمی ہو لگائیں';

  @override
  String get avoid_heavy_rainfall_application => 'شدید بارش کے دوران لگانے سے بچیں';

  @override
  String get use_soil_test_recommendations => 'مٹی کے ٹیسٹ کی بنیاد پر سفارشات استعمال کریں';

  @override
  String get cotton => 'کپاس';

  @override
  String get apply_full_phosphorus_potassium => 'بوائی کے وقت مکمل فاسفورس اور پوٹاشیم لگائیں';

  @override
  String get split_nitrogen_three_four_doses => 'نائٹروجن کی تقسیم 3-4 خوراکوں میں، پہلی بوائی پر، دوسری اسکوائرنگ پر، تیسری پھولنے پر، چوتھی اگر ضرورت ہو';

  @override
  String get apply_in_bands => '5-7 سینٹی میٹر گہری بینڈز میں لگائیں';

  @override
  String get irrigate_after_application => 'لگانے کے فوراً بعد آبپاشی کریں';

  @override
  String get rice => 'چاول';

  @override
  String get apply_basal_before_pudding => 'پلانٹ لگانے سے پہلے بیسَل کھاد لگائیں';

  @override
  String get split_nitrogen_three_equal_doses => 'نائٹروجن کو تین برابر حصوں میں تقسیم کریں: ';

  @override
  String get first_second_third => 'پہلا پلانٹ لگانے کے وقت، دوسرا ٹِلَرنگ کے وقت، تیسرا پینیکل آغاز پر';

  @override
  String get apply_in_standing_water => 'بہتر کارکردگی کے لیے کھاد کو کھڑے پانی میں لگائیں';

  @override
  String get use_urea_super_granules => 'بہتر نتائج کے لیے یوریا سپر گرینول استعمال کریں';

  @override
  String get avoid_strong_wind_application => 'تیز ہوا کے دوران کھاد لگانے سے گریز کریں';

  @override
  String get corn => 'مکئی';

  @override
  String get apply_starter_fertilizer_planting => 'بوائی کے وقت ابتدائی کھاد لگائیں';

  @override
  String get side_dress_nitrogen => 'پودوں کی قد 30-45 سینٹی میٹر ہونے پر نائٹروجن لگائیں';

  @override
  String get apply_phosphorus_potassium_soil_test => 'فاسفورس اور پوٹاشیم مٹی کے ٹیسٹ کی بنیاد پر لگائیں';

  @override
  String get use_split_for_sandy_soils => 'ریتلی مٹی کے لیے تقسیم شدہ لگانے کا استعمال کریں';

  @override
  String get avoid_root_contact_concentrated => 'مرکوز کھاد کے ساتھ جڑوں کا رابطہ نہ ہونے دیں';

  @override
  String get apply_based_on_soil_test => 'مٹی کے ٹیسٹ کے مطابق کھاد ڈالیں';

  @override
  String get split_applications_for_efficiency => 'بہتر اثر کے لیے کھاد قسطوں میں دیں';

  @override
  String get incorporate_fertilizers_properly => 'کھاد کو مٹی میں اچھی طرح ملائیں';

  @override
  String get apply_when_plants_growing => 'جب پودے بڑھ رہے ہوں تب کھاد ڈالیں';

  @override
  String get avoid_extreme_weather_application => 'شدید موسم میں کھاد ڈالنے سے گریز کریں';

  @override
  String get apply_fertilizers_based_on_soil_test => 'مٹی کے ٹیسٹ کی بنیاد پر کھاد لگائیں';

  @override
  String get apply_during_active_growth => 'جب پودے فعال نمو میں ہوں تو لگائیں';

  @override
  String get follow_recommended_dosage => 'تجویز کردہ مقدار پر سختی سے عمل کریں';

  @override
  String get focus_on_nitrogen => 'نائٹروجن کی لگانے پر توجہ دیں';

  @override
  String get avoid_drought_application => 'خشک سالی کے دوران لگانے سے بچیں';

  @override
  String get best_before_rainfall => 'متوقع بارش سے پہلے لگانا بہترین ہے';

  @override
  String get monitor_leaf_color_deficiencies => 'کمزوری کے لیے پتیوں کے رنگ کی نگرانی کریں';

  @override
  String get evapotranspiration_rate => 'بخارات اور پانی کی کمی کی شرح:';

  @override
  String get reduce_nitrogen_application => 'نائٹروجن کی مقدار کم کریں';

  @override
  String get increase_phosphorus_for_flowering => 'پھول بننے کے لیے فاسفورس بڑھائیں';

  @override
  String get apply_before_flower_buds_open => 'کلیاں کھلنے سے پہلے استعمال کریں';

  @override
  String get avoid_full_bloom_application => 'پورے پھول کے دوران استعمال سے پرہیز کریں';

  @override
  String get monitor_nutrient_deficiencies => 'غذائی کمی پر نظر رکھیں';

  @override
  String get critical_for_nitrogen_application => 'نائٹروجن کے لیے اہم مرحلہ';

  @override
  String get apply_when_tillers_develop => 'جب ٹلرز بننا شروع ہوں تو استعمال کریں';

  @override
  String get split_application_recommended => 'تقسیم کر کے استعمال بہتر ہے';

  @override
  String get ensure_adequate_soil_moisture => 'زمین میں مناسب نمی یقینی بنائیں';

  @override
  String get monitor_tiller_count => 'ٹلرز کی تعداد پر نظر رکھیں';

  @override
  String get focus_on_potassium_application => 'پوٹاشیم پر توجہ دیں';

  @override
  String get apply_early_silking_stage => 'ابتدائی سلکنگ مرحلے میں استعمال کریں';

  @override
  String get reduce_nitrogen_excess_growth => 'زیادہ بڑھوتری سے بچنے کے لیے نائٹروجن کم کریں';

  @override
  String get ensure_balanced_nutrition => 'متوازن غذائیت یقینی بنائیں';

  @override
  String get monitor_ear_development => 'بالوں کی نشوونما پر نظر رکھیں';

  @override
  String get apply_early_pod_development => 'پھلی بننے کے ابتدائی مرحلے میں استعمال کریں';

  @override
  String get monitor_pod_setting_rate => 'پھلی لگنے کی رفتار دیکھتے رہیں';

  @override
  String get avoid_stress_conditions => 'تناؤ کی حالت میں استعمال نہ کریں';

  @override
  String get follow_crop_specific_schedule => 'فصل کے مطابق شیڈول پر عمل کریں';

  @override
  String get consider_weather_conditions => 'موسم کو مدنظر رکھیں';

  @override
  String get monitor_plant_response => 'استعمال کے بعد پودے کا ردعمل دیکھیں';

  @override
  String get fertilizer_wheat_nitrogen => 'Urea (46-0-0)';

  @override
  String get fertilizer_wheat_phosphorus => 'DAP (18-46-0)';

  @override
  String get fertilizer_wheat_potassium => 'MOP (0-0-60)';

  @override
  String get fertilizer_wheat_micronutrients => 'Zinc Sulfate';

  @override
  String get fertilizer_cotton_nitrogen => 'Urea (46-0-0)';

  @override
  String get fertilizer_cotton_phosphorus => 'SSP (0-16-0)';

  @override
  String get fertilizer_cotton_potassium => 'MOP (0-0-60)';

  @override
  String get fertilizer_cotton_micronutrients => 'Boron, Zinc';

  @override
  String get fertilizer_rice_nitrogen => 'Urea (46-0-0)';

  @override
  String get fertilizer_rice_phosphorus => 'DAP (18-46-0)';

  @override
  String get fertilizer_rice_potassium => 'MOP (0-0-60)';

  @override
  String get fertilizer_rice_micronutrients => 'Zinc Sulfate';

  @override
  String get fertilizer_corn_nitrogen => 'Urea (46-0-0)';

  @override
  String get fertilizer_corn_phosphorus => 'NPK (17-17-17)';

  @override
  String get fertilizer_corn_potassium => 'MOP (0-0-60)';

  @override
  String get fertilizer_corn_micronutrients => 'Zinc, Iron';

  @override
  String get fertilizer_default_nitrogen => 'Urea or Ammonium-based';

  @override
  String get fertilizer_default_phosphorus => 'DAP or SSP';

  @override
  String get fertilizer_default_potassium => 'MOP or SOP';

  @override
  String get fertilizer_default_micronutrients => 'As per soil test';

  @override
  String get error_initializing_firebase => 'فایربیس کا مسلہ';

  @override
  String get error_updating_first_time_status => 'Error updating first-time status';

  @override
  String get your_journey_begins_here => 'آپ کا زرعی سفر یہاں سے شروع ہوتا ہے';

  @override
  String get preparing_your_dashboard => 'آپ کا ذاتی ڈیش بورڈ تیار کیا جا رہا ہے';

  @override
  String get tap_to_continue => 'جاری رکھنے کے لیے ٹیپ کریں';

  @override
  String get irrigation_schedule => '📅 آبپاشی کا شیڈول:';

  @override
  String get wheat_first_irrigation => 'پہلی آبپاشی:';

  @override
  String get wheat_first_irrigation_value => 'بیج بونے کے 20-25 دن بعد (تاجی جڑ کا آغاز)';

  @override
  String get wheat_second_irrigation => 'دوسری آبپاشی:';

  @override
  String get wheat_second_irrigation_value => 'بیج بونے کے 45-50 دن بعد (چھوٹے ٹہنی نما پتے نکلنا)';

  @override
  String get wheat_third_irrigation => 'تیسری آبپاشی:';

  @override
  String get wheat_third_irrigation_value => 'بیج بونے کے 70-75 دن بعد (جوائنٹنگ / کانٹے نکلنا)';

  @override
  String get wheat_fourth_irrigation => 'چوتھی آبپاشی:';

  @override
  String get wheat_fourth_irrigation_value => 'بیج بونے کے 90-95 دن بعد (بوٹنگ / پھول کے کانٹے نکلنا)';

  @override
  String get wheat_fifth_irrigation => 'پانچویں آبپاشی:';

  @override
  String get wheat_fifth_irrigation_value => 'بیج بونے کے 110-115 دن بعد (دانے بھرنے کا مرحلہ)';

  @override
  String get cotton_first_irrigation => 'پہلی آبپاشی:';

  @override
  String get cotton_first_irrigation_value => 'بیج بونے کے 30-35 دن بعد (سبز نمو کا مرحلہ)';

  @override
  String get cotton_second_irrigation => 'دوسری آبپاشی:';

  @override
  String get cotton_second_irrigation_value => 'سکوئرنگ مرحلے کے دوران';

  @override
  String get cotton_third_irrigation => 'تیسری آبپاشی:';

  @override
  String get cotton_third_irrigation_value => 'پھول آنے کے مرحلے کے دوران';

  @override
  String get cotton_fourth_irrigation => 'چوتھی آبپاشی:';

  @override
  String get cotton_fourth_irrigation_value => 'پھل (بول) بننے کے مرحلے میں';

  @override
  String get cotton_fifth_irrigation => 'پانچویں آبپاشی:';

  @override
  String get cotton_fifth_irrigation_value => 'پھل (بول) نشوونما کے مرحلے میں';

  @override
  String get rice_initial_flooding => 'ابتدائی پانی ڈالنا:';

  @override
  String get rice_initial_flooding_value => 'تراپلانٹنگ کے بعد 3-5 سینٹی میٹر پانی برقرار رکھیں';

  @override
  String get rice_vegetative_stage => 'سبز نمو کا مرحلہ:';

  @override
  String get rice_vegetative_stage_value => '2-5 سینٹی میٹر پانی برقرار رکھیں';

  @override
  String get rice_reproductive_stage => 'پیداواری مرحلہ:';

  @override
  String get rice_reproductive_stage_value => '5-10 سینٹی میٹر پانی برقرار رکھیں';

  @override
  String get rice_ripening_stage => 'پختگی کا مرحلہ:';

  @override
  String get rice_ripening_stage_value => 'فصل کی کٹائی سے 2 ہفتے قبل پانی آہستہ آہستہ کم کریں';

  @override
  String get corn_first_irrigation => 'پہلی آبپاشی:';

  @override
  String get corn_first_irrigation_value => 'بیج بونے کے فوراً بعد';

  @override
  String get corn_second_irrigation => 'دوسری آبپاشی:';

  @override
  String get corn_second_irrigation_value => 'گٹھلی نما قد (30-45 سینٹی میٹر) کے مرحلے میں';

  @override
  String get corn_third_irrigation => 'تیسری آبپاشی:';

  @override
  String get corn_third_irrigation_value => 'تسلنگ کے مرحلے میں';

  @override
  String get corn_fourth_irrigation => 'چوتھی آبپاشی:';

  @override
  String get corn_fourth_irrigation_value => 'سلکنگ کے مرحلے میں';

  @override
  String get corn_fifth_irrigation => 'پانچویں آبپاشی:';

  @override
  String get corn_fifth_irrigation_value => 'دانے بھرنے کے مرحلے میں';

  @override
  String get general_rule => 'عمومی قاعدہ: ';

  @override
  String get general_rule_value => 'جب اوپر کی 15 سینٹی میٹر مٹی خشک لگے تو آبپاشی کریں';

  @override
  String get general_pests_that_affect_crop => 'فصلوں کو متاثر کرنے والے عام کیڑے';

  @override
  String get critical_stages => 'اہم مراحل: ';

  @override
  String get critical_stages_value => 'فلورنگ اور پھل لگنے کے دوران مناسب نمی یقینی بنائیں';

  @override
  String get water_quantity => 'پانی کی مقدار: ';

  @override
  String get water_quantity_value => 'ہر آبپاشی میں 5-7 سینٹی میٹر پانی لگائیں';

  @override
  String get monitoring => 'نگرانی: ';

  @override
  String get monitoring_value => 'مٹی کی نمی باقاعدگی سے چیک کریں';

  @override
  String get water_management_tips => '💧 پانی کی دیکھ بھال کے نکات:';

  @override
  String get high_tip_first => 'مٹی خشک ہو تو فوراً آبپاشی کریں';

  @override
  String get high_tip_second => 'مٹی کی نمی برقرار رکھنے کے لیے ملچنگ استعمال کریں';

  @override
  String get high_tip_third => 'موثر آبپاشی کے لیے ڈرپ آبپاشی پر غور کریں';

  @override
  String get high_tip_fourth => 'پودوں میں پژمردگی کی علامات دیکھیں';

  @override
  String get high_tip_fifth => 'صبح سویرے یا شام کو پانی دیں';

  @override
  String get high_tip_sixth => 'مٹی کی نمی روزانہ چیک کریں';

  @override
  String get medium_tip_first => 'باقاعدہ آبپاشی شیڈول پر عمل کریں';

  @override
  String get medium_tip_second => 'مٹی کی نمی ہر 2-3 دن چیک کریں';

  @override
  String get medium_tip_third => 'بارش کی بنیاد پر ایڈجسٹ کریں';

  @override
  String get medium_tip_fourth => 'پانی کی بچت کے طریقے استعمال کریں';

  @override
  String get medium_tip_fifth => 'موسم کی پیش گوئی پر نظر رکھیں';

  @override
  String get medium_tip_sixth => 'آبپاشی کے ریکارڈ رکھیں';

  @override
  String get low_tip_first => 'اگر بارش متوقع ہو تو آبپاشی مؤخر کریں';

  @override
  String get low_tip_second => 'پانی دینے سے پہلے مٹی کی نمی چیک کریں';

  @override
  String get low_tip_third => 'آبپاشی کی تعدد کم کریں';

  @override
  String get low_tip_fourth => 'پانی بچانے کے طریقے استعمال کریں';

  @override
  String get low_tip_fifth => 'زیادہ پانی دینے کی علامات دیکھیں';

  @override
  String get low_tip_sixth => 'ممکن ہو تو بارش کا پانی جمع کریں';

  @override
  String get return_tip_first => 'آبپاشی سے پہلے زمین کی نمی چیک کریں';

  @override
  String get return_tip_second => 'پانی پودے کی ضرورت کے مطابق دیں، مقررہ شیڈول پر نہیں';

  @override
  String get return_tip_third => 'مؤثر آبپاشی کے طریقے استعمال کریں';

  @override
  String get return_tip_fourth => 'موسمی حالات پر نظر رکھیں';

  @override
  String get return_tip_fifth => 'زمین میں پانی کھڑا ہونے سے بچیں';

  @override
  String get return_tip_sixth => 'مناسب نکاسی کا انتظام رکھیں';

  @override
  String get irrigation_methods => '⚙️ آبپاشی کے طریقے:';

  @override
  String get drip_irrigation => 'ڈرپ آبپاشی';

  @override
  String get drip_irrigation_desc => 'سب سے مؤثر طریقہ، 30-50٪ پانی کی بچت، قطار کی فصلوں کے لیے مثالی';

  @override
  String get sprinkler_irrigation => 'سپرنکلر آبپاشی';

  @override
  String get sprinkler_irrigation_desc => 'یکساں پانی کی تقسیم کے لیے اچھا، زیادہ تر کھیت کی فصلوں کے لیے موزوں';

  @override
  String get furrow_irrigation => 'فرو آبپاشی';

  @override
  String get furrow_irrigation_desc => 'روایتی طریقہ، درمیانی کارکردگی';

  @override
  String get flood_irrigation => 'سیلابی آبپاشی';

  @override
  String get flood_irrigation_desc => 'چاول اور کچھ فصلوں کے لیے، کم کارکردگی';

  @override
  String get basin_irrigation => 'بیسن آبپاشی';

  @override
  String get basin_irrigation_desc => 'باغات اور کچھ فصلوں کے لیے موزوں';

  @override
  String high_risk_message(Object cropName, Object pests) {
    return '$cropName میں $pests کے حملے کا زیادہ خطرہ';
  }

  @override
  String moderate_risk_message(Object cropName, Object pests) {
    return '$cropName میں $pests کے لیے نگرانی کریں';
  }

  @override
  String low_risk_message(Object cropName) {
    return 'موجودہ حالات میں $cropName میں کیڑوں کا خطرہ کم ہے';
  }

  @override
  String get generic_pest => 'کیڑا';

  @override
  String get potential_pests => 'ممکنہ کیڑے';

  @override
  String high_temp_burn_risk(Object cropName) {
    return 'زیادہ درجہ حرارت $cropName میں کھاد جلنے کا خطرہ بڑھاتا ہے';
  }

  @override
  String warm_weather_nutrient_availability(Object cropName) {
    return 'گرم موسم $cropName کے لیے غذائی اجزاء کو بہتر بناتا ہے';
  }

  @override
  String cold_temp_slow_growth(Object cropName) {
    return 'سرد درجہ حرارت $cropName کی نشوونما اور غذائی اجزاء کے جذب کو سست کر دیتا ہے';
  }

  @override
  String optimal_temp_application(Object cropName) {
    return '$cropName کے لیے کھاد ڈالنے کا موزوں درجہ حرارت';
  }

  @override
  String rain_absorption_help(Object cropName) {
    return 'بارش $cropName کو غذائی اجزاء بہتر طریقے سے جذب کرنے میں مدد دے گی';
  }

  @override
  String irrigation_required_after_application(Object cropName) {
    return '$cropName کو کھاد ڈالنے کے بعد آبپاشی کی ضرورت ہو سکتی ہے';
  }

  @override
  String get as_per_soil_test => 'مٹی کے ٹیسٹ کے مطابق ';

  @override
  String natural_rainfall_sufficient_three(Object crop) {
    return 'قدرتی بارش $crop کے لیے مناسب نمی فراہم کرے گی';
  }

  @override
  String storm_rainfall_avoid_waterlogging_three(Object crop) {
    return 'طوفانی بارش $crop کے لیے کافی ہوگی، پانی کھڑا ہونے سے بچائیں';
  }

  @override
  String high_evaporation_requires_more_water_three(Object crop, Object et) {
    return 'زیادہ بخارات کی شرح ($et ملی میٹر/دن) کی وجہ سے $crop کو زیادہ بار بار پانی دینے کی ضرورت ہے';
  }

  @override
  String low_evaporation_less_water_three(Object crop, Object et) {
    return 'کم بخارات کی شرح ($et ملی میٹر/دن) – $crop کو کم پانی درکار ہے';
  }

  @override
  String dry_warm_conditions_water_management_three(Object crop) {
    return 'خشک اور گرم موسم میں $crop کے لیے پانی کا محتاط انتظام ضروری ہے';
  }

  @override
  String get normal_irrigation_schedule_three => 'معمول کے مطابق آبپاشی کا شیڈول';

  @override
  String moderate_conditions_regular_irrigation_three(Object crop, Object stage) {
    return 'درمیانے موسم میں $crop ($stage مرحلہ) کے لیے باقاعدہ آبپاشی برقرار رکھیں';
  }

  @override
  String get urgency_low => 'کم';

  @override
  String get urgency_medium => 'درمیانہ';

  @override
  String get urgency_high => 'زیادہ';

  @override
  String get mm_day => 'ملی میٹر فی دن';
}
