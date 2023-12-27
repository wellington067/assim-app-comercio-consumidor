import 'package:dio/dio.dart';
import 'package:ecommerceassim/screens/home/components/verticalSpacer.dart';
import 'package:flutter/material.dart';
import 'package:ecommerceassim/shared/core/models/produto_model.dart';
import 'package:ecommerceassim/shared/core/repositories/produto_repository.dart';
import 'package:ecommerceassim/shared/constants/style_constants.dart';
import 'package:ecommerceassim/components/utils/vertical_spacer_box.dart';
import 'package:ecommerceassim/screens/home/components/category_menu.dart';
import 'package:ecommerceassim/screens/home/components/custom_app_bar.dart';
import 'package:ecommerceassim/shared/components/BottomNavigation.dart';
import 'package:ecommerceassim/shared/constants/app_enums.dart';

class MenuProductsScreen extends StatelessWidget {
  const MenuProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProdutoRepository produtoRepository = ProdutoRepository(Dio());
    final Map<String, dynamic> arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final int bancaId = arguments['id'];
    final String bancaNome = arguments['nome'];
    int selectedIndex = 1;

    return Scaffold(
      appBar: const CustomAppBar(),
      bottomNavigationBar: BottomNavigation(selectedIndex: selectedIndex),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  bancaNome,
                  style: const TextStyle(
                      fontSize: 25,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const VerticalSpacerBox(size: SpacerSize.medium),
              const Padding(
                padding: EdgeInsets.all(5.0),
                child: TextField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    hintText: 'Buscar',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                    isDense: true,
                    prefixIcon: Icon(Icons.search, color: kButtom, size: 25),
                  ),
                ),
              ),
              const VerticalSpacerBox(size: SpacerSize.medium),
              const CategoryMenuList(),
              const VerticalSpacerBox(size: SpacerSize.medium),
              FutureBuilder<List<ProdutoModel>>(
                future: produtoRepository.getProdutos(bancaId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(kDetailColor),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 50.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const VerticalSpacer(size: 140),
                          const Icon(
                            Icons.error_outline,
                            color: kButtom,
                            size: 40,
                          ),
                          const VerticalSpacerBox(size: SpacerSize.medium),
                          const Text(
                            'Oops! Nenhum Produto foi encontrado.',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: kButtom,
                            ),
                          ),
                          const VerticalSpacerBox(size: SpacerSize.small),
                          Text(
                            'Parece que não tem produtos nesta banca. Tente outra banca ou volte mais tarde.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    );
                  } else if (snapshot.hasData && snapshot.data!.isEmpty) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 50.0),
                      child: Text(
                        'Nenhum produto encontrado. Tente selecionar outra categoria.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey[800],
                        ),
                      ),
                    );
                  } else if (snapshot.hasData) {
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 0.8,
                      ),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return _buildProductCard(snapshot.data![index]);
                      },
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
              const VerticalSpacerBox(size: SpacerSize.small),
            ],
          ),
        ),
      ),
    );
  }

  String capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }

  Widget _buildProductCard(ProdutoModel produto) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Center(
                child: Image.asset(
                  'lib/assets/images/maça.png', // foto fixa para correção
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                produto.descricao,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF858080),
                ),
              ),
            ),
            Text(
              'R\$ ${double.parse(produto.preco).toStringAsFixed(2).replaceAll('.', ',')}',
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  capitalize(produto.tipoUnidade),
                  style: const TextStyle(fontSize: 18, color: kDetailColor),
                ),
                IconButton(
                  onPressed: () {
                    // Add your onTap functionality here.
                  },
                  icon: const Icon(
                    Icons.add_circle_outline,
                    color: kDetailColor,
                    size: 40,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
