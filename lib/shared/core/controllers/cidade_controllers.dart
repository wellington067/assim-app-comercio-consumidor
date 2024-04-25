// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:ecommerceassim/shared/core/models/cidade_model.dart';
import 'package:ecommerceassim/shared/core/repositories/cidade_repository.dart';
import 'package:flutter/material.dart';

class CidadeController with ChangeNotifier {
  final CidadeRepository _cidadeRepository = CidadeRepository(Dio());

  List<CidadeModel> _cidades = [];

  List<CidadeModel> get cidades => _cidades;

  Future<void> loadCidades() async {
    try {
      _cidades = await _cidadeRepository.getCidades();
      notifyListeners();
    } catch (error) {
      print('Erro ao carregar as cidades: $error');
    }
  }
}
