import 'package:ecommerceassim/components/spacer/verticalSpacer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommerceassim/components/buttons/custom_search_field.dart';
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(7.0, 16.0, 16.0, 8.0),
            child: Text(
              'Feiras em Garanhuns',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 0.0),
            child: CustomSearchField(
              fillColor: kOnBackgroundColorText,
              iconColor: kDetailColor,
              hintText: 'Buscar por feiras',
              padding: EdgeInsets.all(5),
            ),
          ),
          const VerticalSpacer(size: 20),
          Expanded(
            child: Consumer<FeiraController>(
              builder: (context, feiraController, child) {
                List<FeiraModel> feiras = feiraController.feiras;

                if (feiras.isEmpty) {
                  return const Center(
                    child: CircularProgressIndicator(color: kDetailColor),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 6.0), // Match the horizontal padding
                  itemCount: feiras.length,
                  itemBuilder: (context, index) {
                    FeiraModel feira = feiras[index];

                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 4.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 1,
                            blurRadius: 4,
                            offset: const Offset(0, 2),
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
                              Screens.bancas,
                              arguments: {
                                'id': feira.id,
                                'nome': feira.nome,
                                'bairro': feira.bairroId,
                                'horarios': feira.horariosFuncionamento,
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
          ),
        ],
      ),
    );
  }
}
