import 'package:firebase_auth/firebase_auth.dart' as firebase_auth show User;
import 'package:flutter/foundation.dart';

@immutable
class AuthUser {
  final bool isEmailVerified;
  final String id;
  final String email;
  const AuthUser({
    required this.isEmailVerified,
    required this.email,
    required this.id,
  });
  factory AuthUser.fromFirebase(firebase_auth.User user) => AuthUser(
        id: user.uid,
        isEmailVerified: user.emailVerified,
        email: user.email!,
      );
}
