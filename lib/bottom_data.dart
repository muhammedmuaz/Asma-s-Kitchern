import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foofapp/widgets/bottom_counter.dart';

class bottom_data extends StatelessWidget {
  final Stream<QuerySnapshot> _bottom_Container = FirebaseFirestore.instance
      .collection('Catagories')
      .doc('Uos9GVNl1rY1nBUtijbb')
      .collection('bottomdata')
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _bottom_Container,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
            String id = document.id;
            data['id'] = id;
            return bottom_counter(data:data);
          }).toList(),
        );
      },
    );
  }
}
