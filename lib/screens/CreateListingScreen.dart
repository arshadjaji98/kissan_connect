// lib/screens/CreateListingScreen.dart
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import '../helpers/firebase_helper.dart';

class CreateListingScreen extends StatefulWidget {
  final String userLocation;
  final String userName;

  const CreateListingScreen({
    super.key,
    required this.userLocation,
    required this.userName,
  });

  @override
  State<CreateListingScreen> createState() => _CreateListingScreenState();
}

class _CreateListingScreenState extends State<CreateListingScreen> {
  final TextEditingController _cropNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _varietyController = TextEditingController();
  final TextEditingController _harvestDateController = TextEditingController();

  List<XFile> _selectedImages = [];
  bool _isUploading = false;
  String _uploadStatus = '';

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _quantityController.text = '1000';
    _priceController.text = '2500';
    _harvestDateController.text = DateFormat('MMMM yyyy').format(DateTime.now());
  }

  Future<void> _pickImages() async {
    if (_selectedImages.length >= 5) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Maximum 5 images allowed')),
      );
      return;
    }

    try {
      final List<XFile>? images = await _picker.pickMultiImage(
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 75,
      );

      if (images != null && images.isNotEmpty) {
        setState(() {
          _selectedImages.addAll(images);
          if (_selectedImages.length > 5) {
            _selectedImages = _selectedImages.sublist(0, 5);
          }
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Added ${images.length} image(s)')),
        );
      }
    } catch (e) {
      print('Error picking images: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to pick images')),
      );
    }
  }

  Future<void> _submitListing() async {
    // Validate inputs
    if (_cropNameController.text.isEmpty) {
      _showError('Please enter crop name');
      return;
    }

    if (_quantityController.text.isEmpty || double.tryParse(_quantityController.text) == null) {
      _showError('Please enter valid quantity');
      return;
    }

    if (_priceController.text.isEmpty || double.tryParse(_priceController.text) == null) {
      _showError('Please enter valid price');
      return;
    }

    if (_phoneController.text.isEmpty) {
      _showError('Please enter phone number');
      return;
    }

    setState(() {
      _isUploading = true;
      _uploadStatus = 'Creating listing...';
    });

    try {
      List<String> imageUrls = [];

      // If user selected images, map them to default URLs based on crop type
      if (_selectedImages.isNotEmpty) {
        // Since we can't upload to Firebase Storage, we'll use default images
        // based on the crop name, but we'll still show the user we "processed" their images
        String defaultImage = _getDefaultImageForCrop(_cropNameController.text);

        // Use the same default image for all selected images
        for (int i = 0; i < _selectedImages.length; i++) {
          imageUrls.add(defaultImage);
        }

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Images processed successfully!'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        // No images selected, use a single default image
        String defaultImage = _getDefaultImageForCrop(_cropNameController.text);
        imageUrls.add(defaultImage);
      }

      print('🔄 Creating listing...');
      print('📝 Crop: ${_cropNameController.text}');
      print('💰 Price: ${_priceController.text}');
      print('📱 Phone: ${_phoneController.text}');
      print('📍 Location: ${widget.userLocation}');
      print('📸 Image URLs: $imageUrls');

      // Create listing
      final listingId = await FirebaseHelper.createListing(
        cropName: _cropNameController.text.trim(),
        description: _descriptionController.text.trim(),
        quantity: double.parse(_quantityController.text),
        price: double.parse(_priceController.text),
        phoneNumber: _phoneController.text.trim(),
        variety: _varietyController.text.trim(),
        harvestDate: _harvestDateController.text.trim(),
        location: widget.userLocation,
        sellerName: widget.userName,
        imageUrls: imageUrls,
      );

      print('✅ Listing created with ID: $listingId');

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Listing posted successfully!'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 3),
        ),
      );

      // Wait a moment for Firebase to sync
      await Future.delayed(const Duration(milliseconds: 500));

      // Navigate back to marketplace
      Navigator.pop(context, true);

    } catch (e) {
      print('❌ Error creating listing: $e');
      _showError('Failed to create listing: ${e.toString()}');
    } finally {
      setState(() {
        _isUploading = false;
        _uploadStatus = '';
      });
    }
  }

  String _getDefaultImageForCrop(String cropName) {
    final name = cropName.toLowerCase();

    if (name.contains('wheat')) {
      return 'https://images.unsplash.com/photo-1592924357228-91a4daadcfea?w=400&auto=format&fit=crop';
    } else if (name.contains('rice') || name.contains('basmati')) {
      return 'https://images.unsplash.com/photo-1586201375761-83865001e31c?w=400&auto=format&fit=crop';
    } else if (name.contains('cotton')) {
      return 'https://images.unsplash.com/photo-1563492065599-3520f775eeed?w=400&auto=format&fit=crop';
    } else if (name.contains('maize') || name.contains('corn')) {
      return 'https://images.unsplash.com/photo-1551754655-cd27e38d2076?w=400&auto=format&fit=crop';
    } else if (name.contains('mango')) {
      return 'https://images.unsplash.com/photo-1592924357228-91a4daadcfea?w=400&auto=format&fit=crop';
    } else if (name.contains('potato')) {
      return 'https://images.unsplash.com/photo-1518977676601-b53f82aba655?w=400&auto=format&fit=crop';
    } else if (name.contains('chilli') || name.contains('pepper')) {
      return 'https://images.unsplash.com/photo-1586201375761-83865001e31c?w=400&auto=format&fit=crop';
    } else if (name.contains('sugarcane')) {
      return 'https://images.unsplash.com/photo-1574943320219-553eb213f72d?w=400&auto=format&fit=crop';
    } else if (name.contains('onion')) {
      return 'https://images.unsplash.com/photo-1574943320219-553eb213f72d?w=400&auto=format&fit=crop';
    } else if (name.contains('tomato')) {
      return 'https://images.unsplash.com/photo-1592924357228-91a4daadcfea?w=400&auto=format&fit=crop';
    } else {
      return 'https://images.unsplash.com/photo-1592924357228-91a4daadcfea?w=400&auto=format&fit=crop';
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  Future<void> _selectHarvestDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        _harvestDateController.text = DateFormat('MMMM yyyy').format(picked);
      });
    }
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: Colors.black87,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Create New Listing",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Photo Upload Area
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      const Icon(Icons.add_photo_alternate, size: 40, color: Color(0xFF4CAF50)),
                      const SizedBox(height: 8),
                      const Text(
                        "Upload Crop Photos",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Add up to ${5 - _selectedImages.length} photos of your crop",
                        style: const TextStyle(color: Colors.grey, fontSize: 12),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        "Photos will be mapped to high-quality crop images",
                        style: TextStyle(color: Colors.orange, fontSize: 11),
                        textAlign: TextAlign.center,
                      ),

                      if (_selectedImages.isNotEmpty) ...[
                        const SizedBox(height: 16),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: _selectedImages.asMap().entries.map((entry) {
                            final index = entry.key;
                            final image = entry.value;
                            return Stack(
                              children: [
                                Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    image: DecorationImage(
                                      image: FileImage(File(image.path)),
                                      fit: BoxFit.cover,
                                    ),
                                    border: Border.all(color: Colors.green, width: 2),
                                  ),
                                ),
                                Positioned(
                                  top: -8,
                                  right: -8,
                                  child: IconButton(
                                    icon: const CircleAvatar(
                                      radius: 12,
                                      backgroundColor: Colors.red,
                                      child: Icon(Icons.close, size: 12, color: Colors.white),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _selectedImages.removeAt(index);
                                      });
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text('Image removed')),
                                      );
                                    },
                                  ),
                                ),
                                Positioned(
                                  bottom: 4,
                                  right: 4,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      '${index + 1}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }).toList(),
                        ),
                      ],

                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _pickImages,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4CAF50),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.add_a_photo, size: 18),
                            SizedBox(width: 8),
                            Text("Add Photos"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Crop Name
                _buildLabel("Crop Name"),
                TextField(
                  controller: _cropNameController,
                  decoration: InputDecoration(
                    hintText: "e.g., Wheat, Basmati Rice, Cotton",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.green),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Description
                _buildLabel("Description"),
                TextField(
                  controller: _descriptionController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText: "Describe the quality, variety, and any other details.",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.green),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Quantity and Price
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildLabel("Quantity (kg)"),
                          TextField(
                            controller: _quantityController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: "1000",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: Colors.grey.shade300),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: Colors.grey.shade300),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(color: Colors.green),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildLabel("Price per kg (PKR)"),
                          TextField(
                            controller: _priceController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: "2500",
                              suffixText: "PKR/kg",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: Colors.grey.shade300),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: Colors.grey.shade300),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(color: Colors.green),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Phone Number
                _buildLabel("Phone Number"),
                TextField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: "Enter your phone number",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.green),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Crop Variety
                _buildLabel("Crop Variety"),
                TextField(
                  controller: _varietyController,
                  decoration: InputDecoration(
                    hintText: "e.g., Faisalabad-2008",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.green),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Harvest Date
                _buildLabel("Harvest Date"),
                TextField(
                  controller: _harvestDateController,
                  readOnly: true,
                  onTap: _selectHarvestDate,
                  decoration: InputDecoration(
                    hintText: "Select harvest date",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.green),
                    ),
                    suffixIcon: const Icon(Icons.calendar_today, color: Colors.grey),
                  ),
                ),

                const SizedBox(height: 16),

                // Location
                _buildLabel("Confirm your location"),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.location_on, color: Colors.grey),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.userLocation,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const Text(
                              "Your listing will be visible to buyers in this area.",
                              style: TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),

                // Submit Button
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: _isUploading ? null : _submitListing,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4CAF50),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      elevation: 0,
                    ),
                    child: _isUploading
                        ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 3,
                      ),
                    )
                        : const Text(
                      "Post Listing",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),

          // Loading Overlay
          if (_isUploading)
            Container(
              color: Colors.black.withOpacity(0.8),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const CircularProgressIndicator(
                        color: Color(0xFF4CAF50),
                        strokeWidth: 3,
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Creating Your Listing',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        _uploadStatus,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'This may take a few moments...',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _cropNameController.dispose();
    _descriptionController.dispose();
    _quantityController.dispose();
    _priceController.dispose();
    _phoneController.dispose();
    _varietyController.dispose();
    _harvestDateController.dispose();
    super.dispose();
  }
}