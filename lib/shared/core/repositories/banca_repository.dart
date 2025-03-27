// ignore_for_file: deprecated_member_use

import 'package:dio/dio.dart';
import 'package:ecommerceassim/shared/constants/app_text_constants.dart';
import 'package:ecommerceassim/shared/core/models/banca_model.dart';
import 'package:ecommerceassim/shared/core/user_storage.dart';

class BancaRepository {
  final Dio _dio = Dio();

  Future<List<BancaModel>> getBancas(int feiraId) async {
    final userToken = await UserStorage().getUserToken();

    try {
      final response = await _dio.get(
        '$kBaseURL/feiras/$feiraId/bancas',
        options: Options(
          headers: {"Authorization": "Bearer $userToken"},
        ),
      );

      if (response.statusCode == 200) {
        final List<dynamic> bancasJson = response.data['bancas'] ?? [];
        return bancasJson
            .map((bancaJson) => BancaModel.fromJson(bancaJson))
            .toList();
      } else {
        throw Exception(
            'Failed to load bancas with status code: ${response.statusCode}.');
      }
    } on DioError catch (dioError) {
      throw Exception('DioError caught: ${dioError.message}');
    } catch (error) {
      throw Exception('An unexpected error occurred: $error');
    }
  }

  Future<BancaModel> getBanca(int bancaId) async {
  final userToken = await UserStorage().getUserToken();

  try {
    print('Buscando dados da banca ID: $bancaId');
    
    final response = await _dio.get(
      '$kBaseURL/bancas/$bancaId',
      options: Options(
        headers: {"Authorization": "Bearer $userToken"},
      ),
    );

    if (response.statusCode == 200) {
      // Verifica e loga a resposta completa para debug
      print('Resposta da API: ${response.data}');
      
      final bancaJson = response.data['banca'];
      
      // Verifica especificamente o campo pix
      print('Campo pix na resposta: ${bancaJson['pix']}');
      
      BancaModel banca = BancaModel.fromJson(bancaJson);
      print('Banca carregada: ${banca.nome}, PIX: ${banca.pix}');
      
      return banca;
    } else {
      throw Exception(
          'Failed to load banca with status code: ${response.statusCode}.');
    }
  } catch (error) {
    print('Erro ao buscar banca: $error');
    throw Exception('An unexpected error occurred: $error');
  }
}
}
