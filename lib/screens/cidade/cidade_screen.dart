// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommerceassim/components/buttons/custom_search_field.dart';
import 'package:ecommerceassim/shared/core/controllers/cidade_controllers.dart';
import 'package:ecommerceassim/shared/core/models/cidade_model.dart';
import 'package:ecommerceassim/screens/screens_index.dart';
import 'package:ecommerceassim/shared/constants/style_constants.dart';

import '../../components/buttons/debouncer.dart';

class CidadeScreen extends StatefulWidget {
  const CidadeScreen({super.key});

  @override
  _CidadeScreenState createState() => _CidadeScreenState();
}

class _CidadeScreenState extends State<CidadeScreen> {
  bool isLoading = true;
  final Debouncer debouncer = Debouncer(milliseconds: 0);

  @override
  void initState() {
    super.initState();
    final cidadeController =
        Provider.of<CidadeController>(context, listen: false);
    cidadeController.loadCidades().then((_) {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
/*     final cidadeController = Provider.of<CidadeController>(context);
 */
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 16),
            child: Text('Cidades',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          ),
          CustomSearchField(
            fillColor: kOnBackgroundColorText,
            iconColor: kDetailColor,
            hintText: 'Buscar por cidades',
            padding: const EdgeInsets.all(5),
            onSearch: (text) {
              final cidadeController =
                  Provider.of<CidadeController>(context, listen: false);
              if (text.isEmpty) {
                cidadeController.loadCidades();
              } else {
                debouncer.call(() => cidadeController.searchCidades(text));
              }
            },
            setLoading: (loading) {
              setState(() {
                isLoading = loading;
              });
            },
          ),
          Expanded(
            child: isLoading
                ? const Center(
                    child: CircularProgressIndicator(color: kDetailColor))
                : Consumer<CidadeController>(
                    builder: (context, cidadeController, child) {
                      if (cidadeController.hasError) {
                        return _buildEmptyListWidget();
                      }
                      return ListView.builder(
                        itemCount: cidadeController.cidades.length,
                        itemBuilder: (context, index) =>
                            _buildCidadeItem(cidadeController.cidades[index]),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildCidadeItem(CidadeModel cidade) {
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
            Navigator.pushNamed(context, Screens.feiras, arguments: {
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
  }

  Widget _buildEmptyListWidget() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 00.0, left: 8, right: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.storefront, color: kDetailColor, size: 80),
            const SizedBox(height: 20),
            const Text(
              'Nenhuma cidade foi encontrada.',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: kDetailColor,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Não há cidades cadastradas ou elas estão indisponíveis no momento.',
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
