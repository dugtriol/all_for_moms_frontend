import 'package:flutter/material.dart';

Widget buildTextField(String labelText, String placeholder) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 25.0),
    child: TextField(
      readOnly: true,
      // obscureText: isPasswordTextField ? showPassword : false,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.only(bottom: 3),
          labelText: labelText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: placeholder,
          hintStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          )),
    ),
  );
}
