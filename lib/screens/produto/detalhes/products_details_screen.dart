// ignore_for_file: library_private_types_in_public_api

import 'package:ecommerceassim/components/appBar/custom_app_bar.dart';
import 'package:ecommerceassim/shared/components/BottomNavigation.dart';
import 'package:flutter/material.dart';

import '../../../shared/constants/style_constants.dart';

class ProdutoDetalheScreen extends StatefulWidget {
  const ProdutoDetalheScreen({super.key});

  @override
  _ProdutoDetalheScreenState createState() => _ProdutoDetalheScreenState();
}

class _ProdutoDetalheScreenState extends State<ProdutoDetalheScreen> {
  int quantity = 1;

  void incrementQuantity(int maxQuantity) {
    if (quantity < maxQuantity) {
      setState(() {
        quantity++;
      });
    }
  }

  void decrementQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
/*     final int produtoID = arguments?['id'];
 */
    final int produtoEstoque = arguments?['estoque'];
    final String produtoTitulo = arguments?['titulo'];
    final String produtoDescricao = arguments?['descricao'];
    final String produtoTipo = arguments?['tipoUnidade'];
    final String produtoPreco = arguments?['preco'];

    int selectedIndex = 1;

    return Scaffold(
      appBar: const CustomAppBar(),
      bottomNavigationBar: BottomNavigation(selectedIndex: selectedIndex),
      body: Material(
        color: Colors.white,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Image.asset(
                        'lib/assets/images/maça.png', // foto fixa
                        height: 120,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(height: 15),
                      Text(
                        produtoTitulo,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      Text(
                        'R\$ ${double.parse(produtoPreco).toStringAsFixed(2).replaceAll('.', ',')}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        produtoTipo,
                        style: const TextStyle(
                          fontSize: 16,
                          color: kDetailColor,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Descrição',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        produtoDescricao,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Quantidade',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          _buildQuantityButton(
                              Icons.remove, () => decrementQuantity()),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 25.0),
                            child: Text(
                              '$quantity',
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                          _buildQuantityButton(Icons.add,
                              () => incrementQuantity(produtoEstoque)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: kDetailColor,
                  side: const BorderSide(color: kDetailColor, width: 2.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  minimumSize: const Size(double.infinity, 50),
                ),
                onPressed: () {
                  // função de adicionar ao carrinho
                },
                child: const Text(
                  'Adicionar ao carrinho',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuantityButton(IconData icon, VoidCallback onPressed) {
    return SizedBox(
      width: 40,
      height: 40,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          shape: BoxShape.circle,
        ),
        child: IconButton(
          onPressed: onPressed,
          icon: Icon(icon),
          color: Colors.black,
          iconSize: 15,
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
      ),
    );
  }
}
