import 'package:flutter/material.dart';

Widget EntryField({
  String label = "",
  required TextEditingController? ctrl,
  TextInputType type = TextInputType.text,
  bool required = false,
}) {
  return TextFormField(
      controller: ctrl,
      keyboardType: type,
      validator: (value) {
        if (!required) return null;
        if (value == null || value.isEmpty) {
          return "Champs obligatoire";
        }
        return null;
      },
      decoration: InputDecoration(
          labelText: label,
          hintText: "Saisir...",
          border: _bordure(Colors.grey),
          focusedBorder: _bordure(Colors.orange),
          enabledBorder: _bordure(Colors.grey)));
}

OutlineInputBorder _bordure(MaterialColor _color) {
  return OutlineInputBorder(
      borderSide: BorderSide(width: 2, color: _color),
      borderRadius: BorderRadius.all(Radius.circular(16)));
}
