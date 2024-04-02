import 'package:ecommerceassim/shared/constants/style_constants.dart';
import 'package:flutter/material.dart';

class AddressFormField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final TextInputType keyboardType;

  const AddressFormField({
    super.key,
    required this.controller,
    required this.label,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      style: const TextStyle(
        fontWeight: FontWeight.w400, // Set font weight to w500
        // You can also set other text styles if needed
      ),
      decoration: InputDecoration(
        // Use label to show text above the TextFormField
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: kBackgroundColor,
        // Adjust the padding to add right padding
        contentPadding: const EdgeInsets.fromLTRB(
            16, 13, 16, 13), // left, top, right, bottom
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor, insira um valor';
        }
        return null;
      },
    );
  }
}
