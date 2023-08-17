import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expenso/resources/firestore_methods.dart';
import 'package:expenso/screens/login_screen.dart';
import 'package:expenso/screens/welcomScreen/body.dart';
import 'package:expenso/utils/utils.dart';
import 'package:expenso/widgets/list_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:expenso/Models/users.dart' as models;
import 'package:expenso/Providers/user_provider.dart';
import 'package:expenso/responsive/mobileScreen.dart';
import 'package:expenso/utils/colors.dart';

class AddTransactionScreen extends StatefulWidget {
  final Color blurColor;
  final Color avatarColor;
  final String appbarText;
  final String image;
  final String collectionName;
  const AddTransactionScreen({
    required this.blurColor,
    required this.appbarText,
    required this.avatarColor,
    required this.image,
    required this.collectionName,
    super.key,
  });

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  final TextEditingController amountControl = TextEditingController();
  final TextEditingController descriptionControl = TextEditingController();
  bool isnowloading = false;

  void newTransaction(
      String uid, String username, String amount, String description) async {
    try {
      setState(() {
        isnowloading = true;
      });
      String res = await FirestoreMethods().uploadTransaction(
          uid, username, amount, description, widget.collectionName);
      setState(() {
        isnowloading = false;
      });
      if (res != 'success') {
        ShowSnackBar(res, context);
      }
    } catch (e) {
      ShowSnackBar(e.toString(), context);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    models.users user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.black,
          ),
          onPressed: () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const MobileScreen(),
            ),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          widget.appbarText,
          style:
              const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(widget.collectionName)
            .where('uid', isEqualTo: user.uid)
            .snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: kPrimaryColor,
              ),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (contex, index) => ListScreen(
              snap: snapshot.data!.docs[index].data(),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: kPrimaryLightColor,
          onPressed: () {
            showModalBottomSheet(
                backgroundColor: Colors.transparent,
                context: context,
                builder: (ctx) {
                  return Container(
                    height: size.height / 1.6,
                    width: size.width,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                          bottom: 3,
                          child: Container(
                            width: size.width,
                            height: size.height / 2.1,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black38.withOpacity(0.4),
                                    blurRadius: 35),
                              ],
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(50),
                                topRight: Radius.circular(50),
                              ),
                              gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFF964FC9),
                                    Color(0xFF7e5a98),
                                    Color(0xFF544c5b),
                                    Color(0xFF7f6557),
                                    Color(0xFFa3521b),
                                  ],
                                  begin: Alignment.topRight,
                                  end: Alignment.topLeft),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          child: Container(
                            width: size.width,
                            height: size.height / 2.1,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: kPrimaryColor.withOpacity(0.4),
                                    blurRadius: 60),
                              ],
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(50),
                                topRight: Radius.circular(50),
                              ),
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 14,
                          child: CircleAvatar(
                            backgroundImage: AssetImage(widget.image),
                            radius: 45,
                            backgroundColor: widget.avatarColor,
                          ),
                        ),
                        Positioned(
                          top: size.height / 7,
                          child: const Text(
                            'Add Transaction',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 21,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        Positioned(
                          top: size.height / 5,
                          child: textfieldContainer(
                            child: TextField(
                              controller: amountControl,
                              obscureText: false,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Enter the amount',
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: size.height / 5.4,
                          child: textfieldContainer(
                            child: TextField(
                              controller: descriptionControl,
                              obscureText: false,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Enter the description',
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: size.height / 10,
                          child: RoundedButton(
                              text: 'Submit',
                              color: kPrimaryColor,
                              onpress: () {
                                newTransaction(
                                    user.uid,
                                    user.username,
                                    amountControl.text,
                                    descriptionControl.text);

                                amountControl.clear();
                                descriptionControl.clear();
                                Navigator.of(context).pop();
                              },
                              textcolor: Colors.white,
                              isloading: isnowloading),
                        ),
                      ],
                    ),
                  );
                });
          },
          child: const Icon(
            Icons.add,
            color: kPrimaryColor,
          )),
    );
  }
}
