// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:ecommerceassim/shared/constants/app_text_constants.dart';
import 'package:flutter/material.dart';
import '../../constants/style_constants.dart';
import '../user_storage.dart';
import '../../../screens/screens_index.dart';

class SignUpRepository {
  final Dio _dio = Dio();
  UserStorage userStorage = UserStorage();

  Future<bool> signUp(String name, String email, String password,
      String telefone, String cpf, BuildContext context) async {
    try {
      Response response = await _dio.post(
        '$kBaseURL/users',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
          validateStatus: (status) => status! < 500,
        ),
        data: {
          "name": name,
          "email": email,
          "password": password,
          "telefone": telefone,
          "cpf": cpf,
          "roles": [5],

          // Termos abaixo estão como obrigatório no banco, não deveria
          /*   "rua": "São José das Flores",
          "cep": "54758-948",
          "numero": "423",
          "bairro_id": "1" */
        },
      );

      if (response.statusCode == 201) {
        String userToken = response.data['token'].toString();
        await userStorage.saveUserCredentials(
          nome: name,
          email: email,
          id: response.data['user']['id'].toString(),
          token: userToken,
        );

        showSignUpSuccessDialog(context, 'Cadastro realizado com sucesso!');
        return true;
      } else if (response.statusCode == 422) {
        log('Erro 422: ${response.data}');
        showSignUpErrorDialog(
            context, 'Dados inválidos. Verifique os campos e tente novamente');
        return false;
      } else {
        showSignUpErrorDialog(
            context, 'Ocorreu um erro desconhecido. Tente novamente');
        return false;
      }
    } catch (e) {
      log('Erro no cadastro do consumidor: ${e.toString()}');
      showSignUpErrorDialog(
          context, 'Ocorreu um erro, verifique os campos e tente novamente');
      return false;
    }
  }

  void showSignUpSuccessDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: const Text(
            'Sucesso!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: kDetailColor,
            ),
          ),
          content: Text(
            message,
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            Container(
              width: double.infinity,
              height: 50,
              margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: kDetailColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.pushReplacementNamed(context, Screens.home);
                },
                child: const Text(
                  'Ok',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void showSignUpErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: const Text(
            'Erro',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: kErrorColor,
            ),
          ),
          content: Text(
            message,
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            Container(
              width: double.infinity,
              height: 50,
              margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: kErrorColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () => Navigator.of(context).pop(),
                child: const Text(
                  'Ok',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
