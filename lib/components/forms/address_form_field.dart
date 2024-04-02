import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ecommerceassim/shared/constants/style_constants.dart';

class AddressFormField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final TextInputType keyboardType;
  final TextInputFormatter? maskFormatter;
  final bool enabled;

  const AddressFormField({
    super.key,
    required this.controller,
    required this.label,
    this.keyboardType = TextInputType.text,
    this.maskFormatter,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      style: const TextStyle(
        fontWeight: FontWeight.w400,
      ),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: kBackgroundColor,
        contentPadding: const EdgeInsets.fromLTRB(16, 13, 16, 13),
      ),
      inputFormatters: maskFormatter != null ? [maskFormatter!] : [],
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor, insira um valor';
        }
        return null;
      },
      enabled: enabled,
    );
  }
}
