import 'package:flutter/foundation.dart';

class ProductsDetailsController extends ChangeNotifier{
    int quantity = 1;
  void incrementQuantity(int maxQuantity) {
    if (quantity < maxQuantity) {
      quantity++;
      notifyListeners();
    }
  }

  void decrementQuantity() {
    if (quantity > 1) {
    quantity--;
    notifyListeners();
    }
  }

}