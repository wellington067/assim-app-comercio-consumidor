// ignore_for_file: use_build_context_synchronously

import 'package:ecommerceassim/components/forms/address_form_field.dart';
import 'package:ecommerceassim/components/forms/custom_text_form_field.dart';
import 'package:ecommerceassim/screens/screens_index.dart';
import 'package:ecommerceassim/shared/constants/app_text_constants.dart';
import 'package:ecommerceassim/shared/core/controllers/sign_up_controller.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:ecommerceassim/components/appBar/custom_app_bar.dart';
import 'package:ecommerceassim/components/buttons/primary_button.dart';
import 'package:ecommerceassim/components/utils/vertical_spacer_box.dart';
import 'package:ecommerceassim/shared/constants/app_enums.dart';
import 'package:ecommerceassim/shared/constants/style_constants.dart';
import 'package:ecommerceassim/shared/core/models/bairro_model.dart';
import 'package:ecommerceassim/shared/core/models/cidade_model.dart';
import 'package:ecommerceassim/shared/core/repositories/sign_up_repository.dart';
import 'package:ecommerceassim/shared/core/user_storage.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  late SignUpController controller;
  final double formFieldHeight = 48.0;
  final TextEditingController _ruaController = TextEditingController();
  final TextEditingController _numeroController = TextEditingController();
  final TextEditingController _cepController = TextEditingController();
  final TextEditingController _complementoController = TextEditingController();
  int? _selectedCityId;
  int? _selectedBairroId;
  List<CidadeModel> _cidades = [];
  List<BairroModel> _bairros = [];
  final _formKey = GlobalKey<FormState>();
  SignUpRepository signUpRepository = SignUpRepository();
  final MaskTextInputFormatter _cepMaskFormatter = MaskTextInputFormatter(
    mask: '#####-###',
    filter: {"#": RegExp(r'[0-9]')},
  );

  @override
  void initState() {
    super.initState();
    controller = SignUpController();
    _loadData();
  }

  Future<void> _loadData() async {
    List<CidadeModel> cidades = await signUpRepository.getCidades();
    setState(() {
      _cidades = cidades;
    });
  }

  Future<void> _loadBairros(int cidadeId) async {
    List<BairroModel> bairros =
        await signUpRepository.getBairrosByCidade(cidadeId);
    setState(() {
      _bairros = bairros;
      _selectedBairroId =
          _selectedBairroId ?? (bairros.isNotEmpty ? bairros.first.id : null);
    });
  }

  Future<void> _createAddress() async {
    UserStorage userStorage = UserStorage();
    String userToken = await userStorage.getUserToken();

    final url = Uri.parse("$kBaseURL/users/enderecos");
    final response = await http.post(
      url,
      body: json.encode({
        "rua": _ruaController.text,
        "cep": _cepController.text,
        "numero": _numeroController.text,
        "complemento": _complementoController.text,
        "bairro_id": _selectedBairroId,
      }),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $userToken",
      },
    );

    if (response.statusCode == 201) {
      Navigator.pushNamed(context, Screens.selectAdress);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content:
                Text('Erro ao criar endereço. Por favor, tente novamente.')),
      );
    }
  }

  bool validateEmptyFields() {
    bool isValid = true;
    String errorMessage = '';

    if (_ruaController.text.isEmpty) {
      errorMessage = 'Preencha o campo Rua.';
      isValid = false;
    } else if (RegExp(r'\d').hasMatch(_ruaController.text)) {
      errorMessage = 'O campo Rua não deve conter números.';
      isValid = false;
    } else if (_numeroController.text.isEmpty ||
        _numeroController.text.length > 4) {
      errorMessage =
          'O campo Número deve ser preenchido e ter no máximo 4 caracteres.';
      isValid = false;
    } else if (_cepController.text.isEmpty ||
        _cepController.text.length != _cepMaskFormatter.getMask()?.length) {
      errorMessage = 'Preencha o campo CEP corretamente.';
      isValid = false;
    } else if (_selectedCityId == null) {
      errorMessage = 'Selecione uma cidade.';
      isValid = false;
    } else if (_selectedBairroId == null) {
      errorMessage = 'Selecione um bairro.';
      isValid = false;
    }

    if (!isValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    }

    return isValid;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Container(
        color: kOnSurfaceColor,
        width: size.width,
        padding: const EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const VerticalSpacerBox(size: SpacerSize.small),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Cadastrar novo endereço',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              const VerticalSpacerBox(size: SpacerSize.large),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Cidade',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const VerticalSpacerBox(size: SpacerSize.small),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: kBackgroundColor,
                        ),
                        child: DropdownButtonFormField<int>(
                          isExpanded: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: kBackgroundColor,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: formFieldHeight / 4, horizontal: 16),
                          ),
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(fontSize: 15),
                          value: _selectedCityId,
                          items: _cidades.map((CidadeModel cidade) {
                            return DropdownMenuItem<int>(
                              value: cidade.id,
                              child: Text(cidade.nome ?? ''),
                            );
                          }).toList(),
                          onChanged: (int? newValue) {
                            setState(() {
                              _selectedCityId = newValue;
                              _selectedBairroId = null;
                              _bairros = [];
                            });
                            _loadBairros(newValue!);
                          },
                        ),
                      ),
                      const VerticalSpacerBox(size: SpacerSize.small),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Bairro',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      DropdownButtonFormField<int>(
                        isExpanded: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: kBackgroundColor,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: formFieldHeight / 4, horizontal: 15),
                        ),
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(fontSize: 16),
                        value: _selectedBairroId,
                        items: _bairros.map((BairroModel bairro) {
                          return DropdownMenuItem<int>(
                            value: bairro.id,
                            child: Text(bairro.nome ?? ''),
                          );
                        }).toList(),
                        onChanged: (int? newValue) {
                          setState(() {
                            _selectedBairroId = newValue;
                          });
                        },
                      ),
                      const VerticalSpacerBox(size: SpacerSize.small),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Rua',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      AddressFormField(
                        keyboardType: TextInputType.text,
                        label: 'Rua',
                        controller: _ruaController,
                      ),
                      const VerticalSpacerBox(size: SpacerSize.small),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'CEP',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      AddressFormField(
                        label: 'CEP',
                        keyboardType: TextInputType.text,
                        maskFormatter: controller.cepFormatter,
                        controller: _cepController,
                      ),
                      const VerticalSpacerBox(size: SpacerSize.small),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Número',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      AddressFormField(
                        keyboardType: TextInputType.number,
                        label: 'Número',
                        controller: _numeroController,
                      ),
                      const VerticalSpacerBox(size: SpacerSize.small),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Complemento',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      AddressFormField(
                        keyboardType: TextInputType.text,
                        label: 'Complemento',
                        controller: _complementoController,
                      ),
                      const VerticalSpacerBox(size: SpacerSize.small),
                    ],
                  ),
                ),
              ),
              PrimaryButton(
                text: 'Salvar',
                onPressed: () {
                  if (validateEmptyFields()) {
                    _createAddress();
                  }
                },
                color: kDetailColor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _ruaController.dispose();
    _numeroController.dispose();
    _cepController.dispose();
    _complementoController.dispose();
    super.dispose();
  }
}
