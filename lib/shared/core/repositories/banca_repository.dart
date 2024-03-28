// ignore_for_file: deprecated_member_use, avoid_print

import 'package:dio/dio.dart';
import 'package:ecommerceassim/shared/constants/app_text_constants.dart';
import 'package:ecommerceassim/shared/core/models/banca_model.dart';
import 'package:ecommerceassim/shared/core/user_storage.dart';

class BancaRepository {
  late String userToken;
  final Dio _dio;

  BancaRepository(this._dio);

  Future<List<BancaModel>> getBancas(int feiraId) async {
    UserStorage userStorage = UserStorage();
    userToken = await userStorage.getUserToken();

    try {
      var response = await _dio.get('$kBaseURL/feiras/$feiraId/bancas',
          options: Options(
            headers: {"Authorization": "Bearer $userToken"},
          ));

      if (response.statusCode == 200) {
        final List<dynamic> bancasJson = response.data['bancas'] ?? [];
        if (bancasJson.isNotEmpty) {
          return bancasJson
              .map((bancaJson) => BancaModel.fromJson(bancaJson))
              .toList();
        } else {
          print('Não foram encontradas bancas para a feira com ID: $feiraId.');
          return [];
        }
      } else {
        // Loga a flha na requisição com o código de status.
        print('A requisição falhou com o status: ${response.statusCode}.');
        return [];
      }
    } on DioError catch (dioError) {
      print('Erro de Dio capturado: ${dioError.message}');
      return [];
    } catch (error) {
      print('Ocorreu um erro inesperado: $error');
      return [];
    }
  }
}
