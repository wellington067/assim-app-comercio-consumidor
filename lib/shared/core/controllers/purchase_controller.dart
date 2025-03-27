// ignore_for_file: avoid_print, deprecated_member_use

import 'package:dio/dio.dart';
import 'package:ecommerceassim/shared/core/models/banca_model.dart';
import 'package:ecommerceassim/shared/core/models/cart_model.dart';
import 'package:ecommerceassim/shared/core/models/pedidos_model.dart';
import 'package:ecommerceassim/shared/core/repositories/banca_repository.dart';
import 'package:ecommerceassim/shared/core/repositories/purchase_repository.dart';
import 'package:ecommerceassim/shared/core/user_storage.dart';
import 'package:get/get.dart';

class PurchaseController extends GetxController {
  int idStore = 0;
  List<BancaModel> bancas = [];
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
      if (listCartModel != null && listCartModel!.isNotEmpty && listCartModel![0].storeId != null) {
        bancaModel = await _bancaRepository.getBanca(listCartModel![0].storeId!);
        print('Banca carregada: ${bancaModel?.nome}');
        print('Chave PIX: ${bancaModel?.pix}'); // Adicionar log para verificar se o pix foi carregado
        update();
      } else {
        print('Não foi possível carregar a banca: storeId não encontrado');
      }
    } catch (error) {
      print('Erro ao carregar a banca: $error');
    }
  }

  Future<PedidoModel> purchase(
    int enderecoId,
    String tipoEntrega,
    int formaPagamento,
  ) async {
    // Validações iniciais mais robustas
    if (listCartModel == null || listCartModel!.isEmpty) {
      throw Exception('Carrinho vazio ou inválido.');
    }

    if (bancaModel == null || bancaModel?.id == null) {
      throw Exception('Banca não carregada corretamente.');
    }

    List<List<dynamic>> listCartModelSplited = []; // Tipo explícito

    // Prepara os dados dos produtos
    for (var cart in listCartModel!) {
      if (cart.productId == null) {
        throw Exception('ID do produto não encontrado.');
      }

      listCartModelSplited.add([cart.productId, cart.amount]);
    }

    try {
      print('Iniciando transação com Banca ID: ${bancaModel!.id}');
      
      var response = await _purchaseRepository.purchase(
        listCartModelSplited,
        bancaModel!.id,
        userToken,
        enderecoId,
        tipoEntrega,
        formaPagamento,
      );

      // Validações adicionais 
      if (response == null) {
        throw Exception('Erro: Pedido retornado é nulo.');
      }

      if (response.id == null) {
        throw Exception('ID do pedido não retornado pelo servidor.');
      }

      print('Pedido gerado com sucesso. ID: ${response.id}');
      return response;
    } catch (error) {
      print('Erro na compra: $error');
      if (error is DioError) {
        throw Exception('Erro na comunicação com o servidor: ${error.message}');
      }
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
    // Carrega a banca primeiro e aguarda
    print('Iniciando carregamento da banca em onInit');
    await loadBanca();
    
    // Depois carrega o resto dos dados
    userName = await userStorage.getUserName();
    userToken = await userStorage.getUserToken();
    removeZeroQuantityItems();
    
    // Verificação adicional do PIX
    if (bancaModel != null) {
      print('Banca carregada em onInit. PIX: ${bancaModel!.pix}');
    } else {
      print('Banca não carregada em onInit');
    }
    
    update();
    super.onInit();
  }
}