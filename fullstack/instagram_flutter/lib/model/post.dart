// import 'package:cloud_firestore/cloud_firestore.dart';

// class Post {
//   final String description;
//   final String uid;
//   final String username;
//   final String postId;
//   final List<String> followers; // only storing uid
//   final List<String> following;
//   final String datePublished;

//   const Post({
//     required this.uid,
//     required this.email,
//     required this.username,
//     required this.bio,
//     required this.followers,
//     required this.following,
//     required this.photoURL,
//   });
//   factory User.fromJSON(Map<String, dynamic> json) => User(
//         uid: json['uid'],
//         email: json['email'],
//         username: json['username'],
//         bio: json['bio'],
//         followers: json['followers'],
//         following: json['following'],
//         photoURL: json['photo-url'],
//       );
//   factory User.fromSnap(DocumentSnapshot snap) =>
//       User.fromJSON(snap.data() as Map<String, dynamic>);
//   Map<String, dynamic> toJSON() => {
//         'username': username,
//         'uid': uid,
//         'email': email,
//         'bio': bio,
//         'followers': followers,
//         'following': following,
//         'photo-url': photoURL,
//       };
// }