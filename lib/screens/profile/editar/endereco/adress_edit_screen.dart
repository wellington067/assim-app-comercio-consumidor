import 'package:ecommerceassim/shared/constants/app_enums.dart';
import 'package:ecommerceassim/shared/constants/app_text_constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'package:ecommerceassim/components/utils/vertical_spacer_box.dart';
import 'package:ecommerceassim/screens/screens_index.dart';
import 'package:ecommerceassim/shared/constants/style_constants.dart';
import 'package:ecommerceassim/components/appBar/custom_app_bar.dart';
import 'package:ecommerceassim/components/buttons/primary_button.dart';
import 'package:ecommerceassim/components/forms/address_form_field.dart';
import 'package:ecommerceassim/shared/core/user_storage.dart';
import 'package:ecommerceassim/shared/core/models/bairro_model.dart';
import 'package:ecommerceassim/shared/core/models/cidade_model.dart';
import 'package:ecommerceassim/shared/core/repositories/sign_up_repository.dart';

class AdressEditScreen extends StatefulWidget {
  const AdressEditScreen({super.key});

  @override
  State<AdressEditScreen> createState() => _AdressEditScreenState();
}

class _AdressEditScreenState extends State<AdressEditScreen> {
  int? _selectedCityId;
  int? _selectedBairroId;
  List<CidadeModel> _cidades = [];
  List<BairroModel> _bairros = [];
  final TextEditingController _ruaController = TextEditingController();
  final TextEditingController _numeroController = TextEditingController();
  final TextEditingController _cepController = TextEditingController();
  final TextEditingController _complementoController = TextEditingController();
  String _addressId = "";
  String? errorMessage;
  final _formKey = GlobalKey<FormState>();

  SignUpRepository signUpRepository = SignUpRepository();
  final MaskTextInputFormatter _cepMaskFormatter = MaskTextInputFormatter(
    mask: '#####-###',
    filter: {"#": RegExp(r'[0-9]')},
  );

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      final arguments =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

      if (arguments != null) {
        _addressId = arguments['id'].toString();
        _ruaController.text = arguments['rua'] ?? '';
        _numeroController.text = arguments['numero'] ?? '';
        _cepController.text = arguments['cep'] ?? '';
        _complementoController.text = arguments['complemento'] ?? '';

        _selectedCityId = int.tryParse(arguments['cidadeId'].toString());
        _selectedBairroId = int.tryParse(arguments['bairroId'].toString());
      }

      await _loadData();
    });
  }

  Future<void> _loadData() async {
    List<CidadeModel> cidades = await signUpRepository.getCidades();
    setState(() {
      _cidades = cidades;
    });

    if (_selectedCityId != null && _selectedCityId != 0) {
      await _loadBairros(_selectedCityId!);
    }
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

  Future<void> _updateEndereco() async {
    UserStorage userStorage = UserStorage();
    String userToken = await userStorage.getUserToken();

    final url = Uri.parse("$kBaseURL/users/enderecos/$_addressId");
    final response = await http.patch(
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

    if (response.statusCode == 200) {
      Navigator.pushNamed(context, Screens.selectAdress);
    } else {
      setErrorMessage('Erro ao atualizar endereço.');
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

  void setErrorMessage(String value) {
    setState(() {
      errorMessage = value;
    });
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        errorMessage = null;
      });
    });
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
            children: [
              const VerticalSpacerBox(size: SpacerSize.small),
              const Row(
                children: [
                  Text(
                    'Editar endereço',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Cidade',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 8),
                          DropdownButtonFormField<int>(
                            value: _selectedCityId,
                            items: _cidades.map((cidade) {
                              return DropdownMenuItem<int>(
                                value: cidade.id!,
                                child: Text(cidade.nome ?? ''),
                              );
                            }).toList(),
                            onChanged: (value) async {
                              if (value != null) {
                                setState(() {
                                  _selectedCityId = value;
                                  _selectedBairroId = null;
                                  _bairros = [];
                                });
                                await _loadBairros(value);
                              }
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: kBackgroundColor,
                              contentPadding:
                                  const EdgeInsets.fromLTRB(13, 13, 13, 13),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Bairro',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 8),
                          DropdownButtonFormField<int>(
                            value: _selectedBairroId,
                            items: _bairros.map((bairro) {
                              return DropdownMenuItem<int>(
                                value: bairro.id!,
                                child: Text(bairro.nome ?? ''),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                _selectedBairroId = value;
                              });
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: kBackgroundColor,
                              contentPadding: const EdgeInsets.fromLTRB(
                                  13, 13, 13, 13), // Updated padding
                            ),
                          ),
                        ],
                      ),
                      const VerticalSpacerBox(size: SpacerSize.small),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Rua',
                            style: TextStyle(
                              // Add your desired style for the label
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          AddressFormField(
                            controller: _ruaController,
                            label: 'Rua',
                            keyboardType: TextInputType.text,
                          ),
                        ],
                      ),
                      const VerticalSpacerBox(size: SpacerSize.small),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Número',
                            style: TextStyle(
                              // Add your desired style for the label
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          AddressFormField(
                            controller: _numeroController,
                            label: 'Número',
                            keyboardType: TextInputType.number,
                          ),
                        ],
                      ),
                      const VerticalSpacerBox(size: SpacerSize.small),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'CEP',
                            style: TextStyle(
                              // Add your desired style for the label
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextField(
                            controller: _cepController,
                            keyboardType: TextInputType.number,
                            inputFormatters: [_cepMaskFormatter],
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: kBackgroundColor,
                              contentPadding:
                                  const EdgeInsets.fromLTRB(13, 13, 13, 13),
                            ),
                          ),
                        ],
                      ),
                      const VerticalSpacerBox(size: SpacerSize.small),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Complemento',
                            style: TextStyle(
                              // Add your desired style for the label
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          AddressFormField(
                            controller: _complementoController,
                            label: 'Complemento',
                            keyboardType: TextInputType.text,
                          ),
                        ],
                      ),
                      const VerticalSpacerBox(size: SpacerSize.large),
                      PrimaryButton(
                        text: 'Salvar',
                        onPressed: () {
                          if (validateEmptyFields()) {
                            _updateEndereco();
                          }
                        },
                        color: kDetailColor,
                      ),
                    ],
                  ),
                ),
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
