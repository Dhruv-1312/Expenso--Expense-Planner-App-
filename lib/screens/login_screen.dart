import 'package:expenso/resources/auth.dart';
import 'package:expenso/responsive/mobileScreen.dart';
import 'package:expenso/screens/signup.dart';
import 'package:expenso/utils/colors.dart';
import 'package:expenso/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'welcomScreen/body.dart';

class LoginSceen extends StatefulWidget {
  const LoginSceen({super.key});

  @override
  State<LoginSceen> createState() => _LoginSceenState();
}

class _LoginSceenState extends State<LoginSceen> {
  final TextEditingController emailControl = TextEditingController();
  final TextEditingController passwordControl = TextEditingController();
  bool isloading = false;
  bool isvisible = false;

  void login() async {
    setState(() {
      isloading = true;
    });
    String res = await AuthMethods()
        .login(email: emailControl.text, password: passwordControl.text);
    setState(() {
      isloading = false;
    });
    if (res != 'success') {
      ShowSnackBar(res, context);
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const MobileScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: LoginBackground(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/Component 1.png',
              scale: 0.8,
              width: size.width / 2.6,
            ),
            // const Text(
            //   'Login',
            //   style:
            //       TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            // ),
            SizedBox(
              height: size.height * 0.04,
            ),
            SvgPicture.asset(
              'assets/images/login.svg',
              height: size.height * 0.35,
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            RoundedTextField(
              emailcontrol: emailControl,
              hintText: 'Enter Your Email',
              onchanged: (value) {},
            ),
            textfieldContainer(
              child: TextField(
                controller: passwordControl,
                obscureText: !isvisible,
                decoration: InputDecoration(
                    hintText: 'Enter Your Password',
                    icon: const Icon(
                      Icons.lock,
                      color: kPrimaryColor,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isvisible = !isvisible;
                        });
                      },
                      icon: Icon(
                        isvisible ? Icons.visibility : Icons.visibility_off,
                        color: kPrimaryColor,
                      ),
                    ),
                    border: InputBorder.none),
              ),
            ),
            RoundedButton(
                isloading: isloading,
                text: 'Login',
                color: kPrimaryColor,
                onpress: login,
                textcolor: Colors.white),
            SizedBox(
              height: size.height * 0.01,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Don't have an account? ",
                  style: TextStyle(color: kPrimaryColor),
                ),
                GestureDetector(
                  onTap: () => Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => const Signup())),
                  child: const Text(
                    "Sign up",
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

class RoundedTextField extends StatelessWidget {
  final TextEditingController emailcontrol;
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onchanged;
  const RoundedTextField({
    required this.emailcontrol,
    required this.hintText,
    this.icon = Icons.person,
    required this.onchanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return textfieldContainer(
      child: TextField(
        controller: emailcontrol,
        onChanged: onchanged,
        decoration: InputDecoration(
            hintText: hintText,
            icon: Icon(
              icon,
              color: kPrimaryColor,
            ),
            border: InputBorder.none),
      ),
    );
  }
}

class textfieldContainer extends StatelessWidget {
  final Widget child;
  const textfieldContainer({
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: size.width * 0.8,
      decoration: BoxDecoration(
        color: kPrimaryLightColor,
        borderRadius: BorderRadius.circular(29),
      ),
      child: child,
    );
  }
}

class LoginBackground extends StatelessWidget {
  final Widget child;
  const LoginBackground({
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset(
              'assets/images/main_top.png',
              width: size.width * 0.35,
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset(
              'assets/images/login_bottom.png',
              width: size.width * 0.4,
            ),
          ),
          child,
        ],
      ),
    );
  }
}
