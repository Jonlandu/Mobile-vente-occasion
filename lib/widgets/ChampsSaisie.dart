import 'package:flutter/material.dart';

Widget ChampSaisie(
    {bool isPassword = false,
      String label = "",
      required TextEditingController ctrl,
      TextInputType type = TextInputType.text,
      bool required=false}) {
  return TextFormField(
      obscureText: isPassword,
      controller: ctrl,
      keyboardType: type,
      validator: (String? value) {
        if(!required) return null;
        if ( value == null || value.isEmpty) {
          return "Champs obligatoire";
        }
        return null;
      },
      decoration: InputDecoration(
          labelText: label,
          hintText: "Veuillez saisir vos coordonnées",
          border: _bordure(Colors.orange),
          focusedBorder: _bordure(Colors.grey),
          enabledBorder: _bordure(Colors.grey)));
}

OutlineInputBorder _bordure(MaterialColor _color) {
  return OutlineInputBorder(
      borderSide: BorderSide(width: 2, color: _color),
      borderRadius: BorderRadius.all(Radius.circular(14)));
}