import 'package:dio/dio.dart';
import 'package:ecommerceassim/screens/cesta/card_cart.dart';
import 'package:ecommerceassim/shared/core/repositories/banca_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../shared/core/models/banca_model.dart';
import '../../shared/core/models/cart_model.dart';
import '../../shared/core/models/produto_model.dart';
import '../../shared/core/repositories/produto_repository.dart';
import '../../shared/core/user_storage.dart';

class ProductsController extends GetxController {
  List<CartModel> listCart = [];
  ProdutoModel? produto;
  List<ProdutoModel?> cartProduct = [];

  final ProdutoRepository produtoRepository = ProdutoRepository(Dio());
  final BancaRepository bancaRepository = BancaRepository(Dio());

  CartModel createCart(BuildContext context, int amount, ProdutoModel produto) {
    final Map<String, dynamic> arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final int bancaId = arguments['id'];

    CartModel cart = CartModel(
        produto.id, bancaId, produto.descricao, produto.preco, amount);
    return cart;
  }
}
