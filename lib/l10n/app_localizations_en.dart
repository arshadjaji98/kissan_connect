// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get selectLanguage => 'Select Language';

  @override
  String get choosePreferredLanguage => 'Choose your preferred language';

  @override
  String languageChangedTo(Object language) {
    return 'زبان تبدیل ہو گئی: $language';
  }

  @override
  String get english => 'English';

  @override
  String get urdu => 'Urdu';

  @override
  String get cancel => 'Cancel';

  @override
  String get save => 'Save';

  @override
  String get welcome => 'Welcome';

  @override
  String get sign_up => 'Sign Up';

  @override
  String get login => 'Login';

  @override
  String get full_name => 'Full Name';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get confirm_password => 'Confirm Password';

  @override
  String get farm_location => 'Your Farm\'s Location';

  @override
  String get farm_land_area => 'Area of Farm Land';

  @override
  String get select_crops => 'Select the crops you grow';

  @override
  String get already_have_account => 'Already have an account? Log In';

  @override
  String get signup_success_message => 'Signup successful! Navigating to HomeScreen...';

  @override
  String get email_already_in_use_code => 'email-already-in-use';

  @override
  String get email_already_in_use_message => 'This email is already registered. Please use a different email or login.';

  @override
  String get invalid_email_code => 'invalid-email';

  @override
  String get invalid_email_message => 'Please enter a valid email address.';

  @override
  String get weak_password_message => 'Password is too weak. Please use at least 8 characters.';

  @override
  String get operation_not_allowed_code => 'operation-not-allowed';

  @override
  String get operation_not_allowed_message => 'Email/password accounts are not enabled. Please contact support.';

  @override
  String get network_request_failed_code => 'network-request-failed';

  @override
  String get network_error_message => 'Network error. Please check your internet connection.';

  @override
  String get signup_error_message => 'An error occurred during sign up:';

  @override
  String get unexpected_error_message => 'An unexpected error occurred. Please try again.';

  @override
  String get please_enter => 'Please enter';

  @override
  String get required => 'Required';

  @override
  String get passwords_do_not_match => 'Passwords do not match';

  @override
  String get minimum_8_characters => 'Minimum 8 characters';

  @override
  String get tagline => 'Join our community for better farming';

  @override
  String get area => 'Area';

  @override
  String get selectMultipleCrops => 'You can select multiple crops';

  @override
  String get sugarcane => 'Sugarcane';

  @override
  String get maize => 'Maize';

  @override
  String get vegetables => 'Vegetables';

  @override
  String get welcome_back => 'Welcome Back!';

  @override
  String get signin_continue => 'Sign in to continue to Kissan Connect';

  @override
  String get enter_email => 'Enter your email address';

  @override
  String get please_enter_email => 'Please enter your email address';

  @override
  String get please_enter_valid_email => 'Please enter a valid email address';

  @override
  String get enter_password => 'Enter your password';

  @override
  String get please_enter_password => 'Please enter your password';

  @override
  String get password_min_8 => 'Password must be at least 8 characters';

  @override
  String get remember_me => 'Remember me';

  @override
  String get forgot_password => 'Forgot Password?';

  @override
  String get log_in => 'Log In';

  @override
  String get or_continue_with => 'or continue with';

  @override
  String get dont_have_account => 'Don\'t have an account?';

  @override
  String get login_user_data_missing => 'Login successful but user data not available. Please try again.';

  @override
  String get user_not_found_code => 'user-not-found';

  @override
  String get user_not_found_message => 'No account found with this email.';

  @override
  String get wrong_password_code => 'wrong-password';

  @override
  String get wrong_password_message => 'Incorrect password. Please try again.';

  @override
  String get invalid_credential_code => 'invalid-credential';

  @override
  String get invalid_credential_message => 'Invalid email or password.';

  @override
  String get user_disabled_code => 'user-disabled';

  @override
  String get user_disabled_message => 'This account has been disabled.';

  @override
  String get too_many_requests_code => 'too-many-requests';

  @override
  String get too_many_requests_message => 'Too many login attempts. Please try again later.';

  @override
  String get login_failed => 'Login failed:';

  @override
  String get login_error => 'Login error:';

  @override
  String get unexpected_error => 'An unexpected error occurred. Please try again.';

  @override
  String get name => 'name';

  @override
  String get display_name => 'displayName';

  @override
  String get farmer => 'Farmer';

  @override
  String get location => 'location';

  @override
  String get user_not_logined_in => 'User not logged in.';

  @override
  String get error_fetching_user_location => 'Error fetching user location:';

  @override
  String get error_fetching_weather => 'Error fetching weather data:';

  @override
  String get unable_to_fetch_weather_data_please_check_internet => 'Unable to fetch weather data. Please check your internet connection.';

  @override
  String get failed_to_load_weather_data => 'Failed to load weather data.';

  @override
  String get address => 'address';

  @override
  String get your_location => 'Your Location';

  @override
  String get selected_crops => 'selectedCrops';

  @override
  String get crops => 'crops';

  @override
  String get primary_crop => 'primaryCrop';

  @override
  String get error_fetching_user_data => 'Error fetching user data:';

  @override
  String get error_creating_default_user => 'Error creating default user document:';

  @override
  String get reset_password => 'Reset Password';

  @override
  String get enter_email_first => 'Please enter your email address first.';

  @override
  String get ok => 'OK';

  @override
  String get password_reset_sent_title => 'Password Reset Email Sent';

  @override
  String get password_reset_sent_message => 'A password reset link has been sent to email. Please check your inbox.';

  @override
  String get error => 'Error';

  @override
  String get password_reset_failed => 'Failed to send reset email. Please check the email address and try again.';

  @override
  String password_sent_to_email(Object email) {
    return 'A Password has been sent to $email, Please check your inbox.';
  }

  @override
  String get app_name => 'Kissan Connect';

  @override
  String get weather_data_unavailable => 'Weather data unavailable';

  @override
  String get retry => 'Retry';

  @override
  String get approximate => 'Approximate';

  @override
  String get feels_like => 'Feels like';

  @override
  String get clear => 'Clear';

  @override
  String get partlyCloudy => 'Partly Cloudy';

  @override
  String get cloudy => 'Cloudy';

  @override
  String get fog => 'Fog';

  @override
  String get drizzle => 'Drizzle';

  @override
  String get rain => 'Rain';

  @override
  String get snow => 'Snow';

  @override
  String get thunderstorm => 'Thunderstorm';

  @override
  String get clearSky => 'Clear sky';

  @override
  String get mainlyClear => 'Mainly clear';

  @override
  String get overcast => 'Overcast';

  @override
  String get depositingRimeFog => 'Depositing rime fog';

  @override
  String get lightDrizzle => 'Light drizzle';

  @override
  String get moderateDrizzle => 'Moderate drizzle';

  @override
  String get denseDrizzle => 'Dense drizzle';

  @override
  String get slightRain => 'Slight rain';

  @override
  String get moderateRain => 'Moderate rain';

  @override
  String get heavyRain => 'Heavy rain';

  @override
  String get slightSnow => 'Slight snow';

  @override
  String get moderateSnow => 'Moderate snow';

  @override
  String get heavySnow => 'Heavy snow';

  @override
  String get thunderstormWithHail => 'Thunderstorm with hail';

  @override
  String get mist => 'Mist';

  @override
  String get smoke => 'Smoke';

  @override
  String get haze => 'Haze';

  @override
  String get dust => 'Dust';

  @override
  String get foggy => 'Foggy';

  @override
  String get weather_data_error => 'Weather data error';

  @override
  String get recommendations_for => 'Recommendations for ';

  @override
  String get tap_to_change => 'tap to change';

  @override
  String get you_grow => 'You grow';

  @override
  String get high_alert => 'High Alert';

  @override
  String get moderate_alert => 'Moderate Alert';

  @override
  String get is_high_risk => 'isHighRisk';

  @override
  String get high_risk => 'High Risk!';

  @override
  String get low_risk => 'Low Risk';

  @override
  String get moderate_risk => 'Moderate Risk';

  @override
  String get standard_application_needed => 'Standard application needed';

  @override
  String get no_adjustment_needed => 'No adjustment needed';

  @override
  String get vegetative => 'Vegetative';

  @override
  String get flowering => 'Flowering';

  @override
  String get fruiting => 'Fruiting';

  @override
  String get tillering => 'Tillering';

  @override
  String get silking => 'Silking';

  @override
  String get jointing => 'Jointing';

  @override
  String get reduced_due_to_high_temperature => 'Reduced due to high temperature';

  @override
  String get slightly_increased_due_to_optimal_temp => 'Slightly increased due to optimal temperature';

  @override
  String get increased_due_to_favorable_conditions => 'Increased due to favorable conditions';

  @override
  String get increased_before_expected_rain => 'Increased before expected rain';

  @override
  String get weather_conditions_favorable => 'Weather conditions are favorable for pest activity.';

  @override
  String get pest_attack_prediction => 'Pest Attack Prediction';

  @override
  String get pest_prevention_guide => 'Pest Prevention Guide';

  @override
  String get no_message_available => 'No message available';

  @override
  String get aphids => 'Aphids';

  @override
  String get army_worm => 'Army Worm';

  @override
  String get rust_fungus => 'Rust Fungus';

  @override
  String get hessian_fly => 'Hessian Fly';

  @override
  String get bollworm => 'Bollworm';

  @override
  String get whitefly => 'Whitefly';

  @override
  String get spider_mites => 'Spider Mites';

  @override
  String get min => 'Min';

  @override
  String get max => 'Max';

  @override
  String get various_pests => 'Various Pests';

  @override
  String get stem_borer => 'Stem borer';

  @override
  String get leaf_folder => 'Leaf folder';

  @override
  String get blast_fungus => 'Blast fungus';

  @override
  String get brown_plant_hopper => 'Brown plant hopper';

  @override
  String get corn_borer => 'Corn borer';

  @override
  String get armyworm => 'Armyworm';

  @override
  String get earworm => 'Earworm';

  @override
  String get corn_leaf_aphid => 'Corn leaf aphid';

  @override
  String warm_weather_increases_nutrients(Object crop) {
    return 'Warm weather increases nutrient availability for $crop';
  }

  @override
  String cold_weather_slows_growth(Object crop) {
    return 'Cold temperatures slow $crop growth and nutrient uptake';
  }

  @override
  String optimal_temp_for_fertilizer(Object crop) {
    return 'Optimal temperature for $crop fertilizer application';
  }

  @override
  String adjustment_increased_for_rain(Object adjustment) {
    return '$adjustment, increased for rain';
  }

  @override
  String rain_helps_nutrient_absorption(Object crop, Object reason) {
    return '$reason. Rain will help $crop absorb nutrients efficiently';
  }

  @override
  String adjustment_reduced_for_dryness(Object adjustment) {
    return '$adjustment, reduced for dryness';
  }

  @override
  String dryness_requires_irrigation(Object crop, Object reason) {
    return '$reason. $crop may require irrigation after application';
  }

  @override
  String reason_with_growth_stage(Object growthStage, Object reason) {
    return '$reason. Current growth stage: $growthStage';
  }

  @override
  String get current_growth_rate => 'Current growth rate: ';

  @override
  String get temperature_optimal_for => 'Temperature optimal for';

  @override
  String natural_rainfall_sufficient_two(Object crop) {
    return 'Natural rainfall will provide sufficient moisture for $crop';
  }

  @override
  String storm_adequate_rainfall_two(Object crop) {
    return 'Storm will provide adequate rainfall for $crop, avoid waterlogging';
  }

  @override
  String high_evaporation_requires_more_water(Object crop, Object evap) {
    return 'High evaporation rate ($evap mm/day) requires more frequent watering for $crop';
  }

  @override
  String dry_warm_requires_careful_irrigation(Object crop) {
    return 'Dry, warm conditions require careful water management for $crop';
  }

  @override
  String moderate_conditions_regular_irrigation_two(Object crop, Object stage) {
    return 'Moderate conditions - maintain regular irrigation for $crop ($stage stage)';
  }

  @override
  String get high_risk_pests => '🚨 High Risk Pests:';

  @override
  String get temperature_extremes => 'Temperature extremes may reduce pest activity';

  @override
  String get rain_reduction => 'Rain may reduce some pest populations';

  @override
  String get sunny_conditions_favor_pest_development => 'Sunny conditions favor pest development';

  @override
  String get varies_with_conditions => 'Varies with conditions';

  @override
  String get moderate_risk_pests => '⚠️ Moderate Risk Pests:';

  @override
  String get aphids_description => 'Small sap-sucking insects that cause yellowing and curling of leaves.';

  @override
  String get aphids_active_season => 'Spring and Summer';

  @override
  String get army_worm_description => 'Caterpillars that feed on leaves and can defoliate entire plants.';

  @override
  String get army_worm_active_season => 'Summer and Monsoon';

  @override
  String get bollworm_description => 'Larvae that bore into cotton bolls, causing significant yield loss.';

  @override
  String get bollworm_active_season => 'Flowering season';

  @override
  String get stem_borer_description => 'Larvae that tunnel into stems, causing plants to wilt and die.';

  @override
  String get stem_borer_active_season => 'Throughout growing season';

  @override
  String get whitefly_description => 'Small white insects that suck sap and transmit viral diseases.';

  @override
  String get whitefly_active_season => 'Warm and dry conditions';

  @override
  String get rust_fungus_description => 'Fungal disease causing orange-brown pustules on leaves and stems.';

  @override
  String get rust_fungus_active_season => 'Cool, moist conditions';

  @override
  String get hessian_fly_description => 'Small flies whose larvae feed on wheat stems, stunting growth.';

  @override
  String get hessian_fly_active_season => 'Fall and Spring';

  @override
  String get spider_mites_description => 'Tiny mites that suck plant juices, causing yellow stippling on leaves.';

  @override
  String get spider_mites_active_season => 'Hot, dry weather';

  @override
  String get leaf_folder_description => 'Larvae that fold and feed inside rice leaves, reducing photosynthesis.';

  @override
  String get leaf_folder_active_season => 'Wet season';

  @override
  String get blast_fungus_description => 'Fungal disease causing lesions on leaves, nodes, and panicles.';

  @override
  String get blast_fungus_active_season => 'High humidity conditions';

  @override
  String get humidity => 'Humidity';

  @override
  String get wind => 'Wind';

  @override
  String get high_temperature_alert => 'High Temperature Alert';

  @override
  String get hourly_forecast_not_availale => 'Hourly forecast not available';

  @override
  String get now => 'Now';

  @override
  String get seven_day_forecast_not_available => '7-day forecast not available';

  @override
  String get weather_forecast => 'Weather Forecast';

  @override
  String get todays_forecast => 'Today\'s Forecast';

  @override
  String get seven_days_forecast => '7 Days Forecast';

  @override
  String get sun => 'Sun';

  @override
  String get mon => 'Mon';

  @override
  String get tue => 'Tue';

  @override
  String get wed => 'Wed';

  @override
  String get thu => 'Thu';

  @override
  String get fri => 'Fri';

  @override
  String get sat => 'Sat';

  @override
  String get am => 'AM';

  @override
  String get pm => 'PM';

  @override
  String get brown_plant_hopper_description => 'Sap-sucking insects that cause hopper burn and transmit viruses.';

  @override
  String get brown_plant_hopper_active_season => 'Wet season';

  @override
  String get corn_borer_description => 'Larvae that tunnel into corn stalks and ears, reducing yield.';

  @override
  String get corn_borer_active_season => 'Summer months';

  @override
  String get earworm_description => 'Caterpillars that feed on corn ears, damaging kernels.';

  @override
  String get earworm_active_season => 'Silking to harvest';

  @override
  String get corn_leaf_aphid_description => 'Aphids that cluster on leaves and tassels, reducing plant vigor.';

  @override
  String get corn_leaf_aphid_active_season => 'Cool weather';

  @override
  String get prevention_measures_title => 'Prevention Measures';

  @override
  String get wheat_prevention_1 => 'Use certified disease-free seeds';

  @override
  String get wheat_prevention_2 => 'Practice crop rotation with legumes';

  @override
  String get wheat_prevention_3 => 'Monitor fields regularly for early detection';

  @override
  String get wheat_prevention_4 => 'Use neem-based organic pesticides';

  @override
  String get wheat_prevention_5 => 'Remove and destroy infected plants';

  @override
  String get wheat_prevention_6 => 'Maintain proper plant spacing for air circulation';

  @override
  String get cotton_prevention_1 => 'Install yellow sticky traps for whiteflies';

  @override
  String get cotton_prevention_2 => 'Use pheromone traps for bollworms';

  @override
  String get cotton_prevention_3 => 'Practice intercropping with marigold';

  @override
  String get cotton_prevention_4 => 'Apply recommended insecticides at first sight';

  @override
  String get cotton_prevention_5 => 'Remove crop residues after harvest';

  @override
  String get cotton_prevention_6 => 'Use resistant varieties when available';

  @override
  String get regular_field_monitoring => 'Regular field monitoring';

  @override
  String get use_organic_pesticides => 'Use organic pesticides';

  @override
  String get practice_crop_rotation => 'Practice crop rotation';

  @override
  String get maintain_field_hygiene => 'Maintain Field hygiene';

  @override
  String get use_resistant_varieties => 'Use resistant varieties';

  @override
  String get consult_local_agriculature_expert => 'Consult local aggricultural expert';

  @override
  String get rice_prevention_1 => 'Maintain proper water level in fields';

  @override
  String get rice_prevention_2 => 'Use light traps for monitoring';

  @override
  String get rice_prevention_3 => 'Release natural predators like spiders';

  @override
  String get rice_prevention_4 => 'Apply recommended pesticides at tillering stage';

  @override
  String get rice_prevention_5 => 'Practice synchronous planting in area';

  @override
  String get rice_prevention_6 => 'Remove weed hosts around fields';

  @override
  String get corn_prevention_1 => 'Plant early to avoid peak pest season';

  @override
  String get corn_prevention_2 => 'Use resistant hybrid varieties';

  @override
  String get corn_prevention_3 => 'Practice deep plowing after harvest';

  @override
  String get corn_prevention_4 => 'Apply soil insecticides at planting';

  @override
  String get corn_prevention_5 => 'Monitor for egg masses on leaves';

  @override
  String get corn_prevention_6 => 'Use biological control agents';

  @override
  String get pest_activity_favorable => 'Weather conditions are favorable for pest activity.';

  @override
  String get tap_for_prevention_guide => 'Tap for prevention guide';

  @override
  String get fertilizer_guide_for => 'Fertilizer Guide for';

  @override
  String get tap_for_details => 'Tap for details';

  @override
  String get optimal_irrigation_needed_for => 'Optimal Irrigation Needed for';

  @override
  String get critical_growth_stage_guide => 'crop is at a critical growth stage. Tap for a guide.';

  @override
  String get you => 'You';

  @override
  String get logout => 'Logout';

  @override
  String get error_logout => 'Error logging out:';

  @override
  String get home => 'Home';

  @override
  String get weather => 'Weather';

  @override
  String get crop_guide => 'Crop Guide';

  @override
  String get marketplace => 'Marketplace';

  @override
  String get unknown => 'Unknown';

  @override
  String get crop => 'Crop';

  @override
  String get fertilizer_guide => 'Fertilizer Guide';

  @override
  String get fertilizer_recommendation => 'Fertilizer Recommendation';

  @override
  String get no_reason_provided => 'No reason provided';

  @override
  String get optimal_application_rate => 'Optimal application rate';

  @override
  String get adjustment => 'Adjustment';

  @override
  String get none => 'None';

  @override
  String get nitrogen => 'Nitrogen';

  @override
  String get phosphorus => 'Phosphorus';

  @override
  String get potassium => 'Potassium';

  @override
  String get micronutrients => 'Micronutrients';

  @override
  String get active_in => '🕒 Active in:';

  @override
  String get application_guide => '📋 Application Guide:';

  @override
  String get general => 'General';

  @override
  String get recommended_fertilizer_types => '🧪 Recommended Fertilizer Types:';

  @override
  String get no_description_available => 'No description available';

  @override
  String get various_seasons => 'Various Seasons';

  @override
  String get best_application_timing => '⏰ Best Application Timing:';

  @override
  String get irrigation_guide => 'Irrigation Guide';

  @override
  String get irrigation_recommendation => 'Irrigation Recommendation';

  @override
  String get delay_irrigation_rain_expected => 'Delay irrigation - Rain expected';

  @override
  String get natural_rainfall_sufficient => 'Natural rainfall will provide sufficient moisture';

  @override
  String get low => 'Low';

  @override
  String get delay_irrigation_heavy_rain => 'Delay irrigation - Heavy rain expected';

  @override
  String get storm_adequate_rainfall => 'Storm will provide adequate rainfall for, avoid waterlogging';

  @override
  String get increase_irrigation_frequency => 'Increase irrigation frequency';

  @override
  String get high_evaporation_more_watering => 'High evaporation rate requires more frequent watering';

  @override
  String get high => 'High';

  @override
  String get reduce_irrigation_frequency => 'Reduce irrigation frequency';

  @override
  String get low_evaporation_less_water => 'Low evaporation rate needs less water';

  @override
  String get monitor_soil_moisture => 'Monitor soil moisture closely';

  @override
  String get dry_warm_conditions => 'Dry, warm conditions require careful water management';

  @override
  String get medium => 'Medium';

  @override
  String get normal_irrigation_schedule => 'Normal irrigation schedule';

  @override
  String get moderate_conditions_regular_irrigation => 'Moderate conditions - maintain regular irrigation';

  @override
  String get wheat => 'Wheat';

  @override
  String get apply_one_third_nitrogen_sowing => 'Apply 1/3 of nitrogen at sowing';

  @override
  String get apply_remaining_nitrogen_splits => 'Apply remaining nitrogen in two splits during tillering and jointing';

  @override
  String get mix_fertilizers_thoroughly => 'Mix fertilizers thoroughly in soil';

  @override
  String get apply_when_soil_moist => 'Apply when soil has adequate moisture';

  @override
  String get avoid_heavy_rainfall_application => 'Avoid application during heavy rainfall';

  @override
  String get use_soil_test_recommendations => 'Use soil test-based recommendations';

  @override
  String get cotton => 'Cotton';

  @override
  String get apply_full_phosphorus_potassium => 'Apply full dose of phosphorus and potassium at sowing';

  @override
  String get split_nitrogen_three_four_doses => 'Split nitrogen application in 3-4 doses, First dose at sowing, second at squaring, Third dose at flowering, fourth if needed';

  @override
  String get apply_in_bands => 'Apply in bands 5-7 cm deep';

  @override
  String get irrigate_after_application => 'Irrigate immediately after application';

  @override
  String get rice => 'Rice';

  @override
  String get apply_basal_before_pudding => 'Apply basal dose before pudding';

  @override
  String get split_nitrogen_three_equal_doses => 'Spliting nitrogen into three equal doses: ';

  @override
  String get first_second_third => 'First at transplanting, second at tillering, third at panicle initiation';

  @override
  String get apply_in_standing_water => 'Apply in standing water for better efficiency';

  @override
  String get use_urea_super_granules => 'Use urea super granules for better results';

  @override
  String get avoid_strong_wind_application => 'Avoid application during strong winds';

  @override
  String get corn => 'Corn';

  @override
  String get apply_starter_fertilizer_planting => 'Apply starter fertilizer at planting';

  @override
  String get side_dress_nitrogen => 'Side-dress nitrogen when plants are 30-45 cm tall';

  @override
  String get apply_phosphorus_potassium_soil_test => 'Apply phosphorus and potassium based on soil test';

  @override
  String get use_split_for_sandy_soils => 'Use split applications for sandy soils';

  @override
  String get avoid_root_contact_concentrated => 'Avoid root contact with concentrated fertilizers';

  @override
  String get apply_based_on_soil_test => 'Apply fertilizers based on soil test results';

  @override
  String get split_applications_for_efficiency => 'Split applications for better efficiency';

  @override
  String get incorporate_fertilizers_properly => 'Incorporate fertilizers properly into soil';

  @override
  String get apply_when_plants_growing => 'Apply when plants are actively growing';

  @override
  String get avoid_extreme_weather_application => 'Avoid application during extreme weather';

  @override
  String get apply_fertilizers_based_on_soil_test => 'Apply fertilizers based on soil test results';

  @override
  String get apply_during_active_growth => 'Apply when plants are actively growing';

  @override
  String get follow_recommended_dosage => 'Follow recommended dosage strictly';

  @override
  String get focus_on_nitrogen => 'Focus on nitrogen application';

  @override
  String get avoid_drought_application => 'Avoid application during drought';

  @override
  String get best_before_rainfall => 'Best applied before expected rainfall';

  @override
  String get monitor_leaf_color_deficiencies => 'Monitor leaf color for deficiencies';

  @override
  String get evapotranspiration_rate => 'Evapotranspiration Rate:';

  @override
  String get reduce_nitrogen_application => 'Reduce nitrogen application';

  @override
  String get increase_phosphorus_for_flowering => 'Increase phosphorus for flower formation';

  @override
  String get apply_before_flower_buds_open => 'Apply before flower buds open';

  @override
  String get avoid_full_bloom_application => 'Avoid application during full bloom';

  @override
  String get monitor_nutrient_deficiencies => 'Monitor for nutrient deficiencies';

  @override
  String get critical_for_nitrogen_application => 'Critical for nitrogen application';

  @override
  String get apply_when_tillers_develop => 'Apply when tillers start developing';

  @override
  String get split_application_recommended => 'Split application recommended';

  @override
  String get ensure_adequate_soil_moisture => 'Ensure adequate soil moisture';

  @override
  String get monitor_tiller_count => 'Monitor tiller count regularly';

  @override
  String get focus_on_potassium_application => 'Focus on potassium application';

  @override
  String get apply_early_silking_stage => 'Apply during early silking stage';

  @override
  String get reduce_nitrogen_excess_growth => 'Reduce nitrogen to prevent excessive growth';

  @override
  String get ensure_balanced_nutrition => 'Ensure balanced nutrition';

  @override
  String get monitor_ear_development => 'Monitor ear development';

  @override
  String get apply_early_pod_development => 'Apply during early pod development';

  @override
  String get monitor_pod_setting_rate => 'Monitor pod setting rate';

  @override
  String get avoid_stress_conditions => 'Avoid application during stress conditions';

  @override
  String get follow_crop_specific_schedule => 'Follow crop-specific schedules';

  @override
  String get consider_weather_conditions => 'Consider weather conditions';

  @override
  String get monitor_plant_response => 'Monitor plant response after application';

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
  String get error_initializing_firebase => 'Error initializing Firebase:';

  @override
  String get error_updating_first_time_status => 'Error updating first-time status';

  @override
  String get your_journey_begins_here => 'Your farming journey begins here';

  @override
  String get preparing_your_dashboard => 'Preparing your personalized dashboard...';

  @override
  String get tap_to_continue => 'Tap to continue';

  @override
  String get irrigation_schedule => '📅 Irrigation Schedule:';

  @override
  String get wheat_first_irrigation => 'First Irrigation:';

  @override
  String get wheat_first_irrigation_value => '20-25 days after sowing (Crown root initiation)';

  @override
  String get wheat_second_irrigation => 'Second Irrigation:';

  @override
  String get wheat_second_irrigation_value => '45-50 days after sowing (Tillering)';

  @override
  String get wheat_third_irrigation => 'Third Irrigation:';

  @override
  String get wheat_third_irrigation_value => '70-75 days after sowing (Jointing)';

  @override
  String get wheat_fourth_irrigation => 'Fourth Irrigation: ';

  @override
  String get wheat_fourth_irrigation_value => '90-95 days after sowing (Booting)';

  @override
  String get wheat_fifth_irrigation => 'Fifth Irrigation:';

  @override
  String get wheat_fifth_irrigation_value => '110-115 days after sowing (Grain filling)';

  @override
  String get cotton_first_irrigation => 'First Irrigation: ';

  @override
  String get cotton_first_irrigation_value => '30-35 days after sowing (Vegetative stage)';

  @override
  String get cotton_second_irrigation => 'Second Irrigation: ';

  @override
  String get cotton_second_irrigation_value => 'During squaring stage';

  @override
  String get cotton_third_irrigation => 'Third Irrigation: ';

  @override
  String get cotton_third_irrigation_value => 'During flowering stage';

  @override
  String get cotton_fourth_irrigation => 'Fourth Irrigation: ';

  @override
  String get cotton_fourth_irrigation_value => 'Boll formation stage';

  @override
  String get cotton_fifth_irrigation => 'Fifth Irrigation: ';

  @override
  String get cotton_fifth_irrigation_value => 'Boll development stage';

  @override
  String get rice_initial_flooding => 'Initial Flooding: ';

  @override
  String get rice_initial_flooding_value => '3-5 cm standing water after transplanting';

  @override
  String get rice_vegetative_stage => 'Vegetative Stage:';

  @override
  String get rice_vegetative_stage_value => 'Maintain 2-5 cm standing water';

  @override
  String get rice_reproductive_stage => 'Reproductive Stage: ';

  @override
  String get rice_reproductive_stage_value => 'Maintain 5-10 cm standing water';

  @override
  String get rice_ripening_stage => 'Ripening Stage: ';

  @override
  String get rice_ripening_stage_value => 'Gradually reduce water 2 weeks before harvest';

  @override
  String get corn_first_irrigation => 'First Irrigation: Immediately after sowing';

  @override
  String get corn_first_irrigation_value => 'Immediately after sowing';

  @override
  String get corn_second_irrigation => 'Second Irrigation: Knee-high stage (30-45 cm)';

  @override
  String get corn_second_irrigation_value => 'Knee-high stage (30-45 cm)';

  @override
  String get corn_third_irrigation => 'Third Irrigation: ';

  @override
  String get corn_third_irrigation_value => 'Tasseling stage';

  @override
  String get corn_fourth_irrigation => 'Fourth Irrigation: ';

  @override
  String get corn_fourth_irrigation_value => 'Silking stage';

  @override
  String get corn_fifth_irrigation => 'Fifth Irrigation: ';

  @override
  String get corn_fifth_irrigation_value => 'Grain filling stage';

  @override
  String get general_rule => 'General Rule: ';

  @override
  String get general_rule_value => 'Irrigate when top 15 cm soil feels dry';

  @override
  String get general_pests_that_affect_crop => 'General pest that affects crop health and yield.';

  @override
  String get critical_stages => 'Critical Stages: ';

  @override
  String get critical_stages_value => 'Ensure adequate moisture during flowering and fruit setting';

  @override
  String get water_quantity => 'Water Quantity: ';

  @override
  String get water_quantity_value => 'Apply 5-7 cm depth per irrigation';

  @override
  String get monitoring => 'Monitoring: ';

  @override
  String get monitoring_value => 'RCheck soil moisture regularly';

  @override
  String get water_management_tips => '💧 Water Management Tips:';

  @override
  String get high_tip_first => 'Irrigate immediately if soil is dry';

  @override
  String get high_tip_second => 'Use mulching to conserve soil moisture';

  @override
  String get high_tip_third => 'Consider drip irrigation for efficiency';

  @override
  String get high_tip_fourth => 'Monitor plants for wilting signs';

  @override
  String get high_tip_fifth => 'Water in early morning or late evening';

  @override
  String get high_tip_sixth => 'Check soil moisture daily';

  @override
  String get medium_tip_first => 'Follow regular irrigation schedule';

  @override
  String get medium_tip_second => 'Check soil moisture every 2-3 days';

  @override
  String get medium_tip_third => 'Adjust based on rainfall';

  @override
  String get medium_tip_fourth => 'Use water conservation techniques';

  @override
  String get medium_tip_fifth => 'Monitor weather forecasts';

  @override
  String get medium_tip_sixth => 'Maintain irrigation records';

  @override
  String get low_tip_first => 'Delay irrigation if rain is forecast';

  @override
  String get low_tip_second => 'Check soil moisture before watering';

  @override
  String get low_tip_third => 'Reduce irrigation frequency';

  @override
  String get low_tip_fourth => 'Use water-saving methods';

  @override
  String get low_tip_fifth => 'Monitor for over-watering signs';

  @override
  String get low_tip_sixth => 'Collect rainwater if possible';

  @override
  String get return_tip_first => 'Check soil moisture before irrigation';

  @override
  String get return_tip_second => 'Water based on plant needs, not fixed schedule';

  @override
  String get return_tip_third => 'Use efficient irrigation methods';

  @override
  String get return_tip_fourth => 'Monitor weather conditions';

  @override
  String get return_tip_fifth => 'Avoid waterlogging';

  @override
  String get return_tip_sixth => 'Maintain proper drainage';

  @override
  String get irrigation_methods => '⚙️ Irrigation Methods:';

  @override
  String get drip_irrigation => 'Drip Irrigation';

  @override
  String get drip_irrigation_desc => 'Most efficient method, saves 30-50% water, ideal for row crops';

  @override
  String get sprinkler_irrigation => 'Sprinkler Irrigation';

  @override
  String get sprinkler_irrigation_desc => 'Good for uniform coverage, suitable for most field crops';

  @override
  String get furrow_irrigation => 'Furrow Irrigation';

  @override
  String get furrow_irrigation_desc => 'Traditional method for row crops, moderate efficiency';

  @override
  String get flood_irrigation => 'Flood Irrigation';

  @override
  String get flood_irrigation_desc => 'Used for rice and some field crops, lower efficiency';

  @override
  String get basin_irrigation => 'Basin Irrigation';

  @override
  String get basin_irrigation_desc => 'Suitable for orchards and some field crops';

  @override
  String high_risk_message(Object cropName, Object pests) {
    return 'High risk of $pests infestation in $cropName';
  }

  @override
  String moderate_risk_message(Object cropName, Object pests) {
    return 'Monitor $cropName for $pests';
  }

  @override
  String low_risk_message(Object cropName) {
    return 'Low pest risk for $cropName in current conditions';
  }

  @override
  String get generic_pest => 'pest';

  @override
  String get potential_pests => 'potential pests';

  @override
  String high_temp_burn_risk(Object cropName) {
    return 'High temperatures increase fertilizer burn risk for $cropName';
  }

  @override
  String warm_weather_nutrient_availability(Object cropName) {
    return 'Warm weather increases nutrient availability for $cropName';
  }

  @override
  String cold_temp_slow_growth(Object cropName) {
    return 'Cold temperatures slow $cropName growth and nutrient uptake';
  }

  @override
  String optimal_temp_application(Object cropName) {
    return 'Optimal temperature for $cropName fertilizer application';
  }

  @override
  String rain_absorption_help(Object cropName) {
    return 'Rain will help $cropName absorb nutrients efficiently';
  }

  @override
  String irrigation_required_after_application(Object cropName) {
    return '$cropName may require irrigation after application';
  }

  @override
  String get as_per_soil_test => 'As per soil test recommendations';

  @override
  String natural_rainfall_sufficient_three(Object crop) {
    return 'Natural rainfall will provide sufficient moisture for $crop';
  }

  @override
  String storm_rainfall_avoid_waterlogging_three(Object crop) {
    return 'Storm will provide adequate rainfall for $crop, avoid waterlogging';
  }

  @override
  String high_evaporation_requires_more_water_three(Object crop, Object et) {
    return 'High evaporation rate ($et mm/day) requires more frequent watering for $crop';
  }

  @override
  String low_evaporation_less_water_three(Object crop, Object et) {
    return 'Low evaporation rate ($et mm/day) - $crop needs less water';
  }

  @override
  String dry_warm_conditions_water_management_three(Object crop) {
    return 'Dry, warm conditions require careful water management for $crop';
  }

  @override
  String get normal_irrigation_schedule_three => 'Normal irrigation schedule';

  @override
  String moderate_conditions_regular_irrigation_three(Object crop, Object stage) {
    return 'Moderate conditions - maintain regular irrigation for $crop ($stage stage)';
  }

  @override
  String get urgency_low => 'Low';

  @override
  String get urgency_medium => 'Medium';

  @override
  String get urgency_high => 'High';

  @override
  String get mm_day => 'mm/day';

  @override
  String get wheat_summary => 'Wheat is a staple Rabi crop requiring cool weather (15-25°C) during growth and moderate rainfall. Ideal sowing season is October-December.';

  @override
  String get wheat_p_title => 'Planting';

  @override
  String get wheat_p1 => 'Sow from October to December for Rabi season';

  @override
  String get wheat_p2 => 'Use certified seeds like Punjab-2011, Galaxy-2013';

  @override
  String get wheat_p3 => 'Optimal seed rate: 40-50 kg/acre';

  @override
  String get wheat_p4 => 'Row spacing: 22-25 cm';

  @override
  String get wheat_p5 => 'Sow at depth of 4-5 cm';

  @override
  String get wheat_i_title => 'Irrigation';

  @override
  String get wheat_i1 => 'First irrigation: 21-25 days after sowing';

  @override
  String get wheat_i2 => 'Second irrigation: 45-50 days (Tillering stage)';

  @override
  String get wheat_i3 => 'Third irrigation: 70-75 days (Jointing stage)';

  @override
  String get wheat_i4 => 'Fourth irrigation: 90-95 days (Flowering)';

  @override
  String get wheat_i5 => 'Fifth irrigation: 110-115 days (Grain filling)';

  @override
  String get wheat_f_title => 'Fertilization';

  @override
  String get wheat_f1 => 'Basal dose: 2 bags DAP + 1 bag SOP/acre';

  @override
  String get wheat_f2 => 'First split: 1 bag Urea at tillering';

  @override
  String get wheat_f3 => 'Second split: 1 bag Urea at jointing';

  @override
  String get wheat_f4 => 'Apply Zinc sulfate @ 5 kg/acre if deficient';

  @override
  String get wheat_f5 => 'Foliar spray of boron at flowering';

  @override
  String get wheat_pc_title => 'Pest Control';

  @override
  String get wheat_pc1 => 'Monitor for aphids during Feb-March';

  @override
  String get wheat_pc2 => 'Use neem oil spray @ 5% for early infestation';

  @override
  String get wheat_pc3 => 'For army worm: Chlorpyrifos @ 1.5 L/acre';

  @override
  String get wheat_pc4 => 'Rust control: Propiconazole @ 200 ml/acre';

  @override
  String get wheat_pc5 => 'Remove volunteer plants to break disease cycle';

  @override
  String get wheat_y_title => 'Yield Optimization';

  @override
  String get wheat_y1 => 'Target yield: 40-50 maunds/acre';

  @override
  String get wheat_y2 => 'Harvest when grains harden (30-35% moisture)';

  @override
  String get wheat_y3 => 'Use combine harvester for efficient harvesting';

  @override
  String get wheat_y4 => 'Dry to 12% moisture before storage';

  @override
  String get wheat_y5 => 'Store in clean, rodent-proof godowns';

  @override
  String get sugar_summary => 'Sugarcane is a tropical perennial cash crop needing high heat (25-32°C) and moisture. It has a 12-18 month growing season.';

  @override
  String get sugar_p_title => 'Planting';

  @override
  String get sugar_p1 => 'Plant from February to March (Spring crop)';

  @override
  String get sugar_p2 => 'Use 3-bud setts from healthy canes';

  @override
  String get sugar_p3 => 'Seed rate: 30-35,000 setts/acre';

  @override
  String get sugar_p4 => 'Row spacing: 90-120 cm';

  @override
  String get sugar_p5 => 'Planting depth: 5-7 cm in furrows';

  @override
  String get sugar_i_title => 'Irrigation';

  @override
  String get sugar_i1 => 'Initial: Irrigate immediately after planting';

  @override
  String get sugar_i2 => 'Critical stage: Grand growth period';

  @override
  String get sugar_i3 => 'Irrigation interval: 10-12 days in summer';

  @override
  String get sugar_i4 => 'Stop irrigation 30 days before harvest';

  @override
  String get sugar_i5 => 'Total water requirement: 180-200 cm/season';

  @override
  String get sugar_f_title => 'Fertilization';

  @override
  String get sugar_f1 => 'Basal: 2 bags DAP + 1 bag SOP/acre';

  @override
  String get sugar_f2 => 'Top dressing: 3 bags Urea in 3 splits';

  @override
  String get sugar_f3 => 'First split: 30 days after planting';

  @override
  String get sugar_f4 => 'Second split: 60 days after planting';

  @override
  String get sugar_f5 => 'Third split: 90 days after planting';

  @override
  String get sugar_pc_title => 'Pest Control';

  @override
  String get sugar_pc1 => 'For borers: Furadan @ 10 kg/acre at planting';

  @override
  String get sugar_pc2 => 'For termites: Chlorpyrifos @ 2 L/acre';

  @override
  String get sugar_pc3 => 'For red rot: Use resistant varieties';

  @override
  String get sugar_pc4 => 'Remove and destroy infected plants';

  @override
  String get sugar_pc5 => 'Practice crop rotation with legumes';

  @override
  String get sugar_y_title => 'Yield Optimization';

  @override
  String get sugar_y1 => 'Target yield: 700-800 maunds/acre';

  @override
  String get sugar_y2 => 'Harvest when canes mature (12-18 months)';

  @override
  String get sugar_y3 => 'Cut close to ground level';

  @override
  String get sugar_y4 => 'Mill within 24 hours of harvest';

  @override
  String get sugar_y5 => 'Ratoon management for 2-3 cycles';

  @override
  String get rice_summary => 'Rice needs standing water for most of its growing period. The Kharif season is the best time for cultivation.';

  @override
  String get rice_p_title => 'Planting';

  @override
  String get rice_p1 => 'Transplant seedlings 20-25 days old';

  @override
  String get rice_p2 => 'Optimal spacing: 20 x 15 cm';

  @override
  String get rice_p3 => 'Plant 2-3 seedlings per hill';

  @override
  String get rice_p4 => 'Transplant in puddled soil';

  @override
  String get rice_p5 => 'Best time: June-July for Kharif season';

  @override
  String get rice_i_title => 'Irrigation';

  @override
  String get rice_i1 => 'Maintain 2-5 cm standing water';

  @override
  String get rice_i2 => 'Drain field 15 days before harvest';

  @override
  String get rice_i3 => 'Critical stages: Tillering and flowering';

  @override
  String get rice_i4 => 'Avoid water stress during panicle initiation';

  @override
  String get rice_i5 => 'Total water requirement: 100-150 cm';

  @override
  String get rice_f_title => 'Fertilization';

  @override
  String get rice_f1 => 'Basal: 1.5 bags DAP/acre';

  @override
  String get rice_f2 => 'First top dressing: 1 bag Urea at tillering';

  @override
  String get rice_f3 => 'Second top dressing: 0.5 bag Urea at panicle initiation';

  @override
  String get rice_f4 => 'Apply Zinc sulfate @ 10 kg/acre if needed';

  @override
  String get rice_f5 => 'Silicon application improves stem strength';

  @override
  String get rice_pc_title => 'Pest Control';

  @override
  String get rice_pc1 => 'For stem borer: Cartap hydrochloride @ 500g/acre';

  @override
  String get rice_pc2 => 'For leaf folder: Fipronil @ 200 ml/acre';

  @override
  String get rice_pc3 => 'For blast disease: Tricyclazole @ 300g/acre';

  @override
  String get rice_pc4 => 'Use light traps for moth monitoring';

  @override
  String get rice_pc5 => 'Practice clean cultivation';

  @override
  String get rice_y_title => 'Yield Optimization';

  @override
  String get rice_y1 => 'Target yield: 30-40 maunds/acre';

  @override
  String get rice_y2 => 'Harvest when 80% grains turn golden yellow';

  @override
  String get rice_y3 => 'Thresh within 2-3 days of harvest';

  @override
  String get rice_y4 => 'Dry to 14% moisture content';

  @override
  String get rice_y5 => 'Store in aerated containers';

  @override
  String get cotton_summary => 'Cotton thrives in dry, warm climates and needs plenty of sunshine. Proper pest management is key.';

  @override
  String get cotton_p_title => 'Planting';

  @override
  String get cotton_p1 => 'Sow from April to May';

  @override
  String get cotton_p2 => 'Seed rate: 4-5 kg/acre for Bt cotton';

  @override
  String get cotton_p3 => 'Row spacing: 75-90 cm';

  @override
  String get cotton_p4 => 'Plant-to-plant distance: 30-45 cm';

  @override
  String get cotton_p5 => 'Treat seeds with fungicide before sowing';

  @override
  String get cotton_i_title => 'Irrigation';

  @override
  String get cotton_i1 => 'First irrigation: 30-35 days after sowing';

  @override
  String get cotton_i2 => 'Critical stage: Flowering and boll formation';

  @override
  String get cotton_i3 => 'Irrigation interval: 12-15 days';

  @override
  String get cotton_i4 => 'Stop irrigation 90-100 days after sowing';

  @override
  String get cotton_i5 => 'Avoid waterlogging';

  @override
  String get cotton_f_title => 'Fertilization';

  @override
  String get cotton_f1 => 'Basal: 2 bags DAP + 1 bag SOP/acre';

  @override
  String get cotton_f2 => 'Top dressing: 2 bags Urea in 2 splits';

  @override
  String get cotton_f3 => 'First split: 30 days after sowing';

  @override
  String get cotton_f4 => 'Second split: 60 days after sowing';

  @override
  String get cotton_f5 => 'Apply boron @ 1 kg/acre during flowering';

  @override
  String get cotton_pc_title => 'Pest Control';

  @override
  String get cotton_pc1 => 'For bollworms: Emamectin benzoate @ 150 ml/acre';

  @override
  String get cotton_pc2 => 'For whitefly: Acetamiprid @ 80g/acre';

  @override
  String get cotton_pc3 => 'For mealybug: Chlorpyrifos @ 1.5 L/acre';

  @override
  String get cotton_pc4 => 'Monitor with pheromone traps';

  @override
  String get cotton_pc5 => 'Practice crop rotation';

  @override
  String get cotton_y_title => 'Yield Optimization';

  @override
  String get cotton_y1 => 'Target yield: 25-30 maunds/acre';

  @override
  String get cotton_y2 => 'Harvest in 3-4 pickings';

  @override
  String get cotton_y3 => 'Pick when bolls fully open';

  @override
  String get cotton_y4 => 'Dry in shade to maintain fiber quality';

  @override
  String get cotton_y5 => 'Store in dry place';

  @override
  String get maize_summary => 'Maize is versatile and requires moderate temperatures. It is often grown as a Kharif crop.';

  @override
  String get maize_p_title => 'Planting';

  @override
  String get maize_p1 => 'Sow from June to July for Kharif';

  @override
  String get maize_p2 => 'Seed rate: 8-10 kg/acre';

  @override
  String get maize_p3 => 'Row spacing: 60-75 cm';

  @override
  String get maize_p4 => 'Plant-to-plant: 20-25 cm';

  @override
  String get maize_p5 => 'Sow at depth of 5-7 cm';

  @override
  String get maize_i_title => 'Irrigation';

  @override
  String get maize_i1 => 'Critical stages: Knee-high and tasseling';

  @override
  String get maize_i2 => 'Irrigation every 10-12 days in summer';

  @override
  String get maize_i3 => 'Avoid water stress during pollination';

  @override
  String get maize_i4 => 'Last irrigation 15 days before harvest';

  @override
  String get maize_i5 => 'Total water: 50-60 cm';

  @override
  String get maize_f_title => 'Fertilization';

  @override
  String get maize_f1 => 'Basal: 2 bags DAP + 1 bag SOP/acre';

  @override
  String get maize_f2 => 'Top dressing: 2 bags Urea in 2 splits';

  @override
  String get maize_f3 => 'First split: 25-30 days after sowing';

  @override
  String get maize_f4 => 'Second split: 45-50 days after sowing';

  @override
  String get maize_f5 => 'Apply Zinc @ 10 kg/acre if deficient';

  @override
  String get maize_pc_title => 'Pest Control';

  @override
  String get maize_pc1 => 'For stem borer: Carbofuran @ 10 kg/acre';

  @override
  String get maize_pc2 => 'For fall armyworm: Spinetoram @ 100 ml/acre';

  @override
  String get maize_pc3 => 'For downy mildew: Metalaxyl @ 2g/kg seed';

  @override
  String get maize_pc4 => 'Use bird perches for pest control';

  @override
  String get maize_pc5 => 'Remove infected plants';

  @override
  String get maize_y_title => 'Yield Optimization';

  @override
  String get maize_y1 => 'Target yield: 40-50 maunds/acre';

  @override
  String get maize_y2 => 'Harvest when grains harden';

  @override
  String get maize_y3 => 'Harvest at 20-25% moisture';

  @override
  String get maize_y4 => 'Dry to 14% moisture for storage';

  @override
  String get maize_y5 => 'Store in well-ventilated bins';

  @override
  String get mango_summary => 'Mango is a tropical fruit tree. It requires careful pruning and protection from frost during flowering.';

  @override
  String get mango_p_title => 'Planting';

  @override
  String get mango_p1 => 'Plant in July-August or February-March';

  @override
  String get mango_p2 => 'Spacing: 10 x 10 meters';

  @override
  String get mango_p3 => 'Dig pits of 1 x 1 x 1 meter';

  @override
  String get mango_p4 => 'Mix soil with 30-40 kg FYM per pit';

  @override
  String get mango_p5 => 'Graft preferred varieties (Sindhri, Anwar Ratol)';

  @override
  String get mango_i_title => 'Irrigation';

  @override
  String get mango_i1 => 'Young plants: Irrigate every 3-4 days';

  @override
  String get mango_i2 => 'Mature trees: Irrigate every 10-15 days';

  @override
  String get mango_i3 => 'Critical stage: Fruit setting and development';

  @override
  String get mango_i4 => 'Stop irrigation 15 days before harvest';

  @override
  String get mango_i5 => 'Use basin or drip irrigation';

  @override
  String get mango_f_title => 'Fertilization';

  @override
  String get mango_f1 => 'Young trees: 10-20 kg FYM + 250g NPK/year';

  @override
  String get mango_f2 => 'Mature trees: 50-100 kg FYM + 1-2 kg NPK/year';

  @override
  String get mango_f3 => 'Apply after harvest (June-July)';

  @override
  String get mango_f4 => 'Apply before flowering (December-January)';

  @override
  String get mango_f5 => 'Foliar spray of micronutrients during flowering';

  @override
  String get mango_pc_title => 'Pest Control';

  @override
  String get mango_pc1 => 'For fruit fly: Bait spray (Malathion + jaggery)';

  @override
  String get mango_pc2 => 'For mango hopper: Imidacloprid @ 50 ml/acre';

  @override
  String get mango_pc3 => 'For anthracnose: Copper oxychloride @ 500g/acre';

  @override
  String get mango_pc4 => 'Bag fruits for protection';

  @override
  String get mango_pc5 => 'Maintain orchard sanitation';

  @override
  String get mango_y_title => 'Yield Optimization';

  @override
  String get mango_y1 => 'Target yield: 100-200 kg/tree (mature)';

  @override
  String get mango_y2 => 'Harvest when fruits develop shoulder';

  @override
  String get mango_y3 => 'Harvest in morning hours';

  @override
  String get mango_y4 => 'Handle fruits carefully to avoid damage';

  @override
  String get mango_y5 => 'Pack in ventilated boxes';

  @override
  String get potato_summary => 'Potato is a cool-season crop grown in winter. Proper soil preparation and seed treatment are crucial.';

  @override
  String get potato_p_title => 'Planting';

  @override
  String get potato_p1 => 'Plant from October to November';

  @override
  String get potato_p2 => 'Use disease-free certified tubers';

  @override
  String get potato_p3 => 'Seed rate: 800-1000 kg/acre';

  @override
  String get potato_p4 => 'Row spacing: 60 cm';

  @override
  String get potato_p5 => 'Plant spacing: 20-25 cm';

  @override
  String get potato_p6 => 'Plant at depth of 5-7 cm';

  @override
  String get potato_i_title => 'Irrigation';

  @override
  String get potato_i1 => 'First irrigation: Immediately after planting';

  @override
  String get potato_i2 => 'Critical stage: Tuber initiation and bulking';

  @override
  String get potato_i3 => 'Irrigation every 7-10 days';

  @override
  String get potato_i4 => 'Stop irrigation 15-20 days before harvest';

  @override
  String get potato_i5 => 'Avoid waterlogging';

  @override
  String get potato_f_title => 'Fertilization';

  @override
  String get potato_f1 => 'Basal: 3 bags DAP + 2 bags SOP/acre';

  @override
  String get potato_f2 => 'Top dressing: 2 bags Urea in 2 splits';

  @override
  String get potato_f3 => 'First split: 25-30 days after planting';

  @override
  String get potato_f4 => 'Second split: 45-50 days after planting';

  @override
  String get potato_f5 => 'Apply boron @ 1 kg/acre if needed';

  @override
  String get potato_pc_title => 'Pest Control';

  @override
  String get potato_pc1 => 'For cutworm: Chlorpyrifos @ 2 L/acre in soil';

  @override
  String get potato_pc2 => 'For aphids: Imidacloprid @ 50 ml/acre';

  @override
  String get potato_pc3 => 'For late blight: Mancozeb @ 500g/acre';

  @override
  String get potato_pc4 => 'Use resistant varieties';

  @override
  String get potato_pc5 => 'Practice crop rotation with cereals';

  @override
  String get potato_y_title => 'Yield Optimization';

  @override
  String get potato_y1 => 'Target yield: 200-250 maunds/acre';

  @override
  String get potato_y2 => 'Harvest when vines dry';

  @override
  String get potato_y3 => 'Harvest in cool weather';

  @override
  String get potato_y4 => 'Cure tubers for 10-15 days before storage';

  @override
  String get potato_y5 => 'Store at 4-5°C with high humidity';

  @override
  String get chilli_summary => 'Chilli is a warm-season crop sensitive to frost. Requires well-drained soil and careful water management.';

  @override
  String get chilli_p_title => 'Planting';

  @override
  String get chilli_p1 => 'Transplant 30-35 day old seedlings';

  @override
  String get chilli_p2 => 'Spacing: 45 x 30 cm';

  @override
  String get chilli_p3 => 'Plant 2 seedlings per hill';

  @override
  String get chilli_p4 => 'Best time: February-March for spring crop';

  @override
  String get chilli_p5 => 'Raised beds for better drainage';

  @override
  String get chilli_i_title => 'Irrigation';

  @override
  String get chilli_i1 => 'Light irrigation after transplanting';

  @override
  String get chilli_i2 => 'Irrigation every 5-7 days in summer';

  @override
  String get chilli_i3 => 'Critical stage: Flowering and fruit set';

  @override
  String get chilli_i4 => 'Avoid overhead irrigation to prevent disease';

  @override
  String get chilli_i5 => 'Drip irrigation recommended';

  @override
  String get chilli_f_title => 'Fertilization';

  @override
  String get chilli_f1 => 'Basal: 2 bags DAP + 1 bag SOP/acre';

  @override
  String get chilli_f2 => 'Top dressing: 1.5 bags Urea in 3 splits';

  @override
  String get chilli_f3 => 'First split: 30 days after transplanting';

  @override
  String get chilli_f4 => 'Second split: 60 days after transplanting';

  @override
  String get chilli_f5 => 'Third split: During fruit set';

  @override
  String get chilli_pc_title => 'Pest Control';

  @override
  String get chilli_pc1 => 'For thrips: Spinosad @ 100 ml/acre';

  @override
  String get chilli_pc2 => 'For mites: Abamectin @ 100 ml/acre';

  @override
  String get chilli_pc3 => 'For fruit rot: Carbendazim @ 250g/acre';

  @override
  String get chilli_pc4 => 'Use yellow sticky traps';

  @override
  String get chilli_pc5 => 'Remove infected plants immediately';

  @override
  String get chilli_y_title => 'Yield Optimization';

  @override
  String get chilli_y1 => 'Target yield: 40-50 maunds/acre (dry)';

  @override
  String get chilli_y2 => 'Harvest when fruits turn red';

  @override
  String get chilli_y3 => 'Pick regularly to encourage more fruiting';

  @override
  String get chilli_y4 => 'Dry in shade to retain color and pungency';

  @override
  String get chilli_y5 => 'Store in airtight containers';

  @override
  String get errorLoadingCrops => 'Error loading crops';

  @override
  String get errorFetchingCrops => 'Error fetching crops';

  @override
  String get yourCrops => 'Your Crops';

  @override
  String get allOtherCrops => 'All Other Crops';

  @override
  String get noCropsFound => 'No crops found';

  @override
  String get searchResults => 'Search Results';

  @override
  String get noCropsSelected => 'You have not selected any crops yet.';

  @override
  String get allCropsSelected => 'You have selected all available crops!';

  @override
  String get errorLoadingUserData => 'Error loading user data';

  @override
  String get searchHint => 'Search crops';

  @override
  String get seller_location => 'Seller Location';

  @override
  String get errorLoadingListings => 'Error loading listings';

  @override
  String get noListingsAvailable => 'No listings available';

  @override
  String get createFirstListing => 'Create First Listing';

  @override
  String get searching => 'Searching...';

  @override
  String get searchError => 'Search error';

  @override
  String get clearSearch => 'Clear Search';

  @override
  String get noResultsFor => 'No results for';

  @override
  String get unknownCrop => 'Unknown Crop';

  @override
  String get unknownSeller => 'Unknown Seller';

  @override
  String get unitKg => 'kg';

  @override
  String get kgAvailable => 'kg available';

  @override
  String get settings => 'Settings';

  @override
  String get editProfile => 'Edit Profile';

  @override
  String get updateProfileInfo => 'Update your profile information';

  @override
  String get fullName => 'Full Name';

  @override
  String get farmLocation => 'Farm Location';

  @override
  String get selectCrops => 'Select Crops';

  @override
  String get chooseCrops => 'Choose the crops you grow on your farm';

  @override
  String get saveChanges => 'Save Changes';

  @override
  String get done => 'Done';

  @override
  String get fillAllFields => 'Please fill all fields';

  @override
  String get selectAtLeastOneCrop => 'Please select at least one crop';

  @override
  String get profileUpdated => 'Profile updated successfully';

  @override
  String get errorUpdatingProfile => 'Error updating profile:';

  @override
  String get changePassword => 'Change Password';

  @override
  String get enterPasswordInfo => 'Enter your current and new password';

  @override
  String get currentPassword => 'Current Password';

  @override
  String get newPassword => 'New Password';

  @override
  String get confirmNewPassword => 'Confirm New Password';

  @override
  String get passwordHint => 'Use at least 8 characters';

  @override
  String get enterCurrentPassword => 'Please enter your current password';

  @override
  String get enterNewPassword => 'Please enter a new password';

  @override
  String get passwordMinLength => 'New password must be at least 8 characters';

  @override
  String get passwordNotMatch => 'New passwords do not match';

  @override
  String get passwordUpdated => 'Password updated successfully';

  @override
  String get incorrectPassword => 'Incorrect password entered';

  @override
  String get weakPassword => 'New password is too weak';

  @override
  String get unexpectedError => 'An unexpected error occurred';

  @override
  String get errorChangingLanguage => 'Error changing language:';

  @override
  String get farmInformation => 'Farm Information';

  @override
  String get chosenCrops => 'Chosen Crops';

  @override
  String get primaryCrop => 'Primary Crop';

  @override
  String get notSet => 'Not Set';

  @override
  String get preferences => 'Preferences';

  @override
  String get language => 'Language';

  @override
  String get account => 'Account';

  @override
  String get myActiveListings => 'My Active Listings';

  @override
  String get newestFirst => 'Newest First';

  @override
  String get oldestFirst => 'Oldest First';

  @override
  String get priceLowToHigh => 'Price: Low to High';

  @override
  String get priceHighToLow => 'Price: High to Low';

  @override
  String get quantityAvailable => 'Quantity Available';

  @override
  String get streamError => 'Stream Error:';

  @override
  String get processingError => 'Processing Error:';

  @override
  String get queryError => 'Query Error:';

  @override
  String get buildCardError => 'Build Card Error:';

  @override
  String get errorProcessingData => 'Error processing data:';

  @override
  String get errorDisplayingListing => 'Error displaying listing';

  @override
  String get noDataAvailable => 'No data available';

  @override
  String get noActiveListings => 'No Active Listings';

  @override
  String get noListingsYet => 'You haven\'t created any listings yet';

  @override
  String get userNotLoggedIn => 'User not logged in';

  @override
  String get listed => 'Listed:';

  @override
  String get views => 'Views';

  @override
  String get saves => 'Saves';

  @override
  String get view => 'View';

  @override
  String get edit => 'Edit';

  @override
  String get delete => 'Delete';

  @override
  String get editListing => 'Edit Listing';

  @override
  String get whatToEdit => 'What would you like to edit?';

  @override
  String get editDetails => 'Edit Details';

  @override
  String get editDetailsHint => 'Change price, quantity, description';

  @override
  String get editListingDetails => 'Edit Listing Details';

  @override
  String get price => 'Price';

  @override
  String get quantity => 'Quantity';

  @override
  String get description => 'Description';

  @override
  String get fillRequiredFields => 'Please fill all required fields';

  @override
  String get listingUpdated => 'Listing updated successfully';

  @override
  String get errorUpdatingListing => 'Error updating listing:';

  @override
  String get deleteListingTitle => 'Delete Listing?';

  @override
  String get deleteListingWarning => 'This listing will be permanently deleted. This action cannot be undone.';

  @override
  String get listingDeleted => 'Listing deleted successfully';

  @override
  String get errorDeletingListing => 'Error deleting listing:';

  @override
  String get donthave_active_listings => 'You haven\'t created any listings yet';

  @override
  String get create_first_listing => 'Create Your First Listing';

  @override
  String get active => 'Active';
}
