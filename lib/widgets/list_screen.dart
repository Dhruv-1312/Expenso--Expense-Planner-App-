import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ListScreen extends StatelessWidget {
  final snap;
  const ListScreen({super.key, required this.snap});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Card(
      color: Colors.transparent,
      shadowColor: Colors.grey,
      borderOnForeground: true,
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      elevation: 8,
      child: Container(
        decoration: BoxDecoration(
            color: const Color.fromRGBO(64, 75, 96, .9),
            borderRadius: BorderRadius.circular(29)),
        child: ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            leading: Container(
                padding: const EdgeInsets.only(right: 12.0),
                decoration: const BoxDecoration(
                    border: Border(
                        right: BorderSide(
                  width: 1.0,
                  color: Colors.white24,
                ))),
                child: Container(
                  height: size.height / 5,
                  width: size.width / 7,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: Colors.black38),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      snap['amount'],
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w500),
                    ),
                  ),
                )),
            title: Text(
              snap['description'],
              //snap['description'],
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
            // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

            subtitle: Row(
              children: <Widget>[
                const Icon(Icons.date_range_outlined,
                    color: Colors.yellowAccent),
                Text(DateFormat.yMMMd().format(snap['date'].toDate()),
                    style: const TextStyle(color: Colors.white))
              ],
            ),
            trailing:
                const Icon(Icons.delete, color: Colors.white, size: 30.0)),
      ),
    );
  }
}
