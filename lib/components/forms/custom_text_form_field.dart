import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:ecommerceassim/shared/constants/style_constants.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    this.onChanged,
    this.label,
    this.maskFormatter,
    this.controller,
    this.keyboardType,
    this.hintText,
    this.isPassword,
    this.icon,
    this.isBordered,
    this.decoration,
    this.enabled,
  });

  final String? label;
  final String? hintText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool? isPassword;
  final Function(String)? onChanged;
  final IconData? icon;
  final MaskTextInputFormatter? maskFormatter;
  final bool? isBordered;
  final bool? enabled;
  final InputDecoration? decoration;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword ?? false;
    widget.controller?.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    widget.controller?.removeListener(() {
      setState(() {});
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Container(
        decoration: BoxDecoration(
          color: kBackgroundColor,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: TextFormField(
          onChanged: widget.onChanged,
          inputFormatters:
              widget.maskFormatter == null ? null : [widget.maskFormatter!],
          obscureText: _obscureText,
          controller: widget.controller,
          enabled: widget.enabled ?? true,
          style: widget.enabled == false
              ? TextStyle(color: Colors.grey.withOpacity(0.6))
              : null,
          decoration: (widget.decoration ?? const InputDecoration()).copyWith(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
            prefixIcon: widget.icon == null ? null : Icon(widget.icon),
            border: InputBorder.none,
            labelText: widget.label,
            hintText: widget.hintText,
            suffixIcon: widget.isPassword == true &&
                    widget.controller?.text.isNotEmpty == true
                ? InkWell(
                    onTap: _toggleVisibility,
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

  void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _updateObscureText() {
    setState(() {
      _obscureText = widget.controller?.text.isEmpty ?? true;
    });
  }
}
