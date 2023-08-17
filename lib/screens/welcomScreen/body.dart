import 'package:expenso/screens/login_screen.dart';
import 'package:expenso/screens/signup.dart';
import 'package:expenso/screens/welcomScreen/background.dart';
import 'package:expenso/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Body extends StatefulWidget {
  const Body({super.key});
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool _isloading = false;
  void navigateTologin() {
    setState(() {
      _isloading = true;
    });
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => LoginSceen(),
      ),
    );
    setState(() {
      _isloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return background(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'assets/images/Component 1.png',
            scale: 0.8,
            width: size.width / 2.6,
          ),
          SizedBox(
            height: size.height * 0.04,
          ),
          SvgPicture.asset(
            'assets/icons/chat.svg',
            height: size.height * 0.45,
          ),
          SizedBox(
            height: size.height * 0.05,
          ),
          RoundedButton(
            isloading: _isloading,
            text: 'Login',
            color: kPrimaryColor,
            textcolor: Colors.white,
            onpress: navigateTologin,
          ),
          RoundedButton(
              isloading: false,
              text: 'Signup',
              color: kPrimaryLightColor,
              onpress: () => Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const Signup(),
                    ),
                  ),
              textcolor: Colors.black)
        ],
      ),
    );
  }
}

class RoundedButton extends StatefulWidget {
  bool isloading;
  final String text;
  final Function()? onpress;
  final Color color, textcolor;
  RoundedButton({
    super.key,
    required this.text,
    required this.color,
    required this.onpress,
    required this.textcolor,
    required this.isloading,
  });

  @override
  State<RoundedButton> createState() => _RoundedButtonState();
}

class _RoundedButtonState extends State<RoundedButton> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.8,
      height: size.height / 15.5,
      child: ElevatedButton(
        onPressed: widget.onpress,
        style: ElevatedButton.styleFrom(
            shape: StadiumBorder(), backgroundColor: widget.color),
        child: widget.isloading
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              )
            : Text(
                widget.text,
                style: TextStyle(color: widget.textcolor),
              ),
      ),
    );
    // return Container(
    //   margin: const EdgeInsets.symmetric(vertical: 10),
    //   padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
    //   width: size.width * 0.7,
    //   height: size.height / 12,
    //   decoration: BoxDecoration(
    //     color: widget.color,
    //     borderRadius: BorderRadius.circular(29)
    //   ),
    //   child: TextButton(
    //     onPressed: widget.onpress,
    //     child: Text(
    //       widget.text,
    //       style: TextStyle(color: widget.textcolor),
    //     ),
    //   ),
    // );
  }
}
