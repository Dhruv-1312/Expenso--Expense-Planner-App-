import 'package:expenso/utils/Category_colors.dart';
import 'package:expenso/widgets/addtransaction.dart';
import 'package:flutter/material.dart';

class Health extends StatefulWidget {
  const Health({super.key});

  @override
  State<Health> createState() => _HealthState();
}

class _HealthState extends State<Health> {
  @override
  Widget build(BuildContext context) {
    return const AddTransactionScreen(
        blurColor: AppColors.purple,
        appbarText: 'health',
        avatarColor: AppColors.purple,
        image: 'assets/images/h1.png',
        collectionName: 'health');
  }
}
