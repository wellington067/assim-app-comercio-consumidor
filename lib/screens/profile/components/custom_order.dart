import 'package:ecommerceassim/shared/components/dialogs/deleted_order.dart';
import 'package:ecommerceassim/shared/components/dialogs/finish_dialog.dart';
import 'package:ecommerceassim/shared/constants/app_enums.dart';
import 'package:flutter/material.dart';
import 'package:ecommerceassim/components/utils/horizontal_spacer_box.dart';
import 'package:ecommerceassim/components/utils/vertical_spacer_box.dart';
import 'package:ecommerceassim/shared/constants/style_constants.dart';

class OrderCard extends StatelessWidget {
  final String orderNumber;
  final String sellerName;
  final double itemsTotal;
  final double shippingHandling;
  final String date;
  final String status;
  final VoidCallback onTap;

  const OrderCard({
    Key? key,
    required this.orderNumber,
    required this.sellerName,
    required this.itemsTotal,
    required this.shippingHandling,
    required this.date,
    required this.status,
    required this.onTap,
  }) : super(key: key);

  String formatPrice(double price) {
    return price.toStringAsFixed(2).replaceAll('.', ',');
  }

  String get formattedItemsTotal => formatPrice(itemsTotal);
  String get formattedShippingHandling => formatPrice(shippingHandling);
  String get formattedOrderTotal => formatPrice(orderTotal);

  double get orderTotal => itemsTotal + shippingHandling;

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Em andamento':
        return kAlertColor;
      case 'Entregue':
        return kSuccessColorPurshase;
      case 'Cancelado':
        return kErrorColor;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    Color statusColor = _getStatusColor(status);

    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
            child: Text(
              'Pedido $orderNumber',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        InkWell(
          onTap: onTap,
          child: Container(
            width: 430,
            height: 230,
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
            child: Wrap(
              children: [
                Padding(
                  padding: const EdgeInsets.all(0.5),
                  child: Row(
                    children: [
                      const HorizontalSpacerBox(size: SpacerSize.large),
                      Text(
                        sellerName,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => const DeletedOrderDialog(),
                          );
                        },
                        icon: const Icon(
                          Icons.arrow_forward_ios_outlined,
                          color: kTextButtonColor,
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(
                  color: kTextButtonColor,
                  height: 20,
                  thickness: 1,
                  indent: 5,
                ),
                const VerticalSpacerBox(size: SpacerSize.small),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                  child: Row(
                    children: [
                      const HorizontalSpacerBox(size: SpacerSize.large),
                      const Text(
                        'Valor',
                        style: TextStyle(fontSize: 17),
                      ),
                      const Spacer(),
                      Text(
                        formattedItemsTotal,
                        style: const TextStyle(
                            fontSize: 21, color: kTextButtonColor),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                  child: Row(
                    children: [
                      const HorizontalSpacerBox(size: SpacerSize.large),
                      const Text(
                        'Frete',
                        style: TextStyle(fontSize: 17),
                      ),
                      const Spacer(),
                      Text(
                        formattedShippingHandling,
                        style: const TextStyle(
                            fontSize: 21, color: kTextButtonColor),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                  child: Row(
                    children: [
                      const HorizontalSpacerBox(size: SpacerSize.large),
                      const Text(
                        'Total',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      Text(
                        formattedOrderTotal,
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Colors.black),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                  child: Row(
                    children: [
                      const HorizontalSpacerBox(size: SpacerSize.large),
                      Text(
                        date,
                        style: const TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      ElevatedButton(
                        onPressed: null, // ou alguma outra ação
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(statusColor),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  20.0), // Ajuste o raio conforme necessário
                            ),
                          ),
                        ),
                        child: Text(
                          status,
                          style: const TextStyle(
                              fontSize: 17, color: kOnSurfaceColor),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
