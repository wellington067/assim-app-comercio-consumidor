import 'package:ecommerceassim/components/utils/horizontal_spacer_box.dart';
import 'package:ecommerceassim/components/utils/vertical_spacer_box.dart';
import 'package:ecommerceassim/components/appBar/custom_app_bar.dart';
import 'package:ecommerceassim/screens/cesta/card_cart.dart';
import 'package:ecommerceassim/screens/screens_index.dart';
import 'package:ecommerceassim/shared/components/BottomNavigation.dart';
import 'package:ecommerceassim/shared/constants/app_enums.dart';
import 'package:ecommerceassim/shared/constants/style_constants.dart';
import 'package:ecommerceassim/shared/core/models/produto_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../components/buttons/primary_button.dart';
import '../../shared/constants/app_number_constants.dart';
import 'cart_controller.dart';
import 'cart_provider.dart';

class CartScreen extends StatefulWidget {
  final ProdutoModel? selectedProduct;

  CartScreen({super.key, this.selectedProduct});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int selectedIndex = 3;

  @override
  Widget build(BuildContext context) {
    final cartListProvider = Provider.of<CartProvider>(context);
    //late int melancia = 0;
    //late int limao = 0;
    late int selectedIndex = 1;
    Size size = MediaQuery.of(context).size;
    return GetBuilder<CartController>(
      init: CartController(),
      builder: (controller) => Scaffold(
        appBar: const CustomAppBar(),
        bottomNavigationBar: BottomNavigation(selectedIndex: selectedIndex),
        body: SingleChildScrollView(
          child: Container(
            color: kOnSurfaceColor,
            width: size.width,
            height: size.height,
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Column(
              children: [
                Row(
                  children: [
                    const Text(
                      'Subtotal',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const HorizontalSpacerBox(size: SpacerSize.small),
                    Text(
                        NumberFormat.simpleCurrency(
                    locale: 'pt-BR', decimalDigits: 2)
                        .format(controller.total),
                      style: const TextStyle(
                          fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const VerticalSpacerBox(size: SpacerSize.medium),
                PrimaryButton(
                  text: 'Fechar Pedido (${controller.counter} itens)',
                  onPressed: () {
                    Navigator.pushNamed(context, Screens.finalizePurchase);
                  },
                  color: kDetailColor,
                ),
                const VerticalSpacerBox(size: SpacerSize.large),
                Expanded(
                  child: ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return CardCart(cartListProvider.retriveCardItem(index), controller);
                      },
                      separatorBuilder: (context, index) {
                        return Divider(height: size.height * 0.03, color: Colors.transparent,);
                      },
                      itemCount: cartListProvider.listCart.length),
                ),
              ],
            ),
          ),
          // const VerticalSpacerBox(size: SpacerSize.small),
          // InkWell(
          //   child: Container(
          //     width: 440,
          //     height: 260,
          //     decoration: BoxDecoration(
          //       color: kOnSurfaceColor,
          //       borderRadius:
          //           const BorderRadius.all(Radius.circular(15)),
          //       boxShadow: [
          //         BoxShadow(
          //           color: kTextButtonColor.withOpacity(0.5),
          //           spreadRadius: 0,
          //           blurRadius: 3,
          //           offset: const Offset(0, 0),
          //         ),
          //       ],
          //     ),
          //     child: Center(
          //       child: Wrap(
          //         children: [
          //           Row(
          //             children: [
          //               const HorizontalSpacerBox(
          //                   size: SpacerSize.large),
          //               Container(
          //                 width: 75.0,
          //                 height: 150.0,
          //                 decoration: const BoxDecoration(
          //                   image: DecorationImage(
          //                     fit: BoxFit.contain,
          //                     image: AssetImage(Assets.limao),
          //                   ),
          //                 ),
          //               ),
          //               const Column(
          //                 mainAxisAlignment:
          //                     MainAxisAlignment.center,
          //                 crossAxisAlignment:
          //                     CrossAxisAlignment.start,
          //                 children: [
          //                   VerticalSpacerBox(
          //                       size: SpacerSize.large),
          //                   Row(
          //                     children: [
          //                       Text(
          //                         'Limão',
          //                         style: TextStyle(
          //                             fontSize: 20,
          //                             fontWeight: FontWeight.bold),
          //                       ),
          //                     ],
          //                   ),
          //                   VerticalSpacerBox(
          //                       size: SpacerSize.medium),
          //                   Row(
          //                     children: [
          //                       Text(
          //                         'RS 3,50',
          //                         style: TextStyle(
          //                             fontSize: 25,
          //                             fontWeight: FontWeight.bold),
          //                         textAlign: TextAlign.end,
          //                       ),
          //                       HorizontalSpacerBox(
          //                           size: SpacerSize.tiny),
          //                       Text(
          //                         'Kg',
          //                         style: TextStyle(fontSize: 15),
          //                       ),
          //                     ],
          //                   ),
          //                   VerticalSpacerBox(
          //                       size: SpacerSize.small),
          //                   Row(
          //                     children: [
          //                       Text(
          //                         'Vendido por ',
          //                         style: TextStyle(
          //                           fontSize: 16,
          //                         ),
          //                       ),
          //                       Text(
          //                         'João Frutas',
          //                         style: TextStyle(
          //                             fontSize: 16, color: kButtom),
          //                       ),
          //                       IconButton(
          //                         onPressed: null,
          //                         icon: Icon(
          //                           Icons.phone,
          //                           color: Colors.green,
          //                           size: 30,
          //                         ),
          //                       ),
          //                     ],
          //                   ),
          //                 ],
          //               ),
          //             ],
          //           ),
          //           const HorizontalSpacerBox(
          //               size: SpacerSize.huge),
          //           const Text(
          //             'Quantidade:',
          //             style: TextStyle(
          //                 fontSize: 15,
          //                 fontWeight: FontWeight.bold),
          //             textAlign: TextAlign.end,
          //           ),
          //           Row(
          //             children: [
          //               const HorizontalSpacerBox(
          //                   size: SpacerSize.small),
          //               IconButton(
          //                 icon: const Icon(Icons.remove),
          //                 onPressed: () {
          //                   if (controller.limao > 0 &&
          //                       controller.counter > 0) {
          //                     setState(() {
          //                       controller.limao--;
          //                       controller.decrementCounter();
          //                       controller.total -= 3.50;
          //                     });
          //                   }
          //                 },
          //               ),
          //               const HorizontalSpacerBox(
          //                   size: SpacerSize.small),
          //               Text(
          //                 controller.limao.toString(),
          //                 style: const TextStyle(fontSize: 15),
          //                 textAlign: TextAlign.end,
          //               ),
          //               const HorizontalSpacerBox(
          //                   size: SpacerSize.small),
          //               IconButton(
          //                 icon: const Icon(Icons.add),
          //                 onPressed: () {
          //                   setState(() {
          //                     controller.limao++;
          //                     controller.incrementCounter();
          //                     controller.total += 3.50;
          //                   });
          //                 },
          //               ),
          //               const HorizontalSpacerBox(
          //                   size: SpacerSize.large),
          //               ElevatedButton(
          //                 onPressed: () {
          //                   setState(() {
          //                     controller.limao--;
          //                     controller.decrementCounter();
          //                     controller.total -= 3.50;
          //                   });
          //                 },
          //                 style: ButtonStyle(
          //                   backgroundColor:
          //                       MaterialStateProperty.all(
          //                           kErrorColor),
          //                 ),
          //                 child: const Text(
          //                   'Excluir',
          //                   style: TextStyle(
          //                     color: kOnSurfaceColor,
          //                     fontSize: 15,
          //                     // color: kTextButtonColor
          //                   ),
          //                 ),
          //               ),
          //             ],
          //           ),
          //           const VerticalSpacerBox(size: SpacerSize.tiny),
          //         ],
          //       ),
          //     ),
          //   ),
          //   onTap: () async {},
          // ),
        ),
      ),
    );
  }
}
