import 'package:expenso/Providers/user_provider.dart';
import 'package:expenso/resources/firestore_methods.dart';
import 'package:flutter/material.dart';
import 'package:expenso/Models/users.dart' as models;
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class BillCard extends StatefulWidget {
  final snap;
  bool empty;
  BillCard({
    super.key,
    this.snap,
    required this.empty,
  });

  @override
  State<BillCard> createState() => _BillCardState();
}

class _BillCardState extends State<BillCard> {
  del(BuildContext parentctx) async {
    return showDialog(
        context: parentctx,
        builder: (context) {
          return SimpleDialog(
            backgroundColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            children: [
              SimpleDialogOption(
                  child: const Text('Delete'),
                  onPressed: () async {
                    await FirestoreMethods().DeleteBill(widget.snap['BillId']);
                    Navigator.of(context).pop();
                  })
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    models.users user = Provider.of<UserProvider>(context).getUser;
    return (widget.empty == true)
        ? const Center(
            child: Text(
              'No Bills uploaded yet!!',
              style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w600,
                  fontSize: 20),
            ),
          )
        : Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 16,
                        backgroundImage: NetworkImage(user.photoUrl),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                user.username,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () => del(context),
                        icon: const Icon(Icons.more_vert),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 236, 226, 226)),
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.35,
                      width: double.infinity,
                      child: Image.network(
                        widget.snap['Billurl'],
                        fit: BoxFit.contain,
                      )),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(top: 8, left: 10),
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(color: Colors.black),
                      children: [
                        const TextSpan(
                            text: 'Total Amount',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)),
                        TextSpan(
                          text: '  ₹${widget.snap['amount']}',
                          style: const TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    child: Text(
                      DateFormat.yMMMd()
                          .format(widget.snap['Dateposted'].toDate()),
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
  }
}
