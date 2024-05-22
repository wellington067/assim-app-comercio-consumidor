// ignore_for_file: avoid_print, deprecated_member_use

import 'package:dio/dio.dart';
import 'package:ecommerceassim/shared/core/models/banca_model.dart';
import 'package:ecommerceassim/shared/core/models/cart_model.dart';
import 'package:ecommerceassim/shared/core/repositories/banca_repository.dart';
import 'package:ecommerceassim/shared/core/repositories/purchase_repository.dart';
import 'package:ecommerceassim/shared/core/user_storage.dart';
import 'package:get/get.dart';

class PurchaseController extends GetxController {
  BancaModel? bancaModel;
  List<CartModel>? listCartModel;
  int? enderecoId;
  int? formaPagamento;
  bool? isDelivery;
  UserStorage userStorage = UserStorage();
  String userName = '';
  String userToken = '';
  String tipoEntrega = '';
  final BancaRepository _bancaRepository = BancaRepository();
  final purchaseRepository _purchaseRepository = purchaseRepository();

  PurchaseController({required this.listCartModel});

  Future<void> loadBanca() async {
    try {
      bancaModel = await _bancaRepository.getBanca(listCartModel![0].storeId!);
      update();
    } catch (error) {
      print('Erro ao carregar a banca: $error');
    }
  }

  Future<bool> purchase(
      int enderecoId, String tipoEntrega, int formaPagamento) async {
    List<List> listCartModelSplited = [];
    for (var cart in listCartModel!) {
      List listItem = [];
      listItem.add(cart.productId);
      listItem.add(cart.amount);
      listCartModelSplited.add(listItem);
    }
    try {
      final response = await _purchaseRepository.purchase(listCartModelSplited,
          bancaModel!.id, userToken, enderecoId, tipoEntrega, formaPagamento);
      return response;
    } on DioError catch (dioError) {
      if (dioError.response?.statusCode == 400) {
        final errorMessage =
            dioError.response?.data['error'] ?? 'Erro desconhecido';
        throw Exception(errorMessage);
      } else {
        throw Exception('Erro ao realizar a compra: ${dioError.message}');
      }
    } catch (error) {
      rethrow;
    }
  }

  double get totalValue => listCartModel?.isNotEmpty == true
      ? listCartModel!.fold(
          0, (total, cart) => total + cart.amount * double.parse(cart.price!))
      : 0;

  void removeZeroQuantityItems() {
    listCartModel?.removeWhere((item) => item.amount <= 0);
    update();
  }

  void updateCartItemQuantity(int productId, int quantity) {
    final cartItem =
        listCartModel?.firstWhereOrNull((item) => item.productId == productId);
    if (cartItem != null) {
      cartItem.amount = quantity;
      if (cartItem.amount <= 0) {
        listCartModel?.remove(cartItem);
      }
      update();
    }
  }

  @override
  void onInit() async {
    await loadBanca();
    userName = await userStorage.getUserName();
    userToken = await userStorage.getUserToken();
    removeZeroQuantityItems(); // Ensure no zero quantity items at the start
    update();
    super.onInit();
  }
}
