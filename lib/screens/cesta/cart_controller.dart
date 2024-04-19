import 'dart:developer';
import 'package:ecommerceassim/screens/produto/products_controller.dart';
import 'package:ecommerceassim/shared/core/models/cart_model.dart';

import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../shared/core/user_storage.dart';
import 'card_cart.dart';

class CartController extends GetxController{
  UserStorage userStorage = UserStorage();
  int _counter = 0;
  int get counter => _counter;
  double total = 0.00;
  late int amount = 0;
  List<CardCart> cards = [];

  //ProductsController productsController = ProductsController();


  List<CardCart> populateCardCart(List<CartModel> listCart){
    List<CardCart> list = [];

      if (listCart.isNotEmpty) {
        for (int i = 0; i < listCart.length; i++) {
          print(listCart[i]);
          CardCart card = CardCart(listCart[i], CartController());
          list.add(card);
          print(list);
        }
      } else {
        log('CARD VAZIO');
        list = [];
        print(listCart);
        print(list);
        return list;
      }

    // Verifica se a lista está vazia antes de tentar acessá-la
    if (list.isNotEmpty) {
      update();
      print(listCart);
      print(list);
      return list;
    } else {
      throw RangeError('Lista vazia');
    }
  }

  void incrementCounter() {
    _counter++;
    update();
  }

  void decrementCounter() {
    _counter--;
    update();
  }

  void incrementTotal(double valor) {
    total += valor;
    update();
  }

  @override
  void onInit() async {
    super.onInit();
    update();
  }

}