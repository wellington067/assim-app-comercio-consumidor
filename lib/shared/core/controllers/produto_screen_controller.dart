import 'dart:convert';

import 'package:ecommerceassim/shared/core/models/table_products_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProdutoScreenController {
  Future<List<TableProductsModel>> loadList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> listaString =
        prefs.getStringList('listaProdutosTabelados') ?? [];
    return listaString
        .map((string) => TableProductsModel.fromJson(json.decode(string)))
        .toList();
  }
}