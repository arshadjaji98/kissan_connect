// lib/screens/MarketplaceScreen.dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../helpers/firebase_helper.dart';
import 'CreateListingScreen.dart';
import 'ListingDetailsScreen.dart';
import 'HomeScreen.dart';
import 'WeatherScreen.dart';
import 'cropguide.dart';
import 'ActiveAdScreen.dart'; // Import the ActiveAdScreen

class MarketplaceScreen extends StatefulWidget {
  final String userLocation;
  final String userName;

  const MarketplaceScreen({
    super.key,
    required this.userLocation,
    required this.userName,
  });

  @override
  State<MarketplaceScreen> createState() => _MarketplaceScreenState();
}

class _MarketplaceScreenState extends State<MarketplaceScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _isLoading = false;
  int _bottomNavIndex = 3;
  String _searchQuery = '';

  // Store user data for navigation
  late String _userLocation;
  late String _userName;
  List<String> _selectedCrops = ['Wheat'];
  String _primaryCrop = 'Wheat';

  @override
  void initState() {
    super.initState();
    _userLocation = widget.userLocation;
    _userName = widget.userName;
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        final doc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        if (doc.exists) {
          final userData = doc.data() as Map<String, dynamic>;
          setState(() {
            _userLocation = userData['location'] ?? widget.userLocation;
            _userName = userData['name'] ?? widget.userName;
            _selectedCrops = List<String>.from(userData['selectedCrops'] ?? ['Wheat']);
            _primaryCrop = userData['primaryCrop'] ?? 'Wheat';
          });
        }
      } catch (e) {
        print('Error loading user data: $e');
      }
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
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
        builder: (context) => WeatherScreen(
          weatherData: {},
          cityName: _userLocation,
        ),
      ),
    ).then((_) {
      if (mounted) {
        setState(() {
          _bottomNavIndex = 3;
        });
      }
    });
  }

  void _navigateToCropGuide(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CropGuideScreen(),
      ),
    ).then((_) {
      if (mounted) {
        setState(() {
          _bottomNavIndex = 3;
        });
      }
    });
  }

  void _navigateToActiveAds(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ActiveAdScreen(
          userName: _userName,
          userLocation: _userLocation,
        ),
      ),
    ).then((_) {
      if (mounted) {
        setState(() {
          _bottomNavIndex = 3;
        });
      }
    });
  }

  void _filterListings(String query) {
    setState(() {
      _searchQuery = query;
    });
  }

  void _clearSearch() {
    _searchController.clear();
    _filterListings('');
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
          "Marketplace",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        // Settings button removed from here
      ),
      body: Column(
        children: [
          // Search Bar
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
                onChanged: _filterListings,
                decoration: InputDecoration(
                  hintText: "Search crops, sellers, locations...",
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
                  suffixIcon: _searchQuery.isNotEmpty
                      ? IconButton(
                    icon: const Icon(Icons.clear, size: 18, color: Colors.grey),
                    onPressed: _clearSearch,
                    padding: const EdgeInsets.only(right: 8),
                  )
                      : null,
                ),
              ),
            ),
          ),

          // Listings Grid
          Expanded(
            child: _searchQuery.isEmpty
                ? _buildListingsStream()
                : _buildSearchResults(),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // White semi-transparent button for Active Ads
          Container(
            margin: const EdgeInsets.only(bottom: 16),
            child: FloatingActionButton(
              onPressed: () {
                _navigateToActiveAds(context);
              },
              backgroundColor: Colors.white.withOpacity(0.9),
              foregroundColor: const Color(0xFF2E7D32),
              elevation: 4,
              child: const Icon(Icons.list_alt, size: 26),
            ),
          ),
          // Green button for Create Listing
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CreateListingScreen(
                    userLocation: _userLocation,
                    userName: _userName,
                  ),
                ),
              );
            },
            backgroundColor: const Color(0xFF2E7D32),
            child: const Icon(Icons.add, size: 30, color: Colors.white),
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
            case 0:
              _navigateToHome(context);
              break;
            case 1:
              _navigateToWeatherScreen(context);
              break;
            case 2:
              _navigateToCropGuide(context);
              break;
            case 3:
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

  Widget _buildListingsStream() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseHelper.getActiveListingsStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(color: Color(0xFF2E7D32)),
          );
        }

        if (snapshot.hasError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error_outline,
                  size: 60,
                  color: Colors.red,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Error loading listings',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          );
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.inventory_2,
                  size: 60,
                  color: Colors.grey,
                ),
                const SizedBox(height: 16),
                const Text(
                  'No listings available',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CreateListingScreen(
                          userLocation: _userLocation,
                          userName: _userName,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2E7D32),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Create First Listing',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          );
        }

        final listings = snapshot.data!.docs;

        return GridView.builder(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.8,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: listings.length,
          itemBuilder: (context, index) => _buildCropCard(listings[index]),
        );
      },
    );
  }

  Widget _buildSearchResults() {
    return FutureBuilder<List<DocumentSnapshot>>(
      future: FirebaseHelper.searchListings(_searchQuery),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(color: Color(0xFF2E7D32)),
                SizedBox(height: 16),
                Text(
                  'Searching...',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          );
        }

        if (snapshot.hasError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error_outline,
                  size: 60,
                  color: Colors.red,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Search error',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: _clearSearch,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2E7D32),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Clear Search',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          );
        }

        final listings = snapshot.data ?? [];

        if (listings.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.search_off,
                  size: 60,
                  color: Colors.grey,
                ),
                const SizedBox(height: 16),
                Text(
                  'No results for "$_searchQuery"',
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: _clearSearch,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2E7D32),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Clear Search',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          );
        }

        return GridView.builder(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.8,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: listings.length,
          itemBuilder: (context, index) => _buildCropCard(listings[index]),
        );
      },
    );
  }

  Widget _buildCropCard(DocumentSnapshot listing) {
    final data = listing.data() as Map<String, dynamic>;
    final imageUrls = data['imageUrls'] as List<dynamic>? ?? [];
    final imageUrl = FirebaseHelper.getImageUrl(imageUrls);
    final cropName = data['cropName']?.toString() ?? 'Unknown Crop';
    final price = (data['price'] as num?)?.toDouble() ?? 0.0;
    final quantity = (data['quantity'] as num?)?.toDouble() ?? 0.0;
    final location = data['location']?.toString() ?? 'Unknown';
    final sellerName = data['sellerName']?.toString() ?? 'Unknown Seller';

    final priceFormatted = 'PKR ${price.toStringAsFixed(0)}/kg';
    final quantityFormatted = '${quantity.toStringAsFixed(0)} kg available';

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ListingDetailsScreen(
              listingId: listing.id,
              listingData: data,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                  color: Colors.grey[200],
                ),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                        child: Image.network(
                          imageUrl,
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                    (loadingProgress.expectedTotalBytes ?? 1)
                                    : null,
                                color: const Color(0xFF2E7D32),
                              ),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: const Color(0xFFE8F5E9),
                              child: const Center(
                                child: Icon(
                                  Icons.agriculture,
                                  color: Color(0xFF4CAF50),
                                  size: 40,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Details
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cropName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    priceFormatted,
                    style: const TextStyle(
                      color: Color(0xFF2E7D32),
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    quantityFormatted,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.location_on, size: 10, color: Colors.grey),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          location,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 10,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}