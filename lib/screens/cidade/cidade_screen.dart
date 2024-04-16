import 'package:ecommerceassim/components/buttons/custom_search_field.dart';
import 'package:ecommerceassim/shared/core/controllers/cidade_controllers.dart';
import 'package:ecommerceassim/shared/core/models/cidade_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommerceassim/screens/screens_index.dart';
import 'package:ecommerceassim/shared/constants/style_constants.dart';

class CidadeScreen extends StatelessWidget {
  const CidadeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cidadeController = Provider.of<CidadeController>(context);

    if (cidadeController.cidades.isEmpty) {
      cidadeController.loadCidades();
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Cidades',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const CustomSearchField(
            fillColor: kOnBackgroundColorText,
            iconColor: kDetailColor,
            hintText: 'Buscar por Cidades',
            padding: EdgeInsets.all(5),
          ),
          Expanded(
            child: Consumer<CidadeController>(
              builder: (context, cidadeController, child) {
                List<CidadeModel> cidades = cidadeController.cidades;

                if (cidades.isEmpty) {
                  return const Center(
                    child: CircularProgressIndicator(color: kDetailColor),
                  );
                }

                return ListView.builder(
                  itemCount: cidades.length,
                  itemBuilder: (context, index) {
                    CidadeModel cidade = cidades[index];

                    return Container(
                      margin: const EdgeInsets.all(7.0),
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
                            Navigator.pushNamed(context, Screens.feiras,
                                arguments: {
                                  'id': cidade.id,
                                  'nome': cidade.nome,
                                });
                          },
                          borderRadius: BorderRadius.circular(15.0),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              children: [
                                const CircleAvatar(
                                  radius: 25.0,
                                  backgroundImage: AssetImage(
                                    "lib/assets/images/banca-fruta.jpg",
                                  ),
                                ),
                                const SizedBox(width: 16.0),
                                Expanded(
                                  child: Text(
                                    cidade.nome!,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: kTextColorBlack,
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
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
