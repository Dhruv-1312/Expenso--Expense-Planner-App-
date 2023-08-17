import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class users {
  final String username;
  final String uid;
  final String email;
  final budget;
  final String photoUrl;
  final String password;

  const users(
      {required this.username,
      required this.email,
      required this.budget,
      required this.photoUrl,
      required this.uid,
      required this.password});

  Map<String, dynamic> toJason() => {
        'username': username,
        'uid': uid,
        'email': email,
        'budget': budget,
        'photoUrl': photoUrl,
        'password':password
      };
// State managment ka part hai store krane ka nhi 
  static users fromsnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return users(
      username: snapshot['username'],
      uid: snapshot['uid'],
      email: snapshot['email'],
      budget: snapshot['budget'],
      photoUrl: snapshot['photoUrl'],
      password: snapshot['password'],
    );
  }
}
