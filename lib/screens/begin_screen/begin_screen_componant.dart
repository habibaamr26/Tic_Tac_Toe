

import 'package:flutter/material.dart';

Widget textField({
  required String text,
  required TextEditingController controller,
  String? Function(String?)? validator,
}) =>
    TextFormField(
      validator: validator,
      controller:controller ,
      maxLength: 10,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: text,
        hintStyle: const TextStyle(
          color: Color(0xFFFFFFFF),
          fontWeight: FontWeight.w400,
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.white)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.white)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.white)),
      ),
    );
