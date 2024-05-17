// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';

// class PaymentScreen extends StatefulWidget {
//   const PaymentScreen({super.key});

//   @override
//   State<PaymentScreen> createState() => _PaymentScreenState();
// }

// class _PaymentScreenState extends State<PaymentScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return const Row(children: [
//                           Text(
//                             'Informações de pagamento',
//                             style: TextStyle(
//                                 fontSize: 22, fontWeight: FontWeight.bold),
//                           ),
//                         ]
//                         const VerticalSpacerBox(size: SpacerSize.small),
//                         // const Row(children: [
//                         //   Text(
//                         //     'Formas de pagamento:',
//                         //     style: TextStyle(
//                         //         fontSize: 17, fontWeight: FontWeight.bold),
//                         //   ),
//                         // ]),

//                         // Row(
//                         //   crossAxisAlignment: CrossAxisAlignment.start,
//                         //   children: [
//                         //     Row(
//                         //       children: [
//                         //         Radio(
//                         //             overlayColor:
//                         //                 MaterialStateProperty.all(kDetailColor),
//                         //             activeColor: kDetailColor,
//                         //             focusColor: kDetailColor,
//                         //             hoverColor: kDetailColor,
//                         //             value: 'Pix',
//                         //             groupValue: 'Pix',
//                         //             onChanged: (value) {
//                         //               setState(() {
//                         //                 controller.setFormPag(value.toString());
//                         //               });
//                         //             }),
//                         //         const Text(
//                         //           'Pix',
//                         //           style: TextStyle(
//                         //               fontSize: 20, color: kTextButtonColor),
//                         //         ),
//                         //       ],
//                         //     ),
//                         //     const HorizontalSpacerBox(size: SpacerSize.small),
//                         //     Row(
//                         //       children: [
//                         //         Radio(
//                         //             overlayColor:
//                         //                 MaterialStateProperty.all(kDetailColor),
//                         //             activeColor: kDetailColor,
//                         //             focusColor: kDetailColor,
//                         //             hoverColor: kDetailColor,
//                         //             value: 'Espécie',
//                         //             groupValue: 'Espécie',
//                         //             onChanged: (value) {
//                         //               setState(() {
//                         //                 controller.setFormPag(value.toString());
//                         //               });
//                         //             }),
//                         //         const Text(
//                         //           'Espécie',
//                         //           style: TextStyle(
//                         //               fontSize: 20, color: kTextButtonColor),
//                         //         ),
//                         //       ],
//                         //     ),
//                         //     const HorizontalSpacerBox(size: SpacerSize.small),
//                         //     Row(
//                         //       children: [
//                         //         Radio(
//                         //             overlayColor:
//                         //                 MaterialStateProperty.all(kDetailColor),
//                         //             value: 'Cartão',
//                         //             activeColor: kDetailColor,
//                         //             focusColor: kDetailColor,
//                         //             hoverColor: kDetailColor,
//                         //             groupValue: 'Cartão',
//                         //             onChanged: (value) {
//                         //               setState(() {
//                         //                 controller.setFormPag(value.toString());
//                         //               });
//                         //             }),
//                         //         const Text(
//                         //           'Cartão',
//                         //           style: TextStyle(
//                         //               fontSize: 20, color: kTextButtonColor),
//                         //         ),
//                         //       ],
//                         //     ),
//                         //   ],
//                         // ),
//                         // InkWell(
//                         //   child: Row(
//                         //     mainAxisAlignment: MainAxisAlignment.center,
//                         //     children: [
//                         //       // Container(
//                         //       //   width: 350,
//                         //       //   height: 110,
//                         //       //   decoration: BoxDecoration(
//                         //       //     color: kOnSurfaceColor,
//                         //       //     borderRadius: const BorderRadius.all(
//                         //       //         Radius.circular(15)),
//                         //       //     boxShadow: [
//                         //       //       BoxShadow(
//                         //       //         color: kTextButtonColor.withOpacity(0.5),
//                         //       //         spreadRadius: 0,
//                         //       //         blurRadius: 3,
//                         //       //         offset: const Offset(0, 0),
//                         //       //       ),
//                         //       //     ],
//                         //       //   ),
//                         //       //   child: Wrap(
//                         //       //     children: [
//                         //       //       Row(
//                         //       //         children: [
//                         //       //           Container(
//                         //       //             width: 30.0,
//                         //       //             decoration: const BoxDecoration(
//                         //       //               shape: BoxShape.circle,
//                         //       //             ),
//                         //       //           ),
//                         //       //           const Text(
//                         //       //             'Forma de Pagamento',
//                         //       //             style: TextStyle(
//                         //       //                 fontSize: 20,
//                         //       //                 fontWeight: FontWeight.bold),
//                         //       //             textAlign: TextAlign.start,
//                         //       //           ),
//                         //       //           const Spacer(),
//                         //       //           Column(
//                         //       //             crossAxisAlignment:
//                         //       //                 CrossAxisAlignment.end,
//                         //       //             mainAxisAlignment:
//                         //       //                 MainAxisAlignment.center,
//                         //       //             children: [
//                         //       //               const VerticalSpacerBox(
//                         //       //                   size: SpacerSize.medium),
//                         //       //               IconButton(
//                         //       //                   onPressed: () {
//                         //       //                     Navigator.pushNamed(context,
//                         //       //                         Screens.selectCard);
//                         //       //                   },
//                         //       //                   icon: const Icon(
//                         //       //                     Icons
//                         //       //                         .arrow_forward_ios_outlined,
//                         //       //                     color: kTextButtonColor,
//                         //       //                   )),
//                         //       //             ],
//                         //       //           ),
//                         //       //         ],
//                         //       //       ),
//                         //       //       const Center(
//                         //       //         child: Row(
//                         //       //           children: [
//                         //       //             HorizontalSpacerBox(
//                         //       //                 size: SpacerSize.huge),
//                         //       //             Text(
//                         //       //               'Mastercard ',
//                         //       //               style: TextStyle(fontSize: 16),
//                         //       //             ),
//                         //       //             Text('(Crédito) ',
//                         //       //                 style: TextStyle(
//                         //       //                     fontSize: 16,
//                         //       //                     fontWeight: FontWeight.bold)),
//                         //       //             Text(
//                         //       //               'com final 1447 ',
//                         //       //               style: TextStyle(fontSize: 16),
//                         //       //             ),
//                         //       //           ],
//                         //       //         ),
//                         //       //       ),
//                         //       //       const Center(
//                         //       //         child: Row(
//                         //       //           children: [
//                         //       //             HorizontalSpacerBox(
//                         //       //                 size: SpacerSize.huge),
//                         //       //             Text(
//                         //       //               'Parcelas não disponíveis',
//                         //       //               style: TextStyle(fontSize: 16),
//                         //       //             ),
//                         //       //           ],
//                         //       //         ),
//                         //       //       ),
//                         //       //     ],
//                         //       //   ),
//                         //       // ),
//                         //     ],
//                         //   ),
//                         //   onTap: () {
//                         //     Navigator.pushNamed(context, Screens.selectCard);
//                         //   },
//                         // ),
//                         const VerticalSpacerBox(size: SpacerSize.large),
//                         InkWell(
//                           child: Container(
//                             width: 350,
//                             height: 320,
//                             decoration: BoxDecoration(
//                               color: kOnSurfaceColor,
//                               borderRadius:
//                                   const BorderRadius.all(Radius.circular(15)),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: kTextButtonColor.withOpacity(0.5),
//                                   spreadRadius: 0,
//                                   blurRadius: 3,
//                                   offset: const Offset(0, 0),
//                                 ),
//                               ],
//                             ),
//                             child: Center(
//                               child: Wrap(
//                                 children: [
//                                   Row(
//                                     children: [
//                                       const HorizontalSpacerBox(
//                                           size: SpacerSize.large),
//                                       Container(
//                                         transformAlignment: Alignment.center,
//                                         alignment: Alignment.center,
//                                         height: 75.0,
//                                         decoration: const BoxDecoration(
//                                           shape: BoxShape.rectangle,
                                          
//                                         ),
//                                       ),
//                                       const HorizontalSpacerBox(
//                                           size: SpacerSize.large),
//                                       Column(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Row(
//                                             children: [
//                                               Image.asset(
//                                                 Assets.pix,
//                                                 width: 180,
//                                                 height: 100,
//                                               ),
//                                               // Text(
//                                               //   'PIX: CHAVES',
//                                               //   style: TextStyle(
//                                               //       fontSize: 26,
//                                               //       fontWeight:
//                                               //           FontWeight.bold),
//                                               // ),
//                                             ],
//                                           ),
//                                           const VerticalSpacerBox(
//                                               size: SpacerSize.small),
//                                           const Row(
//                                             children: [
//                                               Text(
//                                                 'Nome: João da Silva',
//                                                 style: TextStyle(
//                                                     fontSize: 20,
//                                                     fontWeight:
//                                                         FontWeight.bold),
//                                                 selectionColor: kText,
//                                               ),
//                                             ],
//                                           ),
//                                           const Row(
//                                             children: [
//                                               Text(
//                                                 'Tipo de Chave: QR Code',
//                                                 style: TextStyle(
//                                                     fontSize: 20,
//                                                     fontWeight:
//                                                         FontWeight.bold),
//                                                 selectionColor: kText,
//                                               ),
//                                             ],
//                                           ),
//                                           const VerticalSpacerBox(
//                                               size: SpacerSize.medium),
//                                           const Row(
//                                             children: [
//                                               HorizontalSpacerBox(
//                                                   size: SpacerSize.huge),
//                                               HorizontalSpacerBox(
//                                                   size: SpacerSize.medium),
//                                               Text(
//                                                 'Chave aleatória',
//                                                 style: TextStyle(
//                                                     fontSize: 20,
//                                                     fontWeight:
//                                                         FontWeight.bold),
//                                                 selectionColor: kText,
//                                               ),
//                                             ],
//                                           ),
//                                           Row(
//                                             children: [
//                                               Container(
//                                                 color: kColorBottom,
//                                                 height: 25,
//                                                 width: 225,
//                                                 child: const Center(
//                                                   child: Text(
//                                                     'edjsd-574757-dsdijsd4',
//                                                     style: TextStyle(
//                                                         fontSize: 20,
//                                                         fontWeight:
//                                                             FontWeight.bold),
//                                                     selectionColor: kText,
//                                                   ),
//                                                 ),
//                                               ),
//                                               IconButton(
//                                                 onPressed: () => {
//                                                   ScaffoldMessenger.of(context)
//                                                       .showSnackBar(const SnackBar(
//                                                           backgroundColor:
//                                                               kDetailColor,
//                                                           content: Text(
//                                                               'Copiado para área de transferência')))
//                                                 },
//                                                 icon: const Icon(
//                                                   Icons.copy,
//                                                   color: kTextButtonColor,
//                                                   size: 30,
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                           InkWell(
//                                             onTap: null,
//                                             child: Row(
//                                               children: [
//                                                 Container(
//                                                   color: kDetailColor,
//                                                   height: 30,
//                                                   width: 225,
//                                                   child: const Center(
//                                                     child: Text(
//                                                       'Comprovante de pagamento',
//                                                       style: TextStyle(
//                                                           fontSize: 15,
//                                                           fontWeight:
//                                                               FontWeight.bold,
//                                                           color: kText),
//                                                     ),
//                                                   ),
//                                                 ),
//                                                 IconButton(
//                                                   onPressed: () => {},
//                                                   icon: const Icon(
//                                                     Icons.archive,
//                                                     color: kDetailColor,
//                                                     size: 30,
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           onTap: () {},
//                         ),;
//   }
// }