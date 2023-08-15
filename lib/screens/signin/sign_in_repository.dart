import 'dart:developer';
import 'package:ecommerceassim/shared/core/user_storage.dart';
import 'package:dio/dio.dart';

import '../../shared/constants/app_text_constants.dart';

class SignInRepository {
  final userStorage = UserStorage();

  final _dio = Dio();
  Future signIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dio.post(
        '$kBaseURL/login',
        data: {
          'email': email,
          'password': password,
        },
      );
      if (response.statusCode == 200) {
        if (response.data['user']['papel'].toString() == 'Consumidor') {
          log('User é um Consumidor');
          if (await userStorage.userHasCredentials()) {
            await userStorage.clearUserCredentials();
          }
          await userStorage.saveUserCredentials(
              id: response.data['user']['id'].toString(),
              nome: response.data['user']['nome'].toString(),
              token: response.data['user']['token'].toString(),
              email: response.data['user']['email'].toString(),
              papel: response.data['user']['papel'].toString(),
              papelId: response.data['user']['papel_id'].toString());
          return true;
        } else {
          return false;
        }
      }
    } catch (e) {
      log(e.toString());
      return false;
    }
    return false;
  }
}
