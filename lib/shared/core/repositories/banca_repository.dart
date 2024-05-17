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
      final response = await _dio.get(
        '$kBaseURL/bancas/$bancaId',
        options: Options(
          headers: {"Authorization": "Bearer $userToken"},
        ),
      );

      if (response.statusCode == 200) {
        final bancaJson = response.data['banca'];
        return BancaModel.fromJson(bancaJson);
      } else {
        throw Exception(
            'Failed to load banca with status code: ${response.statusCode}.');
      }
    } catch (error) {
      // Handle general errors here
      throw Exception('An unexpected error occurred: $error');
    }
  }
}
