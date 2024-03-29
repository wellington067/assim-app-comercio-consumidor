import 'package:ecommerceassim/shared/constants/app_number_constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommerceassim/components/buttons/custom_text_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ecommerceassim/components/buttons/primary_button.dart';
import 'package:ecommerceassim/components/forms/custom_text_form_field.dart';
import 'package:ecommerceassim/components/utils/vertical_spacer_box.dart';
import 'package:ecommerceassim/shared/core/controllers/sign_in_controller.dart';
import 'package:ecommerceassim/shared/constants/style_constants.dart';
import 'package:ecommerceassim/screens/screens_index.dart';
import '../../shared/constants/app_enums.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

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
                  ),
                  const VerticalSpacerBox(size: SpacerSize.small),
                  CustomTextFormField(
                    hintText: 'Senha',
                    isPassword: true,
                    icon: Icons.lock,
                    controller: controller.passwordController,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: CustomTextButton(
                      title: 'Esqueceu a senha?',
                      onPressed: () {},
                    ),
                  ),
                  const VerticalSpacerBox(size: SpacerSize.medium),
                  if (controller.status == SignInStatus.loading)
                    const CircularProgressIndicator()
                  else
                    PrimaryButton(
                      text: 'Entrar',
                      onPressed: () => controller.signIn(context),
                      color: kDetailColor,
                    ),
                  const VerticalSpacerBox(size: SpacerSize.medium),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Divider(
                          color: Colors.grey,
                          thickness: 1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          'ou',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: Colors.grey,
                          thickness: 1,
                        ),
                      ),
                    ],
                  ),
                  const VerticalSpacerBox(size: SpacerSize.medium),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(FontAwesomeIcons.google,
                            color: kErrorColor),
                        iconSize: 38,
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(FontAwesomeIcons.facebook,
                            color: kTextSign),
                        iconSize: 38,
                      ),
                    ],
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
    );
  }
}
