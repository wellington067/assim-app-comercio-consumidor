import 'package:ecommerceassim/shared/constants/style_constants.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    Key? key,
    this.onChanged,
    this.label,
    this.maskFormatter,
    this.controller,
    this.keyboardType,
    this.hintText,
    this.isPassword,
    this.icon,
    this.isBordered,
  }) : super(key: key);

  final String? label;
  final String? hintText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool? isPassword;
  final Function(String)? onChanged;
  final IconData? icon;
  final MaskTextInputFormatter? maskFormatter;
  final bool? isBordered;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _obscureText = false;

  @override
  void initState() {
    if (widget.isPassword != null) {
      _obscureText = widget.isPassword!;
    }
    super.initState();
  }

  void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Container(
        decoration: BoxDecoration(
          color: kBackgroundColor,
          borderRadius: BorderRadius.circular(8.0), // Define o raio das bordas
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 3,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: TextFormField(
          onChanged: widget.onChanged,
          inputFormatters: widget.maskFormatter == null ? null : [widget.maskFormatter!],
          obscureText: _obscureText,
          controller: widget.controller,
          decoration: InputDecoration(
            prefixIcon: widget.icon == null ? null : Icon(widget.icon as IconData?),
            border: InputBorder.none,
            labelText: widget.label,
            hintText: widget.hintText,
            suffixIcon: widget.isPassword == true
                ? InkWell(
                    onTap: () => _toggleVisibility(),
                    child: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                    ),
                  )
                : null,
          ),
        ),
      ),
    );
  }
}
