import 'package:dio/dio.dart';
import 'package:ecommerceassim/components/buttons/custom_search_field.dart';
import 'package:ecommerceassim/components/spacer/verticalSpacer.dart';
import 'package:ecommerceassim/components/utils/horizontal_spacer_box.dart';
import 'package:flutter/material.dart';
import 'package:ecommerceassim/shared/core/models/produto_model.dart';
import 'package:ecommerceassim/shared/core/repositories/produto_repository.dart';
import 'package:ecommerceassim/shared/constants/style_constants.dart';
import 'package:ecommerceassim/components/utils/vertical_spacer_box.dart';
import 'package:ecommerceassim/components/buttons/category_menu.dart';
import 'package:ecommerceassim/components/navBar/custom_app_bar.dart';
import 'package:ecommerceassim/shared/components/BottomNavigation.dart';
import 'package:ecommerceassim/shared/constants/app_enums.dart';

class MenuProductsScreen extends StatelessWidget {
  const MenuProductsScreen({super.key});

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
              const CustomSearchField(
                fillColor: kOnBackgroundColorText,
                iconColor: kDetailColor,
                hintText: 'Buscar',
                padding: EdgeInsets.all(0),
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
                  } else if (snapshot.hasError ||
                      (snapshot.hasData && snapshot.data!.isEmpty)) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 50.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const VerticalSpacer(
                              size: 100,
                            ),
                            const Center(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.error_outline,
                                    color: kButtom,
                                    size: 35,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    'Oops!',
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: kButtom,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Text(
                              'Nenhum Produto foi encontrado.',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: kButtom,
                              ),
                            ),
                            const SizedBox(height: 10),
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
                        childAspectRatio: 0.6,
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
    return Material(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 10,
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
            Text(
              produto.titulo,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF858080),
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
                  onPressed: () {},
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
