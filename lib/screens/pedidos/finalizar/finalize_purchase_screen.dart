import 'package:ecommerceassim/assets/index.dart';
import 'package:ecommerceassim/components/appBar/custom_app_bar.dart';
import 'package:ecommerceassim/shared/core/controllers/profile_controller.dart';
import 'package:ecommerceassim/shared/core/controllers/purchase_controller.dart';
import 'package:ecommerceassim/shared/core/models/cart_model.dart';
import 'package:ecommerceassim/shared/core/models/endereco_model.dart';
import 'package:flutter/material.dart';
import 'package:ecommerceassim/components/utils/horizontal_spacer_box.dart';
import 'package:ecommerceassim/components/utils/vertical_spacer_box.dart';
import 'package:ecommerceassim/screens/screens_index.dart';
import 'package:ecommerceassim/shared/constants/app_enums.dart';
import 'package:ecommerceassim/shared/constants/style_constants.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:rating_dialog/rating_dialog.dart';
import '../../../components/buttons/primary_button.dart';

class FinalizePurchaseScreen extends StatefulWidget {
  final List<CartModel> cartModel;
  final Map<String, dynamic>? addressData;

  const FinalizePurchaseScreen(this.cartModel, {this.addressData, super.key});

  @override
  State<FinalizePurchaseScreen> createState() => _FinalizePurchaseScreenState();
}

class _FinalizePurchaseScreenState extends State<FinalizePurchaseScreen> {
  String _deliveryMethod = 'Retirada';
  AddressModel? userAddress;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserAddress();
  }

  Future<void> _loadUserAddress() async {
    final profileController =
        Provider.of<ProfileController>(context, listen: false);
    await profileController.fetchUserAddresses();
    setState(() {
      userAddress = profileController.addresses.isNotEmpty
          ? profileController.addresses.first
          : null;
      isLoading = false;
    });
  }

  void _chooseAddress(
      BuildContext context, ProfileController controller) async {
    final AddressModel? selectedAddress = await showDialog<AddressModel>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text("Escolha um endereço"),
          content: SizedBox(
            width: double.minPositive,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: controller.addresses.length,
              itemBuilder: (BuildContext context, int index) {
                var address = controller.addresses[index];
                return ListTile(
                  title: Text('${address.rua}, ${address.numero}'),
                  subtitle:
                      Text('${address.bairroNome}, ${address.cidadeNome}'),
                  onTap: () => Navigator.pop(context, address),
                );
              },
            ),
          ),
        );
      },
    );
    if (selectedAddress != null) {
      setState(() {
        userAddress = selectedAddress;
      });
    }
  }

  void showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pedido realizado!'),
          content:
              const Icon(Icons.shopping_bag, size: 100, color: kDetailColor),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushNamed(context, Screens.home);
              },
              child: const Text(
                'OK',
                style: TextStyle(color: kTextNavColor),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final profileController =
        Provider.of<ProfileController>(context, listen: false);

    return isLoading
        ? const Center(child: CircularProgressIndicator(color: kDetailColor))
        : GetBuilder<PurchaseController>(
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Text(
                              'Forma de entrega',
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Radio(
                                overlayColor:
                                    MaterialStateProperty.all(kDetailColor),
                                value: 'Retirada',
                                groupValue: _deliveryMethod,
                                activeColor: kDetailColor,
                                focusColor: kDetailColor,
                                hoverColor: kDetailColor,
                                onChanged: (value) {
                                  setState(() {
                                    _deliveryMethod = value.toString();
                                  });
                                }),
                            const Text(
                              'Retirada',
                              style: TextStyle(
                                  fontSize: 20, color: kTextButtonColor),
                            ),
                            const HorizontalSpacerBox(size: SpacerSize.small),
                            Radio(
                                overlayColor:
                                    MaterialStateProperty.all(kDetailColor),
                                value: 'Entrega',
                                groupValue: _deliveryMethod,
                                activeColor: kDetailColor,
                                focusColor: kDetailColor,
                                hoverColor: kDetailColor,
                                onChanged: (value) {
                                  setState(() {
                                    _deliveryMethod = value.toString();
                                  });
                                }),
                            const Text(
                              'Entrega',
                              style: TextStyle(
                                  fontSize: 20, color: kTextButtonColor),
                            ),
                          ],
                        ),
                        const VerticalSpacerBox(size: SpacerSize.medium),
                        InkWell(
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(16),
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
                              border: Border(
                                left: BorderSide(
                                  color: kTextButtonColor.withOpacity(0.5),
                                  width: 1,
                                ),
                                right: BorderSide(
                                  color: kTextButtonColor.withOpacity(0.5),
                                  width: 1,
                                ),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Text(
                                      'Endereço de entrega',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const Spacer(),
                                    IconButton(
                                        onPressed: () => _chooseAddress(
                                            context, profileController),
                                        icon: const Icon(
                                          Icons.arrow_forward_ios_outlined,
                                          color: kTextButtonColor,
                                        )),
                                  ],
                                ),
                                const VerticalSpacerBox(size: SpacerSize.tiny),
                                Text(
                                  'Bairro: ${userAddress?.bairroNome ?? 'Bairro não disponível'}',
                                  style: const TextStyle(fontSize: 13),
                                ),
                                const VerticalSpacerBox(size: SpacerSize.tiny),
                                Text(
                                  'Cidade: ${userAddress?.cidadeNome ?? 'Cidade não disponível'}',
                                  style: const TextStyle(fontSize: 13),
                                ),
                                const VerticalSpacerBox(size: SpacerSize.tiny),
                                Text(
                                  'Rua: ${userAddress?.rua ?? 'Rua não disponível'}',
                                  style: const TextStyle(fontSize: 13),
                                ),
                                const VerticalSpacerBox(size: SpacerSize.tiny),
                                Text(
                                  'Número: ${userAddress?.numero ?? 'Número não disponível'}',
                                  style: const TextStyle(fontSize: 13),
                                ),
                                const VerticalSpacerBox(size: SpacerSize.tiny),
                                if (userAddress?.complemento != null)
                                  Text(
                                    'Complemento: ${userAddress?.complemento}',
                                    style: const TextStyle(fontSize: 13),
                                  ),
                              ],
                            ),
                          ),
                          onTap: () {},
                        ),
                        const VerticalSpacerBox(size: SpacerSize.large),
                        InkWell(
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(16),
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
                              border: Border(
                                left: BorderSide(
                                  color: kTextButtonColor.withOpacity(0.5),
                                  width: 1,
                                ),
                                right: BorderSide(
                                  color: kTextButtonColor.withOpacity(0.5),
                                  width: 1,
                                ),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Text(
                                      'Resumo de valores',
                                      style: TextStyle(
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
                                const VerticalSpacerBox(size: SpacerSize.tiny),
                                Row(
                                  children: [
                                    const Text(
                                      'Subtotal:',
                                      style: TextStyle(fontSize: 17),
                                    ),
                                    const Spacer(),
                                    Text(
                                      'R\$ ${controller.totalValue.toStringAsFixed(2)}',
                                      style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: kTextButtonColor),
                                    ),
                                  ],
                                ),
                                const VerticalSpacerBox(size: SpacerSize.small),
                                const Row(
                                  children: [
                                    Text(
                                      'Frete:',
                                      style: TextStyle(fontSize: 17),
                                    ),
                                    Spacer(),
                                    Text(
                                      'R\$ 5.00',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: kTextButtonColor),
                                    ),
                                  ],
                                ),
                                const VerticalSpacerBox(size: SpacerSize.small),
                                Row(
                                  children: [
                                    const Text(
                                      'Total:',
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const Spacer(),
                                    Text(
                                      'R\$ ${(controller.totalValue + 5).toStringAsFixed(2)}',
                                      style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: kTextButtonColor),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          onTap: () {},
                        ),
                        const VerticalSpacerBox(size: SpacerSize.large),
                        PrimaryButton(
                          text: 'Confirmar pedido',
                          onPressed: () async {
                            bool success = await controller.purchase();
                            if (success) {
                              print("Purchase successful, showing dialog.");
                              showSuccessDialog(context);
                            } else {
                              print("Purchase failed.");
                            }
                          },
                          color: kDetailColor,
                        ),
                        const VerticalSpacerBox(size: SpacerSize.medium),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, Screens.cart);
                                },
                                child: const Text(
                                  'Voltar a cesta',
                                  style: TextStyle(
                                      color: kDetailColor, fontSize: 16),
                                ))
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
  }
}
