// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:ecommerceassim/shared/core/models/banca_model.dart';
import 'package:ecommerceassim/shared/core/repositories/banca_repository.dart';
import 'package:flutter/material.dart';

class BancaController with ChangeNotifier {
  List<BancaModel> _bancas = [];
  final BancaRepository _bancaRepository = BancaRepository();

  List<BancaModel> get bancas => _bancas;

  Future<void> loadBancas(int feiraId) async {
    try {
      _bancas = await _bancaRepository.getBancas(feiraId);
      notifyListeners();
    } catch (error) {
      print(feiraId);
      print('Erro ao carregar as bancas: $error');
    }
  }
}
