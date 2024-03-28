import 'package:flutter/material.dart';

class CustomSearchField extends StatelessWidget {
  final Color fillColor;
  final Color iconColor;
  final String hintText;
  final EdgeInsets padding;
  final double borderRadius;

  const CustomSearchField({
    super.key,
    required this.fillColor,
    required this.iconColor,
    required this.hintText,
    required this.padding,
    this.borderRadius = 10.0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: TextField(
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          filled: true,
          fillColor: fillColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
            borderSide: BorderSide.none,
          ),
          hintText: hintText,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 15,
          ),
          isDense: true,
          prefixIcon: Icon(
            Icons.search,
            color: iconColor,
            size: 25,
          ),
        ),
      ),
    );
  }
}
