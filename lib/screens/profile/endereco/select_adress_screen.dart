// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:ecommerceassim/screens/screens_index.dart';
import 'package:ecommerceassim/shared/constants/app_text_constants.dart';
import 'package:ecommerceassim/shared/core/user_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:ecommerceassim/components/appBar/custom_app_bar.dart';
import 'package:ecommerceassim/shared/core/controllers/profile_controller.dart';
import 'package:ecommerceassim/shared/constants/style_constants.dart';
import '../../../components/utils/vertical_spacer_box.dart';
import '../../../shared/constants/app_enums.dart';

class SelectAddress extends StatefulWidget {
  const SelectAddress({super.key});

  @override
  State<SelectAddress> createState() => _SelectAddressState();
}

class _SelectAddressState extends State<SelectAddress> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      context.read<ProfileController>().fetchUserAddresses();
    });
  }

  Future<void> _deleteAddress(String id, String token) async {
    final url = '$kBaseURL/users/enderecos/$id';
    try {
      final response = await http.delete(
        Uri.parse(url),
        headers: {'Authorization': 'Bearer $token'},
      );
      if (response.statusCode == 200) {
        context.read<ProfileController>().fetchUserAddresses();
      } else {
        print('Falha ao excluir endereço: ${response.statusCode}');
      }
    } catch (error) {
      print('Erro ao excluir endereço: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: const CustomAppBar(),
      backgroundColor: Colors.white,
      body: Container(
        color: kOnSurfaceColor,
        width: size.width,
        padding: const EdgeInsets.all(20),
        child: Consumer<ProfileController>(
          builder: (context, controller, child) {
            if (controller.addresses.isEmpty) {
              return const Center(
                child: CircularProgressIndicator(
                  color: kDetailColor,
                ),
              );
            }
            return SingleChildScrollView(
              child: Column(
                children: [
                  const VerticalSpacerBox(size: SpacerSize.small),
                  const Text(
                    'Selecionar um endereço de envio',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const VerticalSpacerBox(size: SpacerSize.large),
                  ...controller.addresses.map((address) {
                    return Container(
                      width: 350,
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Text(
                                  'Rua: ${address.rua}, ${address.numero}',
                                  style: const TextStyle(fontSize: 17),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () async {
                                  bool confirmDelete = await showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        backgroundColor: Colors.white,
                                        title: const Text('Excluir endereço'),
                                        content: const Text(
                                            'Tem certeza de que deseja excluir este endereço?'),
                                        actionsAlignment:
                                            MainAxisAlignment.center,
                                        actions: <Widget>[
                                          ElevatedButton(
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      kDetailColor),
                                              shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                              ),
                                            ),
                                            onPressed: () {
                                              Navigator.of(context).pop(false);
                                            },
                                            child: const Text(
                                              'Cancelar',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          ElevatedButton(
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      kButtom2),
                                              shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                              ),
                                            ),
                                            onPressed: () {
                                              Navigator.of(context).pop(true);
                                            },
                                            child: const Text(
                                              'Excluir',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  );

                                  if (confirmDelete == true) {
                                    String token =
                                        await UserStorage().getUserToken();
                                    await _deleteAddress(
                                        address.id.toString(), token);
                                  }
                                },
                              ),
                            ],
                          ),
                          if (address.complemento != null)
                            Container(
                              padding: const EdgeInsets.only(bottom: 4),
                              child: Text(
                                'Complemento: ${address.complemento}',
                                style: const TextStyle(fontSize: 17),
                              ),
                            ),
                          Container(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Text(
                              'CEP: ${address.cep}',
                              style: const TextStyle(fontSize: 17),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Text(
                              'Bairro: ${address.bairroNome}',
                              style: const TextStyle(fontSize: 17),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Text(
                              'Cidade: ${address.cidadeNome}',
                              style: const TextStyle(fontSize: 17),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 0),
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                    context,
                                    Screens.addressEdit,
                                    arguments: {
                                      'id': address.id,
                                      'rua': address.rua,
                                      'numero': address.numero,
                                      'cep': address.cep,
                                      'complemento': address.complemento,
                                      'bairroId': address.bairroId,
                                      'cidadeId': address.cidadeId,
                                      'bairroNome': address.bairroNome,
                                      'cidadeNome': address.cidadeNome,
                                    },
                                  );
                                },
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(kDetailColor),
                                ),
                                child: const Text(
                                  'Editar',
                                  style: TextStyle(
                                      fontSize: 15, color: kOnSurfaceColor),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                  InkWell(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 350,
                          height: 75,
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
                          child: Center(
                            child: Wrap(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 35.0,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    const Text(
                                      'Adicione um novo endereço',
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: kTextButtonColor,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.start,
                                    ),
                                    const Spacer(),
                                    IconButton(
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context, Screens.adress);
                                      },
                                      icon: const Icon(
                                        Icons.arrow_forward_ios_outlined,
                                        color: kTextButtonColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, Screens.adress);
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
