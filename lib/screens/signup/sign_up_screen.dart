import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ecommerceassim/shared/core/controllers/sign_up_controller.dart';
import 'package:ecommerceassim/shared/constants/style_constants.dart';
import '../../components/buttons/primary_button.dart';
import '../../shared/constants/app_number_constants.dart';
import 'components/info_first_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
                key: _formKey,
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
                    if (controller.infoIndex == 0) InfoFirstScreen(controller),
                    PrimaryButton(
                      text: 'Concluir',
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          controller.signUp(context);
                        }
                      },
                      color: kDetailColor,
                    ),
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
