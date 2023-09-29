import 'package:dio/dio.dart';
import 'package:ecommerceassim/shared/core/user_storage.dart';

import '../../constants/app_text_constants.dart';
import '../models/produto_model.dart';

class ProdutoRepository {
  late String userToken;
  final Dio _dio;

  ProdutoRepository(this._dio);

  Future<List<ProdutoModel>> getProdutos() async {
    UserStorage userStorage = UserStorage();

    userToken = await userStorage.getUserToken();

    try {
      var response = await _dio.get('$kBaseURL/bancas',
          options: Options(
            headers: {"Authorization": "Bearer $userToken"},
          ));
      if (response.statusCode == 200) {
        final List<ProdutoModel> produtos = [];
        final Map<String, dynamic> jsonData = response.data;
        final produtosJson = jsonData['produtos'];
        for (var item in produtosJson) {
          final ProdutoModel banca = ProdutoModel.fromJson(item);
          produtos.add(banca);
        }
        return produtos;
      } else {
        throw Exception('Não foi possível carregar as bancas.');
      }
    } catch (error) {
      throw Exception('Erro ao fazer a requisição: $error');
    }
  }
}
