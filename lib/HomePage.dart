import 'package:flutter/material.dart';
import 'package:foofapp/widgets/bottom_counter.dart';
import 'package:foofapp/widgets/catagories_counter.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  final Stream<QuerySnapshot> _bottom_Container = FirebaseFirestore.instance
      .collection('Catagories')
      .doc('Uos9GVNl1rY1nBUtijbb')
      .collection('bottomdata')
      .snapshots();
 final Stream<QuerySnapshot> _Catagories_container = FirebaseFirestore.instance
      .collection('Catagories')
      .doc('Uos9GVNl1rY1nBUtijbb')
      .collection('uppercatagories')
      .snapshots();     

  Widget drawerthings({required String name, required IconData icon}) {
    return ListTile(
        leading: Icon(
          icon,
          color: Colors.white,
          size: 40,
        ),
        title: Text(
          name,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          child: SafeArea(
              child: Container(
            color: Color(0xff1e234a),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UserAccountsDrawerHeader(
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: AssetImage("images/kitchenlogo.jpg"),
                  ),
                  accountName: Text(
                    "Maaz",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.black),
                  ),
                  accountEmail: Text(
                    "maaz@gmail.com",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage("images/background2.jpg"))),
                ),
                drawerthings(name: "Profile", icon: Icons.person),
                drawerthings(
                    name: "Shopping Cart", icon: Icons.add_shopping_cart),
                drawerthings(name: "Order", icon: Icons.shop),
                Divider(
                  color: Colors.white,
                  thickness: 3,
                ),
                ListTile(
                  leading: Text(
                    "Communicate",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
                drawerthings(name: "Change", icon: Icons.lock),
                drawerthings(name: "Log Out", icon: Icons.exit_to_app)
              ],
            ),
          )),
        ),
        backgroundColor: Color(0xff1e234a),
        appBar: AppBar(
          backgroundColor: Color(0xff1e234a),
          leading: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.sort,
                color: Colors.white,
                size: 30,
              )),
          actions: [
            CircleAvatar(
              backgroundImage: AssetImage("images/kitchenlogo.jpg"),
            )
          ],
        ),
        body: SafeArea(
            child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: TextField(
                decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    hintText: "Search",
                    hintStyle: TextStyle(color: Colors.white),
                    filled: true,
                    fillColor: Colors.black26,
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(20))),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: StreamBuilder<QuerySnapshot>(
      stream: _Catagories_container,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return Row(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
            return Catagories_counter(data:data);
          }).toList(),
        );
      },
    ),
            ),
            Container(
              height: 950,
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: StreamBuilder<QuerySnapshot>(
      stream: _bottom_Container,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return GridView.count(
                 crossAxisCount: 2,
                crossAxisSpacing: 20,
                shrinkWrap: false,
                primary: false,
                mainAxisSpacing: 20,
                childAspectRatio: 0.6,
                scrollDirection: Axis.vertical,
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
            String id = document.id;
            data['id'] = id;
            return bottom_counter(data:data);
          }).toList(),
        );
      },
    ),
                
              ),
           ] ),
          ),
        ),
        );
  }
}
