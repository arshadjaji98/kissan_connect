import 'package:flutter/material.dart';
// FIX: Use relative path to import the routes file
import '../routes.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // We do not set a background color here because the image covers it
      body: Stack(
        children: [
          // ------------------------------------------------
          // 1. BACKGROUND IMAGE
          // ------------------------------------------------
          Positioned.fill(
            child: Image.asset(
              'assets/images/welcome_background.png',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                // Fallback gradient if image fails to load
                return Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.blue.shade300, Colors.green.shade700],
                    ),
                  ),
                );
              },
            ),
          ),

          // ------------------------------------------------
          // 2. DARK OVERLAY (Optional)
          // Adds a slight dark tint so white text is readable
          // regardless of how bright the background image is.
          // ------------------------------------------------
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.3),
            ),
          ),

          // ------------------------------------------------
          // 3. CONTENT LAYER
          // ------------------------------------------------
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
              child: Column(
                children: [
                  // --- Top Bar: Language ---


                  // Flexible spacer to push content down
                  Flexible(
                    child: Container(),
                    flex: 1,
                  ),

                  // --- LOGO (Enlarged) ---
                  Flexible(
                    flex: 3, // Takes more space
                    child: Center(
                      child: Container(
                        constraints: const BoxConstraints(
                          maxHeight: 500, // Reduced from 600
                          maxWidth: 500,  // Reduced from 600
                        ),
                        child: Image.asset(
                          'assets/images/logo2.png',
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(
                              Icons.eco,
                              size: 600, // Reduced size
                              color: Colors.lightGreenAccent,
                            );
                          },
                        ),
                      ),
                    ),
                  ),

                  // Flexible spacer to push buttons up
                  Flexible(
                    child: Container(),
                    flex: 2,
                  ),

                  // Button Section - Fixed at bottom
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // ------------------------------------------------
                      // SIGN UP BUTTON
                      // ------------------------------------------------
                      SizedBox(
                        width: double.infinity, // Full width
                        height: 55,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed(AppRoutes.signup);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF00C853), // Bright Green
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30), // Pill shape
                            ),
                          ),
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // ------------------------------------------------
                      // LOGIN BUTTON (Transparent with Border)
                      // ------------------------------------------------
                      SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed(AppRoutes.login);
                          },
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Colors.white, width: 1.5),
                            backgroundColor: Colors.white.withOpacity(0.15), // Glassy effect
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: const Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 30), // Bottom padding
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}