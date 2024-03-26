import 'package:ecommerceassim/components/navBar/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommerceassim/screens/screens_index.dart';
import 'package:ecommerceassim/shared/components/BottomNavigation.dart';
import 'package:ecommerceassim/shared/constants/style_constants.dart';
import 'package:ecommerceassim/shared/core/controllers/banca_controller.dart';
import 'package:ecommerceassim/shared/core/models/banca_model.dart';

class Bancas extends StatefulWidget {
  const Bancas({Key? key}) : super(key: key);

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
          const SizedBox(height: 230),
          const Icon(
            Icons.error_outline,
            color: kDetailColor,
            size: 40,
          ),
          const SizedBox(height: 12),
          const Text(
            'Oops! Algo deu errado.',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: kDetailColor,
            ),
          ),
          const SizedBox(height: 8),
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
    return Consumer<BancaController>(
      builder: (context, bancaController, child) => Scaffold(
        backgroundColor: Colors.white,
        appBar: const CustomAppBar(),
        endDrawer: buildCustomDrawer(context),
        bottomNavigationBar: BottomNavigation(selectedIndex: 0),
        body: _isLoading
            ? const Center(
                child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(kDetailColor)))
            : bancaController.bancas.isEmpty
                ? _buildErrorWidget(_error ?? 'Nenhuma banca encontrada.')
                : Column(
                    children: [
                      const SizedBox(height: 15),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
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
                      const SizedBox(height: 20),
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: bancaController.bancas.length,
                          itemBuilder: (context, index) {
                            BancaModel banca = bancaController.bancas[index];
                            bool isFavorite = favorites[banca.id] ?? false;
                            return Card(
                              margin: const EdgeInsets.all(8.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(15.0),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
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
                                      const SizedBox(width: 16.0),
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
                            );
                          },
                        ),
                      ),
                    ],
                  ),
      ),
    );
  }
}
