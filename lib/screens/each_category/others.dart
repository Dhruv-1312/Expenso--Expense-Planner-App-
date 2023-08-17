import 'package:expenso/utils/Category_colors.dart';
import 'package:expenso/widgets/addtransaction.dart';
import 'package:flutter/material.dart';

class Others extends StatefulWidget {
  const Others({super.key});

  @override
  State<Others> createState() => _OthersState();
}

class _OthersState extends State<Others> {
  @override
  Widget build(BuildContext context) {
    return const AddTransactionScreen(
        blurColor: AppColors.purple,
        appbarText: 'Others',
        avatarColor: AppColors.purple,
        image: 'assets/images/other.png',
        collectionName: 'others');
  }
}
