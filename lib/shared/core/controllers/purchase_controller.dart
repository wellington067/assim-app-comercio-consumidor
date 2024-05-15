import 'package:ecommerceassim/shared/core/models/banca_model.dart';
import 'package:ecommerceassim/shared/core/models/cart_model.dart';
import 'package:ecommerceassim/shared/core/repositories/banca_repository.dart';
import 'package:ecommerceassim/shared/core/repositories/purchase_repository.dart';
import 'package:ecommerceassim/shared/core/user_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class PurchaseController extends GetxController{
  BancaModel? bancaModel;
  List<CartModel>? listCartModel;
  int? enderecoId;
  bool? isDelivery;
  UserStorage userStorage = UserStorage();
  String userName = '';
  String userToken = '';
  final BancaRepository _bancaRepository = BancaRepository();
  final purchaseRepository _purchaseRepository = purchaseRepository();

  PurchaseController({required this.listCartModel});


  Future<void> loadBanca() async{
    try {
      bancaModel = await _bancaRepository.getBanca(listCartModel![0].storeId!);
      update();
    } catch (error) {
      print('Erro ao carregar a banca: $error');
    }
  }

  Future<bool> purchase() async{
    List<List> listCartModelSplited = [];
    for (var cart in listCartModel!) {
      List listItem = [];
      listItem.add(cart.productId);
      listItem.add(cart.amount);
      listCartModelSplited.add(listItem);
     }
    try {
      final response = await _purchaseRepository.purchase(listCartModelSplited, bancaModel!.id, userToken);
      return response;
  } catch (error) {
    print('Erro ao realizar a compra: $error');
    return false;
  }
  }

  double get totalValue => listCartModel!.fold(0, (total, cart) => total + cart.amount! * double.parse(cart.price!));

  @override
  void onInit() async{
    await loadBanca();
    userName = await userStorage.getUserName();
    userToken = await userStorage.getUserToken();
    update();
    super.onInit();
  }


  

}