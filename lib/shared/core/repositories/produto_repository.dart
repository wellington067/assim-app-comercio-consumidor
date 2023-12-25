import 'package:dio/dio.dart';
import 'package:ecommerceassim/shared/core/user_storage.dart';

import '../../constants/app_text_constants.dart';
import '../models/produto_model.dart';

class ProdutoRepository {
  late String userToken;
  final Dio _dio;

  ProdutoRepository(this._dio);

  Future<List<ProdutoModel>> getProdutos(int bancaId) async {
    // Adicionado parâmetro bancaId
    UserStorage userStorage = UserStorage();

    userToken = await userStorage.getUserToken();

    try {
      // URL ajustada para incluir o ID da banca
      var response = await _dio.get('$kBaseURL/bancas/$bancaId/produtos',
          options: Options(
            headers: {"Authorization": "Bearer $userToken"},
          ));
      if (response.statusCode == 200) {
        final List<ProdutoModel> produtos = [];
        // Supondo que a resposta seja uma lista diretamente, se não for, você precisará ajustar o caminho.
        for (var item in response.data) {
          final ProdutoModel produto = ProdutoModel.fromJson(item);
          produtos.add(produto);
        }
        return produtos;
      } else {
        throw Exception('Não foi possível carregar os produtos da banca.');
      }
    } catch (error) {
      throw Exception('Erro ao fazer a requisição: $error');
    }
  }
}
