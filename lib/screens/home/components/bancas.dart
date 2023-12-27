import 'package:ecommerceassim/screens/home/components/verticalSpacer.dart';
import 'package:ecommerceassim/shared/constants/app_enums.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommerceassim/shared/core/controllers/banca_controller.dart';
import 'package:ecommerceassim/shared/core/models/banca_model.dart';
import 'package:ecommerceassim/shared/constants/style_constants.dart';
import 'package:ecommerceassim/components/utils/vertical_spacer_box.dart';
import 'package:ecommerceassim/components/utils/horizontal_spacer_box.dart';
import 'package:ecommerceassim/screens/screens_index.dart';

class Bancas extends StatefulWidget {
  const Bancas({Key? key});

  @override
  State<Bancas> createState() => _BancasState();
}

class _BancasState extends State<Bancas> {
  Map<int, bool> favorites = {};
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadBancas();
  }

  void _loadBancas() async {
    try {
      await Provider.of<BancaController>(context, listen: false).loadBancas();
    } catch (e) {
      _error = e.toString();
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Widget _buildErrorWidget(String message) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const VerticalSpacer(size: 230),
          const Icon(
            Icons.error_outline,
            color: kDetailColor,
            size: 40,
          ),
          const VerticalSpacerBox(size: SpacerSize.medium),
          const Text(
            'Oops! Algo deu errado.',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: kDetailColor,
            ),
          ),
          const VerticalSpacerBox(size: SpacerSize.small),
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Consumer<BancaController>(
        builder: (context, bancaController, child) {
          if (_isLoading) {
            return const Column(
              children: [
                VerticalSpacer(size: 300),
                Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(kDetailColor),
                  ),
                ),
              ],
            );
          } else if (bancaController.bancas.isEmpty) {
            return Column(
              children: [
                if (_error == null) // Adicione esta condição
                  _buildErrorWidget('Nenhuma banca encontrada.'),
              ],
            );
          } else if (_error != null) {
            return Column(
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Bancas',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                _buildErrorWidget('Erro ao carregar bancas: $_error'),
              ],
            );
          } else {
            return Column(
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Bancas',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const VerticalSpacer(size: 20),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: bancaController.bancas.length,
                  itemBuilder: (context, index) {
                    BancaModel banca = bancaController.bancas[index];
                    bool isFavorite = favorites[banca.id] ?? false;
                    return Column(
                      children: [
                        InkWell(
                          child: Container(
                            width: 440,
                            height: 125,
                            decoration: BoxDecoration(
                              color: kOnSurfaceColor,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(15)),
                              boxShadow: [
                                BoxShadow(
                                  color: kTextButtonColor.withOpacity(0.5),
                                  spreadRadius: 0,
                                  blurRadius: 3,
                                  offset: const Offset(0, 0),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 20.0),
                              child: Row(
                                children: [
                                  Container(
                                    width: 70.0,
                                    height: 70.0,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: AssetImage(
                                            'lib/assets/images/banca-fruta.jpg'),
                                      ),
                                    ),
                                  ),
                                  const HorizontalSpacerBox(
                                      size: SpacerSize.large),
                                  Expanded(
                                    child: Text(
                                      banca.nome,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        favorites[banca.id] = !isFavorite;
                                      });
                                    },
                                    icon: Icon(
                                      isFavorite
                                          ? Icons.favorite
                                          : Icons.favorite_outline,
                                      color: kButtom,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
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
                        ),
                        const VerticalSpacerBox(size: SpacerSize.large),
                      ],
                    );
                  },
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
