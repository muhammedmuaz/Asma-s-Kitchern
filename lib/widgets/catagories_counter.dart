import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Catagories_counter extends StatelessWidget {
  final Map data;
  Catagories_counter({required this.data});
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        margin: EdgeInsets.only(left: 10),
        height: 80,
        width: 90,
        decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(data['image']),
            ),
            color: Color(0xff1e234a),
            borderRadius: BorderRadius.circular(60)),
      ),
      SizedBox(
        height: 10,
      ),
      Text(
        data['text'],
        style: TextStyle(color: Colors.white, fontSize: 20),
      )
    ]);
  }
}
