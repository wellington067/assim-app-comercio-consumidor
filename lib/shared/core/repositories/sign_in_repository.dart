import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:ecommerceassim/shared/constants/app_text_constants.dart';
import 'package:ecommerceassim/shared/core/user_storage.dart';

class SignInRepository {
  final userStorage = UserStorage();

  final _dio = Dio();
  Future<int> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dio.post(
        '$kBaseURL/sanctum/token',
        data: {'email': email, 'password': password, 'device_name': "PC"},
      );
      if (response.statusCode == 200 && response.data['token'] != null) {
        if (await userStorage.userHasCredentials()) {
          await userStorage.clearUserCredentials();
        }
        String userToken = response.data['token'].toString();
        var userData = response.data['user'];

        // Verificar se o 'telefone' existe antes de tentar acessá-los.
        String telefone = '';
        if (userData != null && userData['contato'] != null) {
          telefone = userData['contato']['telefone'].toString();
        } else {
          log('Objeto telefone é nulo: ${userData}');
        }

        await userStorage.saveUserCredentials(
          id: userData['id'].toString(),
          nome: userData['name'].toString(),
          token: userToken,
          email: userData['email'].toString(),
          telefone: telefone,
        );

        try {
          Response userInfoResponse = await _dio.get(
            '$kBaseURL/users/${userData['id']}',
            options: Options(headers: {"Authorization": "Bearer $userToken"}),
          );
          if (userInfoResponse.statusCode == 200 &&
              userInfoResponse.data["user"] != null) {
            return 1;
          } else {
            log('Estrutura de dados de resposta inesperada: ${userInfoResponse.data}');
            return 2;
          }
        } catch (e) {
          log('Erro ao recuperar dados do usuário: $e');
          return 0;
        }
      } else {
        log('Resposta de login inválida: ${response.data}');
        return 0;
      }
    } catch (e) {
      log('Exceção de login: $e');
      return 0;
    }
  }
}
