import 'package:flutter/material.dart';

List<DropdownMenuItem<String>> toDropdownMenu(List<String> items) {
  return items.map<DropdownMenuItem<String>>((value) {
    return DropdownMenuItem(
      value: value,
      child: Text(value),
    );
  }).toList();
}
