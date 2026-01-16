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
    return 'Language changed to $language';
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
}
