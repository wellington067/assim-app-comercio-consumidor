import 'package:dio/dio.dart';
import 'package:ecommerceassim/shared/core/controllers/bairro_controller.dart';
import 'package:ecommerceassim/shared/core/models/feira_model.dart';
import 'package:ecommerceassim/shared/core/repositories/feira_repository.dart';
import 'package:flutter/material.dart';

class FeiraController with ChangeNotifier {
  final FeiraRepository _feiraRepository = FeiraRepository(Dio());
  final BairroController _bairroController;

  FeiraController(this._bairroController);

  List<FeiraModel> _feiras = [];

  List<FeiraModel> get feiras => _feiras;

  Future<void> loadFeiras() async {
    try {
      _feiras = await _feiraRepository.getFeiras();
      notifyListeners();
    } catch (error) {
      print('Erro ao carregar as feiras: $error');
    }
  }

  String getBairroNome(int bairroId) {
    return _bairroController.getBairroNome(bairroId);
  }
}
