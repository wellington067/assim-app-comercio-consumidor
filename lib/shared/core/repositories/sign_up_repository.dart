// ignore_for_file: deprecated_member_use, avoid_print, use_build_context_synchronously

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:ecommerceassim/shared/constants/app_text_constants.dart';
import 'package:ecommerceassim/shared/core/models/cidade_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../components/dialogs/default_alert_dialog.dart';
import '../../constants/style_constants.dart';
import '../models/bairro_model.dart';
import '../user_storage.dart';
import '../../../screens/screens_index.dart';
import 'sign_in_repository.dart';

class SignUpRepository {
  final Dio _dio = Dio();
  BairroModel bairroModel = BairroModel();
  CidadeModel cidadeModel = CidadeModel();
  UserStorage userStorage = UserStorage();
  int id = 0;
  SignInRepository signInRepository = SignInRepository();
  Future<bool> signUp(
      String name,
      String email,
      String password,
      String telefone,
      String cpf,
      String rua,
      String numero,
      String cep,
      int cidade,
      int bairro,
      BuildContext context) async {
    try {
      //Efetua a chamada da API para o cadastro do produtor
      Response response = await _dio.post('$kBaseURL/users',
          options: Options(headers: {
            'Content-Type': 'application/json',
            // "Accept": "application/json",
          }),
          data: {
            "name": name,
            "email": email,
            "password": password,
            "telefone": telefone,
            "cpf": cpf,
            "roles": [5],
            "rua": rua,
            "bairro_id": bairro,
            "numero": numero,
            "cep": cep,
            "cidade": cidade,
          });
      print(response.data);
      if (response.statusCode == 201) {
        print(response.data);
        //int idTemp = response.data["user"]["id"];
        //String emailTemp = response.data["user"]["email"];
        //String deviceConsumidor = response.data["user"]["device_name"];
        //Caso o cadastro do consumidor dê certo, ele pega o email do produtor e faz o login para pegar o token,
        // depois ele faz o cadastro da banca
        //String emailConsumidor = response.data["user"]["email"];
        // ignore: unused_local_variable
        // int idConsumidor = response.data["user"]["papel_id"];

        //String deviceConsumidor = response.data["user"]["device_name"];
        // log('idConsumidor: $emailConsumidor');
        try {
          Response login = await _dio.post(
            '$kBaseURL/sanctum/token',
            data: {
              'email': email,
              'password': password,
              'device_name': 'PC',
            },
          );

          if (login.statusCode == 200) {
            String userToken = login.data['user']['token'].toString();
            userStorage.saveUserCredentials(
              nome: name,
              email: email,
              //deviceName: login.data['user']['device_name'],
              id: id.toString(),
              token: userToken,
              //deviceName: deviceConsumidor
            );

            showSignUpSuccessDialog(
              context,
              'Cadastro realizado com sucesso',
            );

            return true;
          }
        } catch (e) {
          log('Erro no login ${e.toString()}');
          return false;
        }
        return false;
      } else {
        log('error dentro do request do cadastro do consumidor ${response.statusMessage}');
        return false;
      }
    } catch (e) {
      log('Erro na chamada do cadastro do consumidor ${e.toString()}');
      showSignUpErrorDialog(
        context,
        'Ocorreu um erro, verifique os campos e tente novamente',
      );

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

  Future<List<BairroModel>> getBairros() async {
    Dio dio = Dio();

    dio.options.headers['Authorization'] =
        'Bearer 219|XlaocG1Ae9AhwerSvgOTuNhN0nGv5OnciQDc8Lrc269b7169'; // fixo se nao nao da para fazer o cadastro

    try {
      Response response = await dio.get('$kBaseURL/bairros');

      if (response.statusCode == 200 &&
          response.data != null &&
          response.data is Map &&
          response.data.containsKey('bairros')) {
        List<dynamic> bairrosData = response.data['bairros'];
        List<BairroModel> bairros = bairrosData
            .map((bairroJson) => BairroModel.fromJson(bairroJson))
            .toList();

        return bairros;
      } else {
        log('Erro ao buscar bairros: Status Code ${response.statusCode}');
      }
    } on DioError catch (e) {
      log('DioError ao buscar bairros: ${e.toString()}');
    } catch (e) {
      log('Erro desconhecido ao buscar bairros: ${e.toString()}');
    }

    return [];
  }

  Future<List<CidadeModel>> getCidades() async {
    Dio dio = Dio();

    dio.options.headers['Authorization'] =
        'Bearer 219|XlaocG1Ae9AhwerSvgOTuNhN0nGv5OnciQDc8Lrc269b7169';

    try {
      Response response = await dio.get('$kBaseURL/cidades');

      if (response.statusCode == 200 &&
          response.data != null &&
          response.data is Map &&
          response.data.containsKey('cidades')) {
        List<dynamic> cidadesData = response.data['cidades'];
        List<CidadeModel> cidades = cidadesData
            .map((cidadeJson) => CidadeModel.fromJson(cidadeJson))
            .toList();

        return cidades;
      } else {
        log('Erro ao buscar cidades: Status Code ${response.statusCode}');
      }
    } on DioError catch (e) {
      log('DioError ao buscar cidades: ${e.toString()}');
    } catch (e) {
      log('Erro desconhecido ao buscar cidades: ${e.toString()}');
    }

    return [];
  }
}
