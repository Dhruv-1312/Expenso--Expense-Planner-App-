import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expenso/resources/auth.dart';
import 'package:expenso/screens/welcomScreen/body.dart';
import 'package:expenso/screens/welcomScreen/welcome_screen.dart';
import 'package:expenso/utils/colors.dart';
import 'package:expenso/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var userdata = {};
  bool isloading = false;
  var image;
  @override
  void initState() {
    super.initState();
    getdata();
  }

  getdata() async {
    try {
      setState(() {
        isloading = true;
      });
      var snap = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      userdata = snap.data()!;
      var image = userdata['photoUrl'];
      setState(() {
        isloading = false;
      });
    } catch (e) {
      ShowSnackBar(e.toString(), context);
    }
  }

  void signoutUser() async {
    setState(() {
      isloading = true;
    });
    String res = await AuthMethods().Signout();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const WelcomeScreen()));
    setState(() {
      isloading = false;
    });

    if (res != 'success') {
      ShowSnackBar(res, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    // models.users user = Provider.of<UserProvider>(context).getUser;
    Size size = MediaQuery.of(context).size;
    return isloading
        ? const Center(
            child: CircularProgressIndicator(
              color: kPrimaryColor,
            ),
          )
        : Scaffold(
            appBar: AppBar(
              leading: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              backgroundColor: kPrimaryColor,
              elevation: 0,
              title: const Text(
                'Profile',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w400),
              ),
            ),
            body: Stack(
              children: [
                Stack(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        padding: const EdgeInsets.only(left: 20),
                        width: size.width,
                        height: size.height / 3.5,
                        decoration: const BoxDecoration(color: kPrimaryColor),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: size.width,
                        height: size.height - (size.height / 3.5),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(userdata['photoUrl']),
                        radius: 70,
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Text(
                        userdata['username'],
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 17),
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      Text(
                        userdata['email'],
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      RoundedButton(
                          text: 'Edit Profile',
                          color: kPrimaryLightColor,
                          onpress: () {},
                          textcolor: Colors.black,
                          isloading: isloading),
                      RoundedButton(
                          text: 'Signout',
                          color: kPrimaryColor,
                          onpress: signoutUser,
                          textcolor: Colors.white,
                          isloading: isloading),
                          SizedBox(
                        height: MediaQuery.of(context).size.height /3,
                      ),
                      const Text(
                        'Created By Dhruv Dhall!!',
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                            fontSize: 18),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
  }
}
