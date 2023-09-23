import 'package:ecommerceassim/components/utils/horizontal_spacer_box.dart';
import 'package:ecommerceassim/screens/screens_index.dart';
import 'package:ecommerceassim/shared/constants/app_enums.dart';
import 'package:ecommerceassim/shared/constants/style_constants.dart';
import 'package:ecommerceassim/shared/core/controllers/bairro_controller.dart';
import 'package:ecommerceassim/shared/core/controllers/feira_controller.dart';
import 'package:ecommerceassim/shared/core/models/feira_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Feiras extends StatefulWidget {
  const Feiras({super.key});

  @override
  State<Feiras> createState() => _FeirasState();
}

class _FeirasState extends State<Feiras> {
  @override
  void initState() {
    super.initState();
    final BairroController bairroController = BairroController();
    final feiraController =
        Provider.of<FeiraController>(context, listen: false);

    bairroController.loadBairros();
    feiraController.loadFeiras();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(child:
        Consumer<FeiraController>(builder: (context, feiraController, child) {
      List<FeiraModel> feiras = feiraController.feiras;

      return FutureBuilder<void>(
          future: Future.wait([
            Provider.of<BairroController>(context).loadBairros(),
            feiraController.loadFeiras(),
          ]),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child: CircularProgressIndicator(
                color: kOnSurfaceColor,
              ));
            }
            return ListView.builder(
                itemCount: feiras.length,
                itemBuilder: (context, index) {
                  FeiraModel feira = feiras[index];
                  String nomeBairro =
                      feiraController.getBairroNome(feira.bairroId);

                  return InkWell(
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
                            offset: const Offset(
                                0, 0), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Center(
                        child: Wrap(
                          children: [
                            Row(
                              children: [
                                const HorizontalSpacerBox(
                                    size: SpacerSize.large),
                                Container(
                                  transformAlignment: Alignment.center,
                                  alignment: Alignment.center,
                                  width: 65.0,
                                  height: 65.0,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: NetworkImage(
                                          "https://gentv.com.br/img/content/266-1"),
                                    ),
                                  ),
                                ),
                                const HorizontalSpacerBox(
                                    size: SpacerSize.large),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          nomeBairro,
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
          });
    }));
  }
}
