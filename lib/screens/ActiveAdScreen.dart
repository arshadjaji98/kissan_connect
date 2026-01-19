// lib/screens/ActiveAdScreen.dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:kissan_connect_app_2/l10n/app_localizations.dart';
import '../helpers/firebase_helper.dart';
import 'CreateListingScreen.dart';
import 'ListingDetailsScreen.dart';

class ActiveAdScreen extends StatefulWidget {
  final String userName;
  final String userLocation;

  const ActiveAdScreen({
    super.key,
    required this.userName,
    required this.userLocation,
  });

  @override
  State<ActiveAdScreen> createState() => _ActiveAdScreenState();
}

class _ActiveAdScreenState extends State<ActiveAdScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool _isLoading = false;
  bool _hasError = false;
  String? _errorMessage;
  String? _selectedSortOption = 'newest';
  final List<String> _sortOptions = [
    'newest',
    'oldest',
    'price_low',
    'price_high',
    'quantity',
  ];

  @override
  void initState() {
    super.initState();
    _hasError = false;
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Text(
          loc.myActiveListings,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          // Sort dropdown
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _selectedSortOption,
                icon: const Icon(Icons.sort, color: Color(0xFF4CAF50)),
                elevation: 16,
                style: const TextStyle(color: Colors.black87, fontSize: 14),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedSortOption = newValue;
                  });
                },
                items: _sortOptions.map<DropdownMenuItem<String>>((
                  String value,
                ) {
                  String displayText = '';
                  switch (value) {
                    case 'newest':
                      displayText = loc.newestFirst;
                      break;
                    case 'oldest':
                      displayText = loc.oldestFirst;
                      break;
                    case 'price_low':
                      displayText = loc.priceLowToHigh;
                      break;
                    case 'price_high':
                      displayText = loc.priceHighToLow;
                      break;
                    case 'quantity':
                      displayText = loc.quantityAvailable;
                      break;
                  }
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(displayText),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(color: Color(0xFF2E7D32)),
            )
          : _hasError
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 60, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(
                    loc.errorLoadingListings,
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  if (_errorMessage != null) ...[
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: Text(
                        _errorMessage!,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _hasError = false;
                        _errorMessage = null;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2E7D32),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      loc.retry,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            )
          : StreamBuilder<QuerySnapshot>(
              stream: _getUserListingsStream(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(color: Color(0xFF2E7D32)),
                  );
                }

                if (snapshot.hasError) {
                  print('${loc.streamError} ${snapshot.error}');
                  return _buildErrorState('${loc.error} ${snapshot.error}');
                }

                if (!snapshot.hasData) {
                  return _buildErrorState(loc.noDataAvailable);
                }

                try {
                  // Filter active listings client-side
                  var listings = snapshot.data!.docs.where((doc) {
                    final data = doc.data() as Map<String, dynamic>;
                    final status = data['status']?.toString() ?? 'active';
                    return status == 'active';
                  }).toList();

                  // Apply sorting
                  listings = _sortListings(listings);

                  if (listings.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.inventory_2_outlined,
                            size: 80,
                            color: Colors.grey,
                          ),
                          const SizedBox(height: 20),
                          Text(
                            loc.noActiveListings,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            loc.donthave_active_listings,
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 24),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CreateListingScreen(
                                    userLocation: widget.userLocation,
                                    userName: widget.userName,
                                  ),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF2E7D32),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 32,
                                vertical: 12,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              loc.createFirstListing,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    itemCount: listings.length,
                    itemBuilder: (context, index) =>
                        _buildListingCard(listings[index]),
                  );
                } catch (e) {
                  print('${loc.errorProcessingData} $e');
                  return _buildErrorState('${loc.errorProcessingData}: $e');
                }
              },
            ),
    );
  }

  Widget _buildErrorState(String error) {
    final loc = AppLocalizations.of(context)!;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 60, color: Colors.red),
          const SizedBox(height: 16),
          Text(
            loc.errorLoadingListings,
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              error,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _hasError = false;
                _errorMessage = null;
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2E7D32),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(loc.retry, style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }

  Stream<QuerySnapshot> _getUserListingsStream() {
    final loc = AppLocalizations.of(context)!;
    try {
      final userId = _auth.currentUser?.uid;
      if (userId == null) {
        throw Exception(loc.userNotLoggedIn);
      }

      // Query WITHOUT status filter to avoid index requirement
      // We'll filter client-side for 'active' status
      return _firestore
          .collection('marketplace_listings')
          .where('sellerId', isEqualTo: userId)
          .orderBy('createdAt', descending: true)
          .snapshots();
    } catch (e) {
      print('Query Error: $e');
      setState(() {
        _hasError = true;
        _errorMessage = e.toString();
      });
      return const Stream.empty();
    }
  }

  List<QueryDocumentSnapshot> _sortListings(
    List<QueryDocumentSnapshot> listings,
  ) {
    try {
      switch (_selectedSortOption) {
        case 'newest':
          listings.sort((a, b) {
            final aDate =
                (a['createdAt'] as Timestamp?)?.toDate() ?? DateTime(0);
            final bDate =
                (b['createdAt'] as Timestamp?)?.toDate() ?? DateTime(0);
            return bDate.compareTo(aDate);
          });
          break;
        case 'oldest':
          listings.sort((a, b) {
            final aDate =
                (a['createdAt'] as Timestamp?)?.toDate() ?? DateTime(0);
            final bDate =
                (b['createdAt'] as Timestamp?)?.toDate() ?? DateTime(0);
            return aDate.compareTo(bDate);
          });
          break;
        case 'price_low':
          listings.sort((a, b) {
            final aPrice = (a['price'] as num?)?.toDouble() ?? 0.0;
            final bPrice = (b['price'] as num?)?.toDouble() ?? 0.0;
            return aPrice.compareTo(bPrice);
          });
          break;
        case 'price_high':
          listings.sort((a, b) {
            final aPrice = (a['price'] as num?)?.toDouble() ?? 0.0;
            final bPrice = (b['price'] as num?)?.toDouble() ?? 0.0;
            return bPrice.compareTo(aPrice);
          });
          break;
        case 'quantity':
          listings.sort((a, b) {
            final aQty = (a['quantity'] as num?)?.toDouble() ?? 0.0;
            final bQty = (b['quantity'] as num?)?.toDouble() ?? 0.0;
            return bQty.compareTo(aQty);
          });
          break;
      }
      return listings;
    } catch (e) {
      print('Sort Error: $e');
      return listings; // Return unsorted if error
    }
  }

  Widget _buildListingCard(QueryDocumentSnapshot listing) {
    try {
      final data = listing.data() as Map<String, dynamic>;
      final imageUrls = data['imageUrls'] as List<dynamic>? ?? [];
      final imageUrl = FirebaseHelper.getImageUrl(imageUrls);
      final cropName =
          data['cropName']?.toString() ??
          AppLocalizations.of(context)!.unknownCrop;
      final price = (data['price'] as num?)?.toDouble() ?? 0.0;
      final quantity = (data['quantity'] as num?)?.toDouble() ?? 0.0;
      final description = data['description']?.toString() ?? '';
      final createdAt =
          (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now();
      final views = (data['views'] as num?)?.toInt() ?? 0;
      final saves = (data['saves'] as num?)?.toInt() ?? 0;
      final status =
          data['status']?.toString() ?? AppLocalizations.of(context)!.active;

      // If status is not active, don't show or show differently
      if (status != 'active') {
        return Container(); // Hide non-active listings
      }

      final priceFormatted = 'PKR ${price.toStringAsFixed(0)}/kg';
      final quantityFormatted = '${quantity.toStringAsFixed(0)} kg';
      final dateFormatted = DateFormat('MMM dd, yyyy').format(createdAt);

      return Container(
        key: ValueKey(listing.id),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
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
            // Top row with image and basic info
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image
                Container(
                  width: 100,
                  height: 100,
                  margin: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey[200],
                    image: DecorationImage(
                      image: NetworkImage(imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: imageUrl.isEmpty
                      ? const Center(
                          child: Icon(
                            Icons.agriculture,
                            color: Color(0xFF4CAF50),
                            size: 40,
                          ),
                        )
                      : null,
                ),

                // Details
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16, right: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          cropName,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            const Icon(
                              Icons.price_check,
                              size: 16,
                              color: Color(0xFF2E7D32),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              priceFormatted,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF2E7D32),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            const Icon(
                              Icons.scale,
                              size: 16,
                              color: Colors.grey,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              quantityFormatted,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            const Icon(
                              Icons.calendar_today,
                              size: 16,
                              color: Colors.grey,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              '${AppLocalizations.of(context)!.listed} $dateFormatted',
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            const Icon(
                              Icons.visibility,
                              size: 16,
                              color: Colors.blue,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              '$views ${AppLocalizations.of(context)!.views}',
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.blue,
                              ),
                            ),
                            const SizedBox(width: 16),
                            const Icon(
                              Icons.bookmark,
                              size: 16,
                              color: Colors.pink,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              '$saves ${AppLocalizations.of(context)!.saves}',
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.pink,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Description (collapsible)
            if (description.isNotEmpty) ...[
              const Divider(height: 1, thickness: 0.5),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Text(
                  description,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF555555),
                    height: 1.4,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],

            // Action buttons
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: const BoxDecoration(
                color: Color(0xFFF8F9FA),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
              ),
              child: Row(
                children: [
                  // View button
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
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
                      icon: const Icon(Icons.visibility, size: 18),
                      label: Text(AppLocalizations.of(context)!.view),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFF555555),
                        side: const BorderSide(color: Color(0xFFDDDDDD)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 8),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Edit button
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => _editListing(listing),
                      icon: const Icon(Icons.edit, size: 18),
                      label: Text(AppLocalizations.of(context)!.edit),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4CAF50),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 8),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Delete button
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => _deleteListing(listing),
                      icon: const Icon(Icons.delete_outline, size: 18),
                      label: Text(AppLocalizations.of(context)!.delete),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFEEBEE),
                        foregroundColor: const Color(0xFFD32F2F),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 8),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    } catch (e) {
      print('${AppLocalizations.of(context)!.buildCardError} $e');
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.red.shade100),
        ),
        child: Row(
          children: [
            const Icon(Icons.error, color: Colors.red, size: 24),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                AppLocalizations.of(context)!.errorDisplayingListing,
                style: const TextStyle(color: Colors.grey),
              ),
            ),
          ],
        ),
      );
    }
  }

  Future<void> _editListing(QueryDocumentSnapshot listing) async {
    final data = listing.data() as Map<String, dynamic>;

    // Show options menu
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                AppLocalizations.of(context)!.editListing,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                AppLocalizations.of(context)!.whatToEdit,
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 24),

              // Edit Details
              ListTile(
                leading: const Icon(Icons.edit_note, color: Color(0xFF4CAF50)),
                title: Text(AppLocalizations.of(context)!.editDetails),
                subtitle: Text(AppLocalizations.of(context)!.editDetailsHint),
                onTap: () async {
                  Navigator.pop(context);
                  await _editListingDetails(listing);
                },
              ),

              const SizedBox(height: 20),

              // Cancel button
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.grey,
                    side: const BorderSide(color: Color(0xFFDDDDDD)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: Text(AppLocalizations.of(context)!.cancel),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _editListingDetails(QueryDocumentSnapshot listing) async {
    final data = listing.data() as Map<String, dynamic>;

    // Show dialog with form fields
    final priceController = TextEditingController(
      text: (data['price'] as num?)?.toString() ?? '',
    );
    final quantityController = TextEditingController(
      text: (data['quantity'] as num?)?.toString() ?? '',
    );
    final descriptionController = TextEditingController(
      text: data['description']?.toString() ?? '',
    );

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          title: Text(AppLocalizations.of(context)!.editListingDetails),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: priceController,
                  decoration: InputDecoration(
                    labelText:
                        '${AppLocalizations.of(context)!.price} (PKR/kg)',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    prefixIcon: Icon(Icons.price_check),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: quantityController,
                  decoration: InputDecoration(
                    labelText:
                        '${AppLocalizations.of(context)!.quantity} ${AppLocalizations.of(context)!.unitKg}',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    prefixIcon: Icon(Icons.scale),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.description,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    prefixIcon: Icon(Icons.description),
                  ),
                  maxLines: 3,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                AppLocalizations.of(context)!.cancel,
                style: TextStyle(color: Colors.grey),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                if (priceController.text.isEmpty ||
                    quantityController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        AppLocalizations.of(context)!.fillRequiredFields,
                      ),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }

                try {
                  setState(() => _isLoading = true);
                  await listing.reference.update({
                    'price': double.parse(priceController.text),
                    'quantity': double.parse(quantityController.text),
                    'description': descriptionController.text.trim(),
                    'updatedAt': FieldValue.serverTimestamp(),
                  });
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        AppLocalizations.of(context)!.listingUpdated,
                      ),
                      backgroundColor: Colors.green,
                    ),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        '${AppLocalizations.of(context)!.errorUpdatingListing}: $e',
                      ),
                      backgroundColor: Colors.red,
                    ),
                  );
                } finally {
                  if (mounted) {
                    setState(() => _isLoading = false);
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2E7D32),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(AppLocalizations.of(context)!.saveChanges),
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteListing(QueryDocumentSnapshot listing) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          title: Text(AppLocalizations.of(context)!.deleteListingTitle),
          content: Text(AppLocalizations.of(context)!.deleteListingWarning),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                AppLocalizations.of(context)!.cancel,
                style: TextStyle(color: Colors.grey),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.pop(context);
                try {
                  setState(() => _isLoading = true);
                  await FirebaseHelper.deleteListing(listing.id);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        AppLocalizations.of(context)!.listingDeleted,
                      ),
                      backgroundColor: Colors.green,
                    ),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        '${AppLocalizations.of(context)!.errorDeletingListing}: $e',
                      ),
                      backgroundColor: Colors.red,
                    ),
                  );
                } finally {
                  if (mounted) {
                    setState(() => _isLoading = false);
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(AppLocalizations.of(context)!.delete),
            ),
          ],
        );
      },
    );
  }
}
