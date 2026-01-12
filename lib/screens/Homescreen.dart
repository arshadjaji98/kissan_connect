// lib/screens/HomeScreen.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pest Prevention Guide'),
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
                          '${pestData['riskLevel'] ?? 'Unknown'} - ${pestData['cropName'] ?? 'Crop'}',
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
                      pestData['message'] ?? 'No message available',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // High Risk Pests Section
            if (highRiskPests.isNotEmpty) ...[
              const Text(
                '🚨 High Risk Pests:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
              const SizedBox(height: 10),
              ...highRiskPests.map((pest) => _buildPestCard(pest, true)),
              const SizedBox(height: 20),
            ],

            // Moderate Risk Pests Section
            if (moderateRiskPests.isNotEmpty) ...[
              const Text(
                '⚠️ Moderate Risk Pests:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
              ),
              const SizedBox(height: 10),
              ...moderateRiskPests.map((pest) => _buildPestCard(pest, false)),
              const SizedBox(height: 20),
            ],

            // Prevention Measures
            const Text(
              '🛡️ Prevention Measures:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 10),
            _buildPreventionMeasures(pestData['cropName'] ?? 'General'),
          ],
        ),
      ),
    );
  }

  Widget _buildPestCard(String pestName, bool isHighRisk) {
    final pestInfo = _getPestInformation(pestName);
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
              pestInfo['description'] ?? 'No description available',
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 8),
            Text(
              '🕒 Active in: ${pestInfo['activeSeason'] ?? 'Various seasons'}',
              style: const TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPreventionMeasures(String cropName) {
    final measures = _getPreventionMeasures(cropName);
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

  Map<String, String> _getPestInformation(String pestName) {
    final pestInfo = {
      'Aphids': {
        'description':
            'Small sap-sucking insects that cause yellowing and curling of leaves.',
        'activeSeason': 'Spring and Summer',
      },
      'Army Worm': {
        'description':
            'Caterpillars that feed on leaves and can defoliate entire plants.',
        'activeSeason': 'Summer and Monsoon',
      },
      'Bollworm': {
        'description':
            'Larvae that bore into cotton bolls, causing significant yield loss.',
        'activeSeason': 'Flowering season',
      },
      'Stem Borer': {
        'description':
            'Larvae that tunnel into stems, causing plants to wilt and die.',
        'activeSeason': 'Throughout growing season',
      },
      'Whitefly': {
        'description':
            'Small white insects that suck sap and transmit viral diseases.',
        'activeSeason': 'Warm and dry conditions',
      },
      'Rust Fungus': {
        'description':
            'Fungal disease causing orange-brown pustules on leaves and stems.',
        'activeSeason': 'Cool, moist conditions',
      },
      'Hessian Fly': {
        'description':
            'Small flies whose larvae feed on wheat stems, stunting growth.',
        'activeSeason': 'Fall and Spring',
      },
      'Spider Mites': {
        'description':
            'Tiny mites that suck plant juices, causing yellow stippling on leaves.',
        'activeSeason': 'Hot, dry weather',
      },
      'Leaf Folder': {
        'description':
            'Larvae that fold and feed inside rice leaves, reducing photosynthesis.',
        'activeSeason': 'Wet season',
      },
      'Blast Fungus': {
        'description':
            'Fungal disease causing lesions on leaves, nodes, and panicles.',
        'activeSeason': 'High humidity conditions',
      },
      'Brown Plant Hopper': {
        'description':
            'Sap-sucking insects that cause "hopper burn" and transmit viruses.',
        'activeSeason': 'Wet season',
      },
      'Corn Borer': {
        'description':
            'Larvae that tunnel into corn stalks and ears, reducing yield.',
        'activeSeason': 'Summer months',
      },
      'Earworm': {
        'description': 'Caterpillars that feed on corn ears, damaging kernels.',
        'activeSeason': 'Silking to harvest',
      },
      'Corn Leaf Aphid': {
        'description':
            'Aphids that cluster on leaves and tassels, reducing plant vigor.',
        'activeSeason': 'Cool weather',
      },
    };
    return {
      'description':
          pestInfo[pestName]?['description'] ??
          'General pest that affects crop health and yield.',
      'activeSeason':
          pestInfo[pestName]?['activeSeason'] ?? 'Varies with conditions',
    };
  }

  List<String> _getPreventionMeasures(String cropName) {
    final measures = {
      'Wheat': [
        'Use certified disease-free seeds',
        'Practice crop rotation with legumes',
        'Monitor fields regularly for early detection',
        'Use neem-based organic pesticides',
        'Remove and destroy infected plants',
        'Maintain proper plant spacing for air circulation',
      ],
      'Cotton': [
        'Install yellow sticky traps for whiteflies',
        'Use pheromone traps for bollworms',
        'Practice intercropping with marigold',
        'Apply recommended insecticides at first sight',
        'Remove crop residues after harvest',
        'Use resistant varieties when available',
      ],
      'Rice': [
        'Maintain proper water level in fields',
        'Use light traps for monitoring',
        'Release natural predators like spiders',
        'Apply recommended pesticides at tillering stage',
        'Practice synchronous planting in area',
        'Remove weed hosts around fields',
      ],
      'Corn': [
        'Plant early to avoid peak pest season',
        'Use resistant hybrid varieties',
        'Practice deep plowing after harvest',
        'Apply soil insecticides at planting',
        'Monitor for egg masses on leaves',
        'Use biological control agents',
      ],
    };
    return measures[cropName] ??
        [
          'Regular field monitoring',
          'Use organic pesticides first',
          'Practice crop rotation',
          'Maintain field hygiene',
          'Use resistant varieties',
          'Consult local agriculture expert',
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fertilizer Guide'),
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
                    const Row(
                      children: [
                        Icon(Icons.eco, color: Colors.green, size: 30),
                        SizedBox(width: 10),
                        Text(
                          'Fertilizer Recommendation',
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
                      fertilizerData['reason'] ?? 'No reason provided',
                      style: const TextStyle(fontSize: 16),
                    ),
                    if ((fertilizerData['adjustment'] as String?) !=
                        'Optimal application rate')
                      Text(
                        'Adjustment: ${fertilizerData['adjustment'] ?? "None"}',
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
            const Text(
              '📋 Application Guide:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildApplicationGuide(fertilizerData['cropName'] ?? 'General'),

            const SizedBox(height: 20),

            // Fertilizer Types
            const Text(
              '🧪 Recommended Fertilizer Types:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildFertilizerTypes(fertilizerData['cropName'] ?? 'General'),

            const SizedBox(height: 20),

            // Timing and Methods
            const Text(
              '⏰ Best Application Timing:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildTimingGuide(fertilizerData['growthStage'] ?? 'General'),
          ],
        ),
      ),
    );
  }

  Widget _buildApplicationGuide(String cropName) {
    final guides = _getApplicationGuide(cropName);
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

  Widget _buildFertilizerTypes(String cropName) {
    final types = _getFertilizerTypes(cropName);
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

  Widget _buildTimingGuide(String growthStage) {
    final timing = _getTimingGuide(growthStage);
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

  List<String> _getApplicationGuide(String cropName) {
    final guides = {
      'Wheat': [
        'Apply 1/3 of nitrogen at sowing',
        'Apply remaining nitrogen in two splits during tillering and jointing',
        'Mix fertilizers thoroughly in soil',
        'Apply when soil has adequate moisture',
        'Avoid application during heavy rainfall',
        'Use soil test-based recommendations',
      ],
      'Cotton': [
        'Apply full dose of phosphorus and potassium at sowing',
        'Split nitrogen application in 3-4 doses',
        'First dose at sowing, second at squaring',
        'Third dose at flowering, fourth if needed',
        'Apply in bands 5-7 cm deep',
        'Irrigate immediately after application',
      ],
      'Rice': [
        'Apply basal dose before pudding',
        'Split nitrogen application in 3 equal doses',
        'First at transplanting, second at tillering, third at panicle initiation',
        'Apply in standing water for better efficiency',
        'Use urea super granules for better results',
        'Avoid application during strong winds',
      ],
      'Corn': [
        'Apply starter fertilizer at planting',
        'Side-dress nitrogen when plants are 30-45 cm tall',
        'Apply phosphorus and potassium based on soil test',
        'Use split applications for sandy soils',
        'Incorporate fertilizers properly',
        'Avoid root contact with concentrated fertilizers',
      ],
    };
    return guides[cropName] ??
        [
          'Apply fertilizers based on soil test results',
          'Split applications for better efficiency',
          'Incorporate fertilizers properly into soil',
          'Apply when plants are actively growing',
          'Avoid application during extreme weather',
          'Follow recommended dosage strictly',
        ];
  }

  Map<String, String> _getFertilizerTypes(String cropName) {
    final types = {
      'Wheat': {
        'Nitrogen': 'Urea (46-0-0)',
        'Phosphorus': 'DAP (18-46-0)',
        'Potassium': 'MOP (0-0-60)',
        'Micronutrients': 'Zinc Sulfate',
      },
      'Cotton': {
        'Nitrogen': 'Urea (46-0-0)',
        'Phosphorus': 'SSP (0-16-0)',
        'Potassium': 'MOP (0-0-60)',
        'Micronutrients': 'Boron, Zinc',
      },
      'Rice': {
        'Nitrogen': 'Urea (46-0-0)',
        'Phosphorus': 'DAP (18-46-0)',
        'Potassium': 'MOP (0-0-60)',
        'Micronutrients': 'Zinc Sulfate',
      },
      'Corn': {
        'Nitrogen': 'Urea (46-0-0)',
        'Phosphorus': 'NPK (17-17-17)',
        'Potassium': 'MOP (0-0-60)',
        'Micronutrients': 'Zinc, Iron',
      },
    };
    return types[cropName] ??
        {
          'Nitrogen': 'Urea or Ammonium-based',
          'Phosphorus': 'DAP or SSP',
          'Potassium': 'MOP or SOP',
          'Micronutrients': 'As per soil test',
        };
  }

  List<String> _getTimingGuide(String growthStage) {
    final timing = {
      'Vegetative': [
        'Focus on nitrogen application',
        'Apply when plants show active growth',
        'Avoid application during drought',
        'Best applied before expected rainfall',
        'Monitor leaf color for deficiencies',
      ],
      'Flowering': [
        'Reduce nitrogen application',
        'Increase phosphorus for flower formation',
        'Apply before flower buds open',
        'Avoid application during full bloom',
        'Monitor for nutrient deficiencies',
      ],
      'Tillering': [
        'Critical for nitrogen application',
        'Apply when tillers start developing',
        'Split application recommended',
        'Ensure adequate soil moisture',
        'Monitor tiller count regularly',
      ],
      'Silking': [
        'Focus on potassium application',
        'Apply during early silking stage',
        'Reduce nitrogen to prevent excessive growth',
        'Ensure balanced nutrition',
        'Monitor ear development',
      ],
      'Pod Formation': [
        'Focus on potassium application',
        'Apply during early pod development',
        'Reduce nitrogen to prevent excessive growth',
        'Ensure balanced nutrition',
        'Monitor pod setting rate',
      ],
    };
    return timing[growthStage] ??
        [
          'Apply during active growth phases',
          'Avoid application during stress conditions',
          'Follow crop-specific schedules',
          'Consider weather conditions',
          'Monitor plant response after application',
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Irrigation Guide'),
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
                    const Row(
                      children: [
                        Icon(Icons.opacity, color: Colors.blue, size: 30),
                        SizedBox(width: 10),
                        Text(
                          'Irrigation Recommendation',
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
                      irrigationData['reason'] ?? 'No reason provided',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Evapotranspiration Rate: ${irrigationData['evapotranspiration'] ?? 'N/A'} mm/day',
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
            const Text(
              '📅 Irrigation Schedule:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildIrrigationSchedule(irrigationData['cropName'] ?? 'General'),

            const SizedBox(height: 20),

            // Water Management Tips
            const Text(
              '💧 Water Management Tips:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildWaterManagementTips(irrigationData['urgency'] ?? 'Medium'),

            const SizedBox(height: 20),

            // Methods and Techniques
            const Text(
              '⚙️ Irrigation Methods:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildIrrigationMethods(),
          ],
        ),
      ),
    );
  }

  Widget _buildIrrigationSchedule(String cropName) {
    final schedule = _getIrrigationSchedule(cropName);
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

  Widget _buildWaterManagementTips(String urgency) {
    final tips = _getWaterManagementTips(urgency);
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

  Widget _buildIrrigationMethods() {
    final methods = _getIrrigationMethods();
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

  Map<String, String> _getIrrigationSchedule(String cropName) {
    final schedules = {
      'Wheat': {
        'First Irrigation': '21-25 days after sowing (Crown Root)',
        'Second Irrigation': '45-50 days after sowing (Tillering)',
        'Third Irrigation': '70-75 days after sowing (Jointing)',
        'Fourth Irrigation': '90-95 days after sowing (Flowering)',
        'Fifth Irrigation': '110-115 days after sowing (Grain filling)',
      },
      'Cotton': {
        'First Irrigation': '30-35 days after sowing',
        'Second Irrigation': 'During squaring stage',
        'Third Irrigation': 'During flowering stage',
        'Fourth Irrigation': 'Boll formation stage',
        'Fifth Irrigation': 'Boll development stage',
      },
      'Rice': {
        'Initial Flooding': '3-5 cm standing water after transplanting',
        'Vegetative Stage': 'Maintain 2-5 cm standing water',
        'Reproductive Stage': 'Maintain 5-10 cm standing water',
        'Ripening Stage': 'Gradually reduce water 2 weeks before harvest',
      },
      'Corn': {
        'First Irrigation': 'Immediately after sowing',
        'Second Irrigation': 'Knee-high stage (30-45 cm)',
        'Third Irrigation': 'Tasseling stage',
        'Fourth Irrigation': 'Silking stage',
        'Fifth Irrigation': 'Grain filling stage',
      },
    };
    return schedules[cropName] ??
        {
          'General Rule': 'Irrigate when top 15 cm soil feels dry',
          'Critical Stages':
              'Ensure adequate moisture during flowering and fruit setting',
          'Water Quantity': 'Apply 5-7 cm depth per irrigation',
          'Monitoring': 'Check soil moisture regularly',
        };
  }

  List<String> _getWaterManagementTips(String urgency) {
    final tips = {
      'High': [
        'Irrigate immediately if soil is dry',
        'Use mulching to conserve soil moisture',
        'Consider drip irrigation for efficiency',
        'Monitor plants for wilting signs',
        'Water in early morning or late evening',
        'Check soil moisture daily',
      ],
      'Medium': [
        'Follow regular irrigation schedule',
        'Check soil moisture every 2-3 days',
        'Adjust based on rainfall',
        'Use water conservation techniques',
        'Monitor weather forecasts',
        'Maintain irrigation records',
      ],
      'Low': [
        'Delay irrigation if rain is forecast',
        'Check soil moisture before watering',
        'Reduce irrigation frequency',
        'Use water-saving methods',
        'Monitor for over-watering signs',
        'Collect rainwater if possible',
      ],
    };
    return tips[urgency] ??
        [
          'Check soil moisture before irrigation',
          'Water based on plant needs, not fixed schedule',
          'Use efficient irrigation methods',
          'Monitor weather conditions',
          'Avoid waterlogging',
          'Maintain proper drainage',
        ];
  }

  Map<String, String> _getIrrigationMethods() {
    return {
      'Drip Irrigation':
          'Most efficient method, saves 30-50% water, ideal for row crops',
      'Sprinkler Irrigation':
          'Good for uniform coverage, suitable for most field crops',
      'Furrow Irrigation':
          'Traditional method for row crops, moderate efficiency',
      'Flood Irrigation':
          'Used for rice and some field crops, lower efficiency',
      'Basin Irrigation': 'Suitable for orchards and some field crops',
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
    _displayCity = userLocation.isNotEmpty ? userLocation : 'Your Location';

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
      print('Error initializing Firebase: $e');
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
      print('Error updating first-time status: $e');
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
                  'Welcome ${widget.userName}!',
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
                  'Your farming journey begins here',
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
                  'Preparing your personalized dashboard...',
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
                      'Tap to continue',
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
      print('Error fetching weather: $e');
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
        _errorMessage =
            'Unable to fetch weather data. Please check your internet connection.';
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to load weather data: ${e.toString()}';
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
    if (weatherCode == 0) return 'Clear';
    if (weatherCode == 1) return 'Clear';
    if (weatherCode == 2) return 'Partly Cloudy';
    if (weatherCode == 3) return 'Cloudy';
    if (weatherCode == 45 || weatherCode == 48) return 'Fog';
    if (weatherCode >= 51 && weatherCode <= 57) return 'Drizzle';
    if (weatherCode >= 61 && weatherCode <= 67) return 'Rain';
    if (weatherCode >= 80 && weatherCode <= 86) return 'Rain';
    if (weatherCode >= 71 && weatherCode <= 77) return 'Snow';
    if (weatherCode >= 95 && weatherCode <= 99) return 'Thunderstorm';
    return 'Clear';
  }

  String _getWeatherDescriptionFromCode(int weatherCode) {
    if (weatherCode == 0) return 'Clear sky';
    if (weatherCode == 1) return 'Mainly clear';
    if (weatherCode == 2) return 'Partly cloudy';
    if (weatherCode == 3) return 'Overcast';
    if (weatherCode == 45) return 'Fog';
    if (weatherCode == 48) return 'Depositing rime fog';
    if (weatherCode == 51) return 'Light drizzle';
    if (weatherCode == 53) return 'Moderate drizzle';
    if (weatherCode == 55) return 'Dense drizzle';
    if (weatherCode == 61) return 'Slight rain';
    if (weatherCode == 63) return 'Moderate rain';
    if (weatherCode == 65) return 'Heavy rain';
    if (weatherCode == 71) return 'Slight snow';
    if (weatherCode == 73) return 'Moderate snow';
    if (weatherCode == 75) return 'Heavy snow';
    if (weatherCode == 95) return 'Thunderstorm';
    if (weatherCode == 96) return 'Thunderstorm with hail';
    return 'Clear sky';
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
    final currentWeather = getCurrentWeather();
    if (currentWeather == null) {
      return {
        'riskLevel': 'Unknown',
        'message': 'Weather data not available',
        'pestType': 'Various pests',
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
        "name": "Wheat",
        "pestTypes": ["Aphids", "Army Worm", "Rust Fungus", "Hessian Fly"],
        "optimalTemp": {"min": 15, "max": 25},
        "criticalTemp": {"min": 10, "max": 35},
        "waterRequirement": 4.0,
        "growthStage": "Vegetative",
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
        "name": "Cotton",
        "pestTypes": ["Bollworm", "Whitefly", "Aphids", "Spider Mites"],
        "optimalTemp": {"min": 20, "max": 30},
        "criticalTemp": {"min": 15, "max": 40},
        "waterRequirement": 5.0,
        "growthStage": "Flowering",
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
        "name": "Rice",
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
      message = 'Temperature optimal for ${cropName.toLowerCase()} pests';
    } else if (temp < criticalTemp['min']! || temp > criticalTemp['max']!) {
      riskScore += 0;
      message = 'Temperature extremes may reduce pest activity';
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
      message = 'Rain may reduce some pest populations';
    } else if (weatherCondition.contains('Clear')) {
      riskScore += 1;
      if (message.isEmpty) message = 'Sunny conditions favor pest development';
    }

    String riskLevel;
    bool isHighRisk;
    String pestType;

    if (riskScore >= 6 || highRiskPests.isNotEmpty) {
      riskLevel = 'High Risk';
      isHighRisk = true;
      pestType = highRiskPests.isNotEmpty
          ? highRiskPests.join(', ')
          : cropData['pestTypes'][0];
      message = message.isEmpty
          ? 'High risk of ${highRiskPests.isNotEmpty ? highRiskPests.join(', ') : 'pest'} infestation in $cropName'
          : message;
    } else if (riskScore >= 3 || moderateRiskPests.isNotEmpty) {
      riskLevel = 'Moderate Risk';
      isHighRisk = false;
      pestType = moderateRiskPests.isNotEmpty
          ? moderateRiskPests.join(', ')
          : cropData['pestTypes'][0];
      message = message.isEmpty
          ? 'Monitor $cropName for ${moderateRiskPests.isNotEmpty ? moderateRiskPests.join(', ') : 'potential pests'}'
          : message;
    } else {
      riskLevel = 'Low Risk';
      isHighRisk = false;
      pestType = cropData['pestTypes'][0];
      message = message.isEmpty
          ? 'Low pest risk for $cropName in current conditions'
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
        'recommendation': 'Standard application needed',
        'reason': 'Weather data unavailable - using standard recommendation',
        'adjustment': 'No adjustment',
        'cropSpecific': true,
        'cropName': _currentDisplayCrop,
        'growthStage': 'General',
      };
    }

    final temp = currentWeather['main']['temp'];
    final weatherCondition = currentWeather['weather'][0]['main'];

    final Map<String, Map<String, dynamic>> _cropDatabase = {
      "Wheat": {
        "name": "Wheat",
        "optimalTemp": {"min": 15, "max": 25},
        "growthStage": "Vegetative",
        "fertilizerBase": 50.0,
      },
      "Cotton": {
        "name": "Cotton",
        "optimalTemp": {"min": 20, "max": 30},
        "growthStage": "Flowering",
        "fertilizerBase": 60.0,
      },
      "Rice": {
        "name": "Rice",
        "optimalTemp": {"min": 20, "max": 35},
        "growthStage": "Tillering",
        "fertilizerBase": 70.0,
      },
      "Corn": {
        "name": "Corn",
        "optimalTemp": {"min": 18, "max": 32},
        "growthStage": "Silking",
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
      adjustment = 'Reduced due to high temperature';
      reason = 'High temperatures increase fertilizer burn risk for $cropName';
    } else if (temp > optimalTemp['max']!) {
      baseAmount *= 0.85;
      adjustment = 'Slightly reduced due to warm conditions';
      reason = 'Warm weather increases nutrient availability for $cropName';
    } else if (temp < optimalTemp['min']!) {
      baseAmount *= 0.6;
      adjustment = 'Significantly reduced due to cold weather';
      reason = 'Cold temperatures slow $cropName growth and nutrient uptake';
    } else {
      reason = 'Optimal temperature for $cropName fertilizer application';
    }

    if (weatherCondition.contains('Rain')) {
      baseAmount *= 1.1;
      adjustment = adjustment.isEmpty
          ? 'Increased before expected rain'
          : '$adjustment, increased for rain';
      reason = '$reason. Rain will help $cropName absorb nutrients efficiently';
    } else if (weatherCondition.contains('Clear') &&
        temp > optimalTemp['max']!) {
      baseAmount *= 0.9;
      adjustment = adjustment.isEmpty
          ? 'Reduced for dry conditions'
          : '$adjustment, reduced for dryness';
      reason = '$reason. $cropName may require irrigation after application';
    }

    final growthStage = cropData['growthStage'];
    reason = '$reason. Current growth stage: $growthStage';

    return {
      'recommendation': '${baseAmount.round()}kg $fertilizerType/acre',
      'reason': reason,
      'adjustment': adjustment.isEmpty
          ? 'Optimal application rate'
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
        'recommendation': 'Normal irrigation needed',
        'reason': 'Weather data unavailable - using standard recommendation',
        'urgency': 'Medium',
        'cropSpecific': true,
        'cropName': _currentDisplayCrop,
        'growthStage': 'General',
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
        "growthStage": "Vegetative",
      },
      "Cotton": {
        "name": "Cotton",
        "optimalTemp": {"min": 20, "max": 30},
        "waterRequirement": 5.0,
        "growthStage": "Flowering",
      },
      "Rice": {
        "name": "Rice",
        "optimalTemp": {"min": 20, "max": 35},
        "waterRequirement": 6.0,
        "growthStage": "Tillering",
      },
      "Corn": {
        "name": "Corn",
        "optimalTemp": {"min": 18, "max": 32},
        "waterRequirement": 5.5,
        "growthStage": "Silking",
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
      recommendation = 'Delay irrigation - Rain expected';
      reason =
          'Natural rainfall will provide sufficient moisture for $cropName';
      urgency = 'Low';
    } else if (weatherCondition.contains('Thunderstorm')) {
      recommendation = 'Delay irrigation - Heavy rain expected';
      reason =
          'Storm will provide adequate rainfall for $cropName, avoid waterlogging';
      urgency = 'Low';
    } else if (evapotranspiration > baseET * 1.5) {
      recommendation = 'Increase irrigation frequency';
      reason =
          'High evaporation rate (${evapotranspiration.toStringAsFixed(1)}mm/day) requires more frequent watering for $cropName';
      urgency = 'High';
    } else if (evapotranspiration < baseET * 0.7) {
      recommendation = 'Reduce irrigation frequency';
      reason =
          'Low evaporation rate (${evapotranspiration.toStringAsFixed(1)}mm/day) - $cropName needs less water';
      urgency = 'Low';
    } else if (humidity < 35 && temp > optimalTemp['max']!) {
      recommendation = 'Monitor soil moisture closely';
      reason =
          'Dry, warm conditions require careful water management for $cropName';
      urgency = 'Medium';
    } else {
      recommendation = 'Normal irrigation schedule';
      reason =
          'Moderate conditions - maintain regular irrigation for $cropName ($growthStage stage)';
      urgency = 'Medium';
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
      print('Error during logout: $e');

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => WelcomeScreen()),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final pestData = _getPestPrediction();
    final fertilizerData = _getFertilizerRecommendation();
    final irrigationData = _getIrrigationRecommendation();
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
                      const Text(
                        'Kissan Connect',
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
                                  'Weather data unavailable',
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
                                  child: const Text('Retry'),
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
                                          'Approximate',
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
                                            'Feels like ${currentWeather['main']['feels_like']?.round() ?? 0}°C',
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
                                            'Clear',
                                      ),
                                      color: _getWeatherIconColor(
                                        currentWeather['weather'][0]['main'] ??
                                            'Clear',
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
                                const Text(
                                  'Weather data error',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black87,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                ElevatedButton(
                                  onPressed: () =>
                                      _fetchWeatherData(widget.userLocation),
                                  child: const Text('Retry'),
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
                      const Text(
                        'Recommendations for ',
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
                                                ? 'High Alert'
                                                : 'Moderate Alert',
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
                                  'Pest Attack Prediction',
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
                                      'Weather conditions are favorable for pest activity.',
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
                                      'Tap for prevention guide',
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
                                  'Optimal Irrigation Needed for $_currentDisplayCrop',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Your $_currentDisplayCrop crop is at a critical growth stage. Tap for a guide.',
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
                                        : 'Your Location',
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
                                const SizedBox(width: 10),
                                Text(
                                  'Logout',
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
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
              icon: Icon(Icons.wb_sunny_outlined),
              label: 'Weather',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.grass),
              label: 'Crop Guide',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.storefront),
              label: 'Marketplace',
            ),
          ],
        ),
      ),
    );
  }
}
