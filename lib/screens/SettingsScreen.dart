// lib/screens/SettingsScreen.dart
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kissan_connect_app_2/l10n/app_localizations.dart';
import 'package:kissan_connect_app_2/main.dart';
import '../widgets/crop_selection_widget.dart';

class SettingsScreen extends StatefulWidget {
  final String userLocation;
  final String userName;
  final List<String> selectedCrops;
  final String primaryCrop;

  const SettingsScreen({
    super.key,
    required this.userLocation,
    required this.userName,
    required this.selectedCrops,
    required this.primaryCrop,
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String _userEmail = '';
  bool _isLoading = false;
  String _selectedLanguage = 'English'; // Default language

  // State for editable fields
  late String _currentName;
  late String _currentLocation;
  late List<String> _currentSelectedCrops;
  late String _currentPrimaryCrop;

  @override
  void initState() {
    super.initState();
    _loadUserEmail();
    _loadLanguagePreference();
    // Initialize editable fields with widget values
    _currentName = widget.userName;
    _currentLocation = widget.userLocation;
    _currentSelectedCrops = List.from(widget.selectedCrops);
    _currentPrimaryCrop = widget.primaryCrop;
  }

  void _loadUserEmail() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null && user.email != null) {
      setState(() {
        _userEmail = user.email!;
      });
    }
  }

  void _loadLanguagePreference() async {
    final user = _auth.currentUser;
    if (user != null) {
      final doc = await _firestore.collection('users').doc(user.uid).get();
      if (doc.exists && doc.data() != null) {
        final data = doc.data()!;
        if (data.containsKey('language')) {
          setState(() {
            _selectedLanguage = data['language'] ?? 'English';
          });
        }
      }
    }
  }

  Future<void> _showEditProfileDialog() async {
    final loc = AppLocalizations.of(context)!;
    final TextEditingController nameController = TextEditingController(
      text: _currentName,
    );
    final TextEditingController locationController = TextEditingController(
      text: _currentLocation,
    );
    List<String> tempSelectedCrops = List.from(_currentSelectedCrops);

    await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        loc.editProfile,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        loc.updateProfileInfo,
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      const SizedBox(height: 24),

                      // Name Field
                      TextFormField(
                        controller: nameController,
                        decoration: InputDecoration(
                          labelText: loc.fullName,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          filled: true,
                          fillColor: Colors.grey[50],
                          prefixIcon: const Icon(
                            Icons.person_outline,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Location Field
                      TextFormField(
                        controller: locationController,
                        decoration: InputDecoration(
                          labelText: loc.farmLocation,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          filled: true,
                          fillColor: Colors.grey[50],
                          prefixIcon: const Icon(
                            Icons.location_on_outlined,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Crop Selection
                      Text(
                        loc.selectCrops,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        loc.chooseCrops,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 12),

                      // FIXED: Crop Selection Widget with initial selected crops
                      CropSelectionWidget(
                        key: ValueKey(
                          'edit_profile_${tempSelectedCrops.join(',')}',
                        ),
                        initialSelectedCrops:
                            tempSelectedCrops, // PASS INITIAL CROPS HERE
                        onCropsSelected: (crops) {
                          tempSelectedCrops = crops;
                        },
                      ),

                      const SizedBox(height: 24),

                      // Buttons
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () => Navigator.pop(context),
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                side: BorderSide(color: Colors.grey[300]!),
                              ),
                              child: Text(
                                loc.cancel,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () async {
                                if (nameController.text.isEmpty ||
                                    locationController.text.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(loc.fillAllFields)),
                                  );
                                  return;
                                }

                                if (tempSelectedCrops.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(loc.selectAtLeastOneCrop),
                                    ),
                                  );
                                  return;
                                }

                                try {
                                  setState(() {
                                    _isLoading = true;
                                  });

                                  final user = _auth.currentUser;
                                  if (user != null) {
                                    await _firestore
                                        .collection('users')
                                        .doc(user.uid)
                                        .update({
                                          'name': nameController.text.trim(),
                                          'location': locationController.text
                                              .trim(),
                                          'selectedCrops': tempSelectedCrops,
                                          'primaryCrop':
                                              tempSelectedCrops.isNotEmpty
                                              ? tempSelectedCrops.first
                                              : '',
                                          'updatedAt':
                                              FieldValue.serverTimestamp(),
                                        });

                                    // Update local state
                                    setState(() {
                                      _currentName = nameController.text.trim();
                                      _currentLocation = locationController.text
                                          .trim();
                                      _currentSelectedCrops = tempSelectedCrops;
                                      _currentPrimaryCrop =
                                          tempSelectedCrops.isNotEmpty
                                          ? tempSelectedCrops.first
                                          : '';
                                    });

                                    Navigator.pop(context);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(loc.profileUpdated),
                                        backgroundColor: Colors.green,
                                      ),
                                    );
                                  }
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        '${loc.errorUpdatingProfile} $e',
                                      ),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                } finally {
                                  if (mounted) {
                                    setState(() {
                                      _isLoading = false;
                                    });
                                  }
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 0,
                              ),
                              child: Text(
                                loc.saveChanges,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _showChangePasswordDialog() async {
    final loc = AppLocalizations.of(context)!;
    final TextEditingController oldPasswordController = TextEditingController();
    final TextEditingController newPasswordController = TextEditingController();
    final TextEditingController confirmPasswordController =
        TextEditingController();

    bool obscureOldPassword = true;
    bool obscureNewPassword = true;
    bool obscureConfirmPassword = true;
    String? errorMessage;

    await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        loc.changePassword,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        loc.enterNewPassword,
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      const SizedBox(height: 24),

                      // Error message if any
                      if (errorMessage != null)
                        Container(
                          padding: const EdgeInsets.all(12),
                          margin: const EdgeInsets.only(bottom: 16),
                          decoration: BoxDecoration(
                            color: Colors.red[50],
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.red[200]!),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.error_outline,
                                color: Colors.red[700],
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  errorMessage!,
                                  style: TextStyle(
                                    color: Colors.red[700],
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                      // Old Password
                      TextFormField(
                        controller: oldPasswordController,
                        obscureText: obscureOldPassword,
                        decoration: InputDecoration(
                          labelText: loc.currentPassword,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          filled: true,
                          fillColor: Colors.grey[50],
                          prefixIcon: const Icon(
                            Icons.lock_outline,
                            color: Colors.grey,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              obscureOldPassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setStateDialog(() {
                                obscureOldPassword = !obscureOldPassword;
                              });
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // New Password
                      TextFormField(
                        controller: newPasswordController,
                        obscureText: obscureNewPassword,
                        decoration: InputDecoration(
                          labelText: loc.newPassword,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          filled: true,
                          fillColor: Colors.grey[50],
                          prefixIcon: const Icon(
                            Icons.lock_reset,
                            color: Colors.grey,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              obscureNewPassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setStateDialog(() {
                                obscureNewPassword = !obscureNewPassword;
                              });
                            },
                          ),
                        ),
                        onChanged: (value) {
                          setStateDialog(() {
                            errorMessage = null;
                          });
                        },
                      ),
                      const SizedBox(height: 8),
                      Text(
                        loc.passwordHint,
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      const SizedBox(height: 16),

                      // Confirm New Password
                      TextFormField(
                        controller: confirmPasswordController,
                        obscureText: obscureConfirmPassword,
                        decoration: InputDecoration(
                          labelText: loc.confirmNewPassword,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          filled: true,
                          fillColor: Colors.grey[50],
                          prefixIcon: const Icon(
                            Icons.lock_outline,
                            color: Colors.grey,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              obscureConfirmPassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setStateDialog(() {
                                obscureConfirmPassword =
                                    !obscureConfirmPassword;
                              });
                            },
                          ),
                        ),
                        onChanged: (value) {
                          setStateDialog(() {
                            errorMessage = null;
                          });
                        },
                      ),

                      const SizedBox(height: 32),

                      // Buttons
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                side: BorderSide(color: Colors.grey[300]!),
                              ),
                              child: Text(
                                loc.cancel,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: TextButton(
                              onPressed: () async {
                                // Clear previous error
                                setStateDialog(() {
                                  errorMessage = null;
                                });

                                // Validation
                                if (oldPasswordController.text.isEmpty) {
                                  setStateDialog(() {
                                    errorMessage = loc.enterCurrentPassword;
                                  });
                                  return;
                                }

                                if (newPasswordController.text.isEmpty) {
                                  setStateDialog(() {
                                    errorMessage = loc.enterNewPassword;
                                  });
                                  return;
                                }

                                if (newPasswordController.text.length < 8) {
                                  setStateDialog(() {
                                    errorMessage = loc.passwordMinLength;
                                  });
                                  return;
                                }

                                if (newPasswordController.text !=
                                    confirmPasswordController.text) {
                                  setStateDialog(() {
                                    errorMessage = loc.passwordNotMatch;
                                  });
                                  return;
                                }

                                try {
                                  // Show loading
                                  setState(() {
                                    _isLoading = true;
                                  });

                                  final user = _auth.currentUser;
                                  if (user != null && user.email != null) {
                                    // Re-authenticate user with old password
                                    final credential =
                                        EmailAuthProvider.credential(
                                          email: user.email!,
                                          password: oldPasswordController.text,
                                        );

                                    await user.reauthenticateWithCredential(
                                      credential,
                                    );

                                    // Update password
                                    await user.updatePassword(
                                      newPasswordController.text,
                                    );

                                    Navigator.pop(context);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(loc.passwordUpdated),
                                        backgroundColor: Colors.green,
                                      ),
                                    );
                                  }
                                } on FirebaseAuthException catch (e) {
                                  if (e.code == 'wrong-password') {
                                    setStateDialog(() {
                                      errorMessage = loc.incorrectPassword;
                                    });
                                  } else if (e.code == 'weak-password') {
                                    setStateDialog(() {
                                      errorMessage = loc.weakPassword;
                                    });
                                  } else {
                                    setStateDialog(() {
                                      errorMessage = 'Error: ${e.message}';
                                    });
                                  }
                                } catch (e) {
                                  setStateDialog(() {
                                    errorMessage = loc.unexpectedError;
                                  });
                                } finally {
                                  if (mounted) {
                                    setState(() {
                                      _isLoading = false;
                                    });
                                  }
                                }
                              },
                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Text(
                                loc.done,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _showLanguageDialog() async {
    String tempSelectedLanguage = _selectedLanguage;

    await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      Text(
                        AppLocalizations.of(context)!.selectLanguage,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        AppLocalizations.of(context)!.choosePreferredLanguage,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Language Options
                      _buildLanguageOption(
                        context: context,
                        language: 'English',
                        isSelected: tempSelectedLanguage == 'English',
                        onTap: () {
                          setStateDialog(() {
                            tempSelectedLanguage = 'English';
                          });
                        },
                      ),
                      const SizedBox(height: 12),
                      _buildLanguageOption(
                        context: context,
                        language: 'Urdu',
                        isSelected: tempSelectedLanguage == 'Urdu',
                        onTap: () {
                          setStateDialog(() {
                            tempSelectedLanguage = 'Urdu';
                          });
                        },
                      ),

                      const SizedBox(height: 32),

                      // Buttons
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () => Navigator.pop(context),
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                side: BorderSide(color: Colors.grey[300]!),
                              ),
                              child: Text(
                                AppLocalizations.of(context)!.cancel,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () async {
                                try {
                                  setState(() {
                                    _isLoading = true;
                                  });

                                  final user = _auth.currentUser;
                                  if (user != null) {
                                    // Save language in Firestore
                                    await _firestore
                                        .collection('users')
                                        .doc(user.uid)
                                        .update({
                                          'language': tempSelectedLanguage,
                                          'updatedAt':
                                              FieldValue.serverTimestamp(),
                                        });

                                    setState(() {
                                      _selectedLanguage = tempSelectedLanguage;
                                    });

                                    // Switch app locale dynamically
                                    if (tempSelectedLanguage == 'English') {
                                      MyApp.setLocale(
                                        context,
                                        const Locale('en'),
                                      );
                                    } else if (tempSelectedLanguage == 'Urdu') {
                                      MyApp.setLocale(
                                        context,
                                        const Locale('ur'),
                                      );
                                    }

                                    Navigator.pop(context);

                                    // Show snackbar with placeholder method
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          AppLocalizations.of(
                                            context,
                                          )!.languageChangedTo(
                                            tempSelectedLanguage,
                                          ),
                                        ),
                                        backgroundColor: Colors.green,
                                      ),
                                    );
                                  }
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        '${AppLocalizations.of(context)!.errorChangingLanguage} $e',
                                      ),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                } finally {
                                  if (mounted) {
                                    setState(() {
                                      _isLoading = false;
                                    });
                                  }
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 0,
                              ),
                              child: Text(
                                AppLocalizations.of(context)!.save,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildLanguageOption({
    required BuildContext context,
    required String language,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? Colors.green.withOpacity(0.1) : Colors.grey[50],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Colors.green : Colors.grey[300]!,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              isSelected
                  ? Icons.radio_button_checked
                  : Icons.radio_button_unchecked,
              color: isSelected ? Colors.green : Colors.grey,
            ),
            const SizedBox(width: 16),
            Text(
              language,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: isSelected ? Colors.green : Colors.black87,
              ),
            ),
            const Spacer(),
            if (language == 'English')
              const Text('English', style: TextStyle(color: Colors.grey)),
            if (language == 'Urdu')
              const Text(
                'اردو',
                style: TextStyle(color: Colors.grey, fontSize: 18),
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          loc.settings,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        // Profile Picture
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.green, width: 3),
                          ),
                          child: ClipOval(
                            child: Image.asset(
                              'assets/images/profile_placeholder.png',
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: Colors.grey[200],
                                  child: const Icon(
                                    Icons.person,
                                    size: 50,
                                    color: Colors.grey,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Name
                        Text(
                          _currentName,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),

                        const SizedBox(height: 4),

                        // Email
                        Text(
                          _userEmail,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                          textAlign: TextAlign.center,
                        ),

                        const SizedBox(height: 16),

                        // Edit Profile Button
                        ElevatedButton(
                          onPressed: _isLoading ? null : _showEditProfileDialog,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 10,
                            ),
                          ),
                          child: _isLoading
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white,
                                    ),
                                  ),
                                )
                              : Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.edit, size: 16),
                                    SizedBox(width: 8),
                                    Text(loc.editProfile),
                                  ],
                                ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Farm Information Card
                Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title
                        Padding(
                          padding: EdgeInsets.only(bottom: 16),
                          child: Text(
                            loc.farmInformation,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ),

                        // Location
                        _buildInfoRow(
                          icon: Icons.location_on,
                          title: loc.location,
                          value: _currentLocation,
                          showDivider: true,
                        ),

                        // Chosen Crops
                        _buildInfoRow(
                          icon: Icons.agriculture,
                          title: loc.chosenCrops,
                          value: _currentSelectedCrops.isNotEmpty
                              ? _currentSelectedCrops.join(', ')
                              : loc.noCropsSelected,
                          showDivider: true,
                        ),

                        // Primary Crop
                        _buildInfoRow(
                          icon: Icons.star,
                          title: loc.primaryCrop,
                          value: _currentPrimaryCrop.isNotEmpty
                              ? _currentPrimaryCrop
                              : loc.notSet,
                          showDivider: false,
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Preferences Card (NEW)
                Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title
                        Padding(
                          padding: EdgeInsets.only(bottom: 16),
                          child: Text(
                            loc.preferences,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ),

                        // Language Preference
                        _buildActionTile(
                          icon: Icons.language,
                          title: loc.language,
                          subtitle: _selectedLanguage,
                          onTap: _isLoading ? null : _showLanguageDialog,
                          showDivider: false,
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Account Actions Card
                Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title
                        Padding(
                          padding: EdgeInsets.only(bottom: 16),
                          child: Text(
                            loc.account,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ),

                        // Change Password
                        _buildActionTile(
                          icon: Icons.lock_outline,
                          title: loc.changePassword,
                          subtitle: null,
                          onTap: _isLoading ? null : _showChangePasswordDialog,
                          showDivider: false,
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String title,
    required String value,
    required bool showDivider,
  }) {
    return Column(
      children: [
        Row(
          children: [
            Icon(icon, color: Colors.green, size: 22),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        if (showDivider) ...[
          const SizedBox(height: 16),
          const Divider(height: 1),
          const SizedBox(height: 16),
        ],
      ],
    );
  }

  Widget _buildActionTile({
    required IconData icon,
    required String title,
    required String? subtitle,
    required VoidCallback? onTap,
    required bool showDivider,
  }) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: onTap == null ? Colors.grey : Colors.green,
                  size: 22,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 16,
                          color: onTap == null ? Colors.grey : Colors.black87,
                        ),
                      ),
                      if (subtitle != null) ...[
                        const SizedBox(height: 2),
                        Text(
                          subtitle,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: onTap == null ? Colors.grey : Colors.grey,
                ),
              ],
            ),
          ),
        ),
        if (showDivider) const Divider(height: 1),
      ],
    );
  }
}
