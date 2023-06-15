// To parse this JSON data, do
//
//     final dropdownModel = dropdownModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

DropdownModel dropdownModelFromJson(String str) => DropdownModel.fromJson(json.decode(str));

String dropdownModelToJson(DropdownModel data) => json.encode(data.toJson());

class DropdownModel {
  int value;
  String label;

  DropdownModel({
    required this.value,
    required this.label,
  });

  factory DropdownModel.fromJson(Map<String, dynamic> json) => DropdownModel(
    value: json["value"],
    label: json["label"],
  );

  Map<String, dynamic> toJson() => {
    "value": value,
    "label": label,
  };
}