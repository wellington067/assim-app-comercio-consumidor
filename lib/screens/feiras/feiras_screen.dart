// ignore_for_file: library_private_types_in_public_api

import 'package:ecommerceassim/components/buttons/debouncer.dart';
import 'package:ecommerceassim/shared/components/bottomNavigation/BottomNavigation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommerceassim/screens/screens_index.dart';
import 'package:ecommerceassim/shared/constants/style_constants.dart';
import 'package:ecommerceassim/shared/core/controllers/feira_controller.dart';
import 'package:ecommerceassim/shared/core/models/feira_model.dart';
import 'package:ecommerceassim/components/buttons/custom_search_field.dart';
import 'package:ecommerceassim/components/appBar/custom_app_bar.dart';

class FeirasScreen extends StatefulWidget {
  const FeirasScreen({super.key});

  @override
  _FeirasScreenState createState() => _FeirasScreenState();
}

class _FeirasScreenState extends State<FeirasScreen> {
  bool isLoading = true;
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final int cidadeId = arguments['id'] as int;
    final String cidadeNome = arguments['nome'] as String;
    final Debouncer debouncer = Debouncer(milliseconds: 0);

    return Scaffold(
      appBar: const CustomAppBar(),
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigation(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(25.0, 16.0, 16.0, 10.0),
            child: Text(
              'Feiras em $cidadeNome',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          CustomSearchField(
            fillColor: kOnBackgroundColorText,
            iconColor: kDetailColor,
            hintText: 'Buscar por feiras',
            padding: const EdgeInsets.fromLTRB(21.0, 21.0, 21.0, 5.0),
            onSearch: (text) {
              final feiraController =
                  Provider.of<FeiraController>(context, listen: false);
              debouncer.call(() {
                setState(() {
                  searchQuery = text;
                });
                if (text.isEmpty) {
                  feiraController.loadFeiras();
                } else {
                  feiraController.searchFeiras(text);
                }
              });
            },
            setLoading: (loading) {},
          ),
          Expanded(
            child: FutureBuilder(
              future: Provider.of<FeiraController>(context, listen: false)
                  .loadFeirasByCidadeId(cidadeId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: kDetailColor,
                      backgroundColor: Colors.white,
                    ),
                  );
                } else if (snapshot.hasError) {
                  return _buildErrorWidget();
                } else {
                  List<FeiraModel> feiras =
                      Provider.of<FeiraController>(context).feiras;

                  if (feiras.isEmpty) {
                    return _buildEmptyListWidget(cidadeNome);
                  }

                  final filteredFeiras = feiras
                      .where((feira) => feira.nome
                          .toLowerCase()
                          .contains(searchQuery.toLowerCase()))
                      .toList();

                  if (filteredFeiras.isEmpty) {
                    return _buildErrorWidget();
                  }

                  return ListView.builder(
                    itemCount: filteredFeiras.length,
                    itemBuilder: (context, index) {
                      FeiraModel feira = filteredFeiras[index];

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
                              Navigator.pushNamed(context, Screens.bancas,
                                  arguments: {
                                    'id': feira.id,
                                    'nome': feira.nome,
                                    'bairro': feira.bairroId,
                                    'horarios': feira.horariosFuncionamento,
                                    'cidadeNome': cidadeNome,
                                  });
                            },
                            borderRadius: BorderRadius.circular(15.0),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  16.0, 16.0, 16.0, 16.0),
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
                                      feira.nome,
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
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyListWidget(String cidadeNome) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(
            bottom: 120.0, left: 21.0, right: 21.0), // Ajuste os valores aqui
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.storefront, color: kDetailColor, size: 80),
            const SizedBox(height: 20),
            Text(
              'Nenhuma feira encontrada em $cidadeNome.',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: kDetailColor,
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8),
              child: Text(
                'Não há feiras cadastradas para esta cidade ou elas estão indisponíveis no momento.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorWidget() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 50.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, color: kDetailColor, size: 80),
            const SizedBox(height: 20),
            const Text(
              'Nenhuma feira foi encontrada.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: kDetailColor,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Por favor, verifique se o nome está correto ou tente novamente mais tarde.',
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
}
