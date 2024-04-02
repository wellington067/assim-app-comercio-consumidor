// ignore_for_file: must_be_immutable

import 'package:ecommerceassim/shared/constants/style_constants.dart';
import 'package:ecommerceassim/shared/core/models/cidade_model.dart';
import 'package:flutter/material.dart';

import '../../../components/forms/custom_text_form_field.dart';
import '../../../components/utils/vertical_spacer_box.dart';
import '../../../shared/constants/app_enums.dart';
import '../../../shared/core/models/bairro_model.dart';
import '../../../shared/core/controllers/sign_up_controller.dart';

class InfoSecondScreen extends StatelessWidget {
  late SignUpController controller;
  InfoSecondScreen(this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const VerticalSpacerBox(size: SpacerSize.small),
        DropdownButtonFormField<CidadeModel>(
          isExpanded: true,
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.home),
            border: InputBorder.none,
            filled: true,
            fillColor: kBackgroundColor,
          ),
          style: Theme.of(context).textTheme.titleLarge,
          hint: const Text('Cidade'),
          value: null,
          items: controller.cidades.map((obj) {
            return DropdownMenuItem<CidadeModel>(
              value: obj,
              child: Text(obj.nome.toString()),
            );
          }).toList(),
          onChanged: (selectedObj) {
            controller.cidadeId = selectedObj!.id!.toInt();
          },
        ),
        const VerticalSpacerBox(size: SpacerSize.small),
        DropdownButtonFormField<BairroModel>(
          isExpanded: true,
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.location_city_sharp),
            border: InputBorder.none,
            filled: true,
            fillColor: kBackgroundColor,
          ),
          style: Theme.of(context).textTheme.titleLarge,
          hint: const Text('Bairro'),
          value: null,
          items: controller.bairros.map((obj) {
            return DropdownMenuItem<BairroModel>(
              value: obj,
              child: Text(obj.nome.toString()),
            );
          }).toList(),
          onChanged: (selectedObj) {
            controller.bairroId = selectedObj!.id!.toInt();
          },
        ),
        const VerticalSpacerBox(size: SpacerSize.small),
        CustomTextFormField(
          hintText: 'Rua',
          icon: Icons.location_city_sharp,
          controller: controller.ruaController,
        ),
        const VerticalSpacerBox(size: SpacerSize.small),
        CustomTextFormField(
          hintText: 'CEP',
          icon: Icons.numbers_outlined,
          maskFormatter: controller.cepFormatter,
          controller: controller.cepController,
        ),
        const VerticalSpacerBox(size: SpacerSize.small),
        CustomTextFormField(
          keyboardType: TextInputType.number,
          hintText: 'Número',
          icon: Icons.home_filled,
          controller: controller.numeroController,
        ),
        const VerticalSpacerBox(size: SpacerSize.small),
      ],
    );
  }
}
