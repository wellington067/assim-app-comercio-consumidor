import 'package:ecommerceassim/shared/constants/app_enums.dart';
import 'package:ecommerceassim/shared/constants/app_text_constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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

  SignUpRepository signUpRepository = SignUpRepository();

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
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erro ao atualizar endereço.')),
      );
    }
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
              const VerticalSpacerBox(size: SpacerSize.large),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Form(
                  child: Column(
                    children: [
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
                        decoration: const InputDecoration(
                          labelText: 'Cidade',
                        ),
                      ),
                      const VerticalSpacerBox(size: SpacerSize.small),
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
                        decoration: const InputDecoration(
                          labelText: 'Bairro',
                        ),
                      ),
                      AddressFormField(
                        controller: _ruaController,
                        label: 'Rua',
                        keyboardType: TextInputType.text,
                      ),
                      const VerticalSpacerBox(size: SpacerSize.small),
                      AddressFormField(
                        controller: _numeroController,
                        label: 'Número',
                        keyboardType: TextInputType.number,
                      ),
                      const VerticalSpacerBox(size: SpacerSize.small),
                      AddressFormField(
                        controller: _cepController,
                        label: 'CEP',
                        keyboardType: TextInputType.number,
                      ),
                      const VerticalSpacerBox(size: SpacerSize.small),
                      AddressFormField(
                        controller: _complementoController,
                        label: 'Complemento',
                        keyboardType: TextInputType.text,
                      ),
                      const VerticalSpacerBox(size: SpacerSize.large),
                      PrimaryButton(
                        text: 'Salvar',
                        onPressed: _updateEndereco,
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
