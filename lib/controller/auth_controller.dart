import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  Future<User?> createUserWithEmailandPassword(
      String name, String email, String password) async {
    try {
      final credentials = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      // Add user details to Firestore
      var users = _firestore.collection('users');
      await users.add({
        'name': name,
        'email': email,
      });

      return credentials.user;
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  Future<User?> login(String email, String password) async {
    try {
      final credentials = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      return credentials.user;
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  Future<void> logout() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }
}
