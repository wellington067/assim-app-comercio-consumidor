import 'package:dio/dio.dart';
import 'package:ecommerceassim/shared/constants/app_text_constants.dart';
import 'package:ecommerceassim/shared/core/models/banca_model.dart';
import 'package:ecommerceassim/shared/core/user_storage.dart';

class BancaRepository {
  late String userToken;
  final Dio _dio;

  BancaRepository(this._dio);

  Future<List<BancaModel>> getBancas() async {
    UserStorage userStorage = UserStorage();
    userToken = await userStorage.getUserToken();

    try {
      var response = await _dio.get('$kBaseURL/bancas',
          options: Options(
            headers: {"Authorization": "Bearer $userToken"},
          ));
      if (response.statusCode == 200) {
        final List<BancaModel> bancas = [];
        final Map<String, dynamic> jsonData = response.data;
        final bancasJson = jsonData['bancas'];

        if (bancasJson.isEmpty) {
          throw Exception('Nenhuma banca cadastrada.');
        }

        for (var item in bancasJson) {
          final BancaModel banca = BancaModel.fromJson(item);
          bancas.add(banca);
        }
        return bancas;
      } else {
        throw Exception('Não foi possível carregar as bancas.');
      }
    } catch (error) {
      throw Exception('Erro ao fazer a requisição: $error');
    }
  }
}
