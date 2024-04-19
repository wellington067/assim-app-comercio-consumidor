import 'dart:developer';

import 'package:ecommerceassim/components/utils/horizontal_spacer_box.dart';
import 'package:ecommerceassim/components/utils/vertical_spacer_box.dart';
import 'package:ecommerceassim/components/appBar/custom_app_bar.dart';
import 'package:ecommerceassim/screens/cesta/cart_controller.dart';
import 'package:ecommerceassim/shared/core/controllers/home_screen_controller.dart';
import 'package:ecommerceassim/screens/screens_index.dart';
import 'package:ecommerceassim/shared/components/BottomNavigation.dart';
import 'package:ecommerceassim/shared/constants/app_enums.dart';
import 'package:ecommerceassim/shared/constants/style_constants.dart';
import 'package:ecommerceassim/shared/core/models/cart_model.dart';
import 'package:ecommerceassim/shared/core/models/produto_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../assets/index.dart';
import '../../components/buttons/primary_button.dart';
import '../../shared/constants/app_number_constants.dart';
import 'cart_provider.dart';

class CardCart extends StatefulWidget {
  CartModel model;
  CartController? controller;

  CardCart(this.model, this.controller, {super.key});

  @override
  State<CardCart> createState() => _CardCartState();
}

class _CardCartState extends State<CardCart> {
  @override
  Widget build(BuildContext context) {
    final cartListProvider = Provider.of<CartProvider>(context);
    log(widget.model.nameProduct.toString());
    Size size = MediaQuery.of(context).size;
    double? doublePrice = double.tryParse(widget.model.price!);
    String rightPrice =
        NumberFormat.simpleCurrency(locale: 'pt-BR', decimalDigits: 2)
            .format(doublePrice);
    return InkWell(
      child: Container(
        width: size.width * 0.7,
        height: size.height * 0.3,
        decoration: BoxDecoration(
          color: kOnSurfaceColor,
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          boxShadow: [
            BoxShadow(
              color: kTextButtonColor.withOpacity(0.5),
              spreadRadius: 0,
              blurRadius: 3,
              offset: const Offset(0, 0),
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
                    width: size.width * 0.3,
                    height: size.height * 0.1,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.contain,
                        image: AssetImage(Assets.melancia),
                      ),
                    ),
                  ),
                  const HorizontalSpacerBox(size: SpacerSize.small),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      VerticalSpacerBox(size: SpacerSize.large),
                      Container(
                        width: size.width * 0.42,
                        alignment: AlignmentDirectional.topStart,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            widget.model.nameProduct.toString(),
                            style: TextStyle(
                                fontSize: size.height * 0.024,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      VerticalSpacerBox(size: SpacerSize.medium),
                      Row(
                        children: [
                          Text(
                            rightPrice.toString(),
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.end,
                          ),
                          HorizontalSpacerBox(size: SpacerSize.tiny),
                        ],
                      ),
                      VerticalSpacerBox(size: SpacerSize.small),
                    ],
                  ),
                ],
              ),
              const HorizontalSpacerBox(size: SpacerSize.huge),
              const Text(
                'Quantidade:',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                textAlign: TextAlign.end,
              ),
              Row(
                children: [
                  const HorizontalSpacerBox(size: SpacerSize.small),
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () {
                      if (widget.model.amount > 0 &&
                          widget.controller!.counter > 0) {
                        setState(() {
                          widget.model.amount--;
                          widget.controller?.decrementCounter();
                          widget.controller?.total -= doublePrice!;
                        });
                      }
                    },
                  ),
                  const HorizontalSpacerBox(size: SpacerSize.small),
                  Text(
                    widget.model.amount.toString(),
                    style: const TextStyle(fontSize: 15),
                    textAlign: TextAlign.end,
                  ),
                  const HorizontalSpacerBox(size: SpacerSize.small),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      setState(() {
                        widget.model.amount++;
                        widget.controller?.incrementCounter();
                        widget.controller?.total += doublePrice!;
                      });
                    },
                  ),
                  const HorizontalSpacerBox(size: SpacerSize.large),
                  ElevatedButton(
                    onPressed: () {
                      // setState(() {
                      //   widget.controller?.amount--;
                      //   widget.controller?.decrementCounter();
                      //   widget.controller?.total -= 5.50;
                      // });
                      cartListProvider.removeCart(widget.model);
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(kErrorColor),
                    ),
                    child: const Text(
                      'Excluir',
                      style: TextStyle(
                        color: kOnSurfaceColor,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
              const VerticalSpacerBox(size: SpacerSize.tiny),
            ],
          ),
        ),
      ),
      onTap: () {},
    );
  }
}
