// lib/screens/HomeScreen.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:kissan_connect_app_2/l10n/app_localizations.dart';
import 'cropguide.dart';
import 'WelcomeScreen.dart';
import 'WeatherScreen.dart';
import 'MarketplaceScreen.dart';
import 'SettingsScreen.dart'; // Add this import
import '../helpers/firebase_helper.dart';

// ---------------------------------------------------------------------------
// 1. PEST PREVENTION SCREEN
// ---------------------------------------------------------------------------
class PestPreventionScreen extends StatelessWidget {
  final bool isRiskHigh;
  final Map<String, dynamic>? weatherData;
  final Map<String, dynamic> pestData;

  const PestPreventionScreen({
    super.key,
    required this.isRiskHigh,
    this.weatherData,
    required this.pestData,
  });

  @override
  Widget build(BuildContext context) {
    final highRiskPests = pestData['highRiskPests'] ?? [];
    final moderateRiskPests = pestData['moderateRiskPests'] ?? [];
    final loc = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(loc.pest_prevention_guide),
        backgroundColor: isRiskHigh ? Colors.orange : Colors.green,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Risk Level Card
            Card(
              color: isRiskHigh ? Colors.orange[50] : Colors.green[50],
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.warning,
                          color: isRiskHigh ? Colors.orange : Colors.green,
                          size: 30,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          '${pestData['riskLevel'] ?? loc.unknown} - ${pestData['cropName'] ?? loc.crop}',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: isRiskHigh ? Colors.orange : Colors.green,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      pestData['message'] ?? loc.no_message_available,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // High Risk Pests Section
            if (highRiskPests.isNotEmpty) ...[
              Text(
                loc.high_risk_pests,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
              const SizedBox(height: 10),
              ...highRiskPests.map(
                (pest) => _buildPestCard(pest, true, context),
              ),
              const SizedBox(height: 20),
            ],

            // Moderate Risk Pests Section
            if (moderateRiskPests.isNotEmpty) ...[
              Text(
                loc.moderate_risk_pests,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
              ),
              const SizedBox(height: 10),
              ...moderateRiskPests.map(
                (pest) => _buildPestCard(pest, false, context),
              ),
              const SizedBox(height: 20),
            ],

            // Prevention Measures
            Text(
              loc.prevention_measures_title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 10),
            _buildPreventionMeasures(
              pestData['cropName'] ?? loc.general,
              context,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPestCard(
    String pestName,
    bool isHighRisk,
    BuildContext context,
  ) {
    final loc = AppLocalizations.of(context)!;
    final pestInfo = _getPestInformation(pestName, context);
    return Card(
      color: isHighRisk ? Colors.red[50] : Colors.orange[50],
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              pestName,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isHighRisk ? Colors.red : Colors.orange,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              pestInfo['description'] ?? loc.no_description_available,
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 8),
            Text(
              '${loc.active_in} ${pestInfo['activeSeason'] ?? loc.various_seasons}',
              style: const TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPreventionMeasures(String cropName, BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final measures = _getPreventionMeasures(cropName, context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (var measure in measures)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('• '),
                    Expanded(child: Text(measure)),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Map<String, String> _getPestInformation(
    String pestName,
    BuildContext context,
  ) {
    final loc = AppLocalizations.of(context)!;
    final pestInfo = {
      loc.aphids: {
        'description': loc.aphids_description,
        'activeSeason': loc.aphids_active_season,
      },
      loc.army_worm: {
        'description': loc.army_worm_description,
        'activeSeason': loc.army_worm_active_season,
      },
      loc.bollworm: {
        'description': loc.bollworm_description,
        'activeSeason': loc.bollworm_active_season,
      },
      loc.stem_borer: {
        'description': loc.stem_borer_description,
        'activeSeason': loc.stem_borer_active_season,
      },
      loc.whitefly: {
        'description': loc.whitefly_description,
        'activeSeason': loc.whitefly_active_season,
      },
      loc.rust_fungus: {
        'description': loc.rust_fungus_description,
        'activeSeason': loc.rust_fungus_active_season,
      },
      loc.hessian_fly: {
        'description': loc.hessian_fly_description,
        'activeSeason': loc.hessian_fly_active_season,
      },
      loc.spider_mites: {
        'description': loc.spider_mites_description,
        'activeSeason': loc.spider_mites_active_season,
      },
      loc.leaf_folder: {
        'description': loc.leaf_folder_description,
        'activeSeason': loc.leaf_folder_active_season,
      },
      loc.blast_fungus: {
        'description': loc.blast_fungus_description,
        'activeSeason': loc.blast_fungus_active_season,
      },
      loc.brown_plant_hopper: {
        'description': loc.brown_plant_hopper_description,
        'activeSeason': loc.brown_plant_hopper_active_season,
      },
      loc.corn_borer: {
        'description': loc.corn_borer_description,
        'activeSeason': loc.corn_borer_active_season,
      },
      loc.earworm: {
        'description': loc.earworm_description,
        'activeSeason': loc.earworm_active_season,
      },
      loc.corn_leaf_aphid: {
        'description': loc.corn_leaf_aphid_description,
        'activeSeason': loc.corn_leaf_aphid_active_season,
      },
    };
    return {
      'description':
          pestInfo[pestName]?['description'] ??
          loc.general_pests_that_affect_crop,
      'activeSeason':
          pestInfo[pestName]?['activeSeason'] ?? loc.varies_with_conditions,
    };
  }

  List<String> _getPreventionMeasures(String cropName, BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final measures = {
      'Wheat': [
        loc.wheat_prevention_1,
        loc.wheat_prevention_2,
        loc.wheat_prevention_3,
        loc.wheat_prevention_4,
        loc.wheat_prevention_5,
        loc.wheat_prevention_6,
      ],
      'Cotton': [
        loc.cotton_prevention_1,
        loc.cotton_prevention_2,
        loc.cotton_prevention_3,
        loc.cotton_prevention_4,
        loc.cotton_prevention_5,
        loc.cotton_prevention_6,
      ],
      'Rice': [
        loc.rice_prevention_1,
        loc.rice_prevention_2,
        loc.rice_prevention_3,
        loc.rice_prevention_4,
        loc.rice_prevention_5,
        loc.rice_prevention_6,
      ],
      'Corn': [
        loc.corn_prevention_1,
        loc.corn_prevention_2,
        loc.corn_prevention_3,
        loc.corn_prevention_4,
        loc.corn_prevention_5,
        loc.corn_prevention_6,
      ],
    };
    return measures[cropName] ??
        [
          loc.regular_field_monitoring,
          loc.use_organic_pesticides,
          loc.practice_crop_rotation,
          loc.maintain_field_hygiene,
          loc.use_resistant_varieties,
          loc.consult_local_agriculature_expert,
        ];
  }
}

// ---------------------------------------------------------------------------
// 2. FERTILIZER GUIDE SCREEN
// ---------------------------------------------------------------------------
class FertilizerGuideScreen extends StatelessWidget {
  final String recommendation;
  final Map<String, dynamic>? weatherData;
  final Map<String, dynamic> fertilizerData;

  const FertilizerGuideScreen({
    super.key,
    required this.recommendation,
    this.weatherData,
    required this.fertilizerData,
  });

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(localization.fertilizer_guide),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Recommendation Card
            Card(
              color: Colors.green[50],
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.eco, color: Colors.green, size: 30),
                        SizedBox(width: 10),
                        Text(
                          localization.fertilizer_guide,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      recommendation,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      fertilizerData['reason'] ??
                          localization.no_reason_provided,
                      style: const TextStyle(fontSize: 16),
                    ),
                    if ((fertilizerData['adjustment'] as String?) !=
                        localization.optimal_application_rate)
                      Text(
                        '${localization.adjustment}: ${fertilizerData['adjustment'] ?? localization.none}',
                        style: TextStyle(
                          fontSize: 14,
                          fontStyle: FontStyle.italic,
                          color: Colors.orange[700],
                        ),
                      ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Application Guide
            Text(
              localization.application_guide,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildApplicationGuide(
              context,
              fertilizerData['cropName'] ?? localization.general,
            ),

            const SizedBox(height: 20),

            // Fertilizer Types
            Text(
              localization.recommended_fertilizer_types,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildFertilizerTypes(
              fertilizerData['cropName'] ?? localization.general,
              context,
            ),

            const SizedBox(height: 20),

            // Timing and Methods
            Text(
              localization.best_application_timing,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildTimingGuide(
              fertilizerData['growthStage'] ?? localization.general,
              context,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildApplicationGuide(BuildContext context, String cropName) {
    final guides = _getApplicationGuide(context, cropName);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: guides
              .map(
                (step) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('• '),
                      Expanded(child: Text(step)),
                    ],
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  Widget _buildFertilizerTypes(String cropName, BuildContext context) {
    final types = _getFertilizerTypes(cropName, context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: types.entries
              .map(
                (entry) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          '${entry.key}: ${entry.value}',
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  Widget _buildTimingGuide(String growthStage, BuildContext context) {
    final timing = _getTimingGuide(growthStage, context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: timing
              .map(
                (item) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('• '),
                      Expanded(child: Text(item)),
                    ],
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  List<String> _getApplicationGuide(BuildContext context, String cropName) {
    final localization = AppLocalizations.of(context)!;
    final guides = {
      localization.wheat: [
        localization.apply_one_third_nitrogen_sowing,
        localization.apply_remaining_nitrogen_splits,
        localization.mix_fertilizers_thoroughly,
        localization.apply_when_soil_moist,
        localization.avoid_heavy_rainfall_application,
        localization.use_soil_test_recommendations,
      ],
      localization.cotton: [
        localization.apply_full_phosphorus_potassium,
        localization.split_nitrogen_three_four_doses,
        localization.apply_in_bands,
        localization.irrigate_after_application,
        localization.apply_in_bands,
        localization.irrigate_after_application,
      ],
      localization.rice: [
        localization.apply_basal_before_pudding,
        localization.first_second_third,
        localization.split_nitrogen_three_equal_doses,
        localization.apply_in_standing_water,
        localization.use_urea_super_granules,
        localization.avoid_strong_wind_application,
      ],
      localization.corn: [
        localization.apply_starter_fertilizer_planting,
        localization.side_dress_nitrogen,
        localization.apply_phosphorus_potassium_soil_test,
        localization.use_split_for_sandy_soils,
        localization.incorporate_fertilizers_properly,
        localization.avoid_root_contact_concentrated,
      ],
    };
    return guides[cropName] ??
        [
          localization.apply_based_on_soil_test,
          localization.split_applications_for_efficiency,
          localization.incorporate_fertilizers_properly,
          localization.apply_when_plants_growing,
          localization.avoid_extreme_weather_application,
          localization.follow_recommended_dosage,
        ];
  }

  Map<String, String> _getFertilizerTypes(
    String cropName,
    BuildContext context,
  ) {
    final loc = AppLocalizations.of(context)!;
    final types = {
      'Wheat': {
        loc.nitrogen: 'Urea (46-0-0)',
        loc.phosphorus: 'DAP (18-46-0)',
        loc.potassium: 'MOP (0-0-60)',
        loc.micronutrients: 'Zinc Sulfate',
      },
      'Cotton': {
        loc.nitrogen: 'Urea (46-0-0)',
        loc.phosphorus: 'SSP (0-16-0)',
        loc.potassium: 'MOP (0-0-60)',
        loc.micronutrients: 'Boron, Zinc',
      },
      'Rice': {
        loc.nitrogen: 'Urea (46-0-0)',
        loc.phosphorus: 'DAP (18-46-0)',
        loc.potassium: 'MOP (0-0-60)',
        loc.micronutrients: 'Zinc Sulfate',
      },
      'Corn': {
        loc.nitrogen: 'Urea (46-0-0)',
        loc.phosphorus: 'NPK (17-17-17)',
        loc.potassium: 'MOP (0-0-60)',
        loc.micronutrients: 'Zinc, Iron',
      },
    };

    return types[cropName] ??
        {
          loc.nitrogen: 'Urea or Ammonium-based',
          loc.phosphorus: 'DAP or SSP',
          loc.potassium: 'MOP or SOP',
          loc.micronutrients: loc.as_per_soil_test,
        };
  }

  List<String> _getTimingGuide(String growthStage, BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final timing = {
      'Vegetative': [
        loc.focus_on_nitrogen,
        loc.apply_during_active_growth,
        loc.avoid_drought_application,
        loc.best_application_timing,
        loc.monitor_leaf_color_deficiencies,
      ],
      'Flowering': [
        loc.reduce_nitrogen_application,
        loc.increase_phosphorus_for_flowering,
        loc.apply_before_flower_buds_open,
        loc.avoid_full_bloom_application,
        loc.monitor_nutrient_deficiencies,
      ],
      'Tillering': [
        loc.critical_for_nitrogen_application,
        loc.apply_when_tillers_develop,
        loc.split_application_recommended,
        loc.ensure_adequate_soil_moisture,
        loc.monitor_tiller_count,
      ],
      'Silking': [
        loc.focus_on_potassium_application,
        loc.apply_early_silking_stage,
        loc.reduce_nitrogen_excess_growth,
        loc.ensure_balanced_nutrition,
        loc.monitor_ear_development,
      ],
      'Pod Formation': [
        loc.focus_on_potassium_application,
        loc.apply_early_pod_development,
        loc.reduce_nitrogen_excess_growth,
        loc.ensure_balanced_nutrition,
        loc.monitor_pod_setting_rate,
      ],
    };
    return timing[growthStage] ??
        [
          loc.apply_during_active_growth,
          loc.avoid_stress_conditions,
          loc.follow_crop_specific_schedule,
          loc.consider_weather_conditions,
          loc.monitor_plant_response,
        ];
  }
}

// ---------------------------------------------------------------------------
// 3. IRRIGATION GUIDE SCREEN
// ---------------------------------------------------------------------------
class IrrigationGuideScreen extends StatelessWidget {
  final String recommendation;
  final Map<String, dynamic>? weatherData;
  final Map<String, dynamic> irrigationData;

  const IrrigationGuideScreen({
    super.key,
    required this.recommendation,
    this.weatherData,
    required this.irrigationData,
  });

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(loc.irrigation_guide),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Recommendation Card
            Card(
              color: Colors.blue[50],
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.opacity, color: Colors.blue, size: 30),
                        SizedBox(width: 10),
                        Text(
                          loc.irrigation_recommendation,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      recommendation,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      irrigationData['reason'] ?? loc.no_reason_provided,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '${loc.evapotranspiration_rate} ${irrigationData['evapotranspiration'] ?? 'N/A'} ${loc.mm_day}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Irrigation Schedule
            Text(
              loc.irrigation_schedule,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildIrrigationSchedule(
              irrigationData['cropName'] ?? 'General',
              context,
            ),

            const SizedBox(height: 20),

            // Water Management Tips
            Text(
              loc.water_management_tips,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildWaterManagementTips(
              irrigationData['urgency'] ?? 'Medium',
              context,
            ),

            const SizedBox(height: 20),

            // Methods and Techniques
            Text(
              loc.irrigation_methods,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildIrrigationMethods(context),
          ],
        ),
      ),
    );
  }

  Widget _buildIrrigationSchedule(String cropName, BuildContext context) {
    final schedule = _getIrrigationSchedule(cropName, context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: schedule.entries
              .map(
                (entry) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        margin: const EdgeInsets.only(top: 6),
                        decoration: const BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              entry.key,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(entry.value),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  Widget _buildWaterManagementTips(String urgency, BuildContext context) {
    final tips = _getWaterManagementTips(urgency, context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: tips
              .map(
                (tip) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('• '),
                      Expanded(child: Text(tip)),
                    ],
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  Widget _buildIrrigationMethods(BuildContext context) {
    final methods = _getIrrigationMethods(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: methods.entries
              .map(
                (entry) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        entry.key,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(entry.value, style: const TextStyle(fontSize: 14)),
                    ],
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  Map<String, String> _getIrrigationSchedule(
    String cropName,
    BuildContext context,
  ) {
    final loc = AppLocalizations.of(context)!;
    final schedules = {
      loc.wheat: {
        loc.wheat_first_irrigation: loc.wheat_first_irrigation_value,
        loc.wheat_second_irrigation: loc.wheat_second_irrigation_value,
        loc.wheat_third_irrigation: loc.wheat_third_irrigation_value,
        loc.wheat_fourth_irrigation: loc.wheat_fourth_irrigation_value,
        loc.wheat_fifth_irrigation: loc.wheat_fifth_irrigation_value,
      },
      'Cotton': {
        loc.cotton_first_irrigation: loc.cotton_first_irrigation_value,
        loc.cotton_second_irrigation: loc.cotton_second_irrigation_value,
        loc.cotton_third_irrigation: loc.cotton_third_irrigation_value,
        loc.cotton_fourth_irrigation: loc.cotton_fourth_irrigation_value,
        loc.cotton_fifth_irrigation: loc.cotton_fifth_irrigation_value,
      },
      'Rice': {
        loc.rice_initial_flooding: loc.rice_initial_flooding_value,
        loc.rice_vegetative_stage: loc.rice_vegetative_stage_value,
        loc.rice_reproductive_stage: loc.rice_reproductive_stage_value,
        loc.rice_ripening_stage: loc.rice_ripening_stage_value,
      },
      'Corn': {
        loc.corn_first_irrigation: loc.corn_first_irrigation_value,
        loc.corn_second_irrigation: loc.corn_second_irrigation_value,
        loc.corn_third_irrigation: loc.corn_third_irrigation_value,
        loc.corn_fourth_irrigation: loc.corn_fourth_irrigation_value,
        loc.corn_fifth_irrigation: loc.corn_fifth_irrigation_value,
      },
    };
    return schedules[cropName] ??
        {
          loc.general_rule: loc.general_rule_value,
          loc.critical_stages: loc.critical_stages_value,
          loc.water_quantity: loc.water_quantity_value,
          loc.monitoring: loc.monitoring_value,
        };
  }

  List<String> _getWaterManagementTips(String urgency, BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final tips = {
      'High': [
        loc.high_tip_first,
        loc.high_tip_second,
        loc.high_tip_third,
        loc.high_tip_fourth,
        loc.high_tip_fifth,
        loc.high_tip_sixth,
      ],
      'Medium': [
        loc.medium_tip_first,
        loc.medium_tip_second,
        loc.medium_tip_third,
        loc.medium_tip_fourth,
        loc.medium_tip_fifth,
        loc.medium_tip_sixth,
      ],
      'Low': [
        loc.low_tip_first,
        loc.low_tip_second,
        loc.low_tip_third,
        loc.low_tip_fourth,
        loc.low_tip_fifth,
        loc.low_tip_sixth,
      ],
    };
    return tips[urgency] ??
        [
          loc.return_tip_first,
          loc.return_tip_second,
          loc.return_tip_third,
          loc.return_tip_fourth,
          loc.return_tip_fifth,
          loc.return_tip_sixth,
        ];
  }

  Map<String, String> _getIrrigationMethods(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return {
      loc.drip_irrigation: loc.drip_irrigation_desc,
      loc.sprinkler_irrigation: loc.sprinkler_irrigation_desc,
      loc.furrow_irrigation: loc.furrow_irrigation_desc,
      loc.flood_irrigation: loc.flood_irrigation_desc,
      loc.basin_irrigation: loc.basin_irrigation_desc,
    };
  }
}

// ---------------------------------------------------------------------------
// 4. MAIN HOME SCREEN (UPDATED FOR MULTIPLE CROPS WITH WELCOME MESSAGE)
// ---------------------------------------------------------------------------
class HomeScreen extends StatefulWidget {
  final String userLocation;
  final String userName;
  final List<String> selectedCrops;
  final String primaryCrop;
  final bool isFirstTime;

  const HomeScreen({
    super.key,
    required this.userLocation,
    this.userName = "Farmer",
    required this.selectedCrops,
    required this.primaryCrop,
    this.isFirstTime = false,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String, dynamic>? _weatherData;
  bool _isLoading = true;
  String _errorMessage = '';
  int _bottomNavIndex = 0;
  String _displayCity = '';
  bool _usingFallbackWeather = false;
  String _currentDisplayCrop = '';
  bool _showLogoutButton = false;
  bool _showWelcomeMessage = false;
  bool _isFirstTimeUser = false;

  @override
  void initState() {
    super.initState();

    print('HomeScreen received:');
    print('Location: "${widget.userLocation}"');
    print('All Crops: ${widget.selectedCrops}');
    print('Primary Crop: "${widget.primaryCrop}"');
    print('Name: "${widget.userName}"');
    print('Is First Time: ${widget.isFirstTime}');

    _currentDisplayCrop = widget.primaryCrop;
    final userLocation = widget.userLocation.trim();
    _displayCity = userLocation.isNotEmpty
        ? userLocation
        : AppLocalizations.of(context)!.your_location;

    _isFirstTimeUser = widget.isFirstTime;

    if (_isFirstTimeUser) {
      _showWelcomeMessage = true;

      Future.delayed(const Duration(seconds: 3), () {
        if (mounted) {
          setState(() {
            _showWelcomeMessage = false;
          });
        }
      });

      _markUserAsNotFirstTime();
    }

    // Initialize Firebase collections
    _initializeFirebaseCollections();

    final locationToFetch = userLocation.isNotEmpty
        ? userLocation
        : 'Islamabad';
    _fetchWeatherData(locationToFetch);
  }

  // Initialize Firebase collections
  Future<void> _initializeFirebaseCollections() async {
    try {
      await FirebaseHelper.initializeCollections();
    } catch (e) {
      print(AppLocalizations.of(context)!.error_initializing_firebase);
    }
  }

  Future<void> _markUserAsNotFirstTime() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .update({'isFirstTime': false, 'firstLoginCompleted': true});
      }
    } catch (e) {
      print(AppLocalizations.of(context)!.error_updating_first_time_status);
    }
  }

  Widget _buildWelcomeOverlay() {
    if (!_showWelcomeMessage) return const SizedBox.shrink();

    return AnimatedOpacity(
      opacity: _showWelcomeMessage ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 500),
      child: Container(
        color: Colors.black.withOpacity(0.9),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedScale(
                scale: _showWelcomeMessage ? 1.0 : 0.5,
                duration: const Duration(milliseconds: 800),
                curve: Curves.elasticOut,
                child: Text(
                  '${AppLocalizations.of(context)!.welcome} ${widget.userName}!',
                  style: const TextStyle(
                    fontSize: 42,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1.2,
                    shadows: [
                      Shadow(
                        blurRadius: 10.0,
                        color: Colors.black,
                        offset: Offset(2.0, 2.0),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20),

              AnimatedOpacity(
                opacity: _showWelcomeMessage ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 1000),
                child: Text(
                  AppLocalizations.of(context)!.your_journey_begins_here,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white.withOpacity(0.8),
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 40),

              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                strokeWidth: 2,
              ),
              const SizedBox(height: 20),

              AnimatedOpacity(
                opacity: _showWelcomeMessage ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 1200),
                child: Text(
                  AppLocalizations.of(context)!.preparing_your_dashboard,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.6),
                  ),
                ),
              ),

              const SizedBox(height: 40),
              AnimatedOpacity(
                opacity: _showWelcomeMessage ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 1500),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _showWelcomeMessage = false;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white.withOpacity(0.3)),
                    ),
                    child: Text(
                      AppLocalizations.of(context)!.tap_to_continue,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white.withOpacity(0.7),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _fetchWeatherData(String city) async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
      _usingFallbackWeather = false;
    });

    try {
      final encodedCity = Uri.encodeComponent(city);
      final geocodeUri = Uri.parse(
        'https://geocoding-api.open-meteo.com/v1/search?name=$encodedCity&count=1&language=en&format=json',
      );

      final geocodeResponse = await http.get(geocodeUri);

      if (geocodeResponse.statusCode == 200) {
        final geocodeData = json.decode(geocodeResponse.body);

        if (geocodeData['results'] != null &&
            geocodeData['results'].isNotEmpty) {
          final result = geocodeData['results'][0];
          final lat = result['latitude'];
          final lng = result['longitude'];
          final cityName = result['name'];

          final weatherUri = Uri.parse(
            'https://api.open-meteo.com/v1/forecast?'
            'latitude=$lat&'
            'longitude=$lng&'
            'current_weather=true&'
            'hourly=temperature_2m,relativehumidity_2m,precipitation,weathercode,windspeed_10m&'
            'daily=temperature_2m_max,temperature_2m_min,weathercode&'
            'timezone=auto',
          );

          final weatherResponse = await http.get(weatherUri);

          if (weatherResponse.statusCode == 200) {
            final weatherApiData = json.decode(weatherResponse.body);
            setState(() {
              _weatherData = weatherApiData;
              _weatherData!['location_name'] = cityName;
              _displayCity = cityName;
              _isLoading = false;
            });
          } else {
            await _fetchWeatherWithFallback();
          }
        } else {
          await _fetchWeatherWithFallback();
        }
      } else {
        await _fetchWeatherWithFallback();
      }
    } catch (e) {
      print(AppLocalizations.of(context)!.error_fetching_weather);
      await _fetchWeatherWithFallback();
    }
  }

  Future<void> _fetchWeatherWithFallback() async {
    try {
      setState(() {
        _usingFallbackWeather = true;
      });

      final fallbackCoords = [
        {'lat': 33.6844, 'lng': 73.0479, 'name': 'Islamabad'},
        {'lat': 24.8607, 'lng': 67.0011, 'name': 'Karachi'},
        {'lat': 31.5497, 'lng': 74.3436, 'name': 'Lahore'},
      ];

      for (final location in fallbackCoords) {
        try {
          final weatherUri = Uri.parse(
            'https://api.open-meteo.com/v1/forecast?'
            'latitude=${location['lat']}&'
            'longitude=${location['lng']}&'
            'current_weather=true&'
            'hourly=temperature_2m,relativehumidity_2m,precipitation,weathercode,windspeed_10m&'
            'daily=temperature_2m_max,temperature_2m_min,weathercode&'
            'timezone=auto',
          );

          final response = await http.get(weatherUri);
          if (response.statusCode == 200) {
            final weatherApiData = json.decode(response.body);
            setState(() {
              _weatherData = weatherApiData;
              _weatherData!['location_name'] = location['name'];
              _displayCity = location['name'] as String;
              _isLoading = false;
              _errorMessage = '';
            });
            return;
          }
        } catch (e) {
          continue;
        }
      }

      setState(() {
        _errorMessage = AppLocalizations.of(
          context,
        )!.unable_to_fetch_weather_data_please_check_internet;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = AppLocalizations.of(context)!.error_fetching_weather;
        _isLoading = false;
      });
    }
  }

  Map<String, dynamic>? getCurrentWeather() {
    if (_weatherData == null || _weatherData!['current_weather'] == null) {
      return null;
    }

    final current = _weatherData!['current_weather'];
    final weatherCode = current['weathercode'] ?? 0;

    double humidity = 50.0;
    if (_weatherData!['hourly'] != null &&
        _weatherData!['hourly']['relativehumidity_2m'] != null &&
        _weatherData!['hourly']['relativehumidity_2m'].isNotEmpty) {
      humidity =
          _weatherData!['hourly']['relativehumidity_2m'][0]?.toDouble() ?? 50.0;
    }

    return {
      'main': {
        'temp': current['temperature']?.toDouble() ?? 0.0,
        'humidity': humidity,
        'feels_like': current['temperature']?.toDouble() ?? 0.0,
      },
      'weather': [
        {
          'main': _getWeatherConditionFromCode(weatherCode),
          'description': _getWeatherDescriptionFromCode(weatherCode),
        },
      ],
      'wind': {'speed': current['windspeed']?.toDouble() ?? 0.0},
    };
  }

  String _getWeatherConditionFromCode(int weatherCode) {
    if (weatherCode == 0) return AppLocalizations.of(context)!.clear;
    if (weatherCode == 1) return AppLocalizations.of(context)!.clear;
    if (weatherCode == 2) return AppLocalizations.of(context)!.partlyCloudy;
    if (weatherCode == 3) return AppLocalizations.of(context)!.cloudy;
    if (weatherCode == 45 || weatherCode == 48) {
      return AppLocalizations.of(context)!.fog;
    }
    if (weatherCode >= 51 && weatherCode <= 57) {
      return AppLocalizations.of(context)!.drizzle;
    }
    if (weatherCode >= 61 && weatherCode <= 67) {
      return AppLocalizations.of(context)!.rain;
    }
    if (weatherCode >= 80 && weatherCode <= 86) {
      return AppLocalizations.of(context)!.rain;
    }
    if (weatherCode >= 71 && weatherCode <= 77) {
      return AppLocalizations.of(context)!.snow;
    }
    if (weatherCode >= 95 && weatherCode <= 99) {
      return AppLocalizations.of(context)!.thunderstorm;
    }
    return AppLocalizations.of(context)!.clear;
  }

  String _getWeatherDescriptionFromCode(int weatherCode) {
    if (weatherCode == 0) return AppLocalizations.of(context)!.clearSky;
    if (weatherCode == 1) return AppLocalizations.of(context)!.mainlyClear;
    if (weatherCode == 2) return AppLocalizations.of(context)!.partlyCloudy;
    if (weatherCode == 3) return AppLocalizations.of(context)!.overcast;
    if (weatherCode == 45) return AppLocalizations.of(context)!.fog;
    if (weatherCode == 48) {
      return AppLocalizations.of(context)!.depositingRimeFog;
    }
    if (weatherCode == 51) return AppLocalizations.of(context)!.lightDrizzle;
    if (weatherCode == 53) return AppLocalizations.of(context)!.moderateDrizzle;
    if (weatherCode == 55) return AppLocalizations.of(context)!.denseDrizzle;
    if (weatherCode == 61) return AppLocalizations.of(context)!.slightRain;
    if (weatherCode == 63) return AppLocalizations.of(context)!.moderateRain;
    if (weatherCode == 65) return AppLocalizations.of(context)!.heavyRain;
    if (weatherCode == 71) return AppLocalizations.of(context)!.slightSnow;
    if (weatherCode == 73) return AppLocalizations.of(context)!.moderateSnow;
    if (weatherCode == 75) return AppLocalizations.of(context)!.heavySnow;
    if (weatherCode == 95) return AppLocalizations.of(context)!.thunderstorm;
    if (weatherCode == 96) {
      return AppLocalizations.of(context)!.thunderstormWithHail;
    }
    return AppLocalizations.of(context)!.clearSky;
  }

  IconData _getWeatherIcon(String weatherCondition) {
    final condition = weatherCondition.toLowerCase();
    if (condition.contains('clear')) {
      return Icons.wb_sunny;
    } else if (condition.contains('cloud')) {
      return Icons.cloud;
    } else if (condition.contains('rain') || condition.contains('drizzle')) {
      return Icons.beach_access;
    } else if (condition.contains('snow')) {
      return Icons.ac_unit;
    } else if (condition.contains('thunder') || condition.contains('storm')) {
      return Icons.flash_on;
    } else if (condition.contains('fog') ||
        condition.contains('mist') ||
        condition.contains('haze')) {
      return Icons.blur_on;
    }
    return Icons.wb_sunny;
  }

  Color _getWeatherIconColor(String weatherCondition) {
    final condition = weatherCondition.toLowerCase();
    if (condition.contains('clear')) {
      return Colors.amber;
    } else if (condition.contains('cloud')) {
      return Colors.grey;
    } else if (condition.contains('rain') || condition.contains('drizzle')) {
      return Colors.blue;
    } else if (condition.contains('snow')) {
      return Colors.lightBlue;
    } else if (condition.contains('thunder') || condition.contains('storm')) {
      return Colors.deepPurple;
    } else if (condition.contains('fog') ||
        condition.contains('mist') ||
        condition.contains('haze')) {
      return Colors.grey[400]!;
    }
    return Colors.amber;
  }

  void _cycleCrop() {
    final crops = widget.selectedCrops;
    if (crops.length > 1) {
      final currentIndex = crops.indexOf(_currentDisplayCrop);
      final nextIndex = (currentIndex + 1) % crops.length;
      setState(() {
        _currentDisplayCrop = crops[nextIndex];
      });
    }
  }

  Map<String, dynamic> _getPestPrediction() {
    final loc = AppLocalizations.of(context)!;
    final currentWeather = getCurrentWeather();
    if (currentWeather == null) {
      return {
        'riskLevel': loc.unknown,
        'message': loc.weather_data_unavailable,
        'pestType': loc.various_pests,
        'isHighRisk': false,
        'cropSpecificRisks': [],
        'highRiskPests': [],
        'moderateRiskPests': [],
        'cropName': _currentDisplayCrop,
      };
    }

    final temp = currentWeather['main']['temp'];
    final humidity = currentWeather['main']['humidity'];
    final weatherCondition = currentWeather['weather'][0]['main'];

    final Map<String, Map<String, dynamic>> _cropDatabase = {
      "Wheat": {
        "name": loc.wheat,
        "pestTypes": [
          loc.aphids,
          loc.army_worm,
          loc.rust_fungus,
          loc.hessian_fly,
        ],
        "optimalTemp": {"min": 15, "max": 25},
        "criticalTemp": {"min": 10, "max": 35},
        "waterRequirement": 4.0,
        "growthStage": loc.vegetative,
        "fertilizerBase": 50.0,
        "pestRiskProfile": {
          "aphids": {
            "temp": [20, 30],
            "humidity": [60, 80],
          },
          "army_worm": {
            "temp": [18, 32],
            "humidity": [70, 90],
          },
          "rust_fungus": {
            "temp": [15, 25],
            "humidity": [85, 100],
          },
        },
      },
      "Cotton": {
        "name": loc.cotton,
        "pestTypes": [loc.bollworm, loc.whitefly, loc.aphids, loc.spider_mites],
        "optimalTemp": {"min": 20, "max": 30},
        "criticalTemp": {"min": 15, "max": 40},
        "waterRequirement": 5.0,
        "growthStage": loc.flowering,
        "fertilizerBase": 60.0,
        "pestRiskProfile": {
          "bollworm": {
            "temp": [25, 35],
            "humidity": [60, 80],
          },
          "whitefly": {
            "temp": [20, 30],
            "humidity": [50, 70],
          },
          "spider_mites": {
            "temp": [30, 40],
            "humidity": [20, 50],
          },
        },
      },
      "Rice": {
        "name": loc.rice,
        "pestTypes": [
          "Stem Borer",
          "Leaf Folder",
          "Blast Fungus",
          "Brown Plant Hopper",
        ],
        "optimalTemp": {"min": 20, "max": 35},
        "criticalTemp": {"min": 15, "max": 40},
        "waterRequirement": 6.0,
        "growthStage": "Tillering",
        "fertilizerBase": 70.0,
        "pestRiskProfile": {
          "stem_borer": {
            "temp": [25, 35],
            "humidity": [80, 100],
          },
          "leaf_folder": {
            "temp": [20, 30],
            "humidity": [75, 95],
          },
          "blast_fungus": {
            "temp": [18, 28],
            "humidity": [90, 100],
          },
        },
      },
      "Corn": {
        "name": "Corn",
        "pestTypes": ["Corn Borer", "Armyworm", "Earworm", "Corn Leaf Aphid"],
        "optimalTemp": {"min": 18, "max": 32},
        "criticalTemp": {"min": 10, "max": 38},
        "waterRequirement": 5.5,
        "growthStage": "Silking",
        "fertilizerBase": 65.0,
        "pestRiskProfile": {
          "corn_borer": {
            "temp": [20, 30],
            "humidity": [60, 80],
          },
          "armyworm": {
            "temp": [22, 32],
            "humidity": [70, 90],
          },
          "earworm": {
            "temp": [25, 35],
            "humidity": [50, 70],
          },
        },
      },
    };

    final cropName = _currentDisplayCrop;
    final cropData = _cropDatabase[cropName] ?? _cropDatabase["Wheat"]!;
    final List<String> highRiskPests = [];
    final List<String> moderateRiskPests = [];

    int riskScore = 0;
    String message = '';

    final optimalTemp = cropData['optimalTemp'] as Map<String, int>;
    final criticalTemp = cropData['criticalTemp'] as Map<String, int>;

    if (temp >= optimalTemp['min']! && temp <= optimalTemp['max']!) {
      riskScore += 3;
      message =
          '${loc.temperature_optimal_for} ${cropName.toLowerCase()} pests';
    } else if (temp < criticalTemp['min']! || temp > criticalTemp['max']!) {
      riskScore += 0;
      message = AppLocalizations.of(context)!.temperature_extremes;
    } else {
      riskScore += 2;
    }

    final pestProfile = cropData['pestRiskProfile'] as Map<String, dynamic>;

    pestProfile.forEach((pest, conditions) {
      final pestTempRange = conditions['temp'] as List<int>;
      final pestHumidityRange = conditions['humidity'] as List<int>;

      if (temp >= pestTempRange[0] &&
          temp <= pestTempRange[1] &&
          humidity >= pestHumidityRange[0] &&
          humidity <= pestHumidityRange[1]) {
        highRiskPests.add(_formatPestName(pest));
        riskScore += 2;
      } else if ((temp >= pestTempRange[0] && temp <= pestTempRange[1]) ||
          (humidity >= pestHumidityRange[0] &&
              humidity <= pestHumidityRange[1])) {
        moderateRiskPests.add(_formatPestName(pest));
        riskScore += 1;
      }
    });

    if (weatherCondition.contains('Rain')) {
      riskScore -= 1;
      message = AppLocalizations.of(context)!.rain_reduction;
    } else if (weatherCondition.contains('Clear')) {
      riskScore += 1;
      if (message.isEmpty) {
        message = AppLocalizations.of(
          context,
        )!.sunny_conditions_favor_pest_development;
      }
    }

    String riskLevel;
    bool isHighRisk;
    String pestType;

    if (riskScore >= 6 || highRiskPests.isNotEmpty) {
      riskLevel = AppLocalizations.of(context)!.high_risk;
      isHighRisk = true;
      pestType = highRiskPests.isNotEmpty
          ? highRiskPests.join(', ')
          : cropData['pestTypes'][0];

      message = message.isEmpty
          ? AppLocalizations.of(context)!.high_risk_message(
              cropName,
              highRiskPests.isNotEmpty
                  ? highRiskPests.join(', ')
                  : AppLocalizations.of(context)!.generic_pest,
            )
          : message;
    } else if (riskScore >= 3 || moderateRiskPests.isNotEmpty) {
      riskLevel = AppLocalizations.of(context)!.moderate_risk;
      isHighRisk = false;
      pestType = moderateRiskPests.isNotEmpty
          ? moderateRiskPests.join(', ')
          : cropData['pestTypes'][0];

      message = message.isEmpty
          ? AppLocalizations.of(context)!.moderate_risk_message(
              cropName,
              moderateRiskPests.isNotEmpty
                  ? moderateRiskPests.join(', ')
                  : AppLocalizations.of(context)!.potential_pests,
            )
          : message;
    } else {
      riskLevel = AppLocalizations.of(context)!.low_risk;
      isHighRisk = false;
      pestType = cropData['pestTypes'][0];

      message = message.isEmpty
          ? AppLocalizations.of(context)!.low_risk_message(cropName)
          : message;
    }

    return {
      'riskLevel': riskLevel,
      'message': message,
      'pestType': pestType,
      'isHighRisk': isHighRisk,
      'riskScore': riskScore,
      'cropSpecificRisks': highRiskPests + moderateRiskPests,
      'highRiskPests': highRiskPests,
      'moderateRiskPests': moderateRiskPests,
      'cropName': cropName,
    };
  }

  String _formatPestName(String pestKey) {
    return pestKey
        .split('_')
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join(' ');
  }

  Map<String, dynamic> _getFertilizerRecommendation() {
    final currentWeather = getCurrentWeather();
    if (currentWeather == null) {
      return {
        'recommendation': AppLocalizations.of(
          context,
        )!.standard_application_needed,
        'reason': AppLocalizations.of(context)!.network_error_message,
        'adjustment': AppLocalizations.of(context)!.no_adjustment_needed,
        'cropSpecific': true,
        'cropName': _currentDisplayCrop,
        'growthStage': AppLocalizations.of(context)!.general,
      };
    }

    final temp = currentWeather['main']['temp'];
    final weatherCondition = currentWeather['weather'][0]['main'];
    final loc = AppLocalizations.of(context)!;
    final Map<String, Map<String, dynamic>> _cropDatabase = {
      "Wheat": {
        "name": loc.wheat,
        "optimalTemp": {"min": 15, "max": 25},
        "growthStage": AppLocalizations.of(context)!.vegetative,
        "fertilizerBase": 50.0,
      },
      "Cotton": {
        "name": loc.cotton,
        "optimalTemp": {"min": 20, "max": 30},
        "growthStage": loc.flowering,
        "fertilizerBase": 60.0,
      },
      "Rice": {
        "name": loc.rice,
        "optimalTemp": {"min": 20, "max": 35},
        "growthStage": loc.tillering,
        "fertilizerBase": 70.0,
      },
      "Corn": {
        "name": loc.corn,
        "optimalTemp": {"min": 18, "max": 32},
        "growthStage": loc.silking,
        "fertilizerBase": 65.0,
      },
    };

    final cropName = _currentDisplayCrop;
    final cropData = _cropDatabase[cropName] ?? _cropDatabase["Wheat"]!;
    double baseAmount = cropData['fertilizerBase'];
    String reason = '';
    String adjustment = '';
    String fertilizerType = _getFertilizerType(cropName);

    final optimalTemp = cropData['optimalTemp'] as Map<String, int>;

    if (temp > optimalTemp['max']! + 5) {
      baseAmount *= 0.7;
      adjustment = AppLocalizations.of(
        context,
      )!.reduced_due_to_high_temperature;

      reason = AppLocalizations.of(context)!.high_temp_burn_risk(cropName);
    } else if (temp > optimalTemp['max']!) {
      baseAmount *= 0.85;
      adjustment = AppLocalizations.of(
        context,
      )!.slightly_increased_due_to_optimal_temp;

      reason = AppLocalizations.of(
        context,
      )!.warm_weather_nutrient_availability(cropName);
    } else if (temp < optimalTemp['min']!) {
      baseAmount *= 0.6;
      adjustment = AppLocalizations.of(
        context,
      )!.reduced_due_to_high_temperature;

      reason = AppLocalizations.of(context)!.cold_temp_slow_growth(cropName);
    } else {
      reason = AppLocalizations.of(context)!.optimal_temp_application(cropName);
    }

    if (weatherCondition.contains('Rain')) {
      baseAmount *= 1.1;
      adjustment = adjustment.isEmpty
          ? AppLocalizations.of(context)!.increased_before_expected_rain
          : AppLocalizations.of(
              context,
            )!.adjustment_increased_for_rain(adjustment);

      reason =
          '${reason}. ${AppLocalizations.of(context)!.rain_absorption_help(cropName)}';
    } else if (weatherCondition.contains('Clear') &&
        temp > optimalTemp['max']!) {
      baseAmount *= 0.9;
      adjustment = adjustment.isEmpty
          ? AppLocalizations.of(context)!.reduced_due_to_high_temperature
          : AppLocalizations.of(
              context,
            )!.adjustment_reduced_for_dryness(adjustment);

      reason =
          '${reason}. ${AppLocalizations.of(context)!.irrigation_required_after_application(cropName)}';
    }

    final growthStage = cropData['growthStage'];
    reason =
        '$reason. ${AppLocalizations.of(context)!.current_growth_rate} $growthStage';

    return {
      'recommendation': '${baseAmount.round()}kg $fertilizerType/acre',
      'reason': reason,
      'adjustment': adjustment.isEmpty
          ? AppLocalizations.of(context)!.no_adjustment_needed
          : adjustment,
      'cropSpecific': true,
      'fertilizerType': fertilizerType,
      'growthStage': growthStage,
      'cropName': cropName,
    };
  }

  String _getFertilizerType(String crop) {
    switch (crop) {
      case 'Wheat':
        return 'Urea + DAP';
      case 'Cotton':
        return 'NPK 20-20-20';
      case 'Rice':
        return 'Urea + Potash';
      case 'Corn':
        return 'NPK 17-17-17';
      default:
        return 'Balanced NPK';
    }
  }

  Map<String, dynamic> _getIrrigationRecommendation() {
    final currentWeather = getCurrentWeather();
    if (currentWeather == null) {
      return {
        'recommendation': AppLocalizations.of(
          context,
        )!.normal_irrigation_schedule_three,
        'reason': AppLocalizations.of(context)!.weather_data_unavailable,
        'urgency': AppLocalizations.of(context)!.medium,
        'cropSpecific': true,
        'cropName': _currentDisplayCrop,
        'growthStage': AppLocalizations.of(context)!.general,
      };
    }

    final temp = currentWeather['main']['temp'];
    final weatherCondition = currentWeather['weather'][0]['main'];
    final humidity = currentWeather['main']['humidity'];
    final windSpeed = currentWeather['wind']['speed'];

    final Map<String, Map<String, dynamic>> _cropDatabase = {
      "Wheat": {
        "name": "Wheat",
        "optimalTemp": {"min": 15, "max": 25},
        "waterRequirement": 4.0,
        "growthStage": AppLocalizations.of(context)!.vegetative,
      },
      "Cotton": {
        "name": "Cotton",
        "optimalTemp": {"min": 20, "max": 30},
        "waterRequirement": 5.0,
        "growthStage": AppLocalizations.of(context)!.flowering,
      },
      "Rice": {
        "name": "Rice",
        "optimalTemp": {"min": 20, "max": 35},
        "waterRequirement": 6.0,
        "growthStage": AppLocalizations.of(context)!.tillering,
      },
      "Corn": {
        "name": "Corn",
        "optimalTemp": {"min": 18, "max": 32},
        "waterRequirement": 5.5,
        "growthStage": AppLocalizations.of(context)!.silking,
      },
    };

    final cropName = _currentDisplayCrop;
    final cropData = _cropDatabase[cropName] ?? _cropDatabase["Wheat"]!;
    double baseET = cropData['waterRequirement'];

    String recommendation = '';
    String reason = '';
    String urgency = 'Medium';

    final optimalTemp = cropData['optimalTemp'] as Map<String, int>;

    if (temp > optimalTemp['max']! + 5) {
      baseET *= 1.6;
    } else if (temp > optimalTemp['max']!) {
      baseET *= 1.3;
    } else if (temp >= optimalTemp['min']! && temp <= optimalTemp['max']!) {
      baseET *= 1.0;
    } else if (temp < optimalTemp['min']!) {
      baseET *= 0.7;
    }

    if (humidity < 40) {
      baseET *= 1.4;
    } else if (humidity > 80) {
      baseET *= 0.6;
    }

    if (windSpeed > 5) {
      baseET *= 1.3;
    }

    final double evapotranspiration = baseET;
    final growthStage = cropData['growthStage'];

    if (weatherCondition.contains('Rain')) {
      recommendation = AppLocalizations.of(
        context,
      )!.delay_irrigation_rain_expected;
      reason = AppLocalizations.of(
        context,
      )!.natural_rainfall_sufficient_three(cropName);
      urgency = AppLocalizations.of(context)!.urgency_low;
    } else if (weatherCondition.contains('Thunderstorm')) {
      recommendation = AppLocalizations.of(
        context,
      )!.delay_irrigation_heavy_rain;
      reason = AppLocalizations.of(
        context,
      )!.storm_rainfall_avoid_waterlogging_three(cropName);
      urgency = AppLocalizations.of(context)!.urgency_low;
    } else if (evapotranspiration > baseET * 1.5) {
      recommendation = AppLocalizations.of(
        context,
      )!.increase_irrigation_frequency;
      reason = AppLocalizations.of(context)!
          .high_evaporation_requires_more_water_three(
            evapotranspiration.toStringAsFixed(1),
            cropName,
          );
      urgency = AppLocalizations.of(context)!.urgency_high;
    } else if (evapotranspiration < baseET * 0.7) {
      recommendation = AppLocalizations.of(
        context,
      )!.reduce_irrigation_frequency;
      reason = AppLocalizations.of(context)!.low_evaporation_less_water_three(
        evapotranspiration.toStringAsFixed(1),
        cropName,
      );
      urgency = AppLocalizations.of(context)!.urgency_low;
    } else if (humidity < 35 && temp > optimalTemp['max']!) {
      recommendation = AppLocalizations.of(context)!.monitor_soil_moisture;
      reason = AppLocalizations.of(
        context,
      )!.dry_warm_conditions_water_management_three(cropName);
      urgency = AppLocalizations.of(context)!.urgency_medium;
    } else {
      recommendation = AppLocalizations.of(
        context,
      )!.normal_irrigation_schedule_three;
      reason = AppLocalizations.of(
        context,
      )!.moderate_conditions_regular_irrigation_three(cropName, growthStage);
      urgency = AppLocalizations.of(context)!.urgency_medium;
    }

    return {
      'recommendation': recommendation,
      'reason': reason,
      'urgency': urgency,
      'evapotranspiration': evapotranspiration.toStringAsFixed(1),
      'cropSpecific': true,
      'cropName': cropName,
      'growthStage': growthStage,
    };
  }

  void _navigateToPestPrevention(BuildContext context) {
    final pestData = _getPestPrediction();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PestPreventionScreen(
          isRiskHigh: pestData['isHighRisk'],
          weatherData: getCurrentWeather(),
          pestData: pestData,
        ),
      ),
    );
  }

  void _navigateToFertilizerGuide(BuildContext context) {
    final fertilizerData = _getFertilizerRecommendation();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FertilizerGuideScreen(
          recommendation: fertilizerData['recommendation'],
          weatherData: getCurrentWeather(),
          fertilizerData: fertilizerData,
        ),
      ),
    );
  }

  void _navigateToIrrigationGuide(BuildContext context) {
    final irrigationData = _getIrrigationRecommendation();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => IrrigationGuideScreen(
          recommendation: irrigationData['recommendation'],
          weatherData: getCurrentWeather(),
          irrigationData: irrigationData,
        ),
      ),
    );
  }

  void _navigateToWeatherScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WeatherScreen(
          weatherData: _weatherData ?? {},
          cityName: _displayCity,
        ),
      ),
    );
  }

  void _navigateToMarketplaceScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MarketplaceScreen(
          userLocation: widget.userLocation,
          userName: widget.userName,
        ),
      ),
    );
  }

  void _navigateToSettingsScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SettingsScreen(
          userLocation: widget.userLocation,
          userName: widget.userName,
          selectedCrops: widget.selectedCrops,
          primaryCrop: widget.primaryCrop,
        ),
      ),
    );
  }

  void _toggleLogoutButton() {
    setState(() {
      _showLogoutButton = !_showLogoutButton;
    });
  }

  void _handleLogout() async {
    try {
      await FirebaseAuth.instance.signOut();

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => WelcomeScreen()),
        (route) => false,
      );
    } catch (e) {
      print(AppLocalizations.of(context)!.error_logout);

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => WelcomeScreen()),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    final pestData = _getPestPrediction();
    final fertilizerData = _getFertilizerRecommendation();
    final currentWeather = getCurrentWeather();

    return WillPopScope(
      onWillPop: () async {
        return false;
      },

      child: Scaffold(
        backgroundColor: const Color(0xFFF5F5F5),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: const Color(0xFFF5F5F5),
          elevation: 0,
          title: Row(
            children: [
              GestureDetector(
                onTap: _toggleLogoutButton,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.green, width: 1.5),
                  ),
                  child: const CircleAvatar(
                    backgroundImage: AssetImage(
                      'assets/images/profile_placeholder.png',
                    ),
                    radius: 20,
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.app_name,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 2),
                      widget.selectedCrops.length > 1
                          ? GestureDetector(
                              onTap: _cycleCrop,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '$_displayCity - ',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Text(
                                    '$_currentDisplayCrop',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  const Icon(
                                    Icons.refresh,
                                    size: 10,
                                    color: Colors.green,
                                  ),
                                  Text(
                                    ' (${widget.selectedCrops.length} crops)',
                                    style: const TextStyle(
                                      fontSize: 10,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Text(
                              '$_displayCity - $_currentDisplayCrop',
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                    ],
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.settings,
                  color: Colors.black,
                ), // Changed from translate to settings
                onPressed: () {
                  _navigateToSettingsScreen(context);
                },
              ),
            ],
          ),
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () => _navigateToWeatherScreen(context),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 20,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: _isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : _errorMessage.isNotEmpty
                          ? Column(
                              children: [
                                const Icon(
                                  Icons.error_outline,
                                  color: Colors.red,
                                  size: 40,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  localization.weather_data_unavailable,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  _errorMessage,
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.grey[500],
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 8),
                                ElevatedButton(
                                  onPressed: () =>
                                      _fetchWeatherData(widget.userLocation),
                                  child: Text(localization.retry),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 8,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : currentWeather != null
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        _displayCity,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ),
                                    if (_usingFallbackWeather)
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 6,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.orange[100],
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                        child: Text(
                                          localization.approximate,
                                          style: TextStyle(
                                            fontSize: 9,
                                            color: Colors.orange[800],
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    const SizedBox(width: 6),
                                    const Icon(
                                      Icons.arrow_forward_ios,
                                      size: 12,
                                      color: Colors.grey,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 6),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.baseline,
                                            textBaseline:
                                                TextBaseline.alphabetic,
                                            children: [
                                              Text(
                                                '${currentWeather['main']['temp']?.round() ?? 0}',
                                                style: const TextStyle(
                                                  fontSize: 32,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              const Text(
                                                '°C',
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 2),
                                          Text(
                                            currentWeather['weather'][0]['main'] ??
                                                'N/A',
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.black87,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.water_drop,
                                                size: 14,
                                                color: Colors.blue[400],
                                              ),
                                              const SizedBox(width: 4),
                                              Text(
                                                '${currentWeather['main']['humidity']?.round() ?? 0}%',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.grey[600],
                                                ),
                                              ),
                                              const SizedBox(width: 12),
                                              Icon(
                                                Icons.air,
                                                size: 14,
                                                color: Colors.grey[600],
                                              ),
                                              const SizedBox(width: 4),
                                              Text(
                                                '${currentWeather['wind']['speed']?.toStringAsFixed(1) ?? '0.0'} km/h',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.grey[600],
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 2),
                                          Text(
                                            '${AppLocalizations.of(context)!.feels_like} ${currentWeather['main']['feels_like']?.round() ?? 0}°C',
                                            style: TextStyle(
                                              fontSize: 11,
                                              color: Colors.grey[500],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Icon(
                                      _getWeatherIcon(
                                        currentWeather['weather'][0]['main'] ??
                                            localization.clear,
                                      ),
                                      color: _getWeatherIconColor(
                                        currentWeather['weather'][0]['main'] ??
                                            localization.clear,
                                      ),
                                      size: 60,
                                    ),
                                    const SizedBox(width: 8),
                                  ],
                                ),
                              ],
                            )
                          : Column(
                              children: [
                                const Icon(
                                  Icons.error_outline,
                                  color: Colors.orange,
                                  size: 40,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  localization.weather_data_error,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black87,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                ElevatedButton(
                                  onPressed: () =>
                                      _fetchWeatherData(widget.userLocation),
                                  child: Text(localization.retry),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 8,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Text(
                        localization.recommendations_for,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Expanded(
                        child: widget.selectedCrops.length > 1
                            ? GestureDetector(
                                onTap: _cycleCrop,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        _currentDisplayCrop,
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    const Icon(
                                      Icons.refresh,
                                      size: 16,
                                      color: Colors.green,
                                    ),
                                    const SizedBox(width: 4),
                                    Flexible(
                                      child: Text(
                                        '(tap to change)',
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Text(
                                _currentDisplayCrop,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                      ),
                    ],
                  ),

                  if (widget.selectedCrops.length > 1)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        'You grow ${widget.selectedCrops.length} crops: ${widget.selectedCrops.join(', ')}',
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                    ),
                  const SizedBox(height: 12),

                  GestureDetector(
                    onTap: () => _navigateToPestPrevention(context),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16),
                            ),
                            child: AspectRatio(
                              aspectRatio: 18 / 9,
                              child: Image.asset(
                                'assets/images/pest_aphid.png',
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    color: pestData['isHighRisk']
                                        ? Colors.red[50]
                                        : Colors.orange[50],
                                    child: Center(
                                      child: Icon(
                                        Icons.bug_report,
                                        size: 60,
                                        color: pestData['isHighRisk']
                                            ? Colors.red[300]
                                            : Colors.orange[300],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: pestData['isHighRisk']
                                            ? Colors.red.withOpacity(0.1)
                                            : Colors.orange.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                          color: pestData['isHighRisk']
                                              ? Colors.red.withOpacity(0.3)
                                              : Colors.orange.withOpacity(0.3),
                                          width: 1,
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.warning,
                                            size: 14,
                                            color: pestData['isHighRisk']
                                                ? Colors.red
                                                : Colors.orange,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            pestData['isHighRisk']
                                                ? localization.high_risk
                                                : localization.moderate_risk,
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: pestData['isHighRisk']
                                                  ? Colors.red
                                                  : Colors.orange,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Spacer(),
                                    Text(
                                      _currentDisplayCrop,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  localization.pest_attack_prediction,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: pestData['isHighRisk']
                                        ? Colors.red[800]
                                        : Colors.orange[800],
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  pestData['pestType'],
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  pestData['message'] ??
                                      localization.weather_conditions_favorable,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[700],
                                    height: 1.4,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    Text(
                                      localization.tap_to_change,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.green[600],
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    Icon(
                                      Icons.arrow_forward,
                                      size: 12,
                                      color: Colors.green[600],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  GestureDetector(
                    onTap: () => _navigateToFertilizerGuide(context),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.green[100],
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.eco, color: Colors.green),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${fertilizerData['recommendation'] ?? 'Fertilizer Guide'} for $_currentDisplayCrop',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  fertilizerData['reason'] ?? 'Tap for details',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  GestureDetector(
                    onTap: () => _navigateToIrrigationGuide(context),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.green[50],
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.trending_up,
                              color: Colors.green,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  ' $_currentDisplayCrop, ${localization.optimal_irrigation_needed_for}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  '${localization.you} $_currentDisplayCrop ${localization.critical_growth_stage_guide}',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            _buildWelcomeOverlay(),

            if (_showLogoutButton)
              Positioned(
                top: 70,
                left: 10,
                child: Container(
                  width: 180,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.green[50],
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8),
                          ),
                        ),
                        child: Row(
                          children: [
                            const CircleAvatar(
                              backgroundImage: AssetImage(
                                'assets/images/profile_placeholder.png',
                              ),
                              radius: 20,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.userName,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    widget.userLocation.isNotEmpty
                                        ? widget.userLocation
                                        : localization.your_location,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(height: 1, color: Colors.grey),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: _handleLogout,
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8),
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            width: double.infinity,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.logout,
                                  color: Colors.red[400],
                                  size: 20,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  AppLocalizations.of(context)!.logout,
                                  style: TextStyle(
                                    color: Colors.red[400],
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _bottomNavIndex,
          selectedItemColor: const Color(0xFF4CAF50),
          unselectedItemColor: Colors.grey,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          onTap: (index) {
            // Update the bottom navigation index
            setState(() {
              _bottomNavIndex = index;
              _showLogoutButton =
                  false; // Hide logout button when tapping other tabs
            });

            // Handle navigation based on tapped item
            switch (index) {
              case 0: // Home
                // Already on Home, do nothing
                break;
              case 1: // Weather
                // Navigate to WeatherScreen
                _navigateToWeatherScreen(context);
                // Keep the bottom nav index at 0 (Home) since WeatherScreen will have its own navigation
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  setState(() {
                    _bottomNavIndex = 0;
                  });
                });
                break;
              case 2: // Crop Guide
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CropGuideScreen(),
                  ),
                );
                // Keep the bottom nav index at 0 (Home) since CropGuideScreen will have its own navigation
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  setState(() {
                    _bottomNavIndex = 0;
                  });
                });
                break;
              case 3: // Community (Marketplace)
                // Navigate to MarketplaceScreen instead of Community
                _navigateToMarketplaceScreen(context);
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  setState(() {
                    _bottomNavIndex = 0;
                  });
                });
                break;
            }
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: AppLocalizations.of(context)!.home,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.wb_sunny_outlined),
              label: AppLocalizations.of(context)!.weather,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.grass),
              label: AppLocalizations.of(context)!.crop_guide,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.storefront),
              label: AppLocalizations.of(context)!.marketplace,
            ),
          ],
        ),
      ),
    );
  }
}
