// lib/screens/ListingDetailsScreen.dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:kissan_connect_app_2/l10n/app_localizations.dart';
import '../helpers/firebase_helper.dart';

class ListingDetailsScreen extends StatefulWidget {
  final String listingId;
  final Map<String, dynamic> listingData;

  const ListingDetailsScreen({
    super.key,
    required this.listingId,
    required this.listingData,
  });

  @override
  State<ListingDetailsScreen> createState() => _ListingDetailsScreenState();
}

class _ListingDetailsScreenState extends State<ListingDetailsScreen> {
  int _currentImageIndex = 0;
  bool _isSaved = false;

  @override
  void initState() {
    super.initState();
    _checkIfSaved();
    _incrementViews();
  }

  Future<void> _checkIfSaved() async {
    try {
      final savedListings = await FirebaseHelper.getUserSavedListings();
      setState(() {
        _isSaved = savedListings.contains(widget.listingId);
      });
    } catch (e) {
      print('Error checking saved status: $e');
    }
  }

  Future<void> _incrementViews() async {
    try {
      await FirebaseHelper.incrementViews(widget.listingId);
    } catch (e) {
      print('Error incrementing views: $e');
    }
  }

  Future<void> _toggleSave() async {
    try {
      await FirebaseHelper.toggleSaveListing(widget.listingId, !_isSaved);
      setState(() {
        _isSaved = !_isSaved;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _isSaved
                ? AppLocalizations.of(context)!.listingSaved
                : AppLocalizations.of(context)!.listingRemoved,
          ),
          backgroundColor: _isSaved ? Colors.green : Colors.grey,
        ),
      );
    } catch (e) {
      print('Error toggling save: $e');
    }
  }

  void _showPhoneNumberDialog() {
    final loc = AppLocalizations.of(context)!;
    final phoneNumber = widget.listingData['phoneNumber'] ?? loc.notAvailable;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          loc.sellerPhoneNumber,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10),
            Text(
              phoneNumber,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Text(
              loc.contactSellerPrompt,
              style: TextStyle(fontSize: 14, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              loc.ok,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _nextImage() {
    final imageUrls = widget.listingData['imageUrls'] as List<dynamic>? ?? [];
    if (imageUrls.length > 1) {
      setState(() {
        _currentImageIndex = (_currentImageIndex + 1) % imageUrls.length;
      });
    }
  }

  void _previousImage() {
    final imageUrls = widget.listingData['imageUrls'] as List<dynamic>? ?? [];
    if (imageUrls.length > 1) {
      setState(() {
        _currentImageIndex =
            (_currentImageIndex - 1 + imageUrls.length) % imageUrls.length;
      });
    }
  }

  Widget _buildSpecRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 15)),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final imageUrls = widget.listingData['imageUrls'] as List<dynamic>? ?? [];
    final currentImageUrl = FirebaseHelper.getImageUrl(
      imageUrls,
      _currentImageIndex,
    );
    final cropName = widget.listingData['cropName'] ?? loc.unknownCrop;
    final price = widget.listingData['price'] ?? 0;
    final quantity = widget.listingData['quantity'] ?? 0;
    final description = widget.listingData['description'] ?? '';
    final sellerName = widget.listingData['sellerName'] ?? loc.unknownSeller;
    final location = widget.listingData['location'] ?? loc.unknownLocation;
    final variety = widget.listingData['variety'] ?? loc.notSpecified;
    final harvestDate = widget.listingData['harvestDate'] ?? loc.notSpecified;
    final views = widget.listingData['views'] ?? 0;
    final saves = widget.listingData['saves'] ?? 0;
    final createdAt = widget.listingData['createdAt'] as Timestamp?;
    final phoneNumber = widget.listingData['phoneNumber'] ?? loc.notProvided;

    final formattedDate = createdAt != null
        ? DateFormat('dd MMM yyyy').format(createdAt.toDate())
        : 'Recent';

    final pricePerKg =
        'PKR ${NumberFormat('#,##0').format(price)}/kg'; // Changed to PKR
    final totalPrice =
        'PKR ${NumberFormat('#,##0').format(price * 40)} / 40kg'; // Changed to PKR

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          loc.listingDetails,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: _toggleSave,
            icon: Icon(
              _isSaved ? Icons.bookmark : Icons.bookmark_border,
              color: _isSaved ? Colors.green : Colors.black,
            ),
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image Carousel
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Container(
                        height: 300,
                        width: double.infinity,
                        color: Colors.grey[200],
                        child: GestureDetector(
                          onTap: imageUrls.length > 1 ? _nextImage : null,
                          child: Image.network(
                            currentImageUrl,
                            width: double.infinity,
                            height: 300,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(
                                  value:
                                      loadingProgress.expectedTotalBytes != null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                            (loadingProgress
                                                    .expectedTotalBytes ??
                                                1)
                                      : null,
                                  color: const Color(0xFF2E7D32),
                                ),
                              );
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: const Color(0xFFE8F5E9),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.agriculture,
                                        size: 60,
                                        color: Color(0xFF4CAF50),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        loc.cropImage,
                                        style: TextStyle(
                                          color: Color(0xFF4CAF50),
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),

                      // Navigation arrows for multiple images
                      if (imageUrls.length > 1) ...[
                        Positioned(
                          left: 16,
                          top: 0,
                          bottom: 0,
                          child: GestureDetector(
                            onTap: _previousImage,
                            child: Container(
                              width: 40,
                              color: Colors.black26,
                              child: const Center(
                                child: Icon(
                                  Icons.chevron_left,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          right: 16,
                          top: 0,
                          bottom: 0,
                          child: GestureDetector(
                            onTap: _nextImage,
                            child: Container(
                              width: 40,
                              color: Colors.black26,
                              child: const Center(
                                child: Icon(
                                  Icons.chevron_right,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],

                      if (imageUrls.length > 1)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(imageUrls.length, (index) {
                              return Container(
                                width: 8,
                                height: 8,
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: index == _currentImageIndex
                                      ? Colors.white
                                      : Colors.white.withOpacity(0.5),
                                  shape: BoxShape.circle,
                                ),
                              );
                            }),
                          ),
                        ),
                    ],
                  ),

                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "$cropName",
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF333333),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          totalPrice,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2E7D32),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(
                              Icons.visibility,
                              size: 14,
                              color: Colors.grey,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '$views ${loc.views}',
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(width: 16),
                            const Icon(
                              Icons.bookmark,
                              size: 14,
                              color: Colors.grey,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '$saves ${loc.saves}',
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(width: 16),
                            const Icon(
                              Icons.calendar_today,
                              size: 14,
                              color: Colors.grey,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${loc.posted}: $formattedDate',
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        const Divider(),
                        const SizedBox(height: 16),

                        // Seller Info
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF8F9FA),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.grey.shade200),
                          ),
                          child: Row(
                            children: [
                              const CircleAvatar(
                                radius: 25,
                                backgroundColor: Colors.green,
                                child: Icon(
                                  Icons.person,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      sellerName,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      location,
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 13,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                          size: 14,
                                        ),
                                        const SizedBox(width: 4),
                                        const Text(
                                          "4.8",
                                          style: TextStyle(fontSize: 12),
                                        ),
                                        const SizedBox(width: 8),
                                        const Icon(
                                          Icons.verified,
                                          color: Colors.green,
                                          size: 14,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          loc.verified,
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.green,
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

                        const SizedBox(height: 24),
                        Text(
                          loc.description,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          description.isNotEmpty
                              ? description
                              : loc.noDescriptionProvided,
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.black87,
                            height: 1.5,
                          ),
                        ),

                        const SizedBox(height: 24),
                        Text(
                          loc.specifications,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        _buildSpecRow(loc.quantityAvailable, "${quantity}kg"),
                        _buildSpecRow(loc.variety, variety),
                        _buildSpecRow(loc.harvestDate, harvestDate),
                        _buildSpecRow(loc.location, location),
                        _buildSpecRow(loc.pricePerKg, pricePerKg),
                        _buildSpecRow(loc.contact, phoneNumber),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Single Full Width Phone Button
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(
                onPressed: _showPhoneNumberDialog,
                icon: const Icon(Icons.phone_enabled, color: Colors.white),
                label: Text(
                  loc.viewSellerPhone,
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF5A623),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
