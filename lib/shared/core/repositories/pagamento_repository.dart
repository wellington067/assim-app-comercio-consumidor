import 'dart:io';
import 'package:dio/dio.dart';
import 'package:ecommerceassim/shared/constants/app_text_constants.dart';
import 'package:ecommerceassim/shared/core/models/pagamento_model.dart';
import 'package:ecommerceassim/shared/core/user_storage.dart';

class PagamentoRepository {
  final Dio _dio = Dio();

  Future<void> uploadComprovante(PagamentoModel pagamento, int orderId) async {
    final userToken = await UserStorage().getUserToken();

    String url = '$kBaseURL/transacoes/$orderId/comprovante';
    FormData formData = FormData.fromMap({
      "comprovante": await MultipartFile.fromFile(pagamento.comprovante.path,
          filename: 'comprovante.jpg'),
    });

    try {
      Response response = await _dio.post(
        url,
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $userToken',
            'Content-Type': 'multipart/form-data',
          },
        ),
      );
      if (response.statusCode != 200) {
        throw Exception('Falha ao enviar comprovante');
      }
    } catch (e) {
      throw Exception('Erro: $e');
    }
  }
}
