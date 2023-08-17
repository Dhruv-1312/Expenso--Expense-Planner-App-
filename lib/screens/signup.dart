import 'package:expenso/screens/login_screen.dart';

import 'package:expenso/screens/welcomScreen/body.dart';
import 'package:expenso/utils/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:expenso/resources/auth.dart';
import 'package:expenso/responsive/mobileScreen.dart';
import 'package:expenso/utils/utils.dart';
import 'package:image_picker/image_picker.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  Uint8List? _image;
  final TextEditingController emailControl = TextEditingController();
  final TextEditingController budgetControl = TextEditingController();
  final TextEditingController passControl = TextEditingController();
  final TextEditingController usernameControl = TextEditingController();
  bool isloading = false;

  void selectImage() async {
    Uint8List im = await pickimage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  void signupUser() async {
    setState(() {
      isloading = true;
    });
    if (_image == null) {
      setState(() {
        isloading=false;
      });
      return ShowSnackBar('Please Enter Profile Picture', context);
    }
    String res = await AuthMethods().createUser(
        username: usernameControl.text,
        email: emailControl.text,
        password: passControl.text,
        budget: budgetControl.text,
        file: _image!);
    setState(() {
      isloading = false;
    });
    if (res != 'success') {
      ShowSnackBar(res, context);
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => MobileScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SignupBackground(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/Component 1.png',
              scale: 0.8,
              width: size.width / 2.6,
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            Stack(
              children: [
                (_image != null)
                    ? CircleAvatar(
                        radius: 60,
                        backgroundImage: MemoryImage(_image!),
                      )
                    : const CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage(
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRYd77KFsw2Xd6mepJr49JeM4QDX2bMmjCF0LHaviMrGQ&usqp=CAU&ec=48665698'),
                      ),
                Positioned(
                  bottom: -10,
                  right: 2,
                  child: IconButton(
                    onPressed: selectImage,
                    icon: Icon(Icons.add_a_photo),
                  ),
                ),
              ],
            ),
            Newtextfield(
              control: usernameControl,
              hinttext: 'Enter your username',
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            Newtextfield(control: emailControl, hinttext: 'Enter your Email'),
            SizedBox(
              height: size.height * 0.01,
            ),
            Newtextfield(
              control: budgetControl,
              hinttext: 'Enter your budget',
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            Newtextfield(
              control: passControl,
              hinttext: 'Enter your password',
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            RoundedButton(
                text: 'Signup',
                color: kPrimaryColor,
                onpress: signupUser,
                textcolor: Colors.white,
                isloading: isloading),
            SizedBox(
              height: size.height * 0.01,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Already have an account? ",
                  style: TextStyle(color: kPrimaryColor),
                ),
                GestureDetector(
                  onTap: () => Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                          builder: (context) => const LoginSceen())),
                  child: const Text(
                    "Login",
                    style: TextStyle(
                        color: kPrimaryColor, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class Newtextfield extends StatelessWidget {
  final String hinttext;
  const Newtextfield(
      {super.key, required this.control, required this.hinttext});

  final TextEditingController control;

  @override
  Widget build(BuildContext context) {
    return textfieldContainer(
      child: TextField(
        controller: control,
        obscureText: false,
        decoration:
            InputDecoration(border: InputBorder.none, hintText: hinttext),
      ),
    );
  }
}

class SignupBackground extends StatelessWidget {
  final Widget child;
  const SignupBackground({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset(
              'assets/images/signup_top.png',
              width: size.width * 0.4,
            ),
          ),
          child,
        ],
      ),
    );
  }
}
