import 'package:flutter/material.dart';

Widget EntryFieldBloqued({
  String label = "",
  required TextEditingController? ctrl,
  TextInputType type = TextInputType.text,
  bool required = false,
}) {
  return TextFormField(
      controller: ctrl,
      keyboardType: type,
      decoration: InputDecoration(
        border : _bordure(Colors.grey),
          enabledBorder: _bordure(Colors.grey),
    labelText: '',
    disabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey),
    ),
  ),
    enabled: false,
  );
}

OutlineInputBorder _bordure(MaterialColor _color) {
  return OutlineInputBorder(
      borderSide: BorderSide(width: 1, color: _color),
      borderRadius: BorderRadius.all(Radius.circular(0)));
}
