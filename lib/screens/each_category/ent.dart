import 'package:expenso/utils/Category_colors.dart';
import 'package:expenso/widgets/addtransaction.dart';
import 'package:flutter/material.dart';

class Entertainment extends StatefulWidget {
  const Entertainment({super.key});

  @override
  State<Entertainment> createState() => _EntertainmentState();
}

class _EntertainmentState extends State<Entertainment> {
  @override
  Widget build(BuildContext context) {
    return const AddTransactionScreen(
        blurColor: AppColors.red,
        appbarText: 'Entertainment',
        avatarColor: AppColors.red,
        image: 'assets/images/ent.png',
        collectionName: 'entertainment');
  }
}
