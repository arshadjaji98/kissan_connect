import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/firebase_service.dart';
import 'WelcomeScreen.dart';
import 'HomeScreen.dart';

class AuthWrapper extends StatelessWidget {
  final FirebaseService firebaseService;

  const AuthWrapper({super.key, required this.firebaseService});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: firebaseService.authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasData) {
          return FutureBuilder<Map<String, dynamic>?>(
            future: firebaseService.getUserData(snapshot.data!.uid),
            builder: (context, userDataSnapshot) {
              if (userDataSnapshot.connectionState == ConnectionState.waiting) {
                return const Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                );
              }

              if (userDataSnapshot.hasData && userDataSnapshot.data != null) {
                final userData = userDataSnapshot.data!;
                return HomeScreen(
                  userLocation: userData['location'] ?? 'Your Location',
                  userName: userData['name'] ?? 'Farmer',
                  selectedCrops: List<String>.from(
                    userData['selectedCrops'] ?? ['Wheat'],
                  ),
                  primaryCrop:
                      userData['selectedCrops'] != null &&
                          (userData['selectedCrops'] as List).isNotEmpty
                      ? (userData['selectedCrops'] as List).first
                      : 'Wheat',
                );
              }
              return HomeScreen(
                userLocation: 'Your Location',
                userName: 'Farmer',
                selectedCrops: ['Wheat'],
                primaryCrop: 'Wheat',
              );
            },
          );
        } else {
          return const WelcomeScreen();
        }
      },
    );
  }
}
