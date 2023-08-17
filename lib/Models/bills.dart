import 'package:flutter/material.dart';

class Bill {
  final String uid;
  final String username;
  final String billId;
  final dateposted;
  final String Billurl;
  final String amount;

  Bill(
      {required this.uid,
      required this.username,
      required this.billId,
      required this.Billurl,
      required this.dateposted,
      required this.amount});

  Map<String, dynamic> toJason() => {
        'uid': uid,
        'username': username,
        'BillId': billId,
        'Billurl': Billurl,
        'Dateposted': dateposted,
        'amount': amount,
      };
}
