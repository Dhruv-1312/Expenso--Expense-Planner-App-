import 'package:expenso/utils/Category_colors.dart';
import 'package:expenso/widgets/addtransaction.dart';
import 'package:flutter/material.dart';

class TransportationScreen extends StatefulWidget {
  const TransportationScreen({super.key});

  @override
  State<TransportationScreen> createState() => _TransportationScreenState();
}

class _TransportationScreenState extends State<TransportationScreen> {
  @override
  Widget build(BuildContext context) {
    return const AddTransactionScreen(
        blurColor: AppColors.green,
        appbarText: 'Transportation',
        avatarColor: AppColors.green,
        image: 'assets/images/transport.png',
        collectionName: 'transport');
  }
}
