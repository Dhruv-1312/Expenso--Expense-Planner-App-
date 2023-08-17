import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expenso/Providers/user_provider.dart';
import 'package:expenso/utils/colors.dart';
import 'package:expenso/widgets/bill_card.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:expenso/Models/users.dart' as models;
import 'package:provider/provider.dart';

class BillScreen extends StatefulWidget {
  const BillScreen({super.key});

  @override
  State<BillScreen> createState() => _BillScreenState();
}

class _BillScreenState extends State<BillScreen> {
  bool empty = false;
  @override
  Widget build(BuildContext context) {
    models.users user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Bills',
          style: TextStyle(color: Colors.black),
        ),
      ),
      // body: BillCard(),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('Bills')
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
            if (snapshot.data!.docs.length == 0) {
              return BillCard(empty: true);
            }
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return BillCard(
                    snap: snapshot.data!.docs[index].data(),
                    empty: false,
                  );
                });
          }),
    );
  }
}
