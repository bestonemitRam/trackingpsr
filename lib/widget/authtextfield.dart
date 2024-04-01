import 'package:flutter/material.dart';

class AuthTextField extends StatelessWidget {

  final TextEditingController _controller;

  AuthTextField(this._controller);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      cursorColor: Colors.white,
      decoration: InputDecoration(
          labelStyle: TextStyle(color: Colors.white),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.white, width: 2)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 2.0),
              borderRadius: BorderRadius.circular(20)
          ),
      ),
    );
  }
}
