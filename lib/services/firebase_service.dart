import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get current user
  User? get currentUser => _auth.currentUser;

  // Stream for auth state changes
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Sign up with email and password
  Future<User?> signUp({
    required String email,
    required String password,
    required String name,
    required String location,
    required List<String> selectedCrops,
    required String landArea,
    required String landUnit,
  }) async {
    try {
      // Create user with email and password
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Create user document in Firestore
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': email,
        'name': name,
        'location': location,
        'selectedCrops': selectedCrops,
        'landArea': landArea,
        'landUnit': landUnit,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });

      return userCredential.user;
    } catch (e) {
      if (kDebugMode) {
        print('Sign up error: $e');
      }
      rethrow;
    }
  }

  // Sign in with email and password
  Future<User?> signIn({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      if (kDebugMode) {
        print('Sign in error: $e');
      }
      rethrow;
    }
  }

  // Sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Get user data from Firestore
  Future<Map<String, dynamic>?> getUserData(String uid) async {
    try {
      DocumentSnapshot userDoc = await _firestore.collection('users').doc(uid).get();
      if (userDoc.exists) {
        return userDoc.data() as Map<String, dynamic>;
      }
      return null;
    } catch (e) {
      if (kDebugMode) {
        print('Get user data error: $e');
      }
      return null;
    }
  }

  // Update user preferences
  Future<void> updateUserPreferences({
    required String uid,
    String? location,
    List<String>? selectedCrops,
    String? landArea,
    String? landUnit,
  }) async {
    try {
      Map<String, dynamic> updates = {
        'updatedAt': FieldValue.serverTimestamp(),
      };

      if (location != null) updates['location'] = location;
      if (selectedCrops != null) updates['selectedCrops'] = selectedCrops;
      if (landArea != null) updates['landArea'] = landArea;
      if (landUnit != null) updates['landUnit'] = landUnit;

      await _firestore.collection('users').doc(uid).update(updates);
    } catch (e) {
      if (kDebugMode) {
        print('Update preferences error: $e');
      }
      rethrow;
    }
  }

  // Check if user exists
  Future<bool> checkUserExists(String email) async {
    try {
      // Note: This is not directly possible with Firebase Auth
      // We'll check in Firestore instead
      QuerySnapshot query = await _firestore
          .collection('users')
          .where('email', isEqualTo: email)
          .limit(1)
          .get();

      return query.docs.isNotEmpty;
    } catch (e) {
      if (kDebugMode) {
        print('Check user exists error: $e');
      }
      return false;
    }
  }

  // Reset password
  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      if (kDebugMode) {
        print('Reset password error: $e');
      }
      rethrow;
    }
  }
}