import 'package:ecommerceassim/shared/constants/style_constants.dart';
import 'package:flutter/material.dart';

class AuthFormField extends StatefulWidget {
  final String label;
  final bool isPassword;
  final TextInputType inputType;
  final Function(String)? onChanged;
  final Color backgroundColor;
  final TextEditingController?
      controller; // Adicione o parâmetro nomeado 'controller'
  final String? initialValue; // Adicione o parâmetro nomeado 'initialValue'

  const AuthFormField({
    Key? key,
    required this.label,
    required this.isPassword,
    required this.inputType,
    this.onChanged,
    this.backgroundColor = kOnBackgroundColorText,
    this.controller, // Defina o parâmetro nomeado 'controller' aqui
    this.initialValue,
  }) : super(key: key);

  @override
  State<AuthFormField> createState() => _AuthFormFieldState();
}

class _AuthFormFieldState extends State<AuthFormField> {
  late TextEditingController _controller; // Controlador para o TextFormField
  bool showPassword = true;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
        text: widget
            .initialValue); // Inicializando o controlador com o valor inicial
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.06,
      child: TextFormField(
        controller: _controller, // Definindo o controlador
        onChanged: widget.onChanged,
        style: const TextStyle(color: kSecondaryColor),
        obscureText: widget.isPassword ? showPassword : false,
        keyboardType: widget.inputType,
        decoration: InputDecoration(
          filled: true,
          fillColor: widget.backgroundColor,
          suffixIcon: widget.isPassword
              ? InkWell(
                  onTap: () {
                    setState(() {
                      showPassword = !showPassword;
                    });
                  },
                  child: Icon(
                    showPassword ? Icons.visibility : Icons.visibility_off,
                    color: kDetailColor,
                  ),
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none, // Invisible border by default
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none, // Invisible border by default
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color:
                  kDetailColor, // The color you want the border to be when focused
              width: 1.5, // The width of the border when focused
            ),
          ),
        ),
      ),
    );
  }
}
