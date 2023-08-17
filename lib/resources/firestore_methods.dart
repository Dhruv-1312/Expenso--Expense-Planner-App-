import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expenso/Models/bills.dart';
import 'package:expenso/resources/storage_methods.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:expenso/Models/transaction.dart' as model;

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> uploadTransaction(String uid, String username, String amount,
      String description, String collectioName) async {
    String transactionId = Uuid().v1();
    String res = 'Error';
    try {
      if (amount.isNotEmpty && description.isNotEmpty) {
        model.Transactions NewTransaction = model.Transactions(
            amount: amount,
            date: DateTime.now(),
            description: description,
            transactionId: transactionId,
            uid: uid,
            username: username);

        _firestore
            .collection(collectioName)
            .doc(transactionId)
            .set(NewTransaction.toJason());
        res = 'success';
      } else {
        res = 'Enter all the fields';
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<String> uploadBill(
      String amount, String uid, String username, Uint8List file) async {
    String res = 'Some Error Occurred';
    String billId = Uuid().v1();

    try {
      String Billurl = await StorageMethods().uploadImage('Bills', file, true);

      Bill bills = Bill(
          amount: amount,
          uid: uid,
          username: username,
          billId: billId,
          Billurl: Billurl,
          dateposted: DateTime.now());

      _firestore.collection('Bills').doc(billId).set(bills.toJason());
      res = 'success';
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<void> DeleteBill(String Billid) async {
    try {
      await _firestore.collection('Bills').doc(Billid).delete();
    } catch (e) {
      print(e.toString());
    }
  }
}
