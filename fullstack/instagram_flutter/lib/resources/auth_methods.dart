import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:firebase_auth/firebase_auth.dart";

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> registerUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,
  }) async {
    String res = "";
    try {
      if (email.isNotEmpty &&
          password.isNotEmpty &&
          username.isNotEmpty &&
          bio.isNotEmpty) {
        UserCredential userCred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        _firestore.collection('users').doc(userCred.user!.uid).set({
          'username': username,
          'uid': userCred.user!.uid,
          'email': email,
          'bio': bio,
          'profile-picture': file,
          'followers': [],
          'following': [],
        });
        res = 'success';
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
