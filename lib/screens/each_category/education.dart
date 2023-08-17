import 'package:expenso/utils/Category_colors.dart';
import 'package:expenso/widgets/addtransaction.dart';
import 'package:flutter/material.dart';

class Education extends StatefulWidget {
  const Education({super.key});

  @override
  State<Education> createState() => _EducationState();
}

class _EducationState extends State<Education> {
  @override
  Widget build(BuildContext context) {
    return const AddTransactionScreen(
        blurColor: AppColors.orange,
        appbarText: 'education',
        avatarColor: AppColors.orange,
        image: 'assets/images/education.png',
        collectionName: 'education');
  }
}
