import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommerceassim/screens/screens_index.dart';
import 'package:ecommerceassim/shared/constants/style_constants.dart';
import 'package:ecommerceassim/shared/core/controllers/feira_controller.dart';
import 'package:ecommerceassim/shared/core/models/feira_model.dart';

class FeirasScreen extends StatelessWidget {
  const FeirasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final feiraController = Provider.of<FeiraController>(context);

    if (feiraController.feiras.isEmpty) {
      feiraController.loadFeiras();
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<FeiraController>(
        builder: (context, feiraController, child) {
          List<FeiraModel> feiras = feiraController.feiras;

          if (feiras.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(color: kDetailColor),
            );
          }

          return ListView.builder(
            itemCount: feiras.length,
            itemBuilder: (context, index) {
              FeiraModel feira = feiras[index];

              return Container(
                margin: const EdgeInsets.all(8.0),
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
                      Navigator.pushNamed(context, Screens.bancas);
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
        },
      ),
    );
  }
}
