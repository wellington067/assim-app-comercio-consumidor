import 'package:ecommerceassim/components/utils/horizontal_spacer_box.dart';
import 'package:ecommerceassim/screens/screens_index.dart';
import 'package:ecommerceassim/shared/constants/app_enums.dart';
import 'package:ecommerceassim/shared/constants/style_constants.dart';
import 'package:ecommerceassim/shared/core/controllers/banca_controller.dart';
import 'package:ecommerceassim/shared/core/models/banca_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Bancas extends StatefulWidget {
  const Bancas({super.key});

  @override
  State<Bancas> createState() => _BancasState();
}

class _BancasState extends State<Bancas> {
  @override
  void initState() {
    super.initState();
    final bancaController =
        Provider.of<BancaController>(context, listen: false);
    bancaController.loadBancas();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(child:
        Consumer<BancaController>(builder: (context, bancaController, child) {
      List<BancaModel> bancas = bancaController.bancas;
      return ListView.builder(
          itemCount: bancas.length,
          itemBuilder: (context, index) {
            BancaModel banca = bancas[index];
            return InkWell(
              child: Container(
                width: 440,
                height: 125,
                decoration: BoxDecoration(
                  color: kOnSurfaceColor,
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  boxShadow: [
                    BoxShadow(
                      color: kTextButtonColor.withOpacity(0.5),
                      spreadRadius: 0,
                      blurRadius: 3,
                      offset: const Offset(0, 0), // changes position of shadow
                    ),
                  ],
                ),
                child: Center(
                  child: Wrap(
                    children: [
                      Row(
                        children: [
                          const HorizontalSpacerBox(size: SpacerSize.large),
                          Container(
                            transformAlignment: Alignment.center,
                            alignment: Alignment.center,
                            width: 65.0,
                            height: 65.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage('assets/images/banaca.png'),
                              ),
                            ),
                          ),
                          const HorizontalSpacerBox(size: SpacerSize.large),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    banca.nome,
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const HorizontalSpacerBox(
                                      size: SpacerSize.huge),
                                  const HorizontalSpacerBox(
                                      size: SpacerSize.huge),
                                  const HorizontalSpacerBox(
                                      size: SpacerSize.huge),
                                  const HorizontalSpacerBox(
                                      size: SpacerSize.huge),
                                  const HorizontalSpacerBox(
                                      size: SpacerSize.huge),
                                  const IconButton(
                                      onPressed: null,
                                      icon: Icon(
                                        Icons.favorite,
                                        color: kButtom,
                                      )),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, Screens.menuSeller);
              },
            );
          });
    }));
  }
}
