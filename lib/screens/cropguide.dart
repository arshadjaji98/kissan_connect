import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'HomeScreen.dart';
import 'WeatherScreen.dart';
import 'MarketplaceScreen.dart';

// ---------------------------------------------------------------------------
// DATA MODEL
// ---------------------------------------------------------------------------
class Crop {
  final String nameEn;
  final String nameUr;
  final String imagePath;
  final String description;
  final Map<String, List<String>> recommendations;

  Crop({
    required this.nameEn,
    required this.nameUr,
    required this.imagePath,
    required this.description,
    required this.recommendations,
  });
}

// ---------------------------------------------------------------------------
// MASTER CROP DATA WITH SPECIALIZED RECOMMENDATIONS
// ---------------------------------------------------------------------------
final List<Crop> allAvailableCrops = [
  Crop(
      nameEn: 'Wheat',
      nameUr: 'گندم',
      imagePath: 'assets/images/wheat.png',
      description: 'Wheat is a staple Rabi crop requiring cool weather (15-25°C) during growth and moderate rainfall. Ideal sowing season is October-December.',
      recommendations: {
        '🌱 Planting': [
          'Sow from October to December for Rabi season',
          'Use certified seeds like Punjab-2011, Galaxy-2013',
          'Optimal seed rate: 40-50 kg/acre',
          'Row spacing: 22-25 cm',
          'Sow at depth of 4-5 cm'
        ],
        '💧 Irrigation': [
          'First irrigation: 21-25 days after sowing',
          'Second irrigation: 45-50 days (Tillering stage)',
          'Third irrigation: 70-75 days (Jointing stage)',
          'Fourth irrigation: 90-95 days (Flowering)',
          'Fifth irrigation: 110-115 days (Grain filling)'
        ],
        '🧪 Fertilization': [
          'Basal dose: 2 bags DAP + 1 bag SOP/acre',
          'First split: 1 bag Urea at tillering',
          'Second split: 1 bag Urea at jointing',
          'Apply Zinc sulfate @ 5 kg/acre if deficient',
          'Foliar spray of boron at flowering'
        ],
        '🐛 Pest Control': [
          'Monitor for aphids during Feb-March',
          'Use neem oil spray @ 5% for early infestation',
          'For army worm: Chlorpyrifos @ 1.5 L/acre',
          'Rust control: Propiconazole @ 200 ml/acre',
          'Remove volunteer plants to break disease cycle'
        ],
        '📊 Yield Optimization': [
          'Target yield: 40-50 maunds/acre',
          'Harvest when grains harden (30-35% moisture)',
          'Use combine harvester for efficient harvesting',
          'Dry to 12% moisture before storage',
          'Store in clean, rodent-proof godowns'
        ]
      }
  ),
  Crop(
      nameEn: 'Sugarcane',
      nameUr: 'گنا',
      imagePath: 'assets/images/sugarcane.png',
      description: 'Sugarcane is a tropical perennial cash crop needing high heat (25-32°C) and moisture. It has a 12-18 month growing season.',
      recommendations: {
        '🌱 Planting': [
          'Plant from February to March (Spring crop)',
          'Use 3-bud setts from healthy canes',
          'Seed rate: 30-35,000 setts/acre',
          'Row spacing: 90-120 cm',
          'Planting depth: 5-7 cm in furrows'
        ],
        '💧 Irrigation': [
          'Initial: Irrigate immediately after planting',
          'Critical stage: Grand growth period',
          'Irrigation interval: 10-12 days in summer',
          'Stop irrigation 30 days before harvest',
          'Total water requirement: 180-200 cm/season'
        ],
        '🧪 Fertilization': [
          'Basal: 2 bags DAP + 1 bag SOP/acre',
          'Top dressing: 3 bags Urea in 3 splits',
          'First split: 30 days after planting',
          'Second split: 60 days after planting',
          'Third split: 90 days after planting'
        ],
        '🐛 Pest Control': [
          'For borers: Furadan @ 10 kg/acre at planting',
          'For termites: Chlorpyrifos @ 2 L/acre',
          'For red rot: Use resistant varieties',
          'Remove and destroy infected plants',
          'Practice crop rotation with legumes'
        ],
        '📊 Yield Optimization': [
          'Target yield: 700-800 maunds/acre',
          'Harvest when canes mature (12-18 months)',
          'Cut close to ground level',
          'Mill within 24 hours of harvest',
          'Ratoon management for 2-3 cycles'
        ]
      }
  ),
  Crop(
      nameEn: 'Rice',
      nameUr: 'چاول',
      imagePath: 'assets/images/rice.png',
      description: 'Rice needs standing water for most of its growing period. The Kharif season is the best time for cultivation.',
      recommendations: {
        '🌱 Planting': [
          'Transplant seedlings 20-25 days old',
          'Optimal spacing: 20 x 15 cm',
          'Plant 2-3 seedlings per hill',
          'Transplant in puddled soil',
          'Best time: June-July for Kharif season'
        ],
        '💧 Irrigation': [
          'Maintain 2-5 cm standing water',
          'Drain field 15 days before harvest',
          'Critical stages: Tillering and flowering',
          'Avoid water stress during panicle initiation',
          'Total water requirement: 100-150 cm'
        ],
        '🧪 Fertilization': [
          'Basal: 1.5 bags DAP/acre',
          'First top dressing: 1 bag Urea at tillering',
          'Second top dressing: 0.5 bag Urea at panicle initiation',
          'Apply Zinc sulfate @ 10 kg/acre if needed',
          'Silicon application improves stem strength'
        ],
        '🐛 Pest Control': [
          'For stem borer: Cartap hydrochloride @ 500g/acre',
          'For leaf folder: Fipronil @ 200 ml/acre',
          'For blast disease: Tricyclazole @ 300g/acre',
          'Use light traps for moth monitoring',
          'Practice clean cultivation'
        ],
        '📊 Yield Optimization': [
          'Target yield: 30-40 maunds/acre',
          'Harvest when 80% grains turn golden yellow',
          'Thresh within 2-3 days of harvest',
          'Dry to 14% moisture content',
          'Store in aerated containers'
        ]
      }
  ),
  Crop(
      nameEn: 'Cotton',
      nameUr: 'کپاس',
      imagePath: 'assets/images/cotton.png',
      description: 'Cotton thrives in dry, warm climates and needs plenty of sunshine. Proper pest management is key.',
      recommendations: {
        '🌱 Planting': [
          'Sow from April to May',
          'Seed rate: 4-5 kg/acre for Bt cotton',
          'Row spacing: 75-90 cm',
          'Plant-to-plant distance: 30-45 cm',
          'Treat seeds with fungicide before sowing'
        ],
        '💧 Irrigation': [
          'First irrigation: 30-35 days after sowing',
          'Critical stage: Flowering and boll formation',
          'Irrigation interval: 12-15 days',
          'Stop irrigation 90-100 days after sowing',
          'Avoid waterlogging'
        ],
        '🧪 Fertilization': [
          'Basal: 2 bags DAP + 1 bag SOP/acre',
          'Top dressing: 2 bags Urea in 2 splits',
          'First split: 30 days after sowing',
          'Second split: 60 days after sowing',
          'Apply boron @ 1 kg/acre during flowering'
        ],
        '🐛 Pest Control': [
          'For bollworms: Emamectin benzoate @ 150 ml/acre',
          'For whitefly: Acetamiprid @ 80g/acre',
          'For mealybug: Chlorpyrifos @ 1.5 L/acre',
          'Monitor with pheromone traps',
          'Practice crop rotation'
        ],
        '📊 Yield Optimization': [
          'Target yield: 25-30 maunds/acre',
          'Harvest in 3-4 pickings',
          'Pick when bolls fully open',
          'Dry in shade to maintain fiber quality',
          'Store in dry place'
        ]
      }
  ),
  Crop(
      nameEn: 'Maize',
      nameUr: 'مکئی',
      imagePath: 'assets/images/maize.png',
      description: 'Maize is versatile and requires moderate temperatures. It is often grown as a Kharif crop.',
      recommendations: {
        '🌱 Planting': [
          'Sow from June to July for Kharif',
          'Seed rate: 8-10 kg/acre',
          'Row spacing: 60-75 cm',
          'Plant-to-plant: 20-25 cm',
          'Sow at depth of 5-7 cm'
        ],
        '💧 Irrigation': [
          'Critical stages: Knee-high and tasseling',
          'Irrigation every 10-12 days in summer',
          'Avoid water stress during pollination',
          'Last irrigation 15 days before harvest',
          'Total water: 50-60 cm'
        ],
        '🧪 Fertilization': [
          'Basal: 2 bags DAP + 1 bag SOP/acre',
          'Top dressing: 2 bags Urea in 2 splits',
          'First split: 25-30 days after sowing',
          'Second split: 45-50 days after sowing',
          'Apply Zinc @ 10 kg/acre if deficient'
        ],
        '🐛 Pest Control': [
          'For stem borer: Carbofuran @ 10 kg/acre',
          'For fall armyworm: Spinetoram @ 100 ml/acre',
          'For downy mildew: Metalaxyl @ 2g/kg seed',
          'Use bird perches for pest control',
          'Remove infected plants'
        ],
        '📊 Yield Optimization': [
          'Target yield: 40-50 maunds/acre',
          'Harvest when grains harden',
          'Harvest at 20-25% moisture',
          'Dry to 14% moisture for storage',
          'Store in well-ventilated bins'
        ]
      }
  ),
  Crop(
      nameEn: 'Mango',
      nameUr: 'آم',
      imagePath: 'assets/images/mango.png',
      description: 'Mango is a tropical fruit tree. It requires careful pruning and protection from frost during flowering.',
      recommendations: {
        '🌱 Planting': [
          'Plant in July-August or February-March',
          'Spacing: 10 x 10 meters',
          'Dig pits of 1 x 1 x 1 meter',
          'Mix soil with 30-40 kg FYM per pit',
          'Graft preferred varieties (Sindhri, Anwar Ratol)'
        ],
        '💧 Irrigation': [
          'Young plants: Irrigate every 3-4 days',
          'Mature trees: Irrigate every 10-15 days',
          'Critical stage: Fruit setting and development',
          'Stop irrigation 15 days before harvest',
          'Use basin or drip irrigation'
        ],
        '🧪 Fertilization': [
          'Young trees: 10-20 kg FYM + 250g NPK/year',
          'Mature trees: 50-100 kg FYM + 1-2 kg NPK/year',
          'Apply after harvest (June-July)',
          'Apply before flowering (December-January)',
          'Foliar spray of micronutrients during flowering'
        ],
        '🐛 Pest Control': [
          'For fruit fly: Bait spray (Malathion + jaggery)',
          'For mango hopper: Imidacloprid @ 50 ml/acre',
          'For anthracnose: Copper oxychloride @ 500g/acre',
          'Bag fruits for protection',
          'Maintain orchard sanitation'
        ],
        '📊 Yield Optimization': [
          'Target yield: 100-200 kg/tree (mature)',
          'Harvest when fruits develop shoulder',
          'Harvest in morning hours',
          'Handle fruits carefully to avoid damage',
          'Pack in ventilated boxes'
        ]
      }
  ),
  Crop(
      nameEn: 'Potato',
      nameUr: 'آلو',
      imagePath: 'assets/images/potato.png',
      description: 'Potato is a cool-season crop grown in winter. Proper soil preparation and seed treatment are crucial.',
      recommendations: {
        '🌱 Planting': [
          'Plant from October to November',
          'Use disease-free certified tubers',
          'Seed rate: 800-1000 kg/acre',
          'Row spacing: 60 cm',
          'Plant spacing: 20-25 cm',
          'Plant at depth of 5-7 cm'
        ],
        '💧 Irrigation': [
          'First irrigation: Immediately after planting',
          'Critical stage: Tuber initiation and bulking',
          'Irrigation every 7-10 days',
          'Stop irrigation 15-20 days before harvest',
          'Avoid waterlogging'
        ],
        '🧪 Fertilization': [
          'Basal: 3 bags DAP + 2 bags SOP/acre',
          'Top dressing: 2 bags Urea in 2 splits',
          'First split: 25-30 days after planting',
          'Second split: 45-50 days after planting',
          'Apply boron @ 1 kg/acre if needed'
        ],
        '🐛 Pest Control': [
          'For cutworm: Chlorpyrifos @ 2 L/acre in soil',
          'For aphids: Imidacloprid @ 50 ml/acre',
          'For late blight: Mancozeb @ 500g/acre',
          'Use resistant varieties',
          'Practice crop rotation with cereals'
        ],
        '📊 Yield Optimization': [
          'Target yield: 200-250 maunds/acre',
          'Harvest when vines dry',
          'Harvest in cool weather',
          'Cure tubers for 10-15 days before storage',
          'Store at 4-5°C with high humidity'
        ]
      }
  ),
  Crop(
      nameEn: 'Chilli',
      nameUr: 'مرچ',
      imagePath: 'assets/images/chilli.png',
      description: 'Chilli is a warm-season crop sensitive to frost. Requires well-drained soil and careful water management.',
      recommendations: {
        '🌱 Planting': [
          'Transplant 30-35 day old seedlings',
          'Spacing: 45 x 30 cm',
          'Plant 2 seedlings per hill',
          'Best time: February-March for spring crop',
          'Raised beds for better drainage'
        ],
        '💧 Irrigation': [
          'Light irrigation after transplanting',
          'Irrigation every 5-7 days in summer',
          'Critical stage: Flowering and fruit set',
          'Avoid overhead irrigation to prevent disease',
          'Drip irrigation recommended'
        ],
        '🧪 Fertilization': [
          'Basal: 2 bags DAP + 1 bag SOP/acre',
          'Top dressing: 1.5 bags Urea in 3 splits',
          'First split: 30 days after transplanting',
          'Second split: 60 days after transplanting',
          'Third split: During fruit set'
        ],
        '🐛 Pest Control': [
          'For thrips: Spinosad @ 100 ml/acre',
          'For mites: Abamectin @ 100 ml/acre',
          'For fruit rot: Carbendazim @ 250g/acre',
          'Use yellow sticky traps',
          'Remove infected plants immediately'
        ],
        '📊 Yield Optimization': [
          'Target yield: 40-50 maunds/acre (dry)',
          'Harvest when fruits turn red',
          'Pick regularly to encourage more fruiting',
          'Dry in shade to retain color and pungency',
          'Store in airtight containers'
        ]
      }
  ),
];

// ---------------------------------------------------------------------------
// CROP DETAIL SCREEN
// ---------------------------------------------------------------------------
class CropDetailScreen extends StatelessWidget {
  final Crop crop;

  const CropDetailScreen({Key? key, required this.crop}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          crop.nameEn,
          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Crop Image and Basic Info - FIXED VERSION
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Image Container with consistent styling
                  Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xFFF0F7F0),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        crop.imagePath,
                        fit: BoxFit.cover, // Changed from contain to cover
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[200],
                            child: const Center(
                              child: Icon(
                                Icons.agriculture,
                                size: 60,
                                color: Colors.grey,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Crop Name
                  Text(
                    '${crop.nameEn} (${crop.nameUr})',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  // Description
                  Text(
                    crop.description,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Recommendations
            for (var entry in crop.recommendations.entries)
              _buildRecommendationSection(entry.key, entry.value),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildRecommendationSection(String title, List<String> items) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          const Divider(height: 0),
          ...items.map((item) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 4, right: 12),
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(
                    color: Color(0xFF4CAF50),
                    shape: BoxShape.circle,
                  ),
                ),
                Expanded(
                  child: Text(
                    item,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.black87,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          )).toList(),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// MAIN SCREEN: CropGuideScreen
// ---------------------------------------------------------------------------
class CropGuideScreen extends StatefulWidget {
  const CropGuideScreen({super.key});

  @override
  State<CropGuideScreen> createState() => _CropGuideScreenState();
}

class _CropGuideScreenState extends State<CropGuideScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Crop> _userCrops = [];
  List<Crop> _allOtherCrops = [];
  bool _isLoading = true;
  int _bottomNavIndex = 2;

  // Store user data for navigation
  String _userLocation = '';
  String _userName = '';
  List<String> _selectedCrops = ['Wheat'];
  String _primaryCrop = 'Wheat';

  // For search filtering
  List<Crop> _filteredUserCrops = [];
  List<Crop> _filteredOtherCrops = [];
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _loadUserData();
    _searchController.addListener(_filterCrops);
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterCrops);
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadUserData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final doc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        if (doc.exists) {
          final userData = doc.data() as Map<String, dynamic>;
          setState(() {
            _userLocation = userData['location'] ?? '';
            _userName = userData['name'] ?? '';
            _selectedCrops = List<String>.from(userData['selectedCrops'] ?? ['Wheat']);
            _primaryCrop = userData['primaryCrop'] ?? 'Wheat';
          });
        }

        // Get selected crops from database
        final selectedCropNames = await _getUserCropsFromFirebase(user.uid);

        _userCrops = allAvailableCrops
            .where((crop) => selectedCropNames.contains(crop.nameEn))
            .toList();

        _allOtherCrops = allAvailableCrops
            .where((crop) => !selectedCropNames.contains(crop.nameEn))
            .toList();

        _filteredUserCrops = _userCrops;
        _filteredOtherCrops = _allOtherCrops;
      }
    } catch (e) {
      print('Error loading crops: $e');
      _userCrops = [];
      _allOtherCrops = allAvailableCrops;
      _filteredUserCrops = [];
      _filteredOtherCrops = allAvailableCrops;
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<List<String>> _getUserCropsFromFirebase(String userId) async {
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      if (userDoc.exists) {
        final data = userDoc.data() as Map<String, dynamic>?;

        if (data != null && data.containsKey('selectedCrops')) {
          final crops = data['selectedCrops'];

          if (crops is List) {
            return List<String>.from(crops.map((item) {
              if (item == null) return '';
              return item.toString().trim();
            })).where((item) => item.isNotEmpty).toList();
          }
        }
        return [];
      } else {
        return [];
      }
    } catch (e) {
      print('Error fetching crops: $e');
      return [];
    }
  }

  void _filterCrops() {
    final query = _searchController.text.toLowerCase().trim();
    setState(() {
      _isSearching = query.isNotEmpty;

      if (_isSearching) {
        // Search in both user crops and other crops
        _filteredUserCrops = _userCrops
            .where((crop) =>
        crop.nameEn.toLowerCase().contains(query) ||
            crop.nameUr.toLowerCase().contains(query))
            .toList();

        _filteredOtherCrops = _allOtherCrops
            .where((crop) =>
        crop.nameEn.toLowerCase().contains(query) ||
            crop.nameUr.toLowerCase().contains(query))
            .toList();
      } else {
        _filteredUserCrops = _userCrops;
        _filteredOtherCrops = _allOtherCrops;
      }
    });
  }

  // Navigation Methods
  void _navigateToHome(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => HomeScreen(
          userLocation: _userLocation,
          userName: _userName,
          selectedCrops: _selectedCrops,
          primaryCrop: _primaryCrop,
        ),
      ),
          (route) => false,
    );
  }

  void _navigateToWeatherScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WeatherScreen(
          weatherData: {},
          cityName: _userLocation,
        ),
      ),
    ).then((_) {
      if (mounted) {
        setState(() {
          _bottomNavIndex = 2;
        });
      }
    });
  }

  void _navigateToMarketplace(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MarketplaceScreen(
          userLocation: _userLocation,
          userName: _userName,
        ),
      ),
    ).then((_) {
      if (mounted) {
        setState(() {
          _bottomNavIndex = 2;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          "Crop Guide",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      ),
      body: Column(
        children: [
          // Fixed Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 12.0,
            ),
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                controller: _searchController,
                onChanged: (_) => _filterCrops(),
                decoration: InputDecoration(
                  hintText: "Search crops...",
                  hintStyle: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                  prefixIcon: const Padding(
                    padding: EdgeInsets.only(left: 16.0, right: 8.0),
                    child: Icon(Icons.search, color: Color(0xFF4CAF50), size: 20),
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                    icon: const Icon(Icons.clear, size: 18, color: Colors.grey),
                    onPressed: () {
                      _searchController.clear();
                      _filterCrops();
                    },
                    padding: const EdgeInsets.only(right: 8),
                  )
                      : null,
                ),
              ),
            ),
          ),

          // Content
          Expanded(
            child: _isLoading
                ? const Center(
              child: CircularProgressIndicator(color: Color(0xFF2E7D32)),
            )
                : SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (_isSearching)
                    _buildSearchResults()
                  else
                    _buildNormalView(),
                  const SizedBox(height: 20),
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
          setState(() {
            _bottomNavIndex = index;
          });

          switch (index) {
            case 0: // Home
              _navigateToHome(context);
              break;
            case 1: // Weather
              _navigateToWeatherScreen(context);
              break;
            case 2: // Crop Guide
            // Already on crop guide
              break;
            case 3: // Marketplace
              _navigateToMarketplace(context);
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
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
    );
  }

  Widget _buildNormalView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Your Crops Section
        if (_filteredUserCrops.isNotEmpty)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              const Text(
                'Your Crops',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 15),
              _buildCropGrid(_filteredUserCrops, true),
              const SizedBox(height: 25),
            ],
          ),

        // All Other Crops Section
        const Text(
          'All Other Crops',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 15),
        _buildCropGrid(_filteredOtherCrops, false),
      ],
    );
  }

  Widget _buildSearchResults() {
    final allSearchResults = [..._filteredUserCrops, ..._filteredOtherCrops];

    if (allSearchResults.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(40),
        child: const Column(
          children: [
            Icon(
              Icons.search_off,
              size: 60,
              color: Colors.grey,
            ),
            SizedBox(height: 16),
            Text(
              'No crops found',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Search Results (${allSearchResults.length})',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 15),
        _buildCropGrid(allSearchResults, false),
      ],
    );
  }

  Widget _buildCropGrid(List<Crop> crops, bool isUserCropSection) {
    if (crops.isEmpty && isUserCropSection) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 30.0),
        child: Center(
          child: Text(
            'You have not selected any crops yet.',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ),
      );
    }

    if (crops.isEmpty && !isUserCropSection) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 30.0),
        child: Center(
          child: Text(
            'You have selected all available crops!',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ),
      );
    }

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.85,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
      ),
      itemCount: crops.length,
      itemBuilder: (context, index) {
        final crop = crops[index];
        final isUserCrop = _userCrops.contains(crop);
        return _buildCropCard(crop, isUserCrop);
      },
    );
  }

  Widget _buildCropCard(Crop crop, bool isUserCrop) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CropDetailScreen(crop: crop),
              ),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Image Section with fixed height
              Container(
                height: 120,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                  color: const Color(0xFFF0F7F0),
                ),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                        ),
                        child: Image.asset(
                          crop.imagePath,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.grey[200],
                              child: const Center(
                                child: Icon(
                                  Icons.agriculture,
                                  color: Colors.grey,
                                  size: 40,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    if (isUserCrop)
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE8F5E9),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            'Your Crop',
                            style: TextStyle(
                              color: Color(0xFF4CAF50),
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),

              // Text Section with proper constraints
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        crop.nameEn,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        crop.nameUr,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}