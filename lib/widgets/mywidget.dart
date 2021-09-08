import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  final TextEditingController controller;
  final String hinttext;
  final bool obscuretext;
  MyWidget({required this.hinttext, required this.controller,required this.obscuretext});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(color:Colors.grey),
      controller: controller,
      obscureText: obscuretext,
      decoration: InputDecoration(
          hintText: hinttext,
          hintStyle: TextStyle(fontSize: 20, color: Colors.grey),
          enabledBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey))),
    );
  }
}
