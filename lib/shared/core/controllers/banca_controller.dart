import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:ecommerceassim/shared/core/models/banca_model.dart';
import 'package:ecommerceassim/shared/core/models/feira_model.dart';
import 'package:ecommerceassim/shared/core/repositories/banca_repository.dart';
import 'package:ecommerceassim/shared/core/user_storage.dart';

import '../../constants/app_text_constants.dart';

class BancaController with ChangeNotifier {
  List<BancaModel> _bancas = [];
  List<FeiraModel> _feiras = []; // Lista para armazenar as feiras carregadas
  final BancaRepository _bancaRepository = BancaRepository();

  List<BancaModel> get bancas => _bancas;
  List<FeiraModel> get feiras => _feiras;

  Future<void> loadBancas(int feiraId) async {
    UserStorage userStorage = UserStorage();
    String userToken = await userStorage.getUserToken();
    try {
      _bancas = await _bancaRepository.getBancas(feiraId);
      notifyListeners();
    } catch (error) {
      print('Erro ao carregar as bancas: $error');
    }
  }

  Future<void> searchBancas(String query) async {
    UserStorage userStorage = UserStorage();
    String userToken = await userStorage.getUserToken();

    if (query.isEmpty) {
      await loadBancas(0);
      return;
    }

    try {
      var options = Options(headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        'Cache-Control': 'no-cache',
        "Authorization": "Bearer $userToken",
      });

      var response =
          await Dio().get('$kBaseURL/bancas/search?q=$query', options: options);

      if (response.statusCode == 200) {
        var json = response.data;
        if (json['bancas'].isEmpty) {
          _bancas = [];
          print('Nenhuma banca encontrada para a busca: $query');
        } else {
          _bancas = List<BancaModel>.from(
              json['bancas'].map((x) => BancaModel.fromJson(x)));
        }
      } else {
        _bancas = [];
        print('Erro ao buscar bancas: Status ${response.statusCode}');
      }
    } catch (error) {
      print('Erro na busca de bancas: $error');
      _bancas = [];
    }
    notifyListeners();
  }

  Future<void> loadFeirasByCidadeId(int cidadeId) async {
    UserStorage userStorage = UserStorage();
    String userToken = await userStorage.getUserToken();
    Dio dio = Dio();
    try {
      var bairrosResponse = await dio.get(
        '$kBaseURL/bairros/cidade/$cidadeId',
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            'Cache-Control': 'no-cache',
            "Authorization": "Bearer $userToken"
          },
        ),
      );

      if (bairrosResponse.statusCode == 200) {
        final bairrosJson = List.from(bairrosResponse.data['bairros']);
        final List<int> bairroIds =
            bairrosJson.map((bairro) => bairro['id'] as int).toList();
        var feirasResponse = await dio.get(
          '$kBaseURL/feiras',
          options: Options(
            headers: {
              "Content-Type": "application/json",
              "Accept": "application/json",
              'Cache-Control': 'no-cache',
              "Authorization": "Bearer $userToken"
            },
          ),
        );

        if (feirasResponse.statusCode == 200) {
          final feirasJson = List.from(feirasResponse.data['feiras'])
              .map((feira) => FeiraModel.fromJson(feira))
              .toList();
          _feiras = feirasJson
              .where((feira) => bairroIds.contains(feira.bairroId))
              .toList();
          notifyListeners();
        } else {
          print('Erro ao carregar bancas: ${feirasResponse.statusCode}');
          throw Exception('Failed to load bancas');
        }
      } else {
        print('Erro ao carregar bairros: ${bairrosResponse.statusCode}');
        throw Exception('Failed to load bairros');
      }
    } catch (error) {
      print('Erro ao carregar as feiras e bairros: $error');
      rethrow;
    }
  }
}
