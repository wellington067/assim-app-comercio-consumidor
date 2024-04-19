class CartModel {
  int? productId;
  int? storeId;
  String? nameProduct;
  String? price;
  int? produtoTabeladoId;
  int amount;

  CartModel(
      this.productId, this.storeId, this.nameProduct, this.price,this.produtoTabeladoId, this.amount);
}
