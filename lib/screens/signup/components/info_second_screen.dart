// ignore_for_file: must_be_immutable

import 'package:ecommerceassim/shared/constants/style_constants.dart';
import 'package:ecommerceassim/shared/core/models/cidade_model.dart';
import 'package:ecommerceassim/shared/validation/validate_mixin.dart';
import 'package:flutter/material.dart';
import '../../../components/forms/custom_text_form_field.dart';
import '../../../components/utils/vertical_spacer_box.dart';
import '../../../shared/constants/app_enums.dart';
import '../../../shared/core/models/bairro_model.dart';
import '../../../shared/core/controllers/sign_up_controller.dart';

class InfoSecondScreen extends StatelessWidget with ValidationMixin {
  late SignUpController controller;
  late ValidationMixin validate;

  InfoSecondScreen(this.controller, {super.key});

  final double formFieldHeight = 48.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const VerticalSpacerBox(size: SpacerSize.small),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: kBackgroundColor,
          ),
          child: DropdownButtonFormField<CidadeModel>(
            isExpanded: true,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.home),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: kBackgroundColor,
              contentPadding:
                  EdgeInsets.symmetric(vertical: formFieldHeight / 7),
            ),
            style:
                Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 18),
            hint: const Text('Cidade'),
            value: controller.selectedCidade,
            items: controller.cidades.map((cidade) {
              return DropdownMenuItem<CidadeModel>(
                value: cidade,
                child: Text(cidade.nome.toString(),
                    style: const TextStyle(fontSize: 16)),
              );
            }).toList(),
            onChanged: (CidadeModel? newValue) {
              // controller.cidadeId = newValue!.id!.toInt();
              controller.setCidade(newValue);
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) => isValidCidade(value),
          ),
        ),
        const VerticalSpacerBox(size: SpacerSize.small),
        DropdownButtonFormField<BairroModel>(
          isExpanded: true,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.location_city_sharp),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: kBackgroundColor,
            contentPadding: EdgeInsets.symmetric(vertical: formFieldHeight / 4),
          ),
          style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 16),
          hint: const Text('Bairro'),
          value: controller.selectedBairro,
          items: controller.bairros.map((bairro) {
            return DropdownMenuItem<BairroModel>(
              value: bairro,
              child: Text(bairro.nome.toString(),
                  style: const TextStyle(fontSize: 16)),
            );
          }).toList(),
          onChanged: (BairroModel? newValue) {
            // controller.bairroId = newValue!.id!.toInt(); // Estava assim antes
            controller.setBairro(newValue);
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) => isValidBairro(value),
        ),
        const VerticalSpacerBox(size: SpacerSize.small),
        CustomTextFormField(
          hintText: 'Rua',
          icon: Icons.location_city_sharp,
          controller: controller.ruaController,
          validateForm: (value) => isValidRua(value),
        ),
        const VerticalSpacerBox(size: SpacerSize.small),
        CustomTextFormField(
          hintText: 'CEP',
          icon: Icons.numbers_outlined,
          maskFormatter: controller.cepFormatter,
          controller: controller.cepController,
          validateForm: (value) => isValidCEP(value),
        ),
        const VerticalSpacerBox(size: SpacerSize.small),
        CustomTextFormField(
          keyboardType: TextInputType.number,
          hintText: 'Número',
          icon: Icons.home_filled,
          controller: controller.numeroController,
          validateForm: (value) => isValidNumero(value),
        ),
        const VerticalSpacerBox(size: SpacerSize.small),
        CustomTextFormField(
          keyboardType: TextInputType.text,
          hintText: 'Complemento',
          icon: Icons.home_work,
          controller: controller.complementoController,
          validateForm: (value) => isValidComplemento(value),
        ),
        const VerticalSpacerBox(size: SpacerSize.small),
      ],
    );
  }
}
