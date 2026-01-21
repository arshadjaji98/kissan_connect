// lib/helpers/firebase_helper.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class FirebaseHelper {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseStorage _storage = FirebaseStorage.instance;

  // Initialize collections with sample data
  static Future<void> initializeCollections() async {
    print('🔄 Initializing Firebase collections...');

    try {
      // Check if marketplace_listings collection exists (has any documents)
      final snapshot = await _firestore
          .collection('marketplace_listings')
          .limit(1)
          .get();

      if (snapshot.docs.isEmpty) {
        print('📝 Creating sample marketplace listings...');
        await _createSampleListings();
      }

      // Ensure current user has a document
      await _ensureUserDocumentExists();

      print('✅ Firebase collections initialized successfully!');
    } catch (e) {
      print('❌ Error initializing collections: $e');
    }
  }

  // Create sample listings
  static Future<void> _createSampleListings() async {
    final sampleListings = [
      {
        'cropName': 'Wheat Grains',
        'description':
            'High-quality super fine wheat, harvested this season. Organically grown with no pesticides.',
        'quantity': 2000,
        'price': 25,
        'phoneNumber': '+923001234567',
        'variety': 'Faisalabad-2008',
        'harvestDate': 'April 2024',
        'location': 'Punjab',
        'sellerName': 'Ali Ahmed',
        'sellerId': 'demo_farmer_1',
        'sellerEmail': 'ali.ahmed@demo.com',
        'imageUrls': [
          'https://images.unsplash.com/photo-1592924357228-91a4daadcfea?w=400&auto=format&fit=crop',
        ],
        'status': 'active',
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
        'views': 150,
        'saves': 30,
      },
      {
        'cropName': 'Basmati Rice',
        'description':
            'Premium quality Basmati rice, aged for perfect texture and aroma.',
        'quantity': 500,
        'price': 150,
        'phoneNumber': '+923002345678',
        'variety': 'Super Kernel',
        'harvestDate': 'March 2024',
        'location': 'Punjab',
        'sellerName': 'Ahmed Khan',
        'sellerId': 'demo_farmer_2',
        'sellerEmail': 'ahmed.khan@demo.com',
        'imageUrls': [
          'https://images.unsplash.com/photo-1586201375761-83865001e31c?w=400&auto=format&fit=crop',
        ],
        'status': 'active',
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
        'views': 200,
        'saves': 45,
      },
    ];

    for (var listing in sampleListings) {
      await _firestore.collection('marketplace_listings').add(listing);
    }
  }

  // Ensure user document exists
  static Future<void> _ensureUserDocumentExists() async {
    final user = _auth.currentUser;
    if (user == null) return;

    final userDoc = await _firestore.collection('users').doc(user.uid).get();

    if (!userDoc.exists) {
      await _firestore.collection('users').doc(user.uid).set({
        'uid': user.uid,
        'email': user.email,
        'name': user.displayName ?? 'Farmer',
        'location': 'Your Location',
        'phoneNumber': '',
        'selectedCrops': ['Wheat'],
        'primaryCrop': 'Wheat',
        'isFirstTime': true,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
        'profileImage': '',
        'rating': 5.0,
        'totalSales': 0,
        'savedListings': [],
      });
    }
  }

  // Get all active listings - USES Stream for real-time updates
  static Stream<QuerySnapshot> getActiveListingsStream() {
    return _firestore
        .collection('marketplace_listings')
        .where('status', isEqualTo: 'active')
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  // Get all active listings - USES Future for one-time fetch
  static Future<List<DocumentSnapshot>> getActiveListings() async {
    try {
      final snapshot = await _firestore
          .collection('marketplace_listings')
          .where('status', isEqualTo: 'active')
          .orderBy('createdAt', descending: true)
          .get();
      return snapshot.docs;
    } catch (e) {
      print('Error getting listings: $e');
      return [];
    }
  }

  // Get listing by ID
  static Future<DocumentSnapshot> getListingById(String listingId) async {
    return await _firestore
        .collection('marketplace_listings')
        .doc(listingId)
        .get();
  }

  // Create a new listing - FIXED: Ensure imageUrls is properly typed
  static Future<String> createListing({
    required String cropName,
    required String description,
    required double quantity,
    required double price,
    required String phoneNumber,
    required String variety,
    required String harvestDate,
    required String location,
    required String sellerName,
    required List<String> imageUrls,
  }) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception('User not logged in');

    try {
      print('🔄 Creating listing for: $cropName');
      print('📸 Image URLs to save: $imageUrls');
      print('📞 Phone: $phoneNumber');
      print('📍 Location: $location');

      // Validate image URLs
      final validImageUrls = imageUrls
          .where((url) => url.isNotEmpty && url.startsWith('http'))
          .toList();

      if (validImageUrls.isEmpty) {
        print('⚠️ No valid image URLs provided, using default fallback');
        validImageUrls.add(
          'https://images.unsplash.com/photo-1592924357228-91a4daadcfea?w=400&auto=format&fit=crop',
        );
      }

      final docRef = await _firestore.collection('marketplace_listings').add({
        'cropName': cropName,
        'description': description,
        'quantity': quantity,
        'price': price,
        'phoneNumber': phoneNumber,
        'variety': variety,
        'harvestDate': harvestDate,
        'location': location,
        'sellerName': sellerName,
        'sellerId': user.uid,
        'sellerEmail': user.email,
        'imageUrls': validImageUrls, // Ensure this is a List<String>
        'status': 'active',
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
        'views': 0,
        'saves': 0,
      });

      print('✅ Listing created with ID: ${docRef.id}');

      // Also add to user's myListings
      await _firestore.collection('users').doc(user.uid).update({
        'myListings': FieldValue.arrayUnion([docRef.id]),
        'updatedAt': FieldValue.serverTimestamp(),
      });

      return docRef.id;
    } catch (e) {
      print('❌ Error creating listing: $e');
      throw Exception('Failed to create listing: ${e.toString()}');
    }
  }

  // Upload image to Firebase Storage - IMPROVED with better error handling
  static Future<String> uploadImage(File imageFile) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception('User not logged in');

    try {
      // Generate unique filename
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final randomNum = (DateTime.now().millisecondsSinceEpoch % 10000)
          .toString();
      final fileName = '${user.uid}_${timestamp}_$randomNum.jpg';
      final ref = _storage.ref().child('marketplace_images/$fileName');

      print('🔄 Uploading image: $fileName');
      print('📁 File path: ${imageFile.path}');
      print('📏 File size: ${await imageFile.length()} bytes');

      // Check if file exists and is readable
      if (!await imageFile.exists()) {
        throw Exception('Image file does not exist at path: ${imageFile.path}');
      }

      // Set metadata for better performance
      final metadata = SettableMetadata(
        contentType: 'image/jpeg',
        customMetadata: {
          'uploadedBy': user.uid,
          'timestamp': timestamp.toString(),
          'uploadedAt': DateTime.now().toIso8601String(),
        },
      );

      print('📤 Starting upload to Firebase Storage...');

      // Upload the file with progress tracking
      final uploadTask = ref.putFile(imageFile, metadata);

      // Listen to state changes
      uploadTask.snapshotEvents.listen(
        (TaskSnapshot snapshot) {
          print(
            '📊 Upload progress: ${snapshot.bytesTransferred}/${snapshot.totalBytes}',
          );
        },
        onError: (error) {
          print('❌ Upload error: $error');
        },
      );

      // Wait for upload to complete
      final snapshot = await uploadTask;

      if (snapshot.state == TaskState.success) {
        print('✅ Upload successful! Getting download URL...');

        // Get download URL
        final downloadUrl = await ref.getDownloadURL();

        print('🔗 Download URL received: $downloadUrl');

        // Verify URL is valid
        if (downloadUrl.isEmpty) {
          throw Exception('Empty download URL received from Firebase Storage');
        }

        if (!downloadUrl.startsWith('https://')) {
          throw Exception('Invalid download URL format: $downloadUrl');
        }

        return downloadUrl;
      } else {
        throw Exception('Upload failed with state: ${snapshot.state}');
      }
    } catch (e, stackTrace) {
      print('❌ Error uploading image: $e');
      print('📋 Stack trace: $stackTrace');

      if (e is FirebaseException) {
        print('🔥 Firebase error code: ${e.code}');
        print('🔥 Firebase error message: ${e.message}');
      }

      // Provide more helpful error messages
      String errorMessage = 'Failed to upload image: ';
      if (e is FirebaseException) {
        switch (e.code) {
          case 'storage/object-not-found':
            errorMessage +=
                'Storage reference not found. Please check Firebase Storage configuration.';
            break;
          case 'storage/unauthorized':
            errorMessage +=
                'Unauthorized access. Please check Firebase Storage rules.';
            break;
          case 'storage/canceled':
            errorMessage += 'Upload was canceled.';
            break;
          case 'storage/unknown':
            errorMessage += 'Unknown error occurred.';
            break;
          default:
            errorMessage += e.message ?? 'Unknown Firebase error';
        }
      } else {
        errorMessage += e.toString();
      }

      throw Exception(errorMessage);
    }
  }

  // Increment view count
  static Future<void> incrementViews(String listingId) async {
    try {
      await _firestore.collection('marketplace_listings').doc(listingId).update(
        {
          'views': FieldValue.increment(1),
          'updatedAt': FieldValue.serverTimestamp(),
        },
      );
    } catch (e) {
      print('Error incrementing views: $e');
    }
  }

  // Toggle save listing
  static Future<void> toggleSaveListing(String listingId, bool isSaved) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception('User not logged in');

    try {
      if (isSaved) {
        await _firestore
            .collection('marketplace_listings')
            .doc(listingId)
            .update({'saves': FieldValue.increment(1)});
        await _firestore.collection('users').doc(user.uid).update({
          'savedListings': FieldValue.arrayUnion([listingId]),
        });
      } else {
        await _firestore
            .collection('marketplace_listings')
            .doc(listingId)
            .update({'saves': FieldValue.increment(-1)});
        await _firestore.collection('users').doc(user.uid).update({
          'savedListings': FieldValue.arrayRemove([listingId]),
        });
      }
    } catch (e) {
      print('Error toggling save: $e');
      throw e;
    }
  }

  // Get user's saved listings
  static Future<List<String>> getUserSavedListings() async {
    final user = _auth.currentUser;
    if (user == null) return [];

    try {
      final doc = await _firestore.collection('users').doc(user.uid).get();
      final data = doc.data() as Map<String, dynamic>;
      return List<String>.from(data['savedListings'] ?? []);
    } catch (e) {
      print('Error getting saved listings: $e');
      return [];
    }
  }

  // FIXED: Search listings with local filtering (safe from index errors)
  static Future<List<DocumentSnapshot>> searchListings(String query) async {
    try {
      print('🔍 [FirebaseHelper] Search called with: "$query"');

      if (query.isEmpty || query.trim().isEmpty) {
        print('📝 [FirebaseHelper] Empty query, returning all active listings');
        return await getActiveListings();
      }

      final cleanQuery = query.trim().toLowerCase();
      print('🔍 [FirebaseHelper] Searching for: "$cleanQuery"');

      // Get all active listings first (uses the indexed query)
      final allActiveListings = await _firestore
          .collection('marketplace_listings')
          .where('status', isEqualTo: 'active')
          .orderBy('createdAt', descending: true)
          .get();

      print(
        '📊 [FirebaseHelper] Found ${allActiveListings.docs.length} active listings total',
      );

      // Filter locally by multiple fields
      final results = allActiveListings.docs.where((doc) {
        final data = doc.data();
        final cropName = data['cropName']?.toString().toLowerCase() ?? '';
        final description = data['description']?.toString().toLowerCase() ?? '';
        final location = data['location']?.toString().toLowerCase() ?? '';
        final variety = data['variety']?.toString().toLowerCase() ?? '';
        final sellerName = data['sellerName']?.toString().toLowerCase() ?? '';

        return cropName.contains(cleanQuery) ||
            description.contains(cleanQuery) ||
            location.contains(cleanQuery) ||
            variety.contains(cleanQuery) ||
            sellerName.contains(cleanQuery);
      }).toList();

      print(
        '✅ [FirebaseHelper] Search found ${results.length} matching results',
      );
      return results;
    } catch (e, stackTrace) {
      print('❌ [FirebaseHelper] SEARCH ERROR: $e');
      print('📋 [FirebaseHelper] Stack trace: $stackTrace');

      // Fallback: return empty list to prevent UI crashes
      return [];
    }
  }

  // Get user's listings
  static Future<List<DocumentSnapshot>> getUserListings() async {
    final user = _auth.currentUser;
    if (user == null) return [];

    try {
      final snapshot = await _firestore
          .collection('marketplace_listings')
          .where('sellerId', isEqualTo: user.uid)
          .orderBy('createdAt', descending: true)
          .get();

      return snapshot.docs;
    } catch (e) {
      print('Error getting user listings: $e');
      return [];
    }
  }

  // Delete listing
  static Future<void> deleteListing(String listingId) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception('User not logged in');

    try {
      // Check if user owns the listing
      final listingDoc = await _firestore
          .collection('marketplace_listings')
          .doc(listingId)
          .get();
      if (listingDoc.exists) {
        final data = listingDoc.data() as Map<String, dynamic>;
        if (data['sellerId'] == user.uid) {
          // Soft delete by changing status
          await _firestore
              .collection('marketplace_listings')
              .doc(listingId)
              .update({
                'status': 'deleted',
                'updatedAt': FieldValue.serverTimestamp(),
              });

          // Remove from user's myListings
          await _firestore.collection('users').doc(user.uid).update({
            'myListings': FieldValue.arrayRemove([listingId]),
            'updatedAt': FieldValue.serverTimestamp(),
          });

          print('✅ Listing $listingId marked as deleted');
        } else {
          throw Exception('You do not have permission to delete this listing');
        }
      }
    } catch (e) {
      print('Error deleting listing: $e');
      throw e;
    }
  }

  // Helper to get image URL safely
  static String getImageUrl(List<dynamic>? imageUrls, [int index = 0]) {
    if (imageUrls == null || imageUrls.isEmpty) {
      return 'https://images.unsplash.com/photo-1592924357228-91a4daadcfea?w=400&auto=format&fit=crop';
    }

    if (index >= imageUrls.length) {
      index = 0;
    }

    final url = imageUrls[index].toString();

    // Ensure URL is valid
    if (url.startsWith('http')) {
      return url;
    } else {
      return 'https://images.unsplash.com/photo-1592924357228-91a4daadcfea?w=400&auto=format&fit=crop';
    }
  }

  // Alternative upload method with timeout - FIXED: Using standard Exception
  static Future<String> uploadImageWithTimeout(
    File imageFile, {
    Duration timeout = const Duration(seconds: 30),
  }) async {
    try {
      // Use Future.any to implement timeout
      final result = await Future.any([
        uploadImage(imageFile),
        Future.delayed(
          timeout,
          () => throw Exception(
            'Image upload timed out after ${timeout.inSeconds} seconds',
          ),
        ),
      ]);

      return result;
    } on Exception catch (e) {
      if (e.toString().contains('timed out')) {
        print('⏰ Upload timeout: $e');
        throw Exception(
          'Image upload took too long. Please try again with a smaller image or better internet connection.',
        );
      } else {
        rethrow;
      }
    } catch (e) {
      rethrow;
    }
  }
}
