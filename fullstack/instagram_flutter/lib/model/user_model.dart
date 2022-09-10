import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String email;
  final String uid;
  final String username;
  final String bio;
  final List<String> followers; // only storing uid
  final List<String> following;
  final String photoURL;

  const User({
    required this.uid,
    required this.email,
    required this.username,
    required this.bio,
    required this.followers,
    required this.following,
    required this.photoURL,
  });
  factory User.fromJSON(Map<String, dynamic> json) => User(
        uid: json['uid'],
        email: json['email'],
        username: json['username'],
        bio: json['bio'],
        followers: json['followers'],
        following: json['following'],
        photoURL: json['photo-url'],
      );
  factory User.fromSnap(DocumentSnapshot snap) =>
      User.fromJSON(snap.data() as Map<String, dynamic>);
  Map<String, dynamic> toJSON() => {
        'username': username,
        'uid': uid,
        'email': email,
        'bio': bio,
        'followers': followers,
        'following': following,
        'photo-url': photoURL,
      };
}
