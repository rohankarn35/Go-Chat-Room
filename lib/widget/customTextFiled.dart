import 'package:flutter/material.dart';

class Customtextfiled {
  customTextField({
    required TextEditingController textEditingController,
    required String hintText,
    String? Function(String?)? validator,
  }) {
    return SizedBox(
      width: 300,
      child: TextFormField(
        validator: validator,
        controller: textEditingController,
        autocorrect: false,
        decoration: InputDecoration(
          labelText: hintText,
          labelStyle: TextStyle(color: Colors.white24),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
    );
  }
}
