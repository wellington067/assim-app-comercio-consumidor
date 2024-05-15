import 'package:dio/dio.dart';
import 'package:ecommerceassim/shared/constants/app_text_constants.dart';

class purchaseRepository {
  Dio dio = Dio();

  Future<bool> purchase(
      List<List> products, int storeId, String userToken) async {

        print(products);
        print(storeId);
        print(userToken);
    try {
      final response = await dio.post(
        '$kBaseURL/transacoes',
        options: Options(headers: {"Authorization": "Bearer $userToken"}),
        data: {
          "produtos": products,
          "banca_id": storeId,
          "forma_pagamento_id": 1,
          "tipo_entrega": "retirada"
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        throw Exception(
            'Failed to purchase with status code: ${response.statusCode}.');
      }
    } on DioException catch (dioError) {
      throw Exception('DioError caught: ${dioError.message}');
    } catch (error) {
      throw Exception('An unexpected error occurred: $error');
    }
  }
}
