import 'dart:async';

import 'package:flutter/material.dart';
import 'package:foofapp/HomePage.dart';
import 'package:foofapp/signin.dart';
import 'package:foofapp/widgets/mywidget.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool loading = false;
  TextEditingController email = TextEditingController(text: "maaz@gmail.com");

  TextEditingController password = TextEditingController(text: "123456");

  GlobalKey<ScaffoldState> globalkey = GlobalKey<ScaffoldState>();

  void validation() {
    if (email.text.trim().isEmpty ||
        email.text.trim() == null && password.text.trim().isEmpty ||
        password.text.trim() == null) {
      globalkey.currentState!.showSnackBar(
          SnackBar(content: Text("All Fields are empty is Empty")));
      return;
    }
    if (email.text.trim().isEmpty || email.text.trim() == null) {
      globalkey.currentState!
          .showSnackBar(SnackBar(content: Text("Email is Empty")));
      return;
    }
    if (password.text.trim().isEmpty || password.text.trim() == null) {
      globalkey.currentState!
          .showSnackBar(SnackBar(content: Text("Pasword is Empty")));
      return;
    } else {
      setState(() {
        loading = true;
      });
      login();
    }
  }

  Future login() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: email.text, password: password.text);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        globalkey.currentState!.showSnackBar(
            SnackBar(content: Text("No user found for that email.")));
      } else if (e.code == 'wrong-password') {
        globalkey.currentState!.showSnackBar(
            SnackBar(content: Text("Wrong password provided for that user.")));
      }
      else {
        setState(() {
        loading = false;
      });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: globalkey,
        backgroundColor: Colors.black,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios_new),
              padding: EdgeInsets.only(left: 30),
              iconSize: 40,
              color: Colors.white),
          backgroundColor: Colors.transparent,
        ),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(
                  top: 50,
                ),
                child: Text(
                  "Log In",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                      fontSize: 70),
                ),
              ),
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 70),
                    child: MyWidget(
                      hinttext: "Email",
                      controller: email,
                      obscuretext: false,
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.only(top: 30),
                      child: MyWidget(
                          hinttext: "Password",
                          controller: password,
                          obscuretext: true)),
                  Container(
                    margin: EdgeInsets.only(top: 80),
                    height: 60,
                    width: 250,
                    child: loading?Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(color: Colors.deepOrange,),
                      ],
                    ):   ElevatedButton(
                      onPressed: () {
                        validation();
                      },
                      child: Text(
                        "Log in",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w300),
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.deepOrange,
                          //padding: EdgeInsets.only(left: 60,right: 60,top: 20,bottom: 20),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30))),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    padding: EdgeInsets.only(left: 70),
                    child: Row(
                      children: [
                        Text(
                          "New User?",
                          style: TextStyle(color: Colors.grey),
                        ),
                        GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignUp()));
                            },
                            child: Text(
                              " Register yourself",
                              style: TextStyle(color: Colors.deepOrange),
                            )),
                            
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
