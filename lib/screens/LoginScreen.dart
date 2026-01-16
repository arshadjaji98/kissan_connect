import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kissan_connect_app_2/l10n/app_localizations.dart';
import '../routes.dart';
import '../services/firebase_service.dart';
import 'package:flutter/foundation.dart';

class LoginScreen extends StatefulWidget {
  final FirebaseService? firebaseService;

  const LoginScreen({super.key, this.firebaseService});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _rememberMe = false;
  bool _isLoading = false;
  String _errorMessage = '';

  // Firestore instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _signIn() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      final firebaseService = widget.firebaseService ?? FirebaseService();

      await firebaseService.signIn(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      // Get current user
      final currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser != null) {
        // Fetch user data from Firestore
        await _fetchUserDataAndNavigate(currentUser.uid);
      } else {
        setState(() {
          _errorMessage =
              'Login successful but user data not available. Please try again.';
          _isLoading = false;
        });
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'user-not-found':
          errorMessage = 'No account found with this email.';
          break;
        case 'wrong-password':
          errorMessage = 'Incorrect password. Please try again.';
          break;
        case 'invalid-credential':
          errorMessage = 'Invalid email or password.';
          break;
        case 'user-disabled':
          errorMessage = 'This account has been disabled.';
          break;
        case 'too-many-requests':
          errorMessage = 'Too many login attempts. Please try again later.';
          break;
        case 'network-request-failed':
          errorMessage =
              'Network error. Please check your internet connection.';
          break;
        default:
          errorMessage = 'Login failed: ${e.message}';
      }

      setState(() {
        _errorMessage = errorMessage;
      });
    } catch (e) {
      if (kDebugMode) {
        print('Login error: $e');
      }
      setState(() {
        _errorMessage = 'An unexpected error occurred. Please try again.';
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _fetchUserDataAndNavigate(String userId) async {
    try {
      // Fetch user document from Firestore
      final userDoc = await _firestore.collection('users').doc(userId).get();

      if (userDoc.exists) {
        final userData = userDoc.data() as Map<String, dynamic>;

        // Extract user data with fallback defaults
        final userName =
            userData['name'] ?? userData['displayName'] ?? 'Farmer';
        final userLocation =
            userData['location'] ?? userData['address'] ?? 'Your Location';

        // Extract selected crops - handle different possible field names
        List<String> selectedCrops = [];
        if (userData['selectedCrops'] != null) {
          if (userData['selectedCrops'] is List) {
            selectedCrops = List<String>.from(userData['selectedCrops']);
          }
        } else if (userData['crops'] != null) {
          if (userData['crops'] is List) {
            selectedCrops = List<String>.from(userData['crops']);
          }
        }

        // If no crops found in database, use default
        if (selectedCrops.isEmpty) {
          selectedCrops = ['Wheat']; // Default crop
        }

        // Determine primary crop (first one in list or from database)
        final primaryCrop =
            userData['primaryCrop'] ??
            (selectedCrops.isNotEmpty ? selectedCrops[0] : 'Wheat');

        // Navigate to HomeScreen with all the data
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.home,
          (route) => false,
          arguments: {
            'userName': userName,
            'userLocation': userLocation,
            'selectedCrops': selectedCrops,
            'primaryCrop': primaryCrop,
            'userId': userId,
            'userEmail': FirebaseAuth.instance.currentUser?.email ?? '',
          },
        );
      } else {
        // User document doesn't exist - create a default one
        await _createDefaultUserDocument(userId);

        // Navigate with default data
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.home,
          (route) => false,
          arguments: {
            'userName': 'Farmer',
            'userLocation': 'Your Location',
            'selectedCrops': ['Wheat'],
            'primaryCrop': 'Wheat',
            'userId': userId,
            'userEmail': FirebaseAuth.instance.currentUser?.email ?? '',
          },
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching user data: $e');
      }

      // On error, navigate with default data
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.home,
        (route) => false,
        arguments: {
          'userName': 'Farmer',
          'userLocation': 'Your Location',
          'selectedCrops': ['Wheat'],
          'primaryCrop': 'Wheat',
          'userId': userId,
          'userEmail': FirebaseAuth.instance.currentUser?.email ?? '',
        },
      );
    }
  }

  Future<void> _createDefaultUserDocument(String userId) async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      final userEmail = currentUser?.email ?? '';
      final displayName = currentUser?.displayName ?? 'Farmer';

      await _firestore.collection('users').doc(userId).set({
        'name': displayName,
        'email': userEmail,
        'location': 'Your Location',
        'selectedCrops': ['Wheat'],
        'primaryCrop': 'Wheat',
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      if (kDebugMode) {
        print('Error creating default user document: $e');
      }
    }
  }

  Future<void> _resetPassword() async {
    final loc = AppLocalizations.of(context)!;
    final email = _emailController.text.trim();

    if (email.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(loc.reset_password),
          content: Text(loc.please_enter_email),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(loc.ok),
            ),
          ],
        ),
      );
      return;
    }

    try {
      final firebaseService = widget.firebaseService ?? FirebaseService();
      await firebaseService.resetPassword(email);

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(loc.password_reset_sent_message),
          content: Text(loc.password_sent_to_email(email)),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(loc.ok),
            ),
          ],
        ),
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(loc.error),
          content: Text(loc.password_reset_failed),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(loc.ok),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          localizations.login,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Welcome back section
              Container(
                margin: const EdgeInsets.only(bottom: 32),
                child: Column(
                  children: [
                    Text(
                      localizations.welcome_back,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.green[800],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      localizations.signin_continue,
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ],
                ),
              ),

              // Error message
              if (_errorMessage.isNotEmpty)
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
                      Icon(Icons.error_outline, color: Colors.red[700]),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          _errorMessage,
                          style: TextStyle(color: Colors.red[700]),
                        ),
                      ),
                    ],
                  ),
                ),

              // Email Field
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: localizations.email,
                  hintText: localizations.enter_email,
                  prefixIcon: Icon(Icons.email_outlined),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return localizations.enter_email_first;
                  }
                  if (!value.contains('@') || !value.contains('.')) {
                    return localizations.please_enter_valid_email;
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // Password Field
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: localizations.password,
                  hintText: localizations.enter_password,
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                  border: const OutlineInputBorder(),
                ),
                obscureText: _obscurePassword,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return localizations.enter_password;
                  }
                  if (value.length < 8) {
                    return localizations.password_min_8;
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // Remember me and Forgot password
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: _rememberMe,
                        onChanged: (value) {
                          setState(() {
                            _rememberMe = value!;
                          });
                        },
                        activeColor: const Color(0xFF4CAF50),
                      ),
                      Text(localizations.remember_me),
                    ],
                  ),
                  TextButton(
                    onPressed: _isLoading ? null : _resetPassword,
                    child: Text(
                      localizations.forgot_password,
                      style: TextStyle(color: Color(0xFF4CAF50)),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Log In Button
              ElevatedButton(
                onPressed: _isLoading ? null : _signIn,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4CAF50),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: _isLoading
                    ? const SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                        ),
                      )
                    : Text(
                        localizations.log_in,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),

              const SizedBox(height: 24),

              // Divider
              Row(
                children: [
                  Expanded(child: Divider(color: Colors.grey[300])),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      localizations.or_continue_with,
                      style: TextStyle(color: Colors.grey[600], fontSize: 14),
                    ),
                  ),
                  Expanded(child: Divider(color: Colors.grey[300])),
                ],
              ),

              const SizedBox(height: 24),

              // Social login buttons (optional - can be removed)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Google
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.g_mobiledata, size: 24),
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.grey[100],
                      padding: const EdgeInsets.all(16),
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Facebook
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.facebook,
                      size: 24,
                      color: Colors.blue,
                    ),
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.grey[100],
                      padding: const EdgeInsets.all(16),
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Apple
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.apple,
                      size: 24,
                      color: Colors.black,
                    ),
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.grey[100],
                      padding: const EdgeInsets.all(16),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // Sign up link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(localizations.dont_have_account),
                  // const SizedBox(width: 8),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.signup);
                    },
                    child: Text(
                      localizations.sign_up,
                      style: TextStyle(
                        color: Color(0xFF4CAF50),
                        fontWeight: FontWeight.bold,
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
  }
}
