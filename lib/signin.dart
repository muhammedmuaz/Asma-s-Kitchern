import 'package:flutter/material.dart';
import 'package:foofapp/login.dart';
import 'package:foofapp/widgets/mywidget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool loading = false;

  TextEditingController firstname = TextEditingController();

  TextEditingController lastname = TextEditingController();

  TextEditingController email = TextEditingController();

  TextEditingController password = TextEditingController();


  GlobalKey<ScaffoldState> globalkey = GlobalKey<ScaffoldState>();

  void validation() {
    if (firstname.text.trim().isEmpty || firstname.text.trim() == null) {
      globalkey.currentState!
          .showSnackBar(SnackBar(content: Text("FirstName is Empty")));
      return;
    }
    if (lastname.text.trim().isEmpty || lastname.text.trim() == null) {
      globalkey.currentState!
          .showSnackBar(SnackBar(content: Text("LastName is Empty")));
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
      sendData();
      }
  }
    Future sendData() async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      firestore.collection('users').doc().set({
        "FirstName": firstname.text,
        "LastName": lastname.text,
        "Email": email.text,
        "Password": password.text
      });
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Login()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        globalkey.currentState!.showSnackBar(
            SnackBar(content: Text("The provided password is too weak")));
      } else if (e.code == 'email-already-in-use') {
        globalkey.currentState!.showSnackBar(SnackBar(
            content: Text('The account already exists for that email.')));
      }
    } catch (e) {
      setState(() {
        loading = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: globalkey,
        backgroundColor: Colors.black,
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(
                  top: 50,
                ),
                child: Text(
                  "Sign In",
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
                        hinttext: "FirstName",
                        controller: firstname,
                        obscuretext: false),
                  ),
                  Container(
                      padding: EdgeInsets.only(top: 40),
                      child: MyWidget(
                          hinttext: "LastName",
                          controller: lastname,
                          obscuretext: false)),
                  Container(
                      padding: EdgeInsets.only(top: 40),
                      child: MyWidget(
                          hinttext: "Email",
                          controller: email,
                          obscuretext: false)),
                  Container(
                      padding: EdgeInsets.only(top: 40),
                      child: MyWidget(
                          hinttext: "Confirm Password",
                          controller: password,
                          obscuretext: true)),
                  SizedBox(height: 70),
                  loading?CircularProgressIndicator(color: Colors.deepOrange,):Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height:60,
                        width: 160,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                                fontSize: 30,
                                color: Colors.black,
                                fontWeight: FontWeight.w300),
                          ),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.grey,
                              //padding: EdgeInsets.only(left: 60,right: 60,top: 20,bottom: 20),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30))),
                        ),
                      ),
                      Container(
                        height: 60,
                        width: 160,
                        child: ElevatedButton(
                          onPressed: () {
                            validation();
                          },
                          child: Text(
                            "Registor",
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.deepOrange,
                              //padding: EdgeInsets.only(left: 60,right: 60,top: 20,bottom: 20),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30))),
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
