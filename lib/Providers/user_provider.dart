import 'package:expenso/Models/users.dart';
import 'package:expenso/resources/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier{

  users?_user;
  final AuthMethods _authmethods=AuthMethods();

  users get getUser=>_user?? users(username: '', email: '', budget: '', photoUrl: '', uid: '', password: '');

  Future<void>refreshUser()async{
    users user=await _authmethods.getuserdetails();
    _user=user;
    notifyListeners();
  }
} 