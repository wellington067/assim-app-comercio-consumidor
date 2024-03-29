import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ecommerceassim/shared/core/controllers/sign_up_controller.dart';
import 'package:ecommerceassim/shared/constants/style_constants.dart';
import '../../components/buttons/custom_text_button.dart';
import '../../components/buttons/primary_button.dart';
import '../../components/utils/vertical_spacer_box.dart';
import '../../shared/components/dialogs/default_alert_dialog.dart';
import '../../shared/constants/app_enums.dart';
import '../../shared/constants/app_number_constants.dart';
import '../../shared/core/navigator.dart';
import '../screens_index.dart';
import 'components/info_first_screen.dart';
// import 'components/info_second_screen.dart'; // Descomente para usar

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(); // Chave global para o Form

  @override
  Widget build(BuildContext context) {
    Size size =
        MediaQuery.of(context).size; // Tamanho da tela para design responsivo
    return GetBuilder<SignUpController>(
      init: SignUpController(),
      builder: (controller) => Scaffold(
        appBar: AppBar(
          backgroundColor: kOnSurfaceColor,
          iconTheme: const IconThemeData(color: kDetailColor),
          elevation: 0,
        ),
        backgroundColor: kOnSurfaceColor,
        body: SingleChildScrollView(
          reverse: true,
          child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              width: size.width,
              padding: const EdgeInsets.all(kDefaultPadding),
              child: Form(
                key: _formKey, // Associar a chave global do Form
                child: Column(
                  children: [
                    Center(
                      child: Text(
                        controller.infoIndex == 0 ? 'Cadastro' : 'Endereço',
                        style: kTitle2.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 28,
                            color: kSecondaryDarkColor),
                      ),
                    ),
                    // A estrutura condicional para exibir diferentes telas baseadas no índice
                    if (controller.infoIndex == 0) InfoFirstScreen(controller),
                    // Descomente e implemente suas condições e telas adicionais conforme necessário
                    // if (controller.infoIndex == 1) InfoSecondScreen(controller),
                    // Adicione mais condições para outras telas de cadastro aqui
                    PrimaryButton(
                      text: 'Concluir',
                      onPressed: () {
                        // Verificar se o form é válido antes de prosseguir
                        if (_formKey.currentState!.validate()) {
                          controller.signUp(context);
                        }
                      },
                      color: kDetailColor,
                    ),
                    // Outros widgets e lógica podem ser adicionados aqui conforme necessário
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
