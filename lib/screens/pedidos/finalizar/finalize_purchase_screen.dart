import 'package:ecommerceassim/assets/index.dart';
import 'package:ecommerceassim/components/appBar/custom_app_bar.dart';
import 'package:ecommerceassim/shared/core/controllers/purchase_controller.dart';
import 'package:ecommerceassim/shared/core/models/cart_model.dart';
import 'package:flutter/material.dart';
import 'package:ecommerceassim/components/utils/horizontal_spacer_box.dart';
import 'package:ecommerceassim/components/utils/vertical_spacer_box.dart';
import 'package:ecommerceassim/screens/screens_index.dart';
import 'package:ecommerceassim/shared/constants/app_enums.dart';
import 'package:ecommerceassim/shared/constants/style_constants.dart';
import 'package:get/get.dart';
import 'package:rating_dialog/rating_dialog.dart';
import '../../../components/buttons/primary_button.dart';

// ignore: must_be_immutable
class FinalizePurchaseScreen extends StatefulWidget {
  List<CartModel> cartModel;
  FinalizePurchaseScreen(this.cartModel, {super.key});

  @override
  State<FinalizePurchaseScreen> createState() => _FinalizePurchaseScreenState();
}

class _FinalizePurchaseScreenState extends State<FinalizePurchaseScreen> {
  @override
  Widget build(BuildContext context) {
    print(widget.cartModel[0].storeId!);
    Size size = MediaQuery.of(context).size;
    return GetBuilder<PurchaseController>(
        init: PurchaseController(listCartModel: widget.cartModel),
        builder: (controller) {
          controller.listCartModel = widget.cartModel;
          return Scaffold(
              appBar: const CustomAppBar(),
              body: Container(
                  color: kOnSurfaceColor,
                  width: size.width,
                  padding: const EdgeInsets.all(20),
                  child: SingleChildScrollView(
                      child: Column(children: [
                    const VerticalSpacerBox(size: SpacerSize.medium),
                    InkWell(
                      child: Row(
                        children: [
                          Container(
                            width: 350,
                            height: 310,
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
                            child: Wrap(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(0.5),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 35.0,
                                        height: 55.0,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      const Text(
                                        'Enviado para:',
                                        style: TextStyle(fontSize: 17),
                                      ),
                                      const HorizontalSpacerBox(
                                          size: SpacerSize.medium),
                                      Text(
                                        controller.userName,
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const Spacer(),
                                      IconButton(
                                          onPressed: () {},
                                          icon: const Icon(
                                            Icons.arrow_forward_ios_outlined,
                                            color: kTextButtonColor,
                                          )),
                                    ],
                                  ),
                                ),
                                const Divider(
                                  color: kTextButtonColor,
                                  height: 20,
                                  thickness: 1,
                                  indent: 5,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 6),
                                  child: Row(
                                    children: [
                                      const HorizontalSpacerBox(
                                          size: SpacerSize.large),
                                      const Text(
                                        'Vendido por:',
                                        style: TextStyle(fontSize: 17),
                                      ),
                                      Spacer(),
                                      controller.bancaModel == null
                                          ? const Text('Carregando...')
                                          : Text(
                                              controller.bancaModel!.nome,
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: kButtom),
                                            ),
                                    ],
                                  ),
                                ),
                                const VerticalSpacerBox(size: SpacerSize.small),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 6),
                                  child: Row(
                                    children: [
                                      const HorizontalSpacerBox(
                                          size: SpacerSize.large),
                                      const Text(
                                        'Itens:',
                                        style: TextStyle(fontSize: 17),
                                      ),
                                      const Spacer(),
                                      Text(
                                        controller.listCartModel!.length
                                            .toString(),
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 6),
                                  // child: Row(
                                  //   children: [
                                  //     HorizontalSpacerBox(
                                  //         size: SpacerSize.large),
                                  //     Text(
                                  //       'Taxa de entrega:',
                                  //       style: TextStyle(fontSize: 17),
                                  //     ),
                                  //     Spacer(),
                                  //     Text(
                                  //       'R\$ 7.00',
                                  //       style: TextStyle(
                                  //         fontSize: 20,
                                  //         fontWeight: FontWeight.bold,
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 6),
                                  child: Row(
                                    children: [
                                      const HorizontalSpacerBox(
                                          size: SpacerSize.large),
                                      const Text(
                                        'Total do pedido:',
                                        style: TextStyle(
                                            fontSize: 23,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const Spacer(),
                                      Text(
                                        'R\$ ${controller.totalValue}',
                                        style: const TextStyle(
                                            fontSize: 23,
                                            fontWeight: FontWeight.bold,
                                            color: kDetailColor),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      onTap: () async {},
                    ),
                    const VerticalSpacerBox(size: SpacerSize.medium),
                    const Row(children: [
                      Text(
                        'Forma de entrega',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                    ]),
                    const VerticalSpacerBox(size: SpacerSize.small),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Radio(
                                overlayColor:
                                    MaterialStateProperty.all(kDetailColor),
                                value: 'Retirada',
                                groupValue: 'Retirada',
                                activeColor: kDetailColor,
                                focusColor: kDetailColor,
                                hoverColor: kDetailColor,
                                onChanged: (value) {
                                  setState(() {
                                    //  controller.setFormEnt(value.toString());
                                  });
                                }),
                            const Text(
                              'Retirada',
                              style: TextStyle(
                                  fontSize: 20, color: kTextButtonColor),
                            ),
                          ],
                        ),
                        //  const HorizontalSpacerBox(size: SpacerSize.small),
                        //  Row(
                        //    children: [
                        //      Radio(
                        //          overlayColor:
                        //              MaterialStateProperty.all(kDetailColor),
                        //          value: 'Entrega',
                        //          groupValue: 'Entrega',
                        //          activeColor: kDetailColor,
                        //          focusColor: kDetailColor,
                        //          hoverColor: kDetailColor,
                        //          onChanged: (value) {
                        //            setState(() {
                        //              // controller.setFormEnt(value.toString());
                        //            });
                        //          }),
                        //      const Text(
                        //        'Entrega',
                        //        style: TextStyle(
                        //            fontSize: 20, color: kTextButtonColor),
                        //      ),
                        //    ],
                        //  ),
                      ],
                    ),
                    // const VerticalSpacerBox(size: SpacerSize.small),
                    // const Row(children: [
                    //   Text(
                    //     'Endereço de entrega',
                    //     style: TextStyle(
                    //         fontSize: 22, fontWeight: FontWeight.bold),
                    //   ),
                    // ]),
                    // const VerticalSpacerBox(size: SpacerSize.small),
                    // InkWell(
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: [
                    //       Container(
                    //         width: 350,
                    //         height: 95,
                    //         decoration: BoxDecoration(
                    //           color: kOnSurfaceColor,
                    //           borderRadius:
                    //               const BorderRadius.all(Radius.circular(15)),
                    //           boxShadow: [
                    //             BoxShadow(
                    //               color: kTextButtonColor.withOpacity(0.5),
                    //               spreadRadius: 0,
                    //               blurRadius: 3,
                    //               offset: const Offset(0, 0),
                    //             ),
                    //           ],
                    //         ),
                    //         child: Wrap(
                    //           children: [
                    //             Row(
                    //               children: [
                    //                 Container(
                    //                   width: 30.0,
                    //                   decoration: const BoxDecoration(
                    //                     shape: BoxShape.circle,
                    //                   ),
                    //                 ),
                    //                 const Text(
                    //                   'Endereço',
                    //                   style: TextStyle(
                    //                       fontSize: 20,
                    //                       fontWeight: FontWeight.bold),
                    //                   textAlign: TextAlign.start,
                    //                 ),
                    //                 const Spacer(),
                    //                 Column(
                    //                   crossAxisAlignment:
                    //                       CrossAxisAlignment.end,
                    //                   mainAxisAlignment:
                    //                       MainAxisAlignment.center,
                    //                   children: [
                    //                     const VerticalSpacerBox(
                    //                         size: SpacerSize.medium),
                    //                     IconButton(
                    //                         onPressed: () {
                    //                           Navigator.pushNamed(context,
                    //                               Screens.selectAdress);
                    //                         },
                    //                         icon: const Icon(
                    //                           Icons.arrow_forward_ios_outlined,
                    //                           color: kTextButtonColor,
                    //                         )),
                    //                   ],
                    //                 ),
                    //               ],
                    //             ),
                    //             const Center(
                    //               child: Row(
                    //                 children: [
                    //                   HorizontalSpacerBox(
                    //                       size: SpacerSize.huge),
                    //                   Text(
                    //                     'Rua Professora Esmeralda Barros, 71, Apt, ...',
                    //                     style: TextStyle(
                    //                         fontSize: 1,
                    //                         color: kTextButtonColor),
                    //                   ),
                    //                 ],
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    //   onTap: () {
                    //     Navigator.pushNamed(context, Screens.selectAdress);
                    //   },
                    // ),
                    const VerticalSpacerBox(size: SpacerSize.large),
                    PrimaryButton(
                      text: 'Confirmar pedido',
                      onPressed: () async {
                        bool sucess = await controller.purchase();
                        if (sucess) {}
                        showDialog(
                            context: context,
                            builder: (context) => RatingDialog(
                                  starColor: Colors.amber,
                                  title: const Text('Que tal nos avaliar?'),
                                  message: const Text(
                                      'Dê uma nota para o seu pedido'),
                                  image: Image.asset(
                                    Assets.feedback,
                                    height: 250,
                                  ),
                                  submitButtonText: 'Enviar',
                                  onCancelled: () =>
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              backgroundColor: kButtom2,
                                              content: Text('Cancelado'))),
                                  onSubmitted: (response) {
                                    Navigator.pushNamed(context, Screens.home);
                                  },
                                ));
                      },
                      color: kButtom,
                    ),
                    const VerticalSpacerBox(size: SpacerSize.medium),
                    const Divider(
                      color: kTextButtonColor,
                      thickness: 1,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, Screens.cart);
                            },
                            child: const Text(
                              'Voltar a cesta',
                              style: TextStyle(color: kButtom, fontSize: 16),
                            ))
                      ],
                    ),
                  ]))));
        });
  }
}
