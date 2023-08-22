import 'package:dio/dio.dart';
import 'package:ecommerceassim/shared/core/user_storage.dart';

import '../../constants/app_text_constants.dart';
import '../models/feira_model.dart';

class FeiraRepository {
  late String userToken;
  final Dio _dio;

  FeiraRepository(this._dio);

  Future<List<FeiraModel>> getFeiras() async {
    UserStorage userStorage = UserStorage();

    userToken = await userStorage.getUserToken();

    try {
      var response = await _dio.get('$kBaseURL/feiras',
          options: Options(
            headers: {
              "Content-Type": "application/json",
              "Accept": "application/json",
              'Cache-Control': 'no-cache',
              "Authorization": "Bearer $userToken"
            },
          ));
      if (response.statusCode == 200) {
        final List<FeiraModel> feiras = [];
        final Map<String, dynamic> jsonData = response.data;
        final feirasJson = jsonData['feiras'];
        for (var item in feirasJson) {
          final FeiraModel feira = FeiraModel.fromJson(item);
          feiras.add(feira);
        }
        return feiras;
      } else {
        throw Exception('Não foi possível carregar as feiras.');
      }
    } catch (error) {
      throw Exception('Erro ao fazer a requisição: $error');
    }
  }
}
