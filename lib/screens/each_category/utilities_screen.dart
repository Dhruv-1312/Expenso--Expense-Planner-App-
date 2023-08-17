import 'package:expenso/widgets/addtransaction.dart';
import 'package:flutter/material.dart';

class UtilityScreen extends StatefulWidget {
  const UtilityScreen({super.key});

  @override
  State<UtilityScreen> createState() => _UtilityScreenState();
}

class _UtilityScreenState extends State<UtilityScreen> {
  @override
  Widget build(BuildContext context) {
    return const AddTransactionScreen(
      appbarText: 'Utilities',
      avatarColor: Colors.pink,
      blurColor: Colors.pink,
      image: 'assets/images/image2.png',
      collectionName: 'utility',
    );
  }
}
