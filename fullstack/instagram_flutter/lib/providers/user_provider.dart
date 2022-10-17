import "package:flutter/material.dart";
import 'package:instagram_flutter/resources/auth_methods.dart';
import "../model/user_model.dart";

class UserProvider extends ChangeNotifier {
  User? _user;
  final _authMethods = AuthMethods();
  User? get getUser => _user;

  Future<void> refreshUser() async {
    final User user = await _authMethods.getUserDetails();
    _user = user;
    notifyListeners();
  }
}
