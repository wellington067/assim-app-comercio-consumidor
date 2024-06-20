import 'package:ecommerceassim/shared/components/dialogs/confirm_dialog.dart';
import 'package:ecommerceassim/shared/constants/app_number_constants.dart';
import 'package:ecommerceassim/shared/validation/validate_mixin.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommerceassim/components/buttons/custom_text_button.dart';
import 'package:ecommerceassim/components/forms/custom_text_form_field.dart';
import 'package:ecommerceassim/components/utils/vertical_spacer_box.dart';
import 'package:ecommerceassim/shared/core/controllers/sign_in_controller.dart';
import 'package:ecommerceassim/shared/constants/style_constants.dart';
import 'package:ecommerceassim/screens/screens_index.dart';
import '../../shared/constants/app_enums.dart';

class SignInScreen extends StatelessWidget with ValidationMixin {
  SignInScreen({super.key});
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SignInController(),
      child: Consumer<SignInController>(
        builder: (context, controller, child) => Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: kOnSurfaceColor,
          appBar: AppBar(
            backgroundColor: kOnSurfaceColor,
            iconTheme: const IconThemeData(color: kDetailColor),
            elevation: 0,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(kDefaultPadding),
              child: Form(
                key: formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Entrar',
                      style: kTitle.copyWith(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const VerticalSpacerBox(size: SpacerSize.huge),
                    CustomTextFormField(
                      hintText: 'E-mail',
                      icon: Icons.email,
                      controller: controller.emailController,
                      validateForm: (value) => isValidEmail(value),
                    ),
                    const VerticalSpacerBox(size: SpacerSize.small),
                    CustomTextFormField(
                      hintText: 'Senha',
                      isPassword: true,
                      icon: Icons.lock,
                      controller: controller.passwordController,
                      validateForm: (value) => isValidPassword(value),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: CustomTextButton(
                        title: 'Esqueceu a senha?',
                        onPressed: () async {
                          showForgotPasswordDialog(context, controller);
                        },
                      ),
                    ),
                    const VerticalSpacerBox(size: SpacerSize.medium),
                    if (controller.status == SignInStatus.loading)
                      const Center(
                        child: CircularProgressIndicator(color: kDetailColor),
                      )
                    else
                      ElevatedButton(
                        onPressed: () {
                          if (formkey.currentState!.validate()) {
                            controller.signIn(context);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kDetailColor,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          textStyle: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        child: const Text(
                          'Entrar',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    const VerticalSpacerBox(size: SpacerSize.medium),
                    if (controller.errorMessage != null)
                      Text(
                        controller.errorMessage!,
                        style: kCaption1,
                        textAlign: TextAlign.center,
                      ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Não possui conta?'),
                        CustomTextButton(
                          title: 'Crie aqui',
                          onPressed: () =>
                              Navigator.pushNamed(context, Screens.register),
                        ),
                      ],
                    ),
                    const VerticalSpacerBox(size: SpacerSize.small),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showForgotPasswordDialog(
      BuildContext context, SignInController controller) {
    final TextEditingController emailController = TextEditingController();
    final GlobalKey<FormState> dialogFormKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Center(
            child: Text(
              'Esqueceu a senha?',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          backgroundColor: Colors.white,
          content: Form(
            key: dialogFormKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomTextFormField(
                  hintText: 'Informe o e-mail:',
                  icon: Icons.email,
                  controller: emailController,
                  validateForm: (value) => isValidEmail(value),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              style: TextButton.styleFrom(
                foregroundColor: kDetailColor,
              ),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (dialogFormKey.currentState!.validate()) {
                  try {
                    await controller
                        .sendResetPasswordEmail(emailController.text);
                    Navigator.of(context).pop();
                    confirmDialog(
                      context,
                      'Email Enviado',
                      'Um email de redefinição de senha foi enviado para o seu endereço de email.',
                      'Cancelar',
                      'Ok',
                    );
                  } catch (e) {
                    Navigator.of(context).pop();
                    confirmDialog(
                      context,
                      'Erro',
                      e.toString().replaceAll('Exception: ', ''),
                      'Cancelar',
                      'Ok',
                    );
                  }
                } else {
                  controller
                      .setErrorMessage('Por favor, forneça um email válido.');
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: kDetailColor,
                foregroundColor: kOnSurfaceColor,
              ),
              child: const Text('Enviar'),
            ),
          ],
        );
      },
    );
  }
}
