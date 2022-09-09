import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:firebase_auth/firebase_auth.dart";
import 'package:instagram_flutter/model/user_model.dart' as model;
import './storage_methods.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> login({
    required String email,
    required String password,
  }) async {
    String res = "";
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      res = "success";
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

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
        String photoURL = await StorageMethods().uploadToStorage(
          'profilePics',
          file,
          false,
        );
        model.User newUser = model.User(
          bio: bio,
          email: email,
          username: username,
          uid: userCred.user!.uid,
          followers: [],
          following: [],
          photoURL: photoURL,
        );

        _firestore
            .collection('users')
            .doc(userCred.user!.uid)
            .set(newUser.toJSON());
        res = 'success';
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
