import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ecommerceassim/shared/core/models/table_products_model.dart';
import 'package:ecommerceassim/shared/core/repositories/banca_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/cart_model.dart';
import '../models/produto_model.dart';
import '../repositories/produto_repository.dart';

class ProductsController extends GetxController {
  List<CartModel> listCart = [];
  List<TableProductsModel> listTableProducts = [];
  ProdutoModel? produto;
  List<ProdutoModel?> cartProduct = [];

  final ProdutoRepository produtoRepository = ProdutoRepository(Dio());
  final BancaRepository bancaRepository = BancaRepository(Dio());

  CartModel createCart(BuildContext context, int amount, ProdutoModel produto) {
    final Map<String, dynamic> arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final int bancaId = arguments['id'];

    CartModel cart = CartModel(produto.id, bancaId, produto.titulo,
        produto.preco, produto.produtoTabeladoId, amount, produto.estoque);
    return cart;
  }

  Future<List<TableProductsModel>> loadList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> listaString =
        prefs.getStringList('listaProdutosTabelados') ?? [];
    return listaString
        .map((string) => TableProductsModel.fromJson(json.decode(string)))
        .toList();
  }

  @override
  void onInit() async {
    listTableProducts = await loadList();
    super.onInit();
    update();
  }
}
