import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommerceassim/components/buttons/category_menu.dart';
import 'package:ecommerceassim/components/buttons/custom_search_field.dart';
import 'package:ecommerceassim/components/appBar/custom_app_bar.dart';
import 'package:ecommerceassim/components/spacer/verticalSpacer.dart';
import 'package:ecommerceassim/screens/screens_index.dart';
import 'package:ecommerceassim/shared/components/BottomNavigation.dart';
import 'package:ecommerceassim/shared/constants/style_constants.dart';
import 'package:ecommerceassim/shared/core/controllers/banca_controller.dart';
import 'package:ecommerceassim/shared/core/models/banca_model.dart';

class Bancas extends StatelessWidget {
  const Bancas({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final int feiraId = arguments['id'];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(),
      bottomNavigationBar: BottomNavigation(selectedIndex: 0),
      body: FutureBuilder(
        future: Provider.of<BancaController>(context, listen: false)
            .loadBancas(feiraId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(kDetailColor),
              ),
            );
          }

          if (snapshot.hasError) {
            return _buildErrorWidget('Ocorreu um erro ao carregar as bancas.');
          }

          final bancaController = Provider.of<BancaController>(context);
          if (bancaController.bancas.isEmpty) {
            return _buildEmptyListWidget();
          }

          return Column(
            children: [
              const SizedBox(height: 15),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 22.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Bancas',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const CustomSearchField(
                fillColor: kOnBackgroundColorText,
                iconColor: kDetailColor,
                hintText: 'Buscar por bancas',
                padding: EdgeInsets.fromLTRB(21.0, 21.0, 21.0, 10.0),
              ),
              const VerticalSpacer(size: 5),
              Expanded(
                child: ListView.builder(
                  itemCount: bancaController.bancas.length,
                  itemBuilder: (context, index) {
                    BancaModel banca = bancaController.bancas[index];
                    return Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 22.0, vertical: 8.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(15.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              Screens.menuProducts,
                              arguments: {
                                'id': banca.id,
                                'nome': banca.nome,
                              },
                            );
                          },
                          borderRadius: BorderRadius.circular(15.0),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              children: [
                                const CircleAvatar(
                                  radius: 25.0,
                                  backgroundImage: AssetImage(
                                      "lib/assets/images/banca-fruta.jpg"),
                                ),
                                const SizedBox(width: 16.0),
                                Expanded(
                                  child: Text(
                                    banca.nome,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildEmptyListWidget() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(Icons.storefront, color: kButtom, size: 80),
            const SizedBox(height: 20),
            const Text(
              'Nenhuma banca foi encontrada.',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: kButtom,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Não há bancas cadastradas para esta feira ou elas estão indisponíveis no momento.',
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
  }

  Widget _buildErrorWidget(String message) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const VerticalSpacer(size: 220),
          const Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.error_outline, color: kButtom, size: 35),
                SizedBox(width: 8),
                Text('Oops!',
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: kButtom)),
              ],
            ),
          ),
          const Text('Nenhuma banca foi encontrada.',
              style: TextStyle(
                  fontSize: 22, fontWeight: FontWeight.bold, color: kButtom)),
          const SizedBox(height: 10),
          Text(message,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey[600])),
        ],
      ),
    );
  }
}
