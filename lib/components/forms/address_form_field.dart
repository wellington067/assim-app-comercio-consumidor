import 'package:flutter/material.dart';

class AddressFormField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final TextInputType keyboardType;

  const AddressFormField({
    Key? key,
    required this.controller,
    required this.label,
    this.keyboardType = TextInputType.text, // Default to text if not provided
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        border:
            OutlineInputBorder(), // Provides a border around the TextFormField
        contentPadding: EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 5), // Optional: Adjusts padding inside the text field
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor, insira um valor'; // Validation message
        }
        // Optional: Include specific validation for CEP or other fields
        return null; // Return null if the input is valid
      },
    );
  }
}
