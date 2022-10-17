import 'package:flutter/material.dart';
import 'package:instagram_flutter/views/add_post_view.dart';
import 'package:instagram_flutter/views/login_view.dart';

const int webScreenSize = 600;
const homeScreenItems = [
  LoginView(),
  Text("search"),
  AddPostView(),
  Text("notif"),
  Text("profile"),
];
