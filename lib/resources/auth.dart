import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expenso/resources/storage_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:expenso/Models/users.dart' as models;

class AuthMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<models.users> getuserdetails() async {
    User currentUser = _auth.currentUser!;
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
        .get();

    return models.users.fromsnap(snapshot);
  }

  Future<String> createUser(
      {required String username,
      required String email,
      required String password,
      required String budget,
      required Uint8List file}) async {
    String res = 'error';

    try {
      if (username.isNotEmpty &&
          password.isNotEmpty &&
          email.isNotEmpty &&
          budget.isNotEmpty &&
          file != null) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        String photoUrl =
            await StorageMethods().uploadImage("profileImage", file, false);

        models.users user = models.users(
            username: username,
            email: email,
            budget: budget,
            photoUrl: photoUrl,
            uid: FirebaseAuth.instance.currentUser!.uid,
            password: password);

        FirebaseFirestore.instance
            .collection('users')
            .doc(_auth.currentUser!.uid)
            .set(user.toJason());
        res = 'success';
      } else {
        res = 'Enter all the fields';
      }
    } catch (e) {
      res = e.toString();
      print(res);
    }
    return res;
  }

  Future<String> Signout() async {
    String res = 'Error';
    try {
      await FirebaseAuth.instance.signOut();
      res = 'success';
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<String> login({
    required String email,
    required String password,
  }) async {
    String res = 'error';
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = 'success';
      } else {
        res = 'Please enter all the fields';
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
