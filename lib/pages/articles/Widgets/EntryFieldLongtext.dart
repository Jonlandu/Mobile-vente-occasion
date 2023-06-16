import 'package:flutter/material.dart';

Widget EntryFieldLongtext({
  String label = "",
  required TextEditingController ctrl,
  TextInputType type = TextInputType.text,
  bool required = false,
}) {
  return TextFormField(
      controller: ctrl,
      //keyboardType: type,
      keyboardType: TextInputType.multiline,
      //maxLines: null,
      minLines: 3,
      maxLines: 10,
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
      borderSide: BorderSide(width: 1, color: _color),
      borderRadius: BorderRadius.all(Radius.circular(0)));
}
