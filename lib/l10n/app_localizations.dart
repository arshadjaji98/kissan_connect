import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ur.dart';

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
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ur')
  ];

  /// No description provided for @selectLanguage.
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get selectLanguage;

  /// No description provided for @choosePreferredLanguage.
  ///
  /// In en, this message translates to:
  /// **'Choose your preferred language'**
  String get choosePreferredLanguage;

  /// No description provided for @languageChangedTo.
  ///
  /// In en, this message translates to:
  /// **'Language changed to {language}'**
  String languageChangedTo(Object language);

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @urdu.
  ///
  /// In en, this message translates to:
  /// **'Urdu'**
  String get urdu;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get welcome;

  /// No description provided for @sign_up.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get sign_up;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @full_name.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get full_name;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @confirm_password.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirm_password;

  /// No description provided for @farm_location.
  ///
  /// In en, this message translates to:
  /// **'Your Farm\'s Location'**
  String get farm_location;

  /// No description provided for @farm_land_area.
  ///
  /// In en, this message translates to:
  /// **'Area of Farm Land'**
  String get farm_land_area;

  /// No description provided for @select_crops.
  ///
  /// In en, this message translates to:
  /// **'Select the crops you grow'**
  String get select_crops;

  /// No description provided for @already_have_account.
  ///
  /// In en, this message translates to:
  /// **'Already have an account? Log In'**
  String get already_have_account;

  /// No description provided for @signup_success_message.
  ///
  /// In en, this message translates to:
  /// **'Signup successful! Navigating to HomeScreen...'**
  String get signup_success_message;

  /// No description provided for @email_already_in_use_code.
  ///
  /// In en, this message translates to:
  /// **'email-already-in-use'**
  String get email_already_in_use_code;

  /// No description provided for @email_already_in_use_message.
  ///
  /// In en, this message translates to:
  /// **'This email is already registered. Please use a different email or login.'**
  String get email_already_in_use_message;

  /// No description provided for @invalid_email_code.
  ///
  /// In en, this message translates to:
  /// **'invalid-email'**
  String get invalid_email_code;

  /// No description provided for @invalid_email_message.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email address.'**
  String get invalid_email_message;

  /// No description provided for @weak_password_message.
  ///
  /// In en, this message translates to:
  /// **'Password is too weak. Please use at least 8 characters.'**
  String get weak_password_message;

  /// No description provided for @operation_not_allowed_code.
  ///
  /// In en, this message translates to:
  /// **'operation-not-allowed'**
  String get operation_not_allowed_code;

  /// No description provided for @operation_not_allowed_message.
  ///
  /// In en, this message translates to:
  /// **'Email/password accounts are not enabled. Please contact support.'**
  String get operation_not_allowed_message;

  /// No description provided for @network_request_failed_code.
  ///
  /// In en, this message translates to:
  /// **'network-request-failed'**
  String get network_request_failed_code;

  /// No description provided for @network_error_message.
  ///
  /// In en, this message translates to:
  /// **'Network error. Please check your internet connection.'**
  String get network_error_message;

  /// No description provided for @signup_error_message.
  ///
  /// In en, this message translates to:
  /// **'An error occurred during sign up:'**
  String get signup_error_message;

  /// No description provided for @unexpected_error_message.
  ///
  /// In en, this message translates to:
  /// **'An unexpected error occurred. Please try again.'**
  String get unexpected_error_message;

  /// No description provided for @please_enter.
  ///
  /// In en, this message translates to:
  /// **'Please enter'**
  String get please_enter;

  /// No description provided for @required.
  ///
  /// In en, this message translates to:
  /// **'Required'**
  String get required;

  /// No description provided for @passwords_do_not_match.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwords_do_not_match;

  /// No description provided for @minimum_8_characters.
  ///
  /// In en, this message translates to:
  /// **'Minimum 8 characters'**
  String get minimum_8_characters;

  /// No description provided for @tagline.
  ///
  /// In en, this message translates to:
  /// **'Join our community for better farming'**
  String get tagline;

  /// No description provided for @area.
  ///
  /// In en, this message translates to:
  /// **'Area'**
  String get area;

  /// No description provided for @selectMultipleCrops.
  ///
  /// In en, this message translates to:
  /// **'You can select multiple crops'**
  String get selectMultipleCrops;

  /// No description provided for @sugarcane.
  ///
  /// In en, this message translates to:
  /// **'Sugarcane'**
  String get sugarcane;

  /// No description provided for @maize.
  ///
  /// In en, this message translates to:
  /// **'Maize'**
  String get maize;

  /// No description provided for @vegetables.
  ///
  /// In en, this message translates to:
  /// **'Vegetables'**
  String get vegetables;

  /// No description provided for @mango.
  ///
  /// In en, this message translates to:
  /// **'Mango'**
  String get mango;

  /// No description provided for @potato.
  ///
  /// In en, this message translates to:
  /// **'Potato'**
  String get potato;

  /// No description provided for @chilli.
  ///
  /// In en, this message translates to:
  /// **'Chilli'**
  String get chilli;

  /// No description provided for @welcome_back.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back!'**
  String get welcome_back;

  /// No description provided for @signin_continue.
  ///
  /// In en, this message translates to:
  /// **'Sign in to continue to Kissan Connect'**
  String get signin_continue;

  /// No description provided for @enter_email.
  ///
  /// In en, this message translates to:
  /// **'Enter your email address'**
  String get enter_email;

  /// No description provided for @please_enter_email.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email address'**
  String get please_enter_email;

  /// No description provided for @please_enter_valid_email.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email address'**
  String get please_enter_valid_email;

  /// No description provided for @enter_password.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get enter_password;

  /// No description provided for @please_enter_password.
  ///
  /// In en, this message translates to:
  /// **'Please enter your password'**
  String get please_enter_password;

  /// No description provided for @password_min_8.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters'**
  String get password_min_8;

  /// No description provided for @remember_me.
  ///
  /// In en, this message translates to:
  /// **'Remember me'**
  String get remember_me;

  /// No description provided for @forgot_password.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgot_password;

  /// No description provided for @log_in.
  ///
  /// In en, this message translates to:
  /// **'Log In'**
  String get log_in;

  /// No description provided for @or_continue_with.
  ///
  /// In en, this message translates to:
  /// **'or continue with'**
  String get or_continue_with;

  /// No description provided for @dont_have_account.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get dont_have_account;

  /// No description provided for @login_user_data_missing.
  ///
  /// In en, this message translates to:
  /// **'Login successful but user data not available. Please try again.'**
  String get login_user_data_missing;

  /// No description provided for @user_not_found_code.
  ///
  /// In en, this message translates to:
  /// **'user-not-found'**
  String get user_not_found_code;

  /// No description provided for @user_not_found_message.
  ///
  /// In en, this message translates to:
  /// **'No account found with this email.'**
  String get user_not_found_message;

  /// No description provided for @wrong_password_code.
  ///
  /// In en, this message translates to:
  /// **'wrong-password'**
  String get wrong_password_code;

  /// No description provided for @wrong_password_message.
  ///
  /// In en, this message translates to:
  /// **'Incorrect password. Please try again.'**
  String get wrong_password_message;

  /// No description provided for @invalid_credential_code.
  ///
  /// In en, this message translates to:
  /// **'invalid-credential'**
  String get invalid_credential_code;

  /// No description provided for @invalid_credential_message.
  ///
  /// In en, this message translates to:
  /// **'Invalid email or password.'**
  String get invalid_credential_message;

  /// No description provided for @user_disabled_code.
  ///
  /// In en, this message translates to:
  /// **'user-disabled'**
  String get user_disabled_code;

  /// No description provided for @user_disabled_message.
  ///
  /// In en, this message translates to:
  /// **'This account has been disabled.'**
  String get user_disabled_message;

  /// No description provided for @too_many_requests_code.
  ///
  /// In en, this message translates to:
  /// **'too-many-requests'**
  String get too_many_requests_code;

  /// No description provided for @too_many_requests_message.
  ///
  /// In en, this message translates to:
  /// **'Too many login attempts. Please try again later.'**
  String get too_many_requests_message;

  /// No description provided for @login_failed.
  ///
  /// In en, this message translates to:
  /// **'Login failed:'**
  String get login_failed;

  /// No description provided for @login_error.
  ///
  /// In en, this message translates to:
  /// **'Login error:'**
  String get login_error;

  /// No description provided for @unexpected_error.
  ///
  /// In en, this message translates to:
  /// **'An unexpected error occurred. Please try again.'**
  String get unexpected_error;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'name'**
  String get name;

  /// No description provided for @display_name.
  ///
  /// In en, this message translates to:
  /// **'displayName'**
  String get display_name;

  /// No description provided for @farmer.
  ///
  /// In en, this message translates to:
  /// **'Farmer'**
  String get farmer;

  /// No description provided for @location.
  ///
  /// In en, this message translates to:
  /// **'location'**
  String get location;

  /// No description provided for @user_not_logined_in.
  ///
  /// In en, this message translates to:
  /// **'User not logged in.'**
  String get user_not_logined_in;

  /// No description provided for @error_fetching_user_location.
  ///
  /// In en, this message translates to:
  /// **'Error fetching user location:'**
  String get error_fetching_user_location;

  /// No description provided for @error_fetching_weather.
  ///
  /// In en, this message translates to:
  /// **'Error fetching weather data:'**
  String get error_fetching_weather;

  /// No description provided for @unable_to_fetch_weather_data_please_check_internet.
  ///
  /// In en, this message translates to:
  /// **'Unable to fetch weather data. Please check your internet connection.'**
  String get unable_to_fetch_weather_data_please_check_internet;

  /// No description provided for @failed_to_load_weather_data.
  ///
  /// In en, this message translates to:
  /// **'Failed to load weather data.'**
  String get failed_to_load_weather_data;

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'address'**
  String get address;

  /// No description provided for @your_location.
  ///
  /// In en, this message translates to:
  /// **'Your Location'**
  String get your_location;

  /// No description provided for @selected_crops.
  ///
  /// In en, this message translates to:
  /// **'selectedCrops'**
  String get selected_crops;

  /// No description provided for @crops.
  ///
  /// In en, this message translates to:
  /// **'crops'**
  String get crops;

  /// No description provided for @primary_crop.
  ///
  /// In en, this message translates to:
  /// **'primaryCrop'**
  String get primary_crop;

  /// No description provided for @error_fetching_user_data.
  ///
  /// In en, this message translates to:
  /// **'Error fetching user data:'**
  String get error_fetching_user_data;

  /// No description provided for @error_creating_default_user.
  ///
  /// In en, this message translates to:
  /// **'Error creating default user document:'**
  String get error_creating_default_user;

  /// No description provided for @reset_password.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get reset_password;

  /// No description provided for @enter_email_first.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email address first.'**
  String get enter_email_first;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @password_reset_sent_title.
  ///
  /// In en, this message translates to:
  /// **'Password Reset Email Sent'**
  String get password_reset_sent_title;

  /// No description provided for @password_reset_sent_message.
  ///
  /// In en, this message translates to:
  /// **'A password reset link has been sent to email. Please check your inbox.'**
  String get password_reset_sent_message;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @password_reset_failed.
  ///
  /// In en, this message translates to:
  /// **'Failed to send reset email. Please check the email address and try again.'**
  String get password_reset_failed;

  /// No description provided for @password_sent_to_email.
  ///
  /// In en, this message translates to:
  /// **'A Password has been sent to {email}, Please check your inbox.'**
  String password_sent_to_email(Object email);

  /// No description provided for @app_name.
  ///
  /// In en, this message translates to:
  /// **'Kissan Connect'**
  String get app_name;

  /// No description provided for @weather_data_unavailable.
  ///
  /// In en, this message translates to:
  /// **'Weather data unavailable'**
  String get weather_data_unavailable;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @approximate.
  ///
  /// In en, this message translates to:
  /// **'Approximate'**
  String get approximate;

  /// No description provided for @feels_like.
  ///
  /// In en, this message translates to:
  /// **'Feels like'**
  String get feels_like;

  /// No description provided for @clear.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get clear;

  /// No description provided for @partlyCloudy.
  ///
  /// In en, this message translates to:
  /// **'Partly Cloudy'**
  String get partlyCloudy;

  /// No description provided for @cloudy.
  ///
  /// In en, this message translates to:
  /// **'Cloudy'**
  String get cloudy;

  /// No description provided for @fog.
  ///
  /// In en, this message translates to:
  /// **'Fog'**
  String get fog;

  /// No description provided for @drizzle.
  ///
  /// In en, this message translates to:
  /// **'Drizzle'**
  String get drizzle;

  /// No description provided for @rain.
  ///
  /// In en, this message translates to:
  /// **'Rain'**
  String get rain;

  /// No description provided for @snow.
  ///
  /// In en, this message translates to:
  /// **'Snow'**
  String get snow;

  /// No description provided for @thunderstorm.
  ///
  /// In en, this message translates to:
  /// **'Thunderstorm'**
  String get thunderstorm;

  /// No description provided for @clearSky.
  ///
  /// In en, this message translates to:
  /// **'Clear sky'**
  String get clearSky;

  /// No description provided for @mainlyClear.
  ///
  /// In en, this message translates to:
  /// **'Mainly clear'**
  String get mainlyClear;

  /// No description provided for @overcast.
  ///
  /// In en, this message translates to:
  /// **'Overcast'**
  String get overcast;

  /// No description provided for @depositingRimeFog.
  ///
  /// In en, this message translates to:
  /// **'Depositing rime fog'**
  String get depositingRimeFog;

  /// No description provided for @lightDrizzle.
  ///
  /// In en, this message translates to:
  /// **'Light drizzle'**
  String get lightDrizzle;

  /// No description provided for @moderateDrizzle.
  ///
  /// In en, this message translates to:
  /// **'Moderate drizzle'**
  String get moderateDrizzle;

  /// No description provided for @denseDrizzle.
  ///
  /// In en, this message translates to:
  /// **'Dense drizzle'**
  String get denseDrizzle;

  /// No description provided for @slightRain.
  ///
  /// In en, this message translates to:
  /// **'Slight rain'**
  String get slightRain;

  /// No description provided for @moderateRain.
  ///
  /// In en, this message translates to:
  /// **'Moderate rain'**
  String get moderateRain;

  /// No description provided for @heavyRain.
  ///
  /// In en, this message translates to:
  /// **'Heavy rain'**
  String get heavyRain;

  /// No description provided for @slightSnow.
  ///
  /// In en, this message translates to:
  /// **'Slight snow'**
  String get slightSnow;

  /// No description provided for @moderateSnow.
  ///
  /// In en, this message translates to:
  /// **'Moderate snow'**
  String get moderateSnow;

  /// No description provided for @heavySnow.
  ///
  /// In en, this message translates to:
  /// **'Heavy snow'**
  String get heavySnow;

  /// No description provided for @thunderstormWithHail.
  ///
  /// In en, this message translates to:
  /// **'Thunderstorm with hail'**
  String get thunderstormWithHail;

  /// No description provided for @mist.
  ///
  /// In en, this message translates to:
  /// **'Mist'**
  String get mist;

  /// No description provided for @smoke.
  ///
  /// In en, this message translates to:
  /// **'Smoke'**
  String get smoke;

  /// No description provided for @haze.
  ///
  /// In en, this message translates to:
  /// **'Haze'**
  String get haze;

  /// No description provided for @dust.
  ///
  /// In en, this message translates to:
  /// **'Dust'**
  String get dust;

  /// No description provided for @foggy.
  ///
  /// In en, this message translates to:
  /// **'Foggy'**
  String get foggy;

  /// No description provided for @weather_data_error.
  ///
  /// In en, this message translates to:
  /// **'Weather data error'**
  String get weather_data_error;

  /// No description provided for @recommendations_for.
  ///
  /// In en, this message translates to:
  /// **'Recommendations for '**
  String get recommendations_for;

  /// No description provided for @tap_to_change.
  ///
  /// In en, this message translates to:
  /// **'tap to change'**
  String get tap_to_change;

  /// No description provided for @you_grow.
  ///
  /// In en, this message translates to:
  /// **'You grow'**
  String get you_grow;

  /// No description provided for @high_alert.
  ///
  /// In en, this message translates to:
  /// **'High Alert'**
  String get high_alert;

  /// No description provided for @moderate_alert.
  ///
  /// In en, this message translates to:
  /// **'Moderate Alert'**
  String get moderate_alert;

  /// No description provided for @is_high_risk.
  ///
  /// In en, this message translates to:
  /// **'isHighRisk'**
  String get is_high_risk;

  /// No description provided for @high_risk.
  ///
  /// In en, this message translates to:
  /// **'High Risk!'**
  String get high_risk;

  /// No description provided for @low_risk.
  ///
  /// In en, this message translates to:
  /// **'Low Risk'**
  String get low_risk;

  /// No description provided for @moderate_risk.
  ///
  /// In en, this message translates to:
  /// **'Moderate Risk'**
  String get moderate_risk;

  /// No description provided for @standard_application_needed.
  ///
  /// In en, this message translates to:
  /// **'Standard application needed'**
  String get standard_application_needed;

  /// No description provided for @no_adjustment_needed.
  ///
  /// In en, this message translates to:
  /// **'No adjustment needed'**
  String get no_adjustment_needed;

  /// No description provided for @vegetative.
  ///
  /// In en, this message translates to:
  /// **'Vegetative'**
  String get vegetative;

  /// No description provided for @flowering.
  ///
  /// In en, this message translates to:
  /// **'Flowering'**
  String get flowering;

  /// No description provided for @fruiting.
  ///
  /// In en, this message translates to:
  /// **'Fruiting'**
  String get fruiting;

  /// No description provided for @tillering.
  ///
  /// In en, this message translates to:
  /// **'Tillering'**
  String get tillering;

  /// No description provided for @silking.
  ///
  /// In en, this message translates to:
  /// **'Silking'**
  String get silking;

  /// No description provided for @jointing.
  ///
  /// In en, this message translates to:
  /// **'Jointing'**
  String get jointing;

  /// No description provided for @reduced_due_to_high_temperature.
  ///
  /// In en, this message translates to:
  /// **'Reduced due to high temperature'**
  String get reduced_due_to_high_temperature;

  /// No description provided for @slightly_increased_due_to_optimal_temp.
  ///
  /// In en, this message translates to:
  /// **'Slightly increased due to optimal temperature'**
  String get slightly_increased_due_to_optimal_temp;

  /// No description provided for @increased_due_to_favorable_conditions.
  ///
  /// In en, this message translates to:
  /// **'Increased due to favorable conditions'**
  String get increased_due_to_favorable_conditions;

  /// No description provided for @increased_before_expected_rain.
  ///
  /// In en, this message translates to:
  /// **'Increased before expected rain'**
  String get increased_before_expected_rain;

  /// No description provided for @weather_conditions_favorable.
  ///
  /// In en, this message translates to:
  /// **'Weather conditions are favorable for pest activity.'**
  String get weather_conditions_favorable;

  /// No description provided for @pest_attack_prediction.
  ///
  /// In en, this message translates to:
  /// **'Pest Attack Prediction'**
  String get pest_attack_prediction;

  /// No description provided for @pest_prevention_guide.
  ///
  /// In en, this message translates to:
  /// **'Pest Prevention Guide'**
  String get pest_prevention_guide;

  /// No description provided for @no_message_available.
  ///
  /// In en, this message translates to:
  /// **'No message available'**
  String get no_message_available;

  /// No description provided for @aphids.
  ///
  /// In en, this message translates to:
  /// **'Aphids'**
  String get aphids;

  /// No description provided for @army_worm.
  ///
  /// In en, this message translates to:
  /// **'Army Worm'**
  String get army_worm;

  /// No description provided for @rust_fungus.
  ///
  /// In en, this message translates to:
  /// **'Rust Fungus'**
  String get rust_fungus;

  /// No description provided for @hessian_fly.
  ///
  /// In en, this message translates to:
  /// **'Hessian Fly'**
  String get hessian_fly;

  /// No description provided for @bollworm.
  ///
  /// In en, this message translates to:
  /// **'Bollworm'**
  String get bollworm;

  /// No description provided for @whitefly.
  ///
  /// In en, this message translates to:
  /// **'Whitefly'**
  String get whitefly;

  /// No description provided for @spider_mites.
  ///
  /// In en, this message translates to:
  /// **'Spider Mites'**
  String get spider_mites;

  /// No description provided for @min.
  ///
  /// In en, this message translates to:
  /// **'Min'**
  String get min;

  /// No description provided for @max.
  ///
  /// In en, this message translates to:
  /// **'Max'**
  String get max;

  /// No description provided for @various_pests.
  ///
  /// In en, this message translates to:
  /// **'Various Pests'**
  String get various_pests;

  /// No description provided for @stem_borer.
  ///
  /// In en, this message translates to:
  /// **'Stem borer'**
  String get stem_borer;

  /// No description provided for @leaf_folder.
  ///
  /// In en, this message translates to:
  /// **'Leaf folder'**
  String get leaf_folder;

  /// No description provided for @blast_fungus.
  ///
  /// In en, this message translates to:
  /// **'Blast fungus'**
  String get blast_fungus;

  /// No description provided for @brown_plant_hopper.
  ///
  /// In en, this message translates to:
  /// **'Brown plant hopper'**
  String get brown_plant_hopper;

  /// No description provided for @corn_borer.
  ///
  /// In en, this message translates to:
  /// **'Corn borer'**
  String get corn_borer;

  /// No description provided for @armyworm.
  ///
  /// In en, this message translates to:
  /// **'Armyworm'**
  String get armyworm;

  /// No description provided for @earworm.
  ///
  /// In en, this message translates to:
  /// **'Earworm'**
  String get earworm;

  /// No description provided for @corn_leaf_aphid.
  ///
  /// In en, this message translates to:
  /// **'Corn leaf aphid'**
  String get corn_leaf_aphid;

  /// No description provided for @warm_weather_increases_nutrients.
  ///
  /// In en, this message translates to:
  /// **'Warm weather increases nutrient availability for {crop}'**
  String warm_weather_increases_nutrients(Object crop);

  /// No description provided for @cold_weather_slows_growth.
  ///
  /// In en, this message translates to:
  /// **'Cold temperatures slow {crop} growth and nutrient uptake'**
  String cold_weather_slows_growth(Object crop);

  /// No description provided for @optimal_temp_for_fertilizer.
  ///
  /// In en, this message translates to:
  /// **'Optimal temperature for {crop} fertilizer application'**
  String optimal_temp_for_fertilizer(Object crop);

  /// No description provided for @adjustment_increased_for_rain.
  ///
  /// In en, this message translates to:
  /// **'{adjustment}, increased for rain'**
  String adjustment_increased_for_rain(Object adjustment);

  /// No description provided for @rain_helps_nutrient_absorption.
  ///
  /// In en, this message translates to:
  /// **'{reason}. Rain will help {crop} absorb nutrients efficiently'**
  String rain_helps_nutrient_absorption(Object crop, Object reason);

  /// No description provided for @adjustment_reduced_for_dryness.
  ///
  /// In en, this message translates to:
  /// **'{adjustment}, reduced for dryness'**
  String adjustment_reduced_for_dryness(Object adjustment);

  /// No description provided for @dryness_requires_irrigation.
  ///
  /// In en, this message translates to:
  /// **'{reason}. {crop} may require irrigation after application'**
  String dryness_requires_irrigation(Object crop, Object reason);

  /// No description provided for @reason_with_growth_stage.
  ///
  /// In en, this message translates to:
  /// **'{reason}. Current growth stage: {growthStage}'**
  String reason_with_growth_stage(Object growthStage, Object reason);

  /// No description provided for @current_growth_rate.
  ///
  /// In en, this message translates to:
  /// **'Current growth rate: '**
  String get current_growth_rate;

  /// No description provided for @temperature_optimal_for.
  ///
  /// In en, this message translates to:
  /// **'Temperature optimal for'**
  String get temperature_optimal_for;

  /// No description provided for @natural_rainfall_sufficient_two.
  ///
  /// In en, this message translates to:
  /// **'Natural rainfall will provide sufficient moisture for {crop}'**
  String natural_rainfall_sufficient_two(Object crop);

  /// No description provided for @storm_adequate_rainfall_two.
  ///
  /// In en, this message translates to:
  /// **'Storm will provide adequate rainfall for {crop}, avoid waterlogging'**
  String storm_adequate_rainfall_two(Object crop);

  /// No description provided for @high_evaporation_requires_more_water.
  ///
  /// In en, this message translates to:
  /// **'High evaporation rate ({evap} mm/day) requires more frequent watering for {crop}'**
  String high_evaporation_requires_more_water(Object crop, Object evap);

  /// No description provided for @dry_warm_requires_careful_irrigation.
  ///
  /// In en, this message translates to:
  /// **'Dry, warm conditions require careful water management for {crop}'**
  String dry_warm_requires_careful_irrigation(Object crop);

  /// No description provided for @moderate_conditions_regular_irrigation_two.
  ///
  /// In en, this message translates to:
  /// **'Moderate conditions - maintain regular irrigation for {crop} ({stage} stage)'**
  String moderate_conditions_regular_irrigation_two(Object crop, Object stage);

  /// No description provided for @high_risk_pests.
  ///
  /// In en, this message translates to:
  /// **'🚨 High Risk Pests:'**
  String get high_risk_pests;

  /// No description provided for @temperature_extremes.
  ///
  /// In en, this message translates to:
  /// **'Temperature extremes may reduce pest activity'**
  String get temperature_extremes;

  /// No description provided for @rain_reduction.
  ///
  /// In en, this message translates to:
  /// **'Rain may reduce some pest populations'**
  String get rain_reduction;

  /// No description provided for @sunny_conditions_favor_pest_development.
  ///
  /// In en, this message translates to:
  /// **'Sunny conditions favor pest development'**
  String get sunny_conditions_favor_pest_development;

  /// No description provided for @varies_with_conditions.
  ///
  /// In en, this message translates to:
  /// **'Varies with conditions'**
  String get varies_with_conditions;

  /// No description provided for @moderate_risk_pests.
  ///
  /// In en, this message translates to:
  /// **'⚠️ Moderate Risk Pests:'**
  String get moderate_risk_pests;

  /// No description provided for @aphids_description.
  ///
  /// In en, this message translates to:
  /// **'Small sap-sucking insects that cause yellowing and curling of leaves.'**
  String get aphids_description;

  /// No description provided for @aphids_active_season.
  ///
  /// In en, this message translates to:
  /// **'Spring and Summer'**
  String get aphids_active_season;

  /// No description provided for @army_worm_description.
  ///
  /// In en, this message translates to:
  /// **'Caterpillars that feed on leaves and can defoliate entire plants.'**
  String get army_worm_description;

  /// No description provided for @army_worm_active_season.
  ///
  /// In en, this message translates to:
  /// **'Summer and Monsoon'**
  String get army_worm_active_season;

  /// No description provided for @bollworm_description.
  ///
  /// In en, this message translates to:
  /// **'Larvae that bore into cotton bolls, causing significant yield loss.'**
  String get bollworm_description;

  /// No description provided for @bollworm_active_season.
  ///
  /// In en, this message translates to:
  /// **'Flowering season'**
  String get bollworm_active_season;

  /// No description provided for @stem_borer_description.
  ///
  /// In en, this message translates to:
  /// **'Larvae that tunnel into stems, causing plants to wilt and die.'**
  String get stem_borer_description;

  /// No description provided for @stem_borer_active_season.
  ///
  /// In en, this message translates to:
  /// **'Throughout growing season'**
  String get stem_borer_active_season;

  /// No description provided for @whitefly_description.
  ///
  /// In en, this message translates to:
  /// **'Small white insects that suck sap and transmit viral diseases.'**
  String get whitefly_description;

  /// No description provided for @whitefly_active_season.
  ///
  /// In en, this message translates to:
  /// **'Warm and dry conditions'**
  String get whitefly_active_season;

  /// No description provided for @rust_fungus_description.
  ///
  /// In en, this message translates to:
  /// **'Fungal disease causing orange-brown pustules on leaves and stems.'**
  String get rust_fungus_description;

  /// No description provided for @rust_fungus_active_season.
  ///
  /// In en, this message translates to:
  /// **'Cool, moist conditions'**
  String get rust_fungus_active_season;

  /// No description provided for @hessian_fly_description.
  ///
  /// In en, this message translates to:
  /// **'Small flies whose larvae feed on wheat stems, stunting growth.'**
  String get hessian_fly_description;

  /// No description provided for @hessian_fly_active_season.
  ///
  /// In en, this message translates to:
  /// **'Fall and Spring'**
  String get hessian_fly_active_season;

  /// No description provided for @spider_mites_description.
  ///
  /// In en, this message translates to:
  /// **'Tiny mites that suck plant juices, causing yellow stippling on leaves.'**
  String get spider_mites_description;

  /// No description provided for @spider_mites_active_season.
  ///
  /// In en, this message translates to:
  /// **'Hot, dry weather'**
  String get spider_mites_active_season;

  /// No description provided for @leaf_folder_description.
  ///
  /// In en, this message translates to:
  /// **'Larvae that fold and feed inside rice leaves, reducing photosynthesis.'**
  String get leaf_folder_description;

  /// No description provided for @leaf_folder_active_season.
  ///
  /// In en, this message translates to:
  /// **'Wet season'**
  String get leaf_folder_active_season;

  /// No description provided for @blast_fungus_description.
  ///
  /// In en, this message translates to:
  /// **'Fungal disease causing lesions on leaves, nodes, and panicles.'**
  String get blast_fungus_description;

  /// No description provided for @blast_fungus_active_season.
  ///
  /// In en, this message translates to:
  /// **'High humidity conditions'**
  String get blast_fungus_active_season;

  /// No description provided for @humidity.
  ///
  /// In en, this message translates to:
  /// **'Humidity'**
  String get humidity;

  /// No description provided for @wind.
  ///
  /// In en, this message translates to:
  /// **'Wind'**
  String get wind;

  /// No description provided for @high_temperature_alert.
  ///
  /// In en, this message translates to:
  /// **'High Temperature Alert'**
  String get high_temperature_alert;

  /// No description provided for @hourly_forecast_not_availale.
  ///
  /// In en, this message translates to:
  /// **'Hourly forecast not available'**
  String get hourly_forecast_not_availale;

  /// No description provided for @now.
  ///
  /// In en, this message translates to:
  /// **'Now'**
  String get now;

  /// No description provided for @seven_day_forecast_not_available.
  ///
  /// In en, this message translates to:
  /// **'7-day forecast not available'**
  String get seven_day_forecast_not_available;

  /// No description provided for @weather_forecast.
  ///
  /// In en, this message translates to:
  /// **'Weather Forecast'**
  String get weather_forecast;

  /// No description provided for @todays_forecast.
  ///
  /// In en, this message translates to:
  /// **'Today\'s Forecast'**
  String get todays_forecast;

  /// No description provided for @seven_days_forecast.
  ///
  /// In en, this message translates to:
  /// **'7 Days Forecast'**
  String get seven_days_forecast;

  /// No description provided for @sun.
  ///
  /// In en, this message translates to:
  /// **'Sun'**
  String get sun;

  /// No description provided for @mon.
  ///
  /// In en, this message translates to:
  /// **'Mon'**
  String get mon;

  /// No description provided for @tue.
  ///
  /// In en, this message translates to:
  /// **'Tue'**
  String get tue;

  /// No description provided for @wed.
  ///
  /// In en, this message translates to:
  /// **'Wed'**
  String get wed;

  /// No description provided for @thu.
  ///
  /// In en, this message translates to:
  /// **'Thu'**
  String get thu;

  /// No description provided for @fri.
  ///
  /// In en, this message translates to:
  /// **'Fri'**
  String get fri;

  /// No description provided for @sat.
  ///
  /// In en, this message translates to:
  /// **'Sat'**
  String get sat;

  /// No description provided for @am.
  ///
  /// In en, this message translates to:
  /// **'AM'**
  String get am;

  /// No description provided for @pm.
  ///
  /// In en, this message translates to:
  /// **'PM'**
  String get pm;

  /// No description provided for @brown_plant_hopper_description.
  ///
  /// In en, this message translates to:
  /// **'Sap-sucking insects that cause hopper burn and transmit viruses.'**
  String get brown_plant_hopper_description;

  /// No description provided for @brown_plant_hopper_active_season.
  ///
  /// In en, this message translates to:
  /// **'Wet season'**
  String get brown_plant_hopper_active_season;

  /// No description provided for @corn_borer_description.
  ///
  /// In en, this message translates to:
  /// **'Larvae that tunnel into corn stalks and ears, reducing yield.'**
  String get corn_borer_description;

  /// No description provided for @corn_borer_active_season.
  ///
  /// In en, this message translates to:
  /// **'Summer months'**
  String get corn_borer_active_season;

  /// No description provided for @earworm_description.
  ///
  /// In en, this message translates to:
  /// **'Caterpillars that feed on corn ears, damaging kernels.'**
  String get earworm_description;

  /// No description provided for @earworm_active_season.
  ///
  /// In en, this message translates to:
  /// **'Silking to harvest'**
  String get earworm_active_season;

  /// No description provided for @corn_leaf_aphid_description.
  ///
  /// In en, this message translates to:
  /// **'Aphids that cluster on leaves and tassels, reducing plant vigor.'**
  String get corn_leaf_aphid_description;

  /// No description provided for @corn_leaf_aphid_active_season.
  ///
  /// In en, this message translates to:
  /// **'Cool weather'**
  String get corn_leaf_aphid_active_season;

  /// No description provided for @prevention_measures_title.
  ///
  /// In en, this message translates to:
  /// **'Prevention Measures'**
  String get prevention_measures_title;

  /// No description provided for @wheat_prevention_1.
  ///
  /// In en, this message translates to:
  /// **'Use certified disease-free seeds'**
  String get wheat_prevention_1;

  /// No description provided for @wheat_prevention_2.
  ///
  /// In en, this message translates to:
  /// **'Practice crop rotation with legumes'**
  String get wheat_prevention_2;

  /// No description provided for @wheat_prevention_3.
  ///
  /// In en, this message translates to:
  /// **'Monitor fields regularly for early detection'**
  String get wheat_prevention_3;

  /// No description provided for @wheat_prevention_4.
  ///
  /// In en, this message translates to:
  /// **'Use neem-based organic pesticides'**
  String get wheat_prevention_4;

  /// No description provided for @wheat_prevention_5.
  ///
  /// In en, this message translates to:
  /// **'Remove and destroy infected plants'**
  String get wheat_prevention_5;

  /// No description provided for @wheat_prevention_6.
  ///
  /// In en, this message translates to:
  /// **'Maintain proper plant spacing for air circulation'**
  String get wheat_prevention_6;

  /// No description provided for @cotton_prevention_1.
  ///
  /// In en, this message translates to:
  /// **'Install yellow sticky traps for whiteflies'**
  String get cotton_prevention_1;

  /// No description provided for @cotton_prevention_2.
  ///
  /// In en, this message translates to:
  /// **'Use pheromone traps for bollworms'**
  String get cotton_prevention_2;

  /// No description provided for @cotton_prevention_3.
  ///
  /// In en, this message translates to:
  /// **'Practice intercropping with marigold'**
  String get cotton_prevention_3;

  /// No description provided for @cotton_prevention_4.
  ///
  /// In en, this message translates to:
  /// **'Apply recommended insecticides at first sight'**
  String get cotton_prevention_4;

  /// No description provided for @cotton_prevention_5.
  ///
  /// In en, this message translates to:
  /// **'Remove crop residues after harvest'**
  String get cotton_prevention_5;

  /// No description provided for @cotton_prevention_6.
  ///
  /// In en, this message translates to:
  /// **'Use resistant varieties when available'**
  String get cotton_prevention_6;

  /// No description provided for @regular_field_monitoring.
  ///
  /// In en, this message translates to:
  /// **'Regular field monitoring'**
  String get regular_field_monitoring;

  /// No description provided for @use_organic_pesticides.
  ///
  /// In en, this message translates to:
  /// **'Use organic pesticides'**
  String get use_organic_pesticides;

  /// No description provided for @practice_crop_rotation.
  ///
  /// In en, this message translates to:
  /// **'Practice crop rotation'**
  String get practice_crop_rotation;

  /// No description provided for @maintain_field_hygiene.
  ///
  /// In en, this message translates to:
  /// **'Maintain Field hygiene'**
  String get maintain_field_hygiene;

  /// No description provided for @use_resistant_varieties.
  ///
  /// In en, this message translates to:
  /// **'Use resistant varieties'**
  String get use_resistant_varieties;

  /// No description provided for @consult_local_agriculature_expert.
  ///
  /// In en, this message translates to:
  /// **'Consult local aggricultural expert'**
  String get consult_local_agriculature_expert;

  /// No description provided for @rice_prevention_1.
  ///
  /// In en, this message translates to:
  /// **'Maintain proper water level in fields'**
  String get rice_prevention_1;

  /// No description provided for @rice_prevention_2.
  ///
  /// In en, this message translates to:
  /// **'Use light traps for monitoring'**
  String get rice_prevention_2;

  /// No description provided for @rice_prevention_3.
  ///
  /// In en, this message translates to:
  /// **'Release natural predators like spiders'**
  String get rice_prevention_3;

  /// No description provided for @rice_prevention_4.
  ///
  /// In en, this message translates to:
  /// **'Apply recommended pesticides at tillering stage'**
  String get rice_prevention_4;

  /// No description provided for @rice_prevention_5.
  ///
  /// In en, this message translates to:
  /// **'Practice synchronous planting in area'**
  String get rice_prevention_5;

  /// No description provided for @rice_prevention_6.
  ///
  /// In en, this message translates to:
  /// **'Remove weed hosts around fields'**
  String get rice_prevention_6;

  /// No description provided for @corn_prevention_1.
  ///
  /// In en, this message translates to:
  /// **'Plant early to avoid peak pest season'**
  String get corn_prevention_1;

  /// No description provided for @corn_prevention_2.
  ///
  /// In en, this message translates to:
  /// **'Use resistant hybrid varieties'**
  String get corn_prevention_2;

  /// No description provided for @corn_prevention_3.
  ///
  /// In en, this message translates to:
  /// **'Practice deep plowing after harvest'**
  String get corn_prevention_3;

  /// No description provided for @corn_prevention_4.
  ///
  /// In en, this message translates to:
  /// **'Apply soil insecticides at planting'**
  String get corn_prevention_4;

  /// No description provided for @corn_prevention_5.
  ///
  /// In en, this message translates to:
  /// **'Monitor for egg masses on leaves'**
  String get corn_prevention_5;

  /// No description provided for @corn_prevention_6.
  ///
  /// In en, this message translates to:
  /// **'Use biological control agents'**
  String get corn_prevention_6;

  /// No description provided for @pest_activity_favorable.
  ///
  /// In en, this message translates to:
  /// **'Weather conditions are favorable for pest activity.'**
  String get pest_activity_favorable;

  /// No description provided for @tap_for_prevention_guide.
  ///
  /// In en, this message translates to:
  /// **'Tap for prevention guide'**
  String get tap_for_prevention_guide;

  /// No description provided for @fertilizer_guide_for.
  ///
  /// In en, this message translates to:
  /// **'Fertilizer Guide for'**
  String get fertilizer_guide_for;

  /// No description provided for @tap_for_details.
  ///
  /// In en, this message translates to:
  /// **'Tap for details'**
  String get tap_for_details;

  /// No description provided for @optimal_irrigation_needed_for.
  ///
  /// In en, this message translates to:
  /// **'Optimal Irrigation Needed for'**
  String get optimal_irrigation_needed_for;

  /// No description provided for @critical_growth_stage_guide.
  ///
  /// In en, this message translates to:
  /// **'crop is at a critical growth stage. Tap for a guide.'**
  String get critical_growth_stage_guide;

  /// No description provided for @you.
  ///
  /// In en, this message translates to:
  /// **'You'**
  String get you;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @error_logout.
  ///
  /// In en, this message translates to:
  /// **'Error logging out:'**
  String get error_logout;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @weather.
  ///
  /// In en, this message translates to:
  /// **'Weather'**
  String get weather;

  /// No description provided for @crop_guide.
  ///
  /// In en, this message translates to:
  /// **'Crop Guide'**
  String get crop_guide;

  /// No description provided for @marketplace.
  ///
  /// In en, this message translates to:
  /// **'Marketplace'**
  String get marketplace;

  /// No description provided for @unknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get unknown;

  /// No description provided for @crop.
  ///
  /// In en, this message translates to:
  /// **'Crop'**
  String get crop;

  /// No description provided for @fertilizer_guide.
  ///
  /// In en, this message translates to:
  /// **'Fertilizer Guide'**
  String get fertilizer_guide;

  /// No description provided for @fertilizer_recommendation.
  ///
  /// In en, this message translates to:
  /// **'Fertilizer Recommendation'**
  String get fertilizer_recommendation;

  /// No description provided for @no_reason_provided.
  ///
  /// In en, this message translates to:
  /// **'No reason provided'**
  String get no_reason_provided;

  /// No description provided for @optimal_application_rate.
  ///
  /// In en, this message translates to:
  /// **'Optimal application rate'**
  String get optimal_application_rate;

  /// No description provided for @adjustment.
  ///
  /// In en, this message translates to:
  /// **'Adjustment'**
  String get adjustment;

  /// No description provided for @none.
  ///
  /// In en, this message translates to:
  /// **'None'**
  String get none;

  /// No description provided for @nitrogen.
  ///
  /// In en, this message translates to:
  /// **'Nitrogen'**
  String get nitrogen;

  /// No description provided for @phosphorus.
  ///
  /// In en, this message translates to:
  /// **'Phosphorus'**
  String get phosphorus;

  /// No description provided for @potassium.
  ///
  /// In en, this message translates to:
  /// **'Potassium'**
  String get potassium;

  /// No description provided for @micronutrients.
  ///
  /// In en, this message translates to:
  /// **'Micronutrients'**
  String get micronutrients;

  /// No description provided for @active_in.
  ///
  /// In en, this message translates to:
  /// **'🕒 Active in:'**
  String get active_in;

  /// No description provided for @application_guide.
  ///
  /// In en, this message translates to:
  /// **'📋 Application Guide:'**
  String get application_guide;

  /// No description provided for @general.
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get general;

  /// No description provided for @recommended_fertilizer_types.
  ///
  /// In en, this message translates to:
  /// **'🧪 Recommended Fertilizer Types:'**
  String get recommended_fertilizer_types;

  /// No description provided for @no_description_available.
  ///
  /// In en, this message translates to:
  /// **'No description available'**
  String get no_description_available;

  /// No description provided for @various_seasons.
  ///
  /// In en, this message translates to:
  /// **'Various Seasons'**
  String get various_seasons;

  /// No description provided for @best_application_timing.
  ///
  /// In en, this message translates to:
  /// **'⏰ Best Application Timing:'**
  String get best_application_timing;

  /// No description provided for @irrigation_guide.
  ///
  /// In en, this message translates to:
  /// **'Irrigation Guide'**
  String get irrigation_guide;

  /// No description provided for @irrigation_recommendation.
  ///
  /// In en, this message translates to:
  /// **'Irrigation Recommendation'**
  String get irrigation_recommendation;

  /// No description provided for @delay_irrigation_rain_expected.
  ///
  /// In en, this message translates to:
  /// **'Delay irrigation - Rain expected'**
  String get delay_irrigation_rain_expected;

  /// No description provided for @natural_rainfall_sufficient.
  ///
  /// In en, this message translates to:
  /// **'Natural rainfall will provide sufficient moisture'**
  String get natural_rainfall_sufficient;

  /// No description provided for @low.
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get low;

  /// No description provided for @delay_irrigation_heavy_rain.
  ///
  /// In en, this message translates to:
  /// **'Delay irrigation - Heavy rain expected'**
  String get delay_irrigation_heavy_rain;

  /// No description provided for @storm_adequate_rainfall.
  ///
  /// In en, this message translates to:
  /// **'Storm will provide adequate rainfall for, avoid waterlogging'**
  String get storm_adequate_rainfall;

  /// No description provided for @increase_irrigation_frequency.
  ///
  /// In en, this message translates to:
  /// **'Increase irrigation frequency'**
  String get increase_irrigation_frequency;

  /// No description provided for @high_evaporation_more_watering.
  ///
  /// In en, this message translates to:
  /// **'High evaporation rate requires more frequent watering'**
  String get high_evaporation_more_watering;

  /// No description provided for @high.
  ///
  /// In en, this message translates to:
  /// **'High'**
  String get high;

  /// No description provided for @reduce_irrigation_frequency.
  ///
  /// In en, this message translates to:
  /// **'Reduce irrigation frequency'**
  String get reduce_irrigation_frequency;

  /// No description provided for @low_evaporation_less_water.
  ///
  /// In en, this message translates to:
  /// **'Low evaporation rate needs less water'**
  String get low_evaporation_less_water;

  /// No description provided for @monitor_soil_moisture.
  ///
  /// In en, this message translates to:
  /// **'Monitor soil moisture closely'**
  String get monitor_soil_moisture;

  /// No description provided for @dry_warm_conditions.
  ///
  /// In en, this message translates to:
  /// **'Dry, warm conditions require careful water management'**
  String get dry_warm_conditions;

  /// No description provided for @medium.
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get medium;

  /// No description provided for @normal_irrigation_schedule.
  ///
  /// In en, this message translates to:
  /// **'Normal irrigation schedule'**
  String get normal_irrigation_schedule;

  /// No description provided for @moderate_conditions_regular_irrigation.
  ///
  /// In en, this message translates to:
  /// **'Moderate conditions - maintain regular irrigation'**
  String get moderate_conditions_regular_irrigation;

  /// No description provided for @wheat.
  ///
  /// In en, this message translates to:
  /// **'Wheat'**
  String get wheat;

  /// No description provided for @apply_one_third_nitrogen_sowing.
  ///
  /// In en, this message translates to:
  /// **'Apply 1/3 of nitrogen at sowing'**
  String get apply_one_third_nitrogen_sowing;

  /// No description provided for @apply_remaining_nitrogen_splits.
  ///
  /// In en, this message translates to:
  /// **'Apply remaining nitrogen in two splits during tillering and jointing'**
  String get apply_remaining_nitrogen_splits;

  /// No description provided for @mix_fertilizers_thoroughly.
  ///
  /// In en, this message translates to:
  /// **'Mix fertilizers thoroughly in soil'**
  String get mix_fertilizers_thoroughly;

  /// No description provided for @apply_when_soil_moist.
  ///
  /// In en, this message translates to:
  /// **'Apply when soil has adequate moisture'**
  String get apply_when_soil_moist;

  /// No description provided for @avoid_heavy_rainfall_application.
  ///
  /// In en, this message translates to:
  /// **'Avoid application during heavy rainfall'**
  String get avoid_heavy_rainfall_application;

  /// No description provided for @use_soil_test_recommendations.
  ///
  /// In en, this message translates to:
  /// **'Use soil test-based recommendations'**
  String get use_soil_test_recommendations;

  /// No description provided for @cotton.
  ///
  /// In en, this message translates to:
  /// **'Cotton'**
  String get cotton;

  /// No description provided for @apply_full_phosphorus_potassium.
  ///
  /// In en, this message translates to:
  /// **'Apply full dose of phosphorus and potassium at sowing'**
  String get apply_full_phosphorus_potassium;

  /// No description provided for @split_nitrogen_three_four_doses.
  ///
  /// In en, this message translates to:
  /// **'Split nitrogen application in 3-4 doses, First dose at sowing, second at squaring, Third dose at flowering, fourth if needed'**
  String get split_nitrogen_three_four_doses;

  /// No description provided for @apply_in_bands.
  ///
  /// In en, this message translates to:
  /// **'Apply in bands 5-7 cm deep'**
  String get apply_in_bands;

  /// No description provided for @irrigate_after_application.
  ///
  /// In en, this message translates to:
  /// **'Irrigate immediately after application'**
  String get irrigate_after_application;

  /// No description provided for @rice.
  ///
  /// In en, this message translates to:
  /// **'Rice'**
  String get rice;

  /// No description provided for @apply_basal_before_pudding.
  ///
  /// In en, this message translates to:
  /// **'Apply basal dose before pudding'**
  String get apply_basal_before_pudding;

  /// No description provided for @split_nitrogen_three_equal_doses.
  ///
  /// In en, this message translates to:
  /// **'Spliting nitrogen into three equal doses: '**
  String get split_nitrogen_three_equal_doses;

  /// No description provided for @first_second_third.
  ///
  /// In en, this message translates to:
  /// **'First at transplanting, second at tillering, third at panicle initiation'**
  String get first_second_third;

  /// No description provided for @apply_in_standing_water.
  ///
  /// In en, this message translates to:
  /// **'Apply in standing water for better efficiency'**
  String get apply_in_standing_water;

  /// No description provided for @use_urea_super_granules.
  ///
  /// In en, this message translates to:
  /// **'Use urea super granules for better results'**
  String get use_urea_super_granules;

  /// No description provided for @avoid_strong_wind_application.
  ///
  /// In en, this message translates to:
  /// **'Avoid application during strong winds'**
  String get avoid_strong_wind_application;

  /// No description provided for @corn.
  ///
  /// In en, this message translates to:
  /// **'Corn'**
  String get corn;

  /// No description provided for @apply_starter_fertilizer_planting.
  ///
  /// In en, this message translates to:
  /// **'Apply starter fertilizer at planting'**
  String get apply_starter_fertilizer_planting;

  /// No description provided for @side_dress_nitrogen.
  ///
  /// In en, this message translates to:
  /// **'Side-dress nitrogen when plants are 30-45 cm tall'**
  String get side_dress_nitrogen;

  /// No description provided for @apply_phosphorus_potassium_soil_test.
  ///
  /// In en, this message translates to:
  /// **'Apply phosphorus and potassium based on soil test'**
  String get apply_phosphorus_potassium_soil_test;

  /// No description provided for @use_split_for_sandy_soils.
  ///
  /// In en, this message translates to:
  /// **'Use split applications for sandy soils'**
  String get use_split_for_sandy_soils;

  /// No description provided for @avoid_root_contact_concentrated.
  ///
  /// In en, this message translates to:
  /// **'Avoid root contact with concentrated fertilizers'**
  String get avoid_root_contact_concentrated;

  /// No description provided for @apply_based_on_soil_test.
  ///
  /// In en, this message translates to:
  /// **'Apply fertilizers based on soil test results'**
  String get apply_based_on_soil_test;

  /// No description provided for @split_applications_for_efficiency.
  ///
  /// In en, this message translates to:
  /// **'Split applications for better efficiency'**
  String get split_applications_for_efficiency;

  /// No description provided for @incorporate_fertilizers_properly.
  ///
  /// In en, this message translates to:
  /// **'Incorporate fertilizers properly into soil'**
  String get incorporate_fertilizers_properly;

  /// No description provided for @apply_when_plants_growing.
  ///
  /// In en, this message translates to:
  /// **'Apply when plants are actively growing'**
  String get apply_when_plants_growing;

  /// No description provided for @avoid_extreme_weather_application.
  ///
  /// In en, this message translates to:
  /// **'Avoid application during extreme weather'**
  String get avoid_extreme_weather_application;

  /// No description provided for @apply_fertilizers_based_on_soil_test.
  ///
  /// In en, this message translates to:
  /// **'Apply fertilizers based on soil test results'**
  String get apply_fertilizers_based_on_soil_test;

  /// No description provided for @apply_during_active_growth.
  ///
  /// In en, this message translates to:
  /// **'Apply when plants are actively growing'**
  String get apply_during_active_growth;

  /// No description provided for @follow_recommended_dosage.
  ///
  /// In en, this message translates to:
  /// **'Follow recommended dosage strictly'**
  String get follow_recommended_dosage;

  /// No description provided for @focus_on_nitrogen.
  ///
  /// In en, this message translates to:
  /// **'Focus on nitrogen application'**
  String get focus_on_nitrogen;

  /// No description provided for @avoid_drought_application.
  ///
  /// In en, this message translates to:
  /// **'Avoid application during drought'**
  String get avoid_drought_application;

  /// No description provided for @best_before_rainfall.
  ///
  /// In en, this message translates to:
  /// **'Best applied before expected rainfall'**
  String get best_before_rainfall;

  /// No description provided for @monitor_leaf_color_deficiencies.
  ///
  /// In en, this message translates to:
  /// **'Monitor leaf color for deficiencies'**
  String get monitor_leaf_color_deficiencies;

  /// No description provided for @evapotranspiration_rate.
  ///
  /// In en, this message translates to:
  /// **'Evapotranspiration Rate:'**
  String get evapotranspiration_rate;

  /// No description provided for @reduce_nitrogen_application.
  ///
  /// In en, this message translates to:
  /// **'Reduce nitrogen application'**
  String get reduce_nitrogen_application;

  /// No description provided for @increase_phosphorus_for_flowering.
  ///
  /// In en, this message translates to:
  /// **'Increase phosphorus for flower formation'**
  String get increase_phosphorus_for_flowering;

  /// No description provided for @apply_before_flower_buds_open.
  ///
  /// In en, this message translates to:
  /// **'Apply before flower buds open'**
  String get apply_before_flower_buds_open;

  /// No description provided for @avoid_full_bloom_application.
  ///
  /// In en, this message translates to:
  /// **'Avoid application during full bloom'**
  String get avoid_full_bloom_application;

  /// No description provided for @monitor_nutrient_deficiencies.
  ///
  /// In en, this message translates to:
  /// **'Monitor for nutrient deficiencies'**
  String get monitor_nutrient_deficiencies;

  /// No description provided for @critical_for_nitrogen_application.
  ///
  /// In en, this message translates to:
  /// **'Critical for nitrogen application'**
  String get critical_for_nitrogen_application;

  /// No description provided for @apply_when_tillers_develop.
  ///
  /// In en, this message translates to:
  /// **'Apply when tillers start developing'**
  String get apply_when_tillers_develop;

  /// No description provided for @split_application_recommended.
  ///
  /// In en, this message translates to:
  /// **'Split application recommended'**
  String get split_application_recommended;

  /// No description provided for @ensure_adequate_soil_moisture.
  ///
  /// In en, this message translates to:
  /// **'Ensure adequate soil moisture'**
  String get ensure_adequate_soil_moisture;

  /// No description provided for @monitor_tiller_count.
  ///
  /// In en, this message translates to:
  /// **'Monitor tiller count regularly'**
  String get monitor_tiller_count;

  /// No description provided for @focus_on_potassium_application.
  ///
  /// In en, this message translates to:
  /// **'Focus on potassium application'**
  String get focus_on_potassium_application;

  /// No description provided for @apply_early_silking_stage.
  ///
  /// In en, this message translates to:
  /// **'Apply during early silking stage'**
  String get apply_early_silking_stage;

  /// No description provided for @reduce_nitrogen_excess_growth.
  ///
  /// In en, this message translates to:
  /// **'Reduce nitrogen to prevent excessive growth'**
  String get reduce_nitrogen_excess_growth;

  /// No description provided for @ensure_balanced_nutrition.
  ///
  /// In en, this message translates to:
  /// **'Ensure balanced nutrition'**
  String get ensure_balanced_nutrition;

  /// No description provided for @monitor_ear_development.
  ///
  /// In en, this message translates to:
  /// **'Monitor ear development'**
  String get monitor_ear_development;

  /// No description provided for @apply_early_pod_development.
  ///
  /// In en, this message translates to:
  /// **'Apply during early pod development'**
  String get apply_early_pod_development;

  /// No description provided for @monitor_pod_setting_rate.
  ///
  /// In en, this message translates to:
  /// **'Monitor pod setting rate'**
  String get monitor_pod_setting_rate;

  /// No description provided for @avoid_stress_conditions.
  ///
  /// In en, this message translates to:
  /// **'Avoid application during stress conditions'**
  String get avoid_stress_conditions;

  /// No description provided for @follow_crop_specific_schedule.
  ///
  /// In en, this message translates to:
  /// **'Follow crop-specific schedules'**
  String get follow_crop_specific_schedule;

  /// No description provided for @consider_weather_conditions.
  ///
  /// In en, this message translates to:
  /// **'Consider weather conditions'**
  String get consider_weather_conditions;

  /// No description provided for @monitor_plant_response.
  ///
  /// In en, this message translates to:
  /// **'Monitor plant response after application'**
  String get monitor_plant_response;

  /// No description provided for @fertilizer_wheat_nitrogen.
  ///
  /// In en, this message translates to:
  /// **'Urea (46-0-0)'**
  String get fertilizer_wheat_nitrogen;

  /// No description provided for @fertilizer_wheat_phosphorus.
  ///
  /// In en, this message translates to:
  /// **'DAP (18-46-0)'**
  String get fertilizer_wheat_phosphorus;

  /// No description provided for @fertilizer_wheat_potassium.
  ///
  /// In en, this message translates to:
  /// **'MOP (0-0-60)'**
  String get fertilizer_wheat_potassium;

  /// No description provided for @fertilizer_wheat_micronutrients.
  ///
  /// In en, this message translates to:
  /// **'Zinc Sulfate'**
  String get fertilizer_wheat_micronutrients;

  /// No description provided for @fertilizer_cotton_nitrogen.
  ///
  /// In en, this message translates to:
  /// **'Urea (46-0-0)'**
  String get fertilizer_cotton_nitrogen;

  /// No description provided for @fertilizer_cotton_phosphorus.
  ///
  /// In en, this message translates to:
  /// **'SSP (0-16-0)'**
  String get fertilizer_cotton_phosphorus;

  /// No description provided for @fertilizer_cotton_potassium.
  ///
  /// In en, this message translates to:
  /// **'MOP (0-0-60)'**
  String get fertilizer_cotton_potassium;

  /// No description provided for @fertilizer_cotton_micronutrients.
  ///
  /// In en, this message translates to:
  /// **'Boron, Zinc'**
  String get fertilizer_cotton_micronutrients;

  /// No description provided for @fertilizer_rice_nitrogen.
  ///
  /// In en, this message translates to:
  /// **'Urea (46-0-0)'**
  String get fertilizer_rice_nitrogen;

  /// No description provided for @fertilizer_rice_phosphorus.
  ///
  /// In en, this message translates to:
  /// **'DAP (18-46-0)'**
  String get fertilizer_rice_phosphorus;

  /// No description provided for @fertilizer_rice_potassium.
  ///
  /// In en, this message translates to:
  /// **'MOP (0-0-60)'**
  String get fertilizer_rice_potassium;

  /// No description provided for @fertilizer_rice_micronutrients.
  ///
  /// In en, this message translates to:
  /// **'Zinc Sulfate'**
  String get fertilizer_rice_micronutrients;

  /// No description provided for @fertilizer_corn_nitrogen.
  ///
  /// In en, this message translates to:
  /// **'Urea (46-0-0)'**
  String get fertilizer_corn_nitrogen;

  /// No description provided for @fertilizer_corn_phosphorus.
  ///
  /// In en, this message translates to:
  /// **'NPK (17-17-17)'**
  String get fertilizer_corn_phosphorus;

  /// No description provided for @fertilizer_corn_potassium.
  ///
  /// In en, this message translates to:
  /// **'MOP (0-0-60)'**
  String get fertilizer_corn_potassium;

  /// No description provided for @fertilizer_corn_micronutrients.
  ///
  /// In en, this message translates to:
  /// **'Zinc, Iron'**
  String get fertilizer_corn_micronutrients;

  /// No description provided for @fertilizer_default_nitrogen.
  ///
  /// In en, this message translates to:
  /// **'Urea or Ammonium-based'**
  String get fertilizer_default_nitrogen;

  /// No description provided for @fertilizer_default_phosphorus.
  ///
  /// In en, this message translates to:
  /// **'DAP or SSP'**
  String get fertilizer_default_phosphorus;

  /// No description provided for @fertilizer_default_potassium.
  ///
  /// In en, this message translates to:
  /// **'MOP or SOP'**
  String get fertilizer_default_potassium;

  /// No description provided for @fertilizer_default_micronutrients.
  ///
  /// In en, this message translates to:
  /// **'As per soil test'**
  String get fertilizer_default_micronutrients;

  /// No description provided for @error_initializing_firebase.
  ///
  /// In en, this message translates to:
  /// **'Error initializing Firebase:'**
  String get error_initializing_firebase;

  /// No description provided for @error_updating_first_time_status.
  ///
  /// In en, this message translates to:
  /// **'Error updating first-time status'**
  String get error_updating_first_time_status;

  /// No description provided for @your_journey_begins_here.
  ///
  /// In en, this message translates to:
  /// **'Your farming journey begins here'**
  String get your_journey_begins_here;

  /// No description provided for @preparing_your_dashboard.
  ///
  /// In en, this message translates to:
  /// **'Preparing your personalized dashboard...'**
  String get preparing_your_dashboard;

  /// No description provided for @tap_to_continue.
  ///
  /// In en, this message translates to:
  /// **'Tap to continue'**
  String get tap_to_continue;

  /// No description provided for @irrigation_schedule.
  ///
  /// In en, this message translates to:
  /// **'📅 Irrigation Schedule:'**
  String get irrigation_schedule;

  /// No description provided for @wheat_first_irrigation.
  ///
  /// In en, this message translates to:
  /// **'First Irrigation:'**
  String get wheat_first_irrigation;

  /// No description provided for @wheat_first_irrigation_value.
  ///
  /// In en, this message translates to:
  /// **'20-25 days after sowing (Crown root initiation)'**
  String get wheat_first_irrigation_value;

  /// No description provided for @wheat_second_irrigation.
  ///
  /// In en, this message translates to:
  /// **'Second Irrigation:'**
  String get wheat_second_irrigation;

  /// No description provided for @wheat_second_irrigation_value.
  ///
  /// In en, this message translates to:
  /// **'45-50 days after sowing (Tillering)'**
  String get wheat_second_irrigation_value;

  /// No description provided for @wheat_third_irrigation.
  ///
  /// In en, this message translates to:
  /// **'Third Irrigation:'**
  String get wheat_third_irrigation;

  /// No description provided for @wheat_third_irrigation_value.
  ///
  /// In en, this message translates to:
  /// **'70-75 days after sowing (Jointing)'**
  String get wheat_third_irrigation_value;

  /// No description provided for @wheat_fourth_irrigation.
  ///
  /// In en, this message translates to:
  /// **'Fourth Irrigation: '**
  String get wheat_fourth_irrigation;

  /// No description provided for @wheat_fourth_irrigation_value.
  ///
  /// In en, this message translates to:
  /// **'90-95 days after sowing (Booting)'**
  String get wheat_fourth_irrigation_value;

  /// No description provided for @wheat_fifth_irrigation.
  ///
  /// In en, this message translates to:
  /// **'Fifth Irrigation:'**
  String get wheat_fifth_irrigation;

  /// No description provided for @wheat_fifth_irrigation_value.
  ///
  /// In en, this message translates to:
  /// **'110-115 days after sowing (Grain filling)'**
  String get wheat_fifth_irrigation_value;

  /// No description provided for @cotton_first_irrigation.
  ///
  /// In en, this message translates to:
  /// **'First Irrigation: '**
  String get cotton_first_irrigation;

  /// No description provided for @cotton_first_irrigation_value.
  ///
  /// In en, this message translates to:
  /// **'30-35 days after sowing (Vegetative stage)'**
  String get cotton_first_irrigation_value;

  /// No description provided for @cotton_second_irrigation.
  ///
  /// In en, this message translates to:
  /// **'Second Irrigation: '**
  String get cotton_second_irrigation;

  /// No description provided for @cotton_second_irrigation_value.
  ///
  /// In en, this message translates to:
  /// **'During squaring stage'**
  String get cotton_second_irrigation_value;

  /// No description provided for @cotton_third_irrigation.
  ///
  /// In en, this message translates to:
  /// **'Third Irrigation: '**
  String get cotton_third_irrigation;

  /// No description provided for @cotton_third_irrigation_value.
  ///
  /// In en, this message translates to:
  /// **'During flowering stage'**
  String get cotton_third_irrigation_value;

  /// No description provided for @cotton_fourth_irrigation.
  ///
  /// In en, this message translates to:
  /// **'Fourth Irrigation: '**
  String get cotton_fourth_irrigation;

  /// No description provided for @cotton_fourth_irrigation_value.
  ///
  /// In en, this message translates to:
  /// **'Boll formation stage'**
  String get cotton_fourth_irrigation_value;

  /// No description provided for @cotton_fifth_irrigation.
  ///
  /// In en, this message translates to:
  /// **'Fifth Irrigation: '**
  String get cotton_fifth_irrigation;

  /// No description provided for @cotton_fifth_irrigation_value.
  ///
  /// In en, this message translates to:
  /// **'Boll development stage'**
  String get cotton_fifth_irrigation_value;

  /// No description provided for @rice_initial_flooding.
  ///
  /// In en, this message translates to:
  /// **'Initial Flooding: '**
  String get rice_initial_flooding;

  /// No description provided for @rice_initial_flooding_value.
  ///
  /// In en, this message translates to:
  /// **'3-5 cm standing water after transplanting'**
  String get rice_initial_flooding_value;

  /// No description provided for @rice_vegetative_stage.
  ///
  /// In en, this message translates to:
  /// **'Vegetative Stage:'**
  String get rice_vegetative_stage;

  /// No description provided for @rice_vegetative_stage_value.
  ///
  /// In en, this message translates to:
  /// **'Maintain 2-5 cm standing water'**
  String get rice_vegetative_stage_value;

  /// No description provided for @rice_reproductive_stage.
  ///
  /// In en, this message translates to:
  /// **'Reproductive Stage: '**
  String get rice_reproductive_stage;

  /// No description provided for @rice_reproductive_stage_value.
  ///
  /// In en, this message translates to:
  /// **'Maintain 5-10 cm standing water'**
  String get rice_reproductive_stage_value;

  /// No description provided for @rice_ripening_stage.
  ///
  /// In en, this message translates to:
  /// **'Ripening Stage: '**
  String get rice_ripening_stage;

  /// No description provided for @rice_ripening_stage_value.
  ///
  /// In en, this message translates to:
  /// **'Gradually reduce water 2 weeks before harvest'**
  String get rice_ripening_stage_value;

  /// No description provided for @corn_first_irrigation.
  ///
  /// In en, this message translates to:
  /// **'First Irrigation: Immediately after sowing'**
  String get corn_first_irrigation;

  /// No description provided for @corn_first_irrigation_value.
  ///
  /// In en, this message translates to:
  /// **'Immediately after sowing'**
  String get corn_first_irrigation_value;

  /// No description provided for @corn_second_irrigation.
  ///
  /// In en, this message translates to:
  /// **'Second Irrigation: Knee-high stage (30-45 cm)'**
  String get corn_second_irrigation;

  /// No description provided for @corn_second_irrigation_value.
  ///
  /// In en, this message translates to:
  /// **'Knee-high stage (30-45 cm)'**
  String get corn_second_irrigation_value;

  /// No description provided for @corn_third_irrigation.
  ///
  /// In en, this message translates to:
  /// **'Third Irrigation: '**
  String get corn_third_irrigation;

  /// No description provided for @corn_third_irrigation_value.
  ///
  /// In en, this message translates to:
  /// **'Tasseling stage'**
  String get corn_third_irrigation_value;

  /// No description provided for @corn_fourth_irrigation.
  ///
  /// In en, this message translates to:
  /// **'Fourth Irrigation: '**
  String get corn_fourth_irrigation;

  /// No description provided for @corn_fourth_irrigation_value.
  ///
  /// In en, this message translates to:
  /// **'Silking stage'**
  String get corn_fourth_irrigation_value;

  /// No description provided for @corn_fifth_irrigation.
  ///
  /// In en, this message translates to:
  /// **'Fifth Irrigation: '**
  String get corn_fifth_irrigation;

  /// No description provided for @corn_fifth_irrigation_value.
  ///
  /// In en, this message translates to:
  /// **'Grain filling stage'**
  String get corn_fifth_irrigation_value;

  /// No description provided for @general_rule.
  ///
  /// In en, this message translates to:
  /// **'General Rule: '**
  String get general_rule;

  /// No description provided for @general_rule_value.
  ///
  /// In en, this message translates to:
  /// **'Irrigate when top 15 cm soil feels dry'**
  String get general_rule_value;

  /// No description provided for @general_pests_that_affect_crop.
  ///
  /// In en, this message translates to:
  /// **'General pest that affects crop health and yield.'**
  String get general_pests_that_affect_crop;

  /// No description provided for @critical_stages.
  ///
  /// In en, this message translates to:
  /// **'Critical Stages: '**
  String get critical_stages;

  /// No description provided for @critical_stages_value.
  ///
  /// In en, this message translates to:
  /// **'Ensure adequate moisture during flowering and fruit setting'**
  String get critical_stages_value;

  /// No description provided for @water_quantity.
  ///
  /// In en, this message translates to:
  /// **'Water Quantity: '**
  String get water_quantity;

  /// No description provided for @water_quantity_value.
  ///
  /// In en, this message translates to:
  /// **'Apply 5-7 cm depth per irrigation'**
  String get water_quantity_value;

  /// No description provided for @monitoring.
  ///
  /// In en, this message translates to:
  /// **'Monitoring: '**
  String get monitoring;

  /// No description provided for @monitoring_value.
  ///
  /// In en, this message translates to:
  /// **'RCheck soil moisture regularly'**
  String get monitoring_value;

  /// No description provided for @water_management_tips.
  ///
  /// In en, this message translates to:
  /// **'💧 Water Management Tips:'**
  String get water_management_tips;

  /// No description provided for @high_tip_first.
  ///
  /// In en, this message translates to:
  /// **'Irrigate immediately if soil is dry'**
  String get high_tip_first;

  /// No description provided for @high_tip_second.
  ///
  /// In en, this message translates to:
  /// **'Use mulching to conserve soil moisture'**
  String get high_tip_second;

  /// No description provided for @high_tip_third.
  ///
  /// In en, this message translates to:
  /// **'Consider drip irrigation for efficiency'**
  String get high_tip_third;

  /// No description provided for @high_tip_fourth.
  ///
  /// In en, this message translates to:
  /// **'Monitor plants for wilting signs'**
  String get high_tip_fourth;

  /// No description provided for @high_tip_fifth.
  ///
  /// In en, this message translates to:
  /// **'Water in early morning or late evening'**
  String get high_tip_fifth;

  /// No description provided for @high_tip_sixth.
  ///
  /// In en, this message translates to:
  /// **'Check soil moisture daily'**
  String get high_tip_sixth;

  /// No description provided for @medium_tip_first.
  ///
  /// In en, this message translates to:
  /// **'Follow regular irrigation schedule'**
  String get medium_tip_first;

  /// No description provided for @medium_tip_second.
  ///
  /// In en, this message translates to:
  /// **'Check soil moisture every 2-3 days'**
  String get medium_tip_second;

  /// No description provided for @medium_tip_third.
  ///
  /// In en, this message translates to:
  /// **'Adjust based on rainfall'**
  String get medium_tip_third;

  /// No description provided for @medium_tip_fourth.
  ///
  /// In en, this message translates to:
  /// **'Use water conservation techniques'**
  String get medium_tip_fourth;

  /// No description provided for @medium_tip_fifth.
  ///
  /// In en, this message translates to:
  /// **'Monitor weather forecasts'**
  String get medium_tip_fifth;

  /// No description provided for @medium_tip_sixth.
  ///
  /// In en, this message translates to:
  /// **'Maintain irrigation records'**
  String get medium_tip_sixth;

  /// No description provided for @low_tip_first.
  ///
  /// In en, this message translates to:
  /// **'Delay irrigation if rain is forecast'**
  String get low_tip_first;

  /// No description provided for @low_tip_second.
  ///
  /// In en, this message translates to:
  /// **'Check soil moisture before watering'**
  String get low_tip_second;

  /// No description provided for @low_tip_third.
  ///
  /// In en, this message translates to:
  /// **'Reduce irrigation frequency'**
  String get low_tip_third;

  /// No description provided for @low_tip_fourth.
  ///
  /// In en, this message translates to:
  /// **'Use water-saving methods'**
  String get low_tip_fourth;

  /// No description provided for @low_tip_fifth.
  ///
  /// In en, this message translates to:
  /// **'Monitor for over-watering signs'**
  String get low_tip_fifth;

  /// No description provided for @low_tip_sixth.
  ///
  /// In en, this message translates to:
  /// **'Collect rainwater if possible'**
  String get low_tip_sixth;

  /// No description provided for @return_tip_first.
  ///
  /// In en, this message translates to:
  /// **'Check soil moisture before irrigation'**
  String get return_tip_first;

  /// No description provided for @return_tip_second.
  ///
  /// In en, this message translates to:
  /// **'Water based on plant needs, not fixed schedule'**
  String get return_tip_second;

  /// No description provided for @return_tip_third.
  ///
  /// In en, this message translates to:
  /// **'Use efficient irrigation methods'**
  String get return_tip_third;

  /// No description provided for @return_tip_fourth.
  ///
  /// In en, this message translates to:
  /// **'Monitor weather conditions'**
  String get return_tip_fourth;

  /// No description provided for @return_tip_fifth.
  ///
  /// In en, this message translates to:
  /// **'Avoid waterlogging'**
  String get return_tip_fifth;

  /// No description provided for @return_tip_sixth.
  ///
  /// In en, this message translates to:
  /// **'Maintain proper drainage'**
  String get return_tip_sixth;

  /// No description provided for @irrigation_methods.
  ///
  /// In en, this message translates to:
  /// **'⚙️ Irrigation Methods:'**
  String get irrigation_methods;

  /// No description provided for @drip_irrigation.
  ///
  /// In en, this message translates to:
  /// **'Drip Irrigation'**
  String get drip_irrigation;

  /// No description provided for @drip_irrigation_desc.
  ///
  /// In en, this message translates to:
  /// **'Most efficient method, saves 30-50% water, ideal for row crops'**
  String get drip_irrigation_desc;

  /// No description provided for @sprinkler_irrigation.
  ///
  /// In en, this message translates to:
  /// **'Sprinkler Irrigation'**
  String get sprinkler_irrigation;

  /// No description provided for @sprinkler_irrigation_desc.
  ///
  /// In en, this message translates to:
  /// **'Good for uniform coverage, suitable for most field crops'**
  String get sprinkler_irrigation_desc;

  /// No description provided for @furrow_irrigation.
  ///
  /// In en, this message translates to:
  /// **'Furrow Irrigation'**
  String get furrow_irrigation;

  /// No description provided for @furrow_irrigation_desc.
  ///
  /// In en, this message translates to:
  /// **'Traditional method for row crops, moderate efficiency'**
  String get furrow_irrigation_desc;

  /// No description provided for @flood_irrigation.
  ///
  /// In en, this message translates to:
  /// **'Flood Irrigation'**
  String get flood_irrigation;

  /// No description provided for @flood_irrigation_desc.
  ///
  /// In en, this message translates to:
  /// **'Used for rice and some field crops, lower efficiency'**
  String get flood_irrigation_desc;

  /// No description provided for @basin_irrigation.
  ///
  /// In en, this message translates to:
  /// **'Basin Irrigation'**
  String get basin_irrigation;

  /// No description provided for @basin_irrigation_desc.
  ///
  /// In en, this message translates to:
  /// **'Suitable for orchards and some field crops'**
  String get basin_irrigation_desc;

  /// No description provided for @high_risk_message.
  ///
  /// In en, this message translates to:
  /// **'High risk of {pests} infestation in {cropName}'**
  String high_risk_message(Object cropName, Object pests);

  /// No description provided for @moderate_risk_message.
  ///
  /// In en, this message translates to:
  /// **'Monitor {cropName} for {pests}'**
  String moderate_risk_message(Object cropName, Object pests);

  /// No description provided for @low_risk_message.
  ///
  /// In en, this message translates to:
  /// **'Low pest risk for {cropName} in current conditions'**
  String low_risk_message(Object cropName);

  /// No description provided for @generic_pest.
  ///
  /// In en, this message translates to:
  /// **'pest'**
  String get generic_pest;

  /// No description provided for @potential_pests.
  ///
  /// In en, this message translates to:
  /// **'potential pests'**
  String get potential_pests;

  /// No description provided for @high_temp_burn_risk.
  ///
  /// In en, this message translates to:
  /// **'High temperatures increase fertilizer burn risk for {cropName}'**
  String high_temp_burn_risk(Object cropName);

  /// No description provided for @warm_weather_nutrient_availability.
  ///
  /// In en, this message translates to:
  /// **'Warm weather increases nutrient availability for {cropName}'**
  String warm_weather_nutrient_availability(Object cropName);

  /// No description provided for @cold_temp_slow_growth.
  ///
  /// In en, this message translates to:
  /// **'Cold temperatures slow {cropName} growth and nutrient uptake'**
  String cold_temp_slow_growth(Object cropName);

  /// No description provided for @optimal_temp_application.
  ///
  /// In en, this message translates to:
  /// **'Optimal temperature for {cropName} fertilizer application'**
  String optimal_temp_application(Object cropName);

  /// No description provided for @rain_absorption_help.
  ///
  /// In en, this message translates to:
  /// **'Rain will help {cropName} absorb nutrients efficiently'**
  String rain_absorption_help(Object cropName);

  /// No description provided for @irrigation_required_after_application.
  ///
  /// In en, this message translates to:
  /// **'{cropName} may require irrigation after application'**
  String irrigation_required_after_application(Object cropName);

  /// No description provided for @as_per_soil_test.
  ///
  /// In en, this message translates to:
  /// **'As per soil test recommendations'**
  String get as_per_soil_test;

  /// No description provided for @natural_rainfall_sufficient_three.
  ///
  /// In en, this message translates to:
  /// **'Natural rainfall will provide sufficient moisture for {crop}'**
  String natural_rainfall_sufficient_three(Object crop);

  /// No description provided for @storm_rainfall_avoid_waterlogging_three.
  ///
  /// In en, this message translates to:
  /// **'Storm will provide adequate rainfall for {crop}, avoid waterlogging'**
  String storm_rainfall_avoid_waterlogging_three(Object crop);

  /// No description provided for @high_evaporation_requires_more_water_three.
  ///
  /// In en, this message translates to:
  /// **'High evaporation rate ({et} mm/day) requires more frequent watering for {crop}'**
  String high_evaporation_requires_more_water_three(Object crop, Object et);

  /// No description provided for @low_evaporation_less_water_three.
  ///
  /// In en, this message translates to:
  /// **'Low evaporation rate ({et} mm/day) - {crop} needs less water'**
  String low_evaporation_less_water_three(Object crop, Object et);

  /// No description provided for @dry_warm_conditions_water_management_three.
  ///
  /// In en, this message translates to:
  /// **'Dry, warm conditions require careful water management for {crop}'**
  String dry_warm_conditions_water_management_three(Object crop);

  /// No description provided for @normal_irrigation_schedule_three.
  ///
  /// In en, this message translates to:
  /// **'Normal irrigation schedule'**
  String get normal_irrigation_schedule_three;

  /// No description provided for @moderate_conditions_regular_irrigation_three.
  ///
  /// In en, this message translates to:
  /// **'Moderate conditions - maintain regular irrigation for {crop} ({stage} stage)'**
  String moderate_conditions_regular_irrigation_three(Object crop, Object stage);

  /// No description provided for @urgency_low.
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get urgency_low;

  /// No description provided for @urgency_medium.
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get urgency_medium;

  /// No description provided for @urgency_high.
  ///
  /// In en, this message translates to:
  /// **'High'**
  String get urgency_high;

  /// No description provided for @mm_day.
  ///
  /// In en, this message translates to:
  /// **'mm/day'**
  String get mm_day;

  /// No description provided for @wheat_summary.
  ///
  /// In en, this message translates to:
  /// **'Wheat is a staple Rabi crop requiring cool weather (15-25°C) during growth and moderate rainfall. Ideal sowing season is October-December.'**
  String get wheat_summary;

  /// No description provided for @wheat_p_title.
  ///
  /// In en, this message translates to:
  /// **'Planting'**
  String get wheat_p_title;

  /// No description provided for @wheat_p1.
  ///
  /// In en, this message translates to:
  /// **'Sow from October to December for Rabi season'**
  String get wheat_p1;

  /// No description provided for @wheat_p2.
  ///
  /// In en, this message translates to:
  /// **'Use certified seeds like Punjab-2011, Galaxy-2013'**
  String get wheat_p2;

  /// No description provided for @wheat_p3.
  ///
  /// In en, this message translates to:
  /// **'Optimal seed rate: 40-50 kg/acre'**
  String get wheat_p3;

  /// No description provided for @wheat_p4.
  ///
  /// In en, this message translates to:
  /// **'Row spacing: 22-25 cm'**
  String get wheat_p4;

  /// No description provided for @wheat_p5.
  ///
  /// In en, this message translates to:
  /// **'Sow at depth of 4-5 cm'**
  String get wheat_p5;

  /// No description provided for @wheat_i_title.
  ///
  /// In en, this message translates to:
  /// **'Irrigation'**
  String get wheat_i_title;

  /// No description provided for @wheat_i1.
  ///
  /// In en, this message translates to:
  /// **'First irrigation: 21-25 days after sowing'**
  String get wheat_i1;

  /// No description provided for @wheat_i2.
  ///
  /// In en, this message translates to:
  /// **'Second irrigation: 45-50 days (Tillering stage)'**
  String get wheat_i2;

  /// No description provided for @wheat_i3.
  ///
  /// In en, this message translates to:
  /// **'Third irrigation: 70-75 days (Jointing stage)'**
  String get wheat_i3;

  /// No description provided for @wheat_i4.
  ///
  /// In en, this message translates to:
  /// **'Fourth irrigation: 90-95 days (Flowering)'**
  String get wheat_i4;

  /// No description provided for @wheat_i5.
  ///
  /// In en, this message translates to:
  /// **'Fifth irrigation: 110-115 days (Grain filling)'**
  String get wheat_i5;

  /// No description provided for @wheat_f_title.
  ///
  /// In en, this message translates to:
  /// **'Fertilization'**
  String get wheat_f_title;

  /// No description provided for @wheat_f1.
  ///
  /// In en, this message translates to:
  /// **'Basal dose: 2 bags DAP + 1 bag SOP/acre'**
  String get wheat_f1;

  /// No description provided for @wheat_f2.
  ///
  /// In en, this message translates to:
  /// **'First split: 1 bag Urea at tillering'**
  String get wheat_f2;

  /// No description provided for @wheat_f3.
  ///
  /// In en, this message translates to:
  /// **'Second split: 1 bag Urea at jointing'**
  String get wheat_f3;

  /// No description provided for @wheat_f4.
  ///
  /// In en, this message translates to:
  /// **'Apply Zinc sulfate @ 5 kg/acre if deficient'**
  String get wheat_f4;

  /// No description provided for @wheat_f5.
  ///
  /// In en, this message translates to:
  /// **'Foliar spray of boron at flowering'**
  String get wheat_f5;

  /// No description provided for @wheat_pc_title.
  ///
  /// In en, this message translates to:
  /// **'Pest Control'**
  String get wheat_pc_title;

  /// No description provided for @wheat_pc1.
  ///
  /// In en, this message translates to:
  /// **'Monitor for aphids during Feb-March'**
  String get wheat_pc1;

  /// No description provided for @wheat_pc2.
  ///
  /// In en, this message translates to:
  /// **'Use neem oil spray @ 5% for early infestation'**
  String get wheat_pc2;

  /// No description provided for @wheat_pc3.
  ///
  /// In en, this message translates to:
  /// **'For army worm: Chlorpyrifos @ 1.5 L/acre'**
  String get wheat_pc3;

  /// No description provided for @wheat_pc4.
  ///
  /// In en, this message translates to:
  /// **'Rust control: Propiconazole @ 200 ml/acre'**
  String get wheat_pc4;

  /// No description provided for @wheat_pc5.
  ///
  /// In en, this message translates to:
  /// **'Remove volunteer plants to break disease cycle'**
  String get wheat_pc5;

  /// No description provided for @wheat_y_title.
  ///
  /// In en, this message translates to:
  /// **'Yield Optimization'**
  String get wheat_y_title;

  /// No description provided for @wheat_y1.
  ///
  /// In en, this message translates to:
  /// **'Target yield: 40-50 maunds/acre'**
  String get wheat_y1;

  /// No description provided for @wheat_y2.
  ///
  /// In en, this message translates to:
  /// **'Harvest when grains harden (30-35% moisture)'**
  String get wheat_y2;

  /// No description provided for @wheat_y3.
  ///
  /// In en, this message translates to:
  /// **'Use combine harvester for efficient harvesting'**
  String get wheat_y3;

  /// No description provided for @wheat_y4.
  ///
  /// In en, this message translates to:
  /// **'Dry to 12% moisture before storage'**
  String get wheat_y4;

  /// No description provided for @wheat_y5.
  ///
  /// In en, this message translates to:
  /// **'Store in clean, rodent-proof godowns'**
  String get wheat_y5;

  /// No description provided for @sugar_summary.
  ///
  /// In en, this message translates to:
  /// **'Sugarcane is a tropical perennial cash crop needing high heat (25-32°C) and moisture. It has a 12-18 month growing season.'**
  String get sugar_summary;

  /// No description provided for @sugar_p_title.
  ///
  /// In en, this message translates to:
  /// **'Planting'**
  String get sugar_p_title;

  /// No description provided for @sugar_p1.
  ///
  /// In en, this message translates to:
  /// **'Plant from February to March (Spring crop)'**
  String get sugar_p1;

  /// No description provided for @sugar_p2.
  ///
  /// In en, this message translates to:
  /// **'Use 3-bud setts from healthy canes'**
  String get sugar_p2;

  /// No description provided for @sugar_p3.
  ///
  /// In en, this message translates to:
  /// **'Seed rate: 30-35,000 setts/acre'**
  String get sugar_p3;

  /// No description provided for @sugar_p4.
  ///
  /// In en, this message translates to:
  /// **'Row spacing: 90-120 cm'**
  String get sugar_p4;

  /// No description provided for @sugar_p5.
  ///
  /// In en, this message translates to:
  /// **'Planting depth: 5-7 cm in furrows'**
  String get sugar_p5;

  /// No description provided for @sugar_i_title.
  ///
  /// In en, this message translates to:
  /// **'Irrigation'**
  String get sugar_i_title;

  /// No description provided for @sugar_i1.
  ///
  /// In en, this message translates to:
  /// **'Initial: Irrigate immediately after planting'**
  String get sugar_i1;

  /// No description provided for @sugar_i2.
  ///
  /// In en, this message translates to:
  /// **'Critical stage: Grand growth period'**
  String get sugar_i2;

  /// No description provided for @sugar_i3.
  ///
  /// In en, this message translates to:
  /// **'Irrigation interval: 10-12 days in summer'**
  String get sugar_i3;

  /// No description provided for @sugar_i4.
  ///
  /// In en, this message translates to:
  /// **'Stop irrigation 30 days before harvest'**
  String get sugar_i4;

  /// No description provided for @sugar_i5.
  ///
  /// In en, this message translates to:
  /// **'Total water requirement: 180-200 cm/season'**
  String get sugar_i5;

  /// No description provided for @sugar_f_title.
  ///
  /// In en, this message translates to:
  /// **'Fertilization'**
  String get sugar_f_title;

  /// No description provided for @sugar_f1.
  ///
  /// In en, this message translates to:
  /// **'Basal: 2 bags DAP + 1 bag SOP/acre'**
  String get sugar_f1;

  /// No description provided for @sugar_f2.
  ///
  /// In en, this message translates to:
  /// **'Top dressing: 3 bags Urea in 3 splits'**
  String get sugar_f2;

  /// No description provided for @sugar_f3.
  ///
  /// In en, this message translates to:
  /// **'First split: 30 days after planting'**
  String get sugar_f3;

  /// No description provided for @sugar_f4.
  ///
  /// In en, this message translates to:
  /// **'Second split: 60 days after planting'**
  String get sugar_f4;

  /// No description provided for @sugar_f5.
  ///
  /// In en, this message translates to:
  /// **'Third split: 90 days after planting'**
  String get sugar_f5;

  /// No description provided for @sugar_pc_title.
  ///
  /// In en, this message translates to:
  /// **'Pest Control'**
  String get sugar_pc_title;

  /// No description provided for @sugar_pc1.
  ///
  /// In en, this message translates to:
  /// **'For borers: Furadan @ 10 kg/acre at planting'**
  String get sugar_pc1;

  /// No description provided for @sugar_pc2.
  ///
  /// In en, this message translates to:
  /// **'For termites: Chlorpyrifos @ 2 L/acre'**
  String get sugar_pc2;

  /// No description provided for @sugar_pc3.
  ///
  /// In en, this message translates to:
  /// **'For red rot: Use resistant varieties'**
  String get sugar_pc3;

  /// No description provided for @sugar_pc4.
  ///
  /// In en, this message translates to:
  /// **'Remove and destroy infected plants'**
  String get sugar_pc4;

  /// No description provided for @sugar_pc5.
  ///
  /// In en, this message translates to:
  /// **'Practice crop rotation with legumes'**
  String get sugar_pc5;

  /// No description provided for @sugar_y_title.
  ///
  /// In en, this message translates to:
  /// **'Yield Optimization'**
  String get sugar_y_title;

  /// No description provided for @sugar_y1.
  ///
  /// In en, this message translates to:
  /// **'Target yield: 700-800 maunds/acre'**
  String get sugar_y1;

  /// No description provided for @sugar_y2.
  ///
  /// In en, this message translates to:
  /// **'Harvest when canes mature (12-18 months)'**
  String get sugar_y2;

  /// No description provided for @sugar_y3.
  ///
  /// In en, this message translates to:
  /// **'Cut close to ground level'**
  String get sugar_y3;

  /// No description provided for @sugar_y4.
  ///
  /// In en, this message translates to:
  /// **'Mill within 24 hours of harvest'**
  String get sugar_y4;

  /// No description provided for @sugar_y5.
  ///
  /// In en, this message translates to:
  /// **'Ratoon management for 2-3 cycles'**
  String get sugar_y5;

  /// No description provided for @cotton_summary.
  ///
  /// In en, this message translates to:
  /// **'Cotton thrives in dry, warm climates and needs plenty of sunshine. Proper pest management is key.'**
  String get cotton_summary;

  /// No description provided for @cotton_p_title.
  ///
  /// In en, this message translates to:
  /// **'Planting'**
  String get cotton_p_title;

  /// No description provided for @cotton_p1.
  ///
  /// In en, this message translates to:
  /// **'Sow from April to May'**
  String get cotton_p1;

  /// No description provided for @cotton_p2.
  ///
  /// In en, this message translates to:
  /// **'Seed rate: 4-5 kg/acre for Bt cotton'**
  String get cotton_p2;

  /// No description provided for @cotton_p3.
  ///
  /// In en, this message translates to:
  /// **'Row spacing: 75-90 cm'**
  String get cotton_p3;

  /// No description provided for @cotton_p4.
  ///
  /// In en, this message translates to:
  /// **'Plant-to-plant distance: 30-45 cm'**
  String get cotton_p4;

  /// No description provided for @cotton_p5.
  ///
  /// In en, this message translates to:
  /// **'Treat seeds with fungicide before sowing'**
  String get cotton_p5;

  /// No description provided for @cotton_i_title.
  ///
  /// In en, this message translates to:
  /// **'Irrigation'**
  String get cotton_i_title;

  /// No description provided for @cotton_i1.
  ///
  /// In en, this message translates to:
  /// **'First irrigation: 30-35 days after sowing'**
  String get cotton_i1;

  /// No description provided for @cotton_i2.
  ///
  /// In en, this message translates to:
  /// **'Critical stage: Flowering and boll formation'**
  String get cotton_i2;

  /// No description provided for @cotton_i3.
  ///
  /// In en, this message translates to:
  /// **'Irrigation interval: 12-15 days'**
  String get cotton_i3;

  /// No description provided for @cotton_i4.
  ///
  /// In en, this message translates to:
  /// **'Stop irrigation 90-100 days after sowing'**
  String get cotton_i4;

  /// No description provided for @cotton_i5.
  ///
  /// In en, this message translates to:
  /// **'Avoid waterlogging'**
  String get cotton_i5;

  /// No description provided for @cotton_f_title.
  ///
  /// In en, this message translates to:
  /// **'Fertilization'**
  String get cotton_f_title;

  /// No description provided for @cotton_f1.
  ///
  /// In en, this message translates to:
  /// **'Basal: 2 bags DAP + 1 bag SOP/acre'**
  String get cotton_f1;

  /// No description provided for @cotton_f2.
  ///
  /// In en, this message translates to:
  /// **'Top dressing: 2 bags Urea in 2 splits'**
  String get cotton_f2;

  /// No description provided for @cotton_f3.
  ///
  /// In en, this message translates to:
  /// **'First split: 30 days after sowing'**
  String get cotton_f3;

  /// No description provided for @cotton_f4.
  ///
  /// In en, this message translates to:
  /// **'Second split: 60 days after sowing'**
  String get cotton_f4;

  /// No description provided for @cotton_f5.
  ///
  /// In en, this message translates to:
  /// **'Apply boron @ 1 kg/acre during flowering'**
  String get cotton_f5;

  /// No description provided for @cotton_pc_title.
  ///
  /// In en, this message translates to:
  /// **'Pest Control'**
  String get cotton_pc_title;

  /// No description provided for @cotton_pc1.
  ///
  /// In en, this message translates to:
  /// **'For bollworms: Emamectin benzoate @ 150 ml/acre'**
  String get cotton_pc1;

  /// No description provided for @cotton_pc2.
  ///
  /// In en, this message translates to:
  /// **'For whitefly: Acetamiprid @ 80g/acre'**
  String get cotton_pc2;

  /// No description provided for @cotton_pc3.
  ///
  /// In en, this message translates to:
  /// **'For mealybug: Chlorpyrifos @ 1.5 L/acre'**
  String get cotton_pc3;

  /// No description provided for @cotton_pc4.
  ///
  /// In en, this message translates to:
  /// **'Monitor with pheromone traps'**
  String get cotton_pc4;

  /// No description provided for @cotton_pc5.
  ///
  /// In en, this message translates to:
  /// **'Practice crop rotation'**
  String get cotton_pc5;

  /// No description provided for @cotton_y_title.
  ///
  /// In en, this message translates to:
  /// **'Yield Optimization'**
  String get cotton_y_title;

  /// No description provided for @cotton_y1.
  ///
  /// In en, this message translates to:
  /// **'Target yield: 25-30 maunds/acre'**
  String get cotton_y1;

  /// No description provided for @cotton_y2.
  ///
  /// In en, this message translates to:
  /// **'Harvest in 3-4 pickings'**
  String get cotton_y2;

  /// No description provided for @cotton_y3.
  ///
  /// In en, this message translates to:
  /// **'Pick when bolls fully open'**
  String get cotton_y3;

  /// No description provided for @cotton_y4.
  ///
  /// In en, this message translates to:
  /// **'Dry in shade to maintain fiber quality'**
  String get cotton_y4;

  /// No description provided for @cotton_y5.
  ///
  /// In en, this message translates to:
  /// **'Store in dry place'**
  String get cotton_y5;

  /// No description provided for @maize_summary.
  ///
  /// In en, this message translates to:
  /// **'Maize is versatile and requires moderate temperatures. It is often grown as a Kharif crop.'**
  String get maize_summary;

  /// No description provided for @maize_p_title.
  ///
  /// In en, this message translates to:
  /// **'Planting'**
  String get maize_p_title;

  /// No description provided for @maize_p1.
  ///
  /// In en, this message translates to:
  /// **'Sow from June to July for Kharif'**
  String get maize_p1;

  /// No description provided for @maize_p2.
  ///
  /// In en, this message translates to:
  /// **'Seed rate: 8-10 kg/acre'**
  String get maize_p2;

  /// No description provided for @maize_p3.
  ///
  /// In en, this message translates to:
  /// **'Row spacing: 60-75 cm'**
  String get maize_p3;

  /// No description provided for @maize_p4.
  ///
  /// In en, this message translates to:
  /// **'Plant-to-plant: 20-25 cm'**
  String get maize_p4;

  /// No description provided for @maize_p5.
  ///
  /// In en, this message translates to:
  /// **'Sow at depth of 5-7 cm'**
  String get maize_p5;

  /// No description provided for @maize_i_title.
  ///
  /// In en, this message translates to:
  /// **'Irrigation'**
  String get maize_i_title;

  /// No description provided for @maize_i1.
  ///
  /// In en, this message translates to:
  /// **'Critical stages: Knee-high and tasseling'**
  String get maize_i1;

  /// No description provided for @maize_i2.
  ///
  /// In en, this message translates to:
  /// **'Irrigation every 10-12 days in summer'**
  String get maize_i2;

  /// No description provided for @maize_i3.
  ///
  /// In en, this message translates to:
  /// **'Avoid water stress during pollination'**
  String get maize_i3;

  /// No description provided for @maize_i4.
  ///
  /// In en, this message translates to:
  /// **'Last irrigation 15 days before harvest'**
  String get maize_i4;

  /// No description provided for @maize_i5.
  ///
  /// In en, this message translates to:
  /// **'Total water: 50-60 cm'**
  String get maize_i5;

  /// No description provided for @maize_f_title.
  ///
  /// In en, this message translates to:
  /// **'Fertilization'**
  String get maize_f_title;

  /// No description provided for @maize_f1.
  ///
  /// In en, this message translates to:
  /// **'Basal: 2 bags DAP + 1 bag SOP/acre'**
  String get maize_f1;

  /// No description provided for @maize_f2.
  ///
  /// In en, this message translates to:
  /// **'Top dressing: 2 bags Urea in 2 splits'**
  String get maize_f2;

  /// No description provided for @maize_f3.
  ///
  /// In en, this message translates to:
  /// **'First split: 25-30 days after sowing'**
  String get maize_f3;

  /// No description provided for @maize_f4.
  ///
  /// In en, this message translates to:
  /// **'Second split: 45-50 days after sowing'**
  String get maize_f4;

  /// No description provided for @maize_f5.
  ///
  /// In en, this message translates to:
  /// **'Apply Zinc @ 10 kg/acre if deficient'**
  String get maize_f5;

  /// No description provided for @maize_pc_title.
  ///
  /// In en, this message translates to:
  /// **'Pest Control'**
  String get maize_pc_title;

  /// No description provided for @maize_pc1.
  ///
  /// In en, this message translates to:
  /// **'For stem borer: Carbofuran @ 10 kg/acre'**
  String get maize_pc1;

  /// No description provided for @maize_pc2.
  ///
  /// In en, this message translates to:
  /// **'For fall armyworm: Spinetoram @ 100 ml/acre'**
  String get maize_pc2;

  /// No description provided for @maize_pc3.
  ///
  /// In en, this message translates to:
  /// **'For downy mildew: Metalaxyl @ 2g/kg seed'**
  String get maize_pc3;

  /// No description provided for @maize_pc4.
  ///
  /// In en, this message translates to:
  /// **'Use bird perches for pest control'**
  String get maize_pc4;

  /// No description provided for @maize_pc5.
  ///
  /// In en, this message translates to:
  /// **'Remove infected plants'**
  String get maize_pc5;

  /// No description provided for @maize_y_title.
  ///
  /// In en, this message translates to:
  /// **'Yield Optimization'**
  String get maize_y_title;

  /// No description provided for @maize_y1.
  ///
  /// In en, this message translates to:
  /// **'Target yield: 40-50 maunds/acre'**
  String get maize_y1;

  /// No description provided for @maize_y2.
  ///
  /// In en, this message translates to:
  /// **'Harvest when grains harden'**
  String get maize_y2;

  /// No description provided for @maize_y3.
  ///
  /// In en, this message translates to:
  /// **'Harvest at 20-25% moisture'**
  String get maize_y3;

  /// No description provided for @maize_y4.
  ///
  /// In en, this message translates to:
  /// **'Dry to 14% moisture for storage'**
  String get maize_y4;

  /// No description provided for @maize_y5.
  ///
  /// In en, this message translates to:
  /// **'Store in well-ventilated bins'**
  String get maize_y5;

  /// No description provided for @mango_summary.
  ///
  /// In en, this message translates to:
  /// **'Mango is a tropical fruit tree. It requires careful pruning and protection from frost during flowering.'**
  String get mango_summary;

  /// No description provided for @mango_p_title.
  ///
  /// In en, this message translates to:
  /// **'Planting'**
  String get mango_p_title;

  /// No description provided for @mango_p1.
  ///
  /// In en, this message translates to:
  /// **'Plant in July-August or February-March'**
  String get mango_p1;

  /// No description provided for @mango_p2.
  ///
  /// In en, this message translates to:
  /// **'Spacing: 10 x 10 meters'**
  String get mango_p2;

  /// No description provided for @mango_p3.
  ///
  /// In en, this message translates to:
  /// **'Dig pits of 1 x 1 x 1 meter'**
  String get mango_p3;

  /// No description provided for @mango_p4.
  ///
  /// In en, this message translates to:
  /// **'Mix soil with 30-40 kg FYM per pit'**
  String get mango_p4;

  /// No description provided for @mango_p5.
  ///
  /// In en, this message translates to:
  /// **'Graft preferred varieties (Sindhri, Anwar Ratol)'**
  String get mango_p5;

  /// No description provided for @mango_i_title.
  ///
  /// In en, this message translates to:
  /// **'Irrigation'**
  String get mango_i_title;

  /// No description provided for @mango_i1.
  ///
  /// In en, this message translates to:
  /// **'Young plants: Irrigate every 3-4 days'**
  String get mango_i1;

  /// No description provided for @mango_i2.
  ///
  /// In en, this message translates to:
  /// **'Mature trees: Irrigate every 10-15 days'**
  String get mango_i2;

  /// No description provided for @mango_i3.
  ///
  /// In en, this message translates to:
  /// **'Critical stage: Fruit setting and development'**
  String get mango_i3;

  /// No description provided for @mango_i4.
  ///
  /// In en, this message translates to:
  /// **'Stop irrigation 15 days before harvest'**
  String get mango_i4;

  /// No description provided for @mango_i5.
  ///
  /// In en, this message translates to:
  /// **'Use basin or drip irrigation'**
  String get mango_i5;

  /// No description provided for @mango_f_title.
  ///
  /// In en, this message translates to:
  /// **'Fertilization'**
  String get mango_f_title;

  /// No description provided for @mango_f1.
  ///
  /// In en, this message translates to:
  /// **'Young trees: 10-20 kg FYM + 250g NPK/year'**
  String get mango_f1;

  /// No description provided for @mango_f2.
  ///
  /// In en, this message translates to:
  /// **'Mature trees: 50-100 kg FYM + 1-2 kg NPK/year'**
  String get mango_f2;

  /// No description provided for @mango_f3.
  ///
  /// In en, this message translates to:
  /// **'Apply after harvest (June-July)'**
  String get mango_f3;

  /// No description provided for @mango_f4.
  ///
  /// In en, this message translates to:
  /// **'Apply before flowering (December-January)'**
  String get mango_f4;

  /// No description provided for @mango_f5.
  ///
  /// In en, this message translates to:
  /// **'Foliar spray of micronutrients during flowering'**
  String get mango_f5;

  /// No description provided for @mango_pc_title.
  ///
  /// In en, this message translates to:
  /// **'Pest Control'**
  String get mango_pc_title;

  /// No description provided for @mango_pc1.
  ///
  /// In en, this message translates to:
  /// **'For fruit fly: Bait spray (Malathion + jaggery)'**
  String get mango_pc1;

  /// No description provided for @mango_pc2.
  ///
  /// In en, this message translates to:
  /// **'For mango hopper: Imidacloprid @ 50 ml/acre'**
  String get mango_pc2;

  /// No description provided for @mango_pc3.
  ///
  /// In en, this message translates to:
  /// **'For anthracnose: Copper oxychloride @ 500g/acre'**
  String get mango_pc3;

  /// No description provided for @mango_pc4.
  ///
  /// In en, this message translates to:
  /// **'Bag fruits for protection'**
  String get mango_pc4;

  /// No description provided for @mango_pc5.
  ///
  /// In en, this message translates to:
  /// **'Maintain orchard sanitation'**
  String get mango_pc5;

  /// No description provided for @mango_y_title.
  ///
  /// In en, this message translates to:
  /// **'Yield Optimization'**
  String get mango_y_title;

  /// No description provided for @mango_y1.
  ///
  /// In en, this message translates to:
  /// **'Target yield: 100-200 kg/tree (mature)'**
  String get mango_y1;

  /// No description provided for @mango_y2.
  ///
  /// In en, this message translates to:
  /// **'Harvest when fruits develop shoulder'**
  String get mango_y2;

  /// No description provided for @mango_y3.
  ///
  /// In en, this message translates to:
  /// **'Harvest in morning hours'**
  String get mango_y3;

  /// No description provided for @mango_y4.
  ///
  /// In en, this message translates to:
  /// **'Handle fruits carefully to avoid damage'**
  String get mango_y4;

  /// No description provided for @mango_y5.
  ///
  /// In en, this message translates to:
  /// **'Pack in ventilated boxes'**
  String get mango_y5;

  /// No description provided for @potato_summary.
  ///
  /// In en, this message translates to:
  /// **'Potato is a cool-season crop grown in winter. Proper soil preparation and seed treatment are crucial.'**
  String get potato_summary;

  /// No description provided for @potato_p_title.
  ///
  /// In en, this message translates to:
  /// **'Planting'**
  String get potato_p_title;

  /// No description provided for @potato_p1.
  ///
  /// In en, this message translates to:
  /// **'Plant from October to November'**
  String get potato_p1;

  /// No description provided for @potato_p2.
  ///
  /// In en, this message translates to:
  /// **'Use disease-free certified tubers'**
  String get potato_p2;

  /// No description provided for @potato_p3.
  ///
  /// In en, this message translates to:
  /// **'Seed rate: 800-1000 kg/acre'**
  String get potato_p3;

  /// No description provided for @potato_p4.
  ///
  /// In en, this message translates to:
  /// **'Row spacing: 60 cm'**
  String get potato_p4;

  /// No description provided for @potato_p5.
  ///
  /// In en, this message translates to:
  /// **'Plant spacing: 20-25 cm'**
  String get potato_p5;

  /// No description provided for @potato_p6.
  ///
  /// In en, this message translates to:
  /// **'Plant at depth of 5-7 cm'**
  String get potato_p6;

  /// No description provided for @potato_i_title.
  ///
  /// In en, this message translates to:
  /// **'Irrigation'**
  String get potato_i_title;

  /// No description provided for @potato_i1.
  ///
  /// In en, this message translates to:
  /// **'First irrigation: Immediately after planting'**
  String get potato_i1;

  /// No description provided for @potato_i2.
  ///
  /// In en, this message translates to:
  /// **'Critical stage: Tuber initiation and bulking'**
  String get potato_i2;

  /// No description provided for @potato_i3.
  ///
  /// In en, this message translates to:
  /// **'Irrigation every 7-10 days'**
  String get potato_i3;

  /// No description provided for @potato_i4.
  ///
  /// In en, this message translates to:
  /// **'Stop irrigation 15-20 days before harvest'**
  String get potato_i4;

  /// No description provided for @potato_i5.
  ///
  /// In en, this message translates to:
  /// **'Avoid waterlogging'**
  String get potato_i5;

  /// No description provided for @potato_f_title.
  ///
  /// In en, this message translates to:
  /// **'Fertilization'**
  String get potato_f_title;

  /// No description provided for @potato_f1.
  ///
  /// In en, this message translates to:
  /// **'Basal: 3 bags DAP + 2 bags SOP/acre'**
  String get potato_f1;

  /// No description provided for @potato_f2.
  ///
  /// In en, this message translates to:
  /// **'Top dressing: 2 bags Urea in 2 splits'**
  String get potato_f2;

  /// No description provided for @potato_f3.
  ///
  /// In en, this message translates to:
  /// **'First split: 25-30 days after planting'**
  String get potato_f3;

  /// No description provided for @potato_f4.
  ///
  /// In en, this message translates to:
  /// **'Second split: 45-50 days after planting'**
  String get potato_f4;

  /// No description provided for @potato_f5.
  ///
  /// In en, this message translates to:
  /// **'Apply boron @ 1 kg/acre if needed'**
  String get potato_f5;

  /// No description provided for @potato_pc_title.
  ///
  /// In en, this message translates to:
  /// **'Pest Control'**
  String get potato_pc_title;

  /// No description provided for @potato_pc1.
  ///
  /// In en, this message translates to:
  /// **'For cutworm: Chlorpyrifos @ 2 L/acre in soil'**
  String get potato_pc1;

  /// No description provided for @potato_pc2.
  ///
  /// In en, this message translates to:
  /// **'For aphids: Imidacloprid @ 50 ml/acre'**
  String get potato_pc2;

  /// No description provided for @potato_pc3.
  ///
  /// In en, this message translates to:
  /// **'For late blight: Mancozeb @ 500g/acre'**
  String get potato_pc3;

  /// No description provided for @potato_pc4.
  ///
  /// In en, this message translates to:
  /// **'Use resistant varieties'**
  String get potato_pc4;

  /// No description provided for @potato_pc5.
  ///
  /// In en, this message translates to:
  /// **'Practice crop rotation with cereals'**
  String get potato_pc5;

  /// No description provided for @potato_y_title.
  ///
  /// In en, this message translates to:
  /// **'Yield Optimization'**
  String get potato_y_title;

  /// No description provided for @potato_y1.
  ///
  /// In en, this message translates to:
  /// **'Target yield: 200-250 maunds/acre'**
  String get potato_y1;

  /// No description provided for @potato_y2.
  ///
  /// In en, this message translates to:
  /// **'Harvest when vines dry'**
  String get potato_y2;

  /// No description provided for @potato_y3.
  ///
  /// In en, this message translates to:
  /// **'Harvest in cool weather'**
  String get potato_y3;

  /// No description provided for @potato_y4.
  ///
  /// In en, this message translates to:
  /// **'Cure tubers for 10-15 days before storage'**
  String get potato_y4;

  /// No description provided for @potato_y5.
  ///
  /// In en, this message translates to:
  /// **'Store at 4-5°C with high humidity'**
  String get potato_y5;

  /// No description provided for @chilli_summary.
  ///
  /// In en, this message translates to:
  /// **'Chilli is a warm-season crop sensitive to frost. Requires well-drained soil and careful water management.'**
  String get chilli_summary;

  /// No description provided for @chilli_p_title.
  ///
  /// In en, this message translates to:
  /// **'Planting'**
  String get chilli_p_title;

  /// No description provided for @chilli_p1.
  ///
  /// In en, this message translates to:
  /// **'Transplant 30-35 day old seedlings'**
  String get chilli_p1;

  /// No description provided for @chilli_p2.
  ///
  /// In en, this message translates to:
  /// **'Spacing: 45 x 30 cm'**
  String get chilli_p2;

  /// No description provided for @chilli_p3.
  ///
  /// In en, this message translates to:
  /// **'Plant 2 seedlings per hill'**
  String get chilli_p3;

  /// No description provided for @chilli_p4.
  ///
  /// In en, this message translates to:
  /// **'Best time: February-March for spring crop'**
  String get chilli_p4;

  /// No description provided for @chilli_p5.
  ///
  /// In en, this message translates to:
  /// **'Raised beds for better drainage'**
  String get chilli_p5;

  /// No description provided for @chilli_i_title.
  ///
  /// In en, this message translates to:
  /// **'Irrigation'**
  String get chilli_i_title;

  /// No description provided for @chilli_i1.
  ///
  /// In en, this message translates to:
  /// **'Light irrigation after transplanting'**
  String get chilli_i1;

  /// No description provided for @chilli_i2.
  ///
  /// In en, this message translates to:
  /// **'Irrigation every 5-7 days in summer'**
  String get chilli_i2;

  /// No description provided for @chilli_i3.
  ///
  /// In en, this message translates to:
  /// **'Critical stage: Flowering and fruit set'**
  String get chilli_i3;

  /// No description provided for @chilli_i4.
  ///
  /// In en, this message translates to:
  /// **'Avoid overhead irrigation to prevent disease'**
  String get chilli_i4;

  /// No description provided for @chilli_i5.
  ///
  /// In en, this message translates to:
  /// **'Drip irrigation recommended'**
  String get chilli_i5;

  /// No description provided for @chilli_f_title.
  ///
  /// In en, this message translates to:
  /// **'Fertilization'**
  String get chilli_f_title;

  /// No description provided for @chilli_f1.
  ///
  /// In en, this message translates to:
  /// **'Basal: 2 bags DAP + 1 bag SOP/acre'**
  String get chilli_f1;

  /// No description provided for @chilli_f2.
  ///
  /// In en, this message translates to:
  /// **'Top dressing: 1.5 bags Urea in 3 splits'**
  String get chilli_f2;

  /// No description provided for @chilli_f3.
  ///
  /// In en, this message translates to:
  /// **'First split: 30 days after transplanting'**
  String get chilli_f3;

  /// No description provided for @chilli_f4.
  ///
  /// In en, this message translates to:
  /// **'Second split: 60 days after transplanting'**
  String get chilli_f4;

  /// No description provided for @chilli_f5.
  ///
  /// In en, this message translates to:
  /// **'Third split: During fruit set'**
  String get chilli_f5;

  /// No description provided for @chilli_pc_title.
  ///
  /// In en, this message translates to:
  /// **'Pest Control'**
  String get chilli_pc_title;

  /// No description provided for @chilli_pc1.
  ///
  /// In en, this message translates to:
  /// **'For thrips: Spinosad @ 100 ml/acre'**
  String get chilli_pc1;

  /// No description provided for @chilli_pc2.
  ///
  /// In en, this message translates to:
  /// **'For mites: Abamectin @ 100 ml/acre'**
  String get chilli_pc2;

  /// No description provided for @chilli_pc3.
  ///
  /// In en, this message translates to:
  /// **'For fruit rot: Carbendazim @ 250g/acre'**
  String get chilli_pc3;

  /// No description provided for @chilli_pc4.
  ///
  /// In en, this message translates to:
  /// **'Use yellow sticky traps'**
  String get chilli_pc4;

  /// No description provided for @chilli_pc5.
  ///
  /// In en, this message translates to:
  /// **'Remove infected plants immediately'**
  String get chilli_pc5;

  /// No description provided for @chilli_y_title.
  ///
  /// In en, this message translates to:
  /// **'Yield Optimization'**
  String get chilli_y_title;

  /// No description provided for @chilli_y1.
  ///
  /// In en, this message translates to:
  /// **'Target yield: 40-50 maunds/acre (dry)'**
  String get chilli_y1;

  /// No description provided for @chilli_y2.
  ///
  /// In en, this message translates to:
  /// **'Harvest when fruits turn red'**
  String get chilli_y2;

  /// No description provided for @chilli_y3.
  ///
  /// In en, this message translates to:
  /// **'Pick regularly to encourage more fruiting'**
  String get chilli_y3;

  /// No description provided for @chilli_y4.
  ///
  /// In en, this message translates to:
  /// **'Dry in shade to retain color and pungency'**
  String get chilli_y4;

  /// No description provided for @chilli_y5.
  ///
  /// In en, this message translates to:
  /// **'Store in airtight containers'**
  String get chilli_y5;

  /// No description provided for @rice_summary.
  ///
  /// In en, this message translates to:
  /// **'Rice needs standing water for most of its growing period. The Kharif season is the best time for cultivation.'**
  String get rice_summary;

  /// No description provided for @rice_p_title.
  ///
  /// In en, this message translates to:
  /// **'Planting'**
  String get rice_p_title;

  /// No description provided for @rice_p1.
  ///
  /// In en, this message translates to:
  /// **'Transplant seedlings 20-25 days old'**
  String get rice_p1;

  /// No description provided for @rice_p2.
  ///
  /// In en, this message translates to:
  /// **'Optimal spacing: 20 x 15 cm'**
  String get rice_p2;

  /// No description provided for @rice_p3.
  ///
  /// In en, this message translates to:
  /// **'Plant 2-3 seedlings per hill'**
  String get rice_p3;

  /// No description provided for @rice_p4.
  ///
  /// In en, this message translates to:
  /// **'Transplant in puddled soil'**
  String get rice_p4;

  /// No description provided for @rice_p5.
  ///
  /// In en, this message translates to:
  /// **'Best time: June-July for Kharif season'**
  String get rice_p5;

  /// No description provided for @rice_i_title.
  ///
  /// In en, this message translates to:
  /// **'Irrigation'**
  String get rice_i_title;

  /// No description provided for @rice_i1.
  ///
  /// In en, this message translates to:
  /// **'Maintain 2-5 cm standing water'**
  String get rice_i1;

  /// No description provided for @rice_i2.
  ///
  /// In en, this message translates to:
  /// **'Drain field 15 days before harvest'**
  String get rice_i2;

  /// No description provided for @rice_i3.
  ///
  /// In en, this message translates to:
  /// **'Critical stages: Tillering and flowering'**
  String get rice_i3;

  /// No description provided for @rice_i4.
  ///
  /// In en, this message translates to:
  /// **'Avoid water stress during panicle initiation'**
  String get rice_i4;

  /// No description provided for @rice_i5.
  ///
  /// In en, this message translates to:
  /// **'Total water requirement: 100-150 cm'**
  String get rice_i5;

  /// No description provided for @rice_f_title.
  ///
  /// In en, this message translates to:
  /// **'Fertilization'**
  String get rice_f_title;

  /// No description provided for @rice_f1.
  ///
  /// In en, this message translates to:
  /// **'Basal: 1.5 bags DAP/acre'**
  String get rice_f1;

  /// No description provided for @rice_f2.
  ///
  /// In en, this message translates to:
  /// **'First top dressing: 1 bag Urea at tillering'**
  String get rice_f2;

  /// No description provided for @rice_f3.
  ///
  /// In en, this message translates to:
  /// **'Second top dressing: 0.5 bag Urea at panicle initiation'**
  String get rice_f3;

  /// No description provided for @rice_f4.
  ///
  /// In en, this message translates to:
  /// **'Apply Zinc sulfate @ 10 kg/acre if needed'**
  String get rice_f4;

  /// No description provided for @rice_f5.
  ///
  /// In en, this message translates to:
  /// **'Silicon application improves stem strength'**
  String get rice_f5;

  /// No description provided for @rice_pc_title.
  ///
  /// In en, this message translates to:
  /// **'Pest Control'**
  String get rice_pc_title;

  /// No description provided for @rice_pc1.
  ///
  /// In en, this message translates to:
  /// **'For stem borer: Cartap hydrochloride @ 500g/acre'**
  String get rice_pc1;

  /// No description provided for @rice_pc2.
  ///
  /// In en, this message translates to:
  /// **'For leaf folder: Fipronil @ 200 ml/acre'**
  String get rice_pc2;

  /// No description provided for @rice_pc3.
  ///
  /// In en, this message translates to:
  /// **'For blast disease: Tricyclazole @ 300g/acre'**
  String get rice_pc3;

  /// No description provided for @rice_pc4.
  ///
  /// In en, this message translates to:
  /// **'Use light traps for moth monitoring'**
  String get rice_pc4;

  /// No description provided for @rice_pc5.
  ///
  /// In en, this message translates to:
  /// **'Practice clean cultivation'**
  String get rice_pc5;

  /// No description provided for @rice_y_title.
  ///
  /// In en, this message translates to:
  /// **'Yield Optimization'**
  String get rice_y_title;

  /// No description provided for @rice_y1.
  ///
  /// In en, this message translates to:
  /// **'Target yield: 30-40 maunds/acre'**
  String get rice_y1;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'ur'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'ur': return AppLocalizationsUr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
