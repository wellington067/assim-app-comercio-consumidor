import 'package:dio/dio.dart';
import 'package:ecommerceassim/components/buttons/custom_search_field.dart';
import 'package:ecommerceassim/components/spacer/verticalSpacer.dart';
import 'package:ecommerceassim/shared/core/controllers/products_controller.dart';
import 'package:ecommerceassim/screens/produto/components/build_product_card.dart';
import 'package:flutter/material.dart';
import 'package:ecommerceassim/shared/core/models/produto_model.dart';
import 'package:ecommerceassim/shared/core/repositories/produto_repository.dart';
import 'package:ecommerceassim/shared/constants/style_constants.dart';
import 'package:ecommerceassim/components/utils/vertical_spacer_box.dart';
import 'package:ecommerceassim/components/buttons/category_menu.dart';
import 'package:ecommerceassim/components/appBar/custom_app_bar.dart';
import 'package:ecommerceassim/shared/components/BottomNavigation.dart';
import 'package:ecommerceassim/shared/constants/app_enums.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../cesta/cart_provider.dart';

class MenuProductsScreen extends StatefulWidget {
  const MenuProductsScreen({super.key});

  @override
  State<MenuProductsScreen> createState() => _MenuProductsScreenState();
}

class _MenuProductsScreenState extends State<MenuProductsScreen> {
  @override
  Widget build(BuildContext context) {
    final cartListProvider = Provider.of<CartProvider>(context);
    final ProdutoRepository produtoRepository = ProdutoRepository(Dio());
    final Map<String, dynamic> arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final int bancaId = arguments['id'];
    final String bancaNome = arguments['nome'];
    final String horarioAbertura = arguments['horario_abertura'];
    final String horarioFechamento = arguments['horario_fechamento'];

    // Função para formatar as horas
/*     String formatarHorario(String horario) {
      String hora = horario.split(':')[0];
      return '${hora}H';
    }

    String horarioAberturaFormatado = formatarHorario(horarioAbertura);
    String horarioFechamentoFormatado = formatarHorario(horarioFechamento); */

    int selectedIndex = 1;

    return GetBuilder<ProductsController>(
      init: ProductsController(),
      builder: (controller) => Scaffold(
        appBar: const CustomAppBar(),
        bottomNavigationBar: BottomNavigation(selectedIndex: selectedIndex),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          bancaNome,
                          style: const TextStyle(
                            fontSize: 25,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Aberto das $horarioAbertura até $horarioFechamento',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const CustomSearchField(
                  fillColor: kOnBackgroundColorText,
                  iconColor: kDetailColor,
                  hintText: 'Buscar por produtos',
                  padding: EdgeInsets.fromLTRB(22.0, 22.0, 22.0, 12.0),
                ),
                const CategoryMenuList(),
                const VerticalSpacerBox(size: SpacerSize.medium),
                FutureBuilder<List<ProdutoModel>>(
                  future: produtoRepository.getProdutos(bancaId),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: Column(
                          children: [
                            VerticalSpacer(size: 180),
                            CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(kDetailColor),
                            ),
                          ],
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
                                      color: kDetailColor,
                                      size: 35,
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      'Oops!',
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        color: kDetailColor,
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
                                  color: kDetailColor,
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
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 0.6,
                        ),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return BuildProductCard(snapshot.data![index],
                              controller, cartListProvider);
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
      ),
    );
  }
}
