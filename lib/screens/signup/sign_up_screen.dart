import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ecommerceassim/shared/core/controllers/sign_up_controller.dart';
import 'package:ecommerceassim/shared/constants/style_constants.dart';
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
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Center(
                      child: Text(
                        'Cadastro',
                        style: kTitle2.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 28,
                          color: kSecondaryDarkColor,
                        ),
                      ),
                    ),
                    InfoFirstScreen(controller),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          controller.signUp(context);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kDetailColor,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        textStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: const Text(
                        'Concluir',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
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
