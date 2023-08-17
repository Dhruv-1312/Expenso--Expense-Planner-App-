import 'package:flutter/material.dart';

class Transactions {
  final String uid;
  final String username;
  final String amount;
  final date;
  final String transactionId;
  final String description;

  Transactions({
    required this.uid,
    required this.transactionId,
    required this.amount,
    required this.date,
    required this.description,
    required this.username,
  });

  Map<String, dynamic> toJason() => {
        'uid': uid,
        'transactionId': transactionId,
        'amount': amount,
        'date': date,
        'description': description,
        'username': username,
      };
}
