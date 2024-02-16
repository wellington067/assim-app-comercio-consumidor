import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommerceassim/screens/screens_index.dart';
import 'package:ecommerceassim/shared/constants/style_constants.dart';
import 'package:ecommerceassim/shared/core/controllers/feira_controller.dart'; // Certifique-se de ter um controller para as feiras
import 'package:ecommerceassim/shared/core/models/feira_model.dart'; // Modelo de feira

class FeirasScreen extends StatelessWidget {
  const FeirasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final feiraController = Provider.of<FeiraController>(context);

    // Chamada para carregar as feiras, se necessário
    if (feiraController.feiras.isEmpty) {
      feiraController.loadFeiras();
    }

    return Scaffold(
      body: Consumer<FeiraController>(
        builder: (context, feiraController, child) {
          List<FeiraModel> feiras = feiraController.feiras;

          if (feiras.isEmpty) {
            return Center(
              child: CircularProgressIndicator(color: kDetailColor),
            );
          }

          return ListView.builder(
            itemCount: feiras.length,
            itemBuilder: (context, index) {
              FeiraModel feira = feiras[index];

              return Material(
                color: Colors.transparent, // Configuração opcional de cor
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, Screens.bancas);
                  },
                  child: Container(
                    padding: EdgeInsets.all(16.0),
                    margin:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    decoration: BoxDecoration(
                      color: kTextButtonColor,
                      borderRadius: BorderRadius.circular(15.0),
                      boxShadow: [
                        BoxShadow(
                          color: kTextButtonColor.withOpacity(0.5),
                          spreadRadius: 0,
                          blurRadius: 3,
                          offset: Offset(0, 0),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 30.0,
                          backgroundImage: NetworkImage(
                            // Substitua por uma imagem relevante da feira, se disponível
                            "https://example.com/feira_image.png",
                          ),
                        ),
                        SizedBox(width: 16.0),
                        Expanded(
                          // Para evitar overflow de texto
                          child: Text(
                            feira
                                .nome, // Presumindo que FeiraModel tem um campo nome
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: kDarkTextColor,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.favorite,
                            color: kButtom,
                          ),
                        ),
                      ],
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
