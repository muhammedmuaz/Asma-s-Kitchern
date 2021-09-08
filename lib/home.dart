
import 'package:flutter/material.dart';
import 'package:foofapp/login.dart';
import 'package:foofapp/signin.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Expanded(
                child: Center(
              child: Container(
                  child: Image.asset("images/kitchenlogo.jpg"))
            )),
            Expanded(
                child: Container(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "   Welcome to\nAsma's Kitchen",
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 30,
                        color: Colors.green),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: Text(
                        "Order food from our Restaurantan  \n     make reservation in real time"),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 40),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Login()));
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      style: TextButton.styleFrom(
                          padding: EdgeInsets.only(
                              top: 15, bottom: 15, right: 130, left: 130),
                          backgroundColor: Colors.green,
                          elevation: 20,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          )),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 40),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => SignUp()));
                      },
                      child: Text(
                        "SignUp",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.green),
                      ),
                      style: TextButton.styleFrom(
                          padding: EdgeInsets.only(
                              top: 15, bottom: 15, right: 130, left: 130),
                          backgroundColor: Colors.white,
                          elevation: 20,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          )),
                    ),
                  ),
                ],
              ),
            )),
          ],
        ));
  }
}

//class BuidContext {}
