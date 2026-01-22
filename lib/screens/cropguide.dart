import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kissan_connect_app_2/l10n/app_localizations.dart';
import 'HomeScreen.dart';
import 'WeatherScreen.dart';
import 'MarketplaceScreen.dart';

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

List<Crop> allAvailableCrops(BuildContext context) {
  final loc = AppLocalizations.of(context)!;
  return [
    Crop(
      nameEn: 'Wheat',
      nameUr: 'گندم',
      imagePath: 'assets/images/wheat.png',
      description: loc.wheat_summary,
      recommendations: {
        loc.wheat_p_title: [
          loc.wheat_p1,
          loc.wheat_p2,
          loc.wheat_p3,
          loc.wheat_p4,
          loc.wheat_p5,
        ],
        loc.wheat_i_title: [
          loc.wheat_i1,
          loc.wheat_i2,
          loc.wheat_i3,
          loc.wheat_i4,
          loc.wheat_i5,
        ],
        loc.wheat_f_title: [
          loc.wheat_f1,
          loc.wheat_f2,
          loc.wheat_f3,
          loc.wheat_f4,
          loc.wheat_f5,
        ],
        loc.wheat_pc_title: [
          loc.wheat_pc1,
          loc.wheat_pc2,
          loc.wheat_pc3,
          loc.wheat_pc4,
          loc.wheat_pc5,
        ],
        loc.wheat_y_title: [
          loc.wheat_y1,
          loc.wheat_y2,
          loc.wheat_y3,
          loc.wheat_y4,
          loc.wheat_y5,
        ],
      },
    ),
    Crop(
      nameEn: 'Sugarcane',
      nameUr: 'گنا',
      imagePath: 'assets/images/sugarcane.png',
      description: loc.sugar_summary,
      recommendations: {
        loc.sugar_p_title: [
          loc.sugar_p1,
          loc.sugar_p2,
          loc.sugar_p3,
          loc.sugar_p4,
          loc.sugar_p5,
        ],
        loc.sugar_i_title: [
          loc.sugar_i1,
          loc.sugar_i2,
          loc.sugar_i3,
          loc.sugar_i4,
          loc.sugar_i5,
        ],
        loc.sugar_f_title: [
          loc.sugar_f1,
          loc.sugar_f2,
          loc.sugar_f3,
          loc.sugar_f4,
          loc.sugar_f5,
        ],
        loc.sugar_pc_title: [
          loc.sugar_pc1,
          loc.sugar_pc2,
          loc.sugar_pc3,
          loc.sugar_pc4,
          loc.sugar_pc5,
        ],
        loc.sugar_y_title: [loc.sugar_p5],
        loc.sugar_i_title: [
          loc.sugar_i1,
          loc.sugar_i2,
          loc.sugar_i3,
          loc.sugar_i4,
          loc.sugar_i5,
        ],
        loc.sugar_f_title: [
          loc.sugar_f1,
          loc.sugar_f2,
          loc.sugar_f3,
          loc.sugar_f4,
          loc.sugar_f5,
        ],
        loc.sugar_pc_title: [
          loc.sugar_pc1,
          loc.sugar_pc2,
          loc.sugar_pc3,
          loc.sugar_pc4,
          loc.sugar_pc5,
        ],

        loc.sugar_y_title: [
          loc.sugar_y1,
          loc.sugar_y2,
          loc.sugar_y3,
          loc.sugar_y4,
          loc.sugar_y5,
        ],
      },
    ),
    Crop(
      nameEn: 'Rice',
      nameUr: 'چاول',
      imagePath: 'assets/images/rice.png',
      description: loc.rice_summary,
      recommendations: {
        loc.rice_p_title: [
          loc.rice_p1,
          loc.rice_p2,
          loc.rice_p3,
          loc.rice_p4,
          loc.rice_p5,
        ],
        loc.rice_i_title: [
          loc.rice_i1,
          loc.rice_i2,
          loc.rice_i3,
          loc.rice_i4,
          loc.rice_i5,
        ],

        loc.rice_f_title: [
          loc.rice_f1,
          loc.rice_f2,
          loc.rice_f3,
          loc.rice_f4,
          loc.rice_f5,
        ],

        loc.rice_pc_title: [
          loc.rice_pc1,
          loc.rice_pc2,
          loc.rice_pc3,
          loc.rice_pc4,
          loc.rice_pc5,
        ],

        loc.rice_y_title: [
          loc.rice_y1,
          loc.rice_y2,
          loc.rice_y3,
          loc.rice_y4,
          loc.rice_y5,
        ],
      },
    ),
    Crop(
      nameEn: 'Cotton',
      nameUr: 'کپاس',
      imagePath: 'assets/images/cotton.png',
      description: loc.cotton_summary,
      recommendations: {
        loc.cotton_p_title: [
          loc.cotton_p1,
          loc.cotton_p2,
          loc.cotton_p3,
          loc.cotton_p4,
          loc.cotton_p5,
        ],
        loc.cotton_i_title: [
          loc.cotton_i1,
          loc.cotton_i2,
          loc.cotton_i3,
          loc.cotton_i4,
          loc.cotton_i5,
        ],
        loc.cotton_f_title: [
          loc.cotton_f1,
          loc.cotton_f2,
          loc.cotton_f3,
          loc.cotton_f4,
          loc.cotton_f5,
        ],
        loc.cotton_pc_title: [
          loc.cotton_pc1,
          loc.cotton_pc2,
          loc.cotton_pc3,
          loc.cotton_pc4,
          loc.cotton_pc5,
        ],
        loc.cotton_y_title: [
          loc.cotton_y1,
          loc.cotton_y2,
          loc.cotton_y3,
          loc.cotton_y4,
          loc.cotton_y5,
        ],

        loc.cotton_p_title: [
          loc.cotton_p1,
          loc.cotton_p2,
          loc.cotton_p3,
          loc.cotton_p4,
          loc.cotton_p5,
        ],
        loc.cotton_i_title: [
          loc.cotton_i1,
          loc.cotton_i2,
          loc.cotton_i3,
          loc.cotton_i4,
          loc.cotton_i5,
        ],
        loc.cotton_f_title: [
          loc.cotton_f1,
          loc.cotton_f2,
          loc.cotton_f3,
          loc.cotton_f4,
          loc.cotton_f5,
        ],
        loc.cotton_pc_title: [
          loc.cotton_pc1,
          loc.cotton_pc2,
          loc.cotton_pc3,
          loc.cotton_pc4,
          loc.cotton_pc5,
        ],
        loc.cotton_y_title: [
          loc.cotton_y1,
          loc.cotton_y2,
          loc.cotton_y3,
          loc.cotton_y4,
          loc.cotton_y5,
        ],
      },
    ),
    Crop(
      nameEn: 'Maize',
      nameUr: 'مکئی',
      imagePath: 'assets/images/maize.png',
      description: loc.maize_summary,
      recommendations: {
        loc.maize_p_title: [
          loc.maize_p1,
          loc.maize_p2,
          loc.maize_p3,
          loc.maize_p4,
          loc.maize_p5,
        ],
        loc.maize_i_title: [
          loc.maize_i1,
          loc.maize_i2,
          loc.maize_i3,
          loc.maize_i4,
          loc.maize_i5,
        ],
        loc.maize_f_title: [
          loc.maize_f1,
          loc.maize_f2,
          loc.maize_f3,
          loc.maize_f4,
          loc.maize_f5,
        ],
        loc.maize_pc_title: [
          loc.maize_pc1,
          loc.maize_pc2,
          loc.maize_pc3,
          loc.maize_pc4,
          loc.maize_pc5,
        ],
      },
    ),
    Crop(
      nameEn: 'Mango',
      nameUr: 'آم',
      imagePath: 'assets/images/mango.png',
      description: loc.mango_summary,
      recommendations: {
        loc.mango_p_title: [
          loc.mango_p1,
          loc.mango_p2,
          loc.mango_p3,
          loc.mango_p4,
          loc.mango_p5,
        ],
        loc.mango_i_title: [
          loc.mango_i1,
          loc.mango_i2,
          loc.mango_i3,
          loc.mango_i4,
          loc.mango_i5,
        ],
        loc.mango_f_title: [
          loc.mango_f1,
          loc.mango_f2,
          loc.mango_f3,
          loc.mango_f4,
          loc.mango_f5,
        ],
        loc.mango_pc_title: [
          loc.mango_pc1,
          loc.mango_pc2,
          loc.mango_pc3,
          loc.mango_pc4,
          loc.mango_pc5,
        ],
        loc.mango_y_title: [
          loc.mango_y1,
          loc.mango_y2,
          loc.mango_y3,
          loc.mango_y4,
          loc.mango_y5,
        ],
      },
    ),
    Crop(
      nameEn: 'Potato',
      nameUr: 'آلو',
      imagePath: 'assets/images/potato.png',
      description: loc.potato_summary,
      recommendations: {
        loc.potato_p_title: [
          loc.potato_p1,
          loc.potato_p2,
          loc.potato_p3,
          loc.potato_p4,
          loc.potato_p5,
          loc.potato_p6,
        ],
        loc.potato_i_title: [
          loc.potato_i1,
          loc.potato_i2,
          loc.potato_i3,
          loc.potato_i4,
          loc.potato_i5,
        ],
        loc.potato_f_title: [
          loc.potato_f1,
          loc.potato_f2,
          loc.potato_f3,
          loc.potato_f4,
          loc.potato_f5,
        ],
        loc.potato_pc_title: [
          loc.potato_pc1,
          loc.potato_pc2,
          loc.potato_pc3,
          loc.potato_pc4,
          loc.potato_pc5,
        ],

        loc.potato_y_title: [
          loc.potato_y1,
          loc.potato_y2,
          loc.potato_y3,
          loc.potato_y4,
          loc.potato_y5,
        ],
      },
    ),
    Crop(
      nameEn: 'Chilli',
      nameUr: 'مرچ',
      imagePath: 'assets/images/chilli.png',
      description: loc.chilli_summary,
      recommendations: {
        loc.chilli_summary: [
          loc.chilli_p1,
          loc.chilli_p2,
          loc.chilli_p3,
          loc.chilli_p4,
          loc.chilli_p5,
        ],
        loc.chilli_i1: [
          loc.chilli_i1,
          loc.chilli_i2,
          loc.chilli_i3,
          loc.chilli_i4,
          loc.chilli_i5,
        ],
        loc.chilli_f1: [
          loc.chilli_f1,
          loc.chilli_f2,
          loc.chilli_f3,
          loc.chilli_f4,
          loc.chilli_f5,
        ],
        loc.chilli_pc_title: [
          loc.chilli_pc1,
          loc.chilli_pc2,
          loc.chilli_pc3,
          loc.chilli_pc4,
          loc.chilli_pc5,
        ],
        loc.chilli_y_title: [
          loc.chilli_y1,
          loc.chilli_y2,
          loc.chilli_y3,
          loc.chilli_y4,
          loc.chilli_y5,
        ],
      },
    ),
  ];
}

class CropDetailScreen extends StatelessWidget {
  final Crop crop;

  const CropDetailScreen({super.key, required this.crop});

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
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
          ...items
              .map(
                (item) => Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
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
                ),
              )
              .toList(),
        ],
      ),
    );
  }
}

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
  String _userLocation = '';
  String _userName = '';
  List<String> _selectedCrops = ['Wheat'];
  String _primaryCrop = 'Wheat';
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
            _selectedCrops = List<String>.from(
              userData['selectedCrops'] ?? ['Wheat'],
            );
            _primaryCrop =
                userData['primaryCrop'] ?? AppLocalizations.of(context)!.wheat;
          });
        }

        // Get selected crops from database
        final selectedCropNames = await _getUserCropsFromFirebase(user.uid);

        _userCrops = allAvailableCrops(
          context,
        ).where((crop) => selectedCropNames.contains(crop.nameEn)).toList();

        _allOtherCrops = allAvailableCrops(
          context,
        ).where((crop) => !selectedCropNames.contains(crop.nameEn)).toList();

        _filteredUserCrops = _userCrops;
        _filteredOtherCrops = _allOtherCrops;
      }
    } catch (e) {
      print('${AppLocalizations.of(context)!.errorLoadingCrops} $e');
      _userCrops = [];
      _allOtherCrops = allAvailableCrops(context);
      _filteredUserCrops = [];
      _filteredOtherCrops = allAvailableCrops(context);
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
            return List<String>.from(
              crops.map((item) {
                if (item == null) return '';
                return item.toString().trim();
              }),
            ).where((item) => item.isNotEmpty).toList();
          }
        }
        return [];
      } else {
        return [];
      }
    } catch (e) {
      print('${AppLocalizations.of(context)!.errorFetchingCrops} $e');
      return [];
    }
  }

  void _filterCrops() {
    final query = _searchController.text.toLowerCase().trim();
    setState(() {
      _isSearching = query.isNotEmpty;

      if (_isSearching) {
        _filteredUserCrops = _userCrops
            .where(
              (crop) =>
                  crop.nameEn.toLowerCase().contains(query) ||
                  crop.nameUr.toLowerCase().contains(query),
            )
            .toList();

        _filteredOtherCrops = _allOtherCrops
            .where(
              (crop) =>
                  crop.nameEn.toLowerCase().contains(query) ||
                  crop.nameUr.toLowerCase().contains(query),
            )
            .toList();
      } else {
        _filteredUserCrops = _userCrops;
        _filteredOtherCrops = _allOtherCrops;
      }
    });
  }

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
        builder: (context) =>
            WeatherScreen(weatherData: {}, cityName: _userLocation),
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
        builder: (context) =>
            MarketplaceScreen(userLocation: _userLocation, userName: _userName),
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
        title: Text(
          AppLocalizations.of(context)!.crop_guide,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      ),
      body: Column(
        children: [
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
                  hintText: AppLocalizations.of(context)!.searchHint,
                  hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
                  prefixIcon: const Padding(
                    padding: EdgeInsets.only(left: 16.0, right: 8.0),
                    child: Icon(
                      Icons.search,
                      color: Color(0xFF4CAF50),
                      size: 20,
                    ),
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(
                            Icons.clear,
                            size: 18,
                            color: Colors.grey,
                          ),
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
          Expanded(
            child: _isLoading
                ? const Center(
                    child: CircularProgressIndicator(color: Color(0xFF2E7D32)),
                  )
                : SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
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
              Text(
                AppLocalizations.of(context)!.yourCrops,
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
        Text(
          AppLocalizations.of(context)!.allOtherCrops,
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
        child: Column(
          children: [
            Icon(Icons.search_off, size: 60, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              AppLocalizations.of(context)!.noCropsFound,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${AppLocalizations.of(context)!.searchResults} (${allSearchResults.length})',
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
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 30.0),
        child: Center(
          child: Text(
            AppLocalizations.of(context)!.noCropsSelected,
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ),
      );
    }

    if (crops.isEmpty && !isUserCropSection) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 30.0),
        child: Center(
          child: Text(
            AppLocalizations.of(context)!.allOtherCrops,
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
                          child: Text(
                            AppLocalizations.of(context)!.yourCrops,
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
              Padding(
                padding: const EdgeInsets.all(5),
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
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
