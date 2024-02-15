import 'package:ecommerceassim/screens/screens_index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommerceassim/shared/constants/style_constants.dart';
import 'package:ecommerceassim/shared/core/controllers/bairro_controller.dart';
import 'package:ecommerceassim/shared/core/models/bairro_model.dart';

class FeirasScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bairroController = Provider.of<BairroController>(context);

    if (bairroController.bairros.isEmpty) {
      bairroController.loadBairros();
    }

    return Scaffold(
      body: Consumer<BairroController>(
        builder: (context, bairroController, child) {
          List<BairroModel> bairros = bairroController.bairros;

          if (bairros.isEmpty) {
            return Center(
              child: CircularProgressIndicator(color: kDetailColor),
            );
          }

          return ListView.builder(
            itemCount: bairros.length,
            itemBuilder: (context, index) {
              BairroModel bairro = bairros[index];

              return Material(
                // Wrap the InkWell in a Material widget
                color: Colors
                    .transparent, // Optional: Set the color to transparent or any other color
                child: InkWell(
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
                            "https://gentv.com.br/img/content/266-1",
                          ),
                        ),
                        SizedBox(width: 16.0),
                        Text(
                          bairro.nome ?? 'Bairro Desconhecido',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: kDarkTextColor,
                          ),
                        ),
                        Spacer(),
                        IconButton(
                          onPressed: () {
                            // Ação ao pressionar o botão de favorito
                          },
                          icon: Icon(
                            Icons.favorite,
                            color: kButtom,
                          ),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, Screens.bancas);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
