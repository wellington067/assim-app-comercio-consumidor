import 'package:ecommerceassim/shared/core/repositories/pedidos_repository.dart';
import 'package:flutter/material.dart';
import 'package:ecommerceassim/shared/core/user_storage.dart';
import 'package:ecommerceassim/shared/core/models/pedidos_model.dart';

class PedidoController with ChangeNotifier {
  final PedidosRepository _pedidosRepository;

  List<PedidoModel> orders = [];

  PedidoController(this._pedidosRepository) {
    loadOrders();
  }

  Future<void> loadOrders() async {
    orders = await _pedidosRepository.getOrders();
    notifyListeners();
  }
}
