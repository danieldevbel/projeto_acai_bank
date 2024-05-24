import 'package:flutter/material.dart';

class CurrencyTextField extends StatelessWidget {
  final String label;
  final String prefix;
  final TextEditingController controller;
  final Function(String)? onChanged;

  const CurrencyTextField({
    super.key,
    required this.label,
    required this.prefix,
    required this.controller,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Color.fromARGB(255, 70, 11, 70)),
        border: const OutlineInputBorder(),
        prefixText: prefix,
      ),
      style: const TextStyle(
          color: Color.fromARGB(255, 70, 11, 70), fontSize: 25.0),
      onChanged: onChanged,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
    );
  }
}
