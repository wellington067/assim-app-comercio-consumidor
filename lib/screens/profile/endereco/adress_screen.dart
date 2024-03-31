import 'package:ecommerceassim/components/appBar/custom_app_bar.dart';
import 'package:ecommerceassim/screens/screens_index.dart';
import 'package:flutter/material.dart';
import 'package:ecommerceassim/components/forms/auth_form_field.dart';
import 'package:ecommerceassim/components/forms/auth_form_field3.dart';
import 'package:ecommerceassim/components/utils/horizontal_spacer_box.dart';

import '../../../components/buttons/primary_button.dart';
import '../../../components/forms/auth_form_field2.dart';
import '../../../components/utils/vertical_spacer_box.dart';
import '../../../shared/constants/app_enums.dart';
import '../../../shared/constants/style_constants.dart';

class AdressScreen extends StatefulWidget {
  const AdressScreen({super.key});

  @override
  State<AdressScreen> createState() => _AdressScreenState();
}

class _AdressScreenState extends State<AdressScreen> {
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
                      'Adicione um novo endereço',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const VerticalSpacerBox(size: SpacerSize.large),
                Padding(
                    padding: const EdgeInsets.all(10),
                    child: Form(
                        child: Column(children: [
                      const Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Cidade',
                              style: TextStyle(),
                            ),
                          ),
                        ],
                      ),
                      const VerticalSpacerBox(size: SpacerSize.small),
                      AuthFormField(
                        label: '',
                        isPassword: false,
                        inputType: TextInputType.text,
                        onChanged: (String value) {},
                        backgroundColor:
                            kOnBackgroundColorText, // Correctly placed within the constructor call
                      ),
                      const VerticalSpacerBox(size: SpacerSize.small),

                      const Row(
                        children: [
                          Text(
                            'Bairro',
                          ),
                        ],
                      ),
                      const VerticalSpacerBox(size: SpacerSize.small),
                      AuthFormField(
                        label: '',
                        isPassword: false,
                        inputType: TextInputType.text,
                        onChanged: (String value) {},
                        backgroundColor:
                            kOnBackgroundColorText, // Correctly placed within the constructor call
                      ),
                      const VerticalSpacerBox(size: SpacerSize.small),
                      const Row(
                        children: [
                          Text(
                            'Rua',
                          ),
                          Spacer(),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(left: 50.0),
                              child: Text(
                                'Número',
                                textAlign: TextAlign.center,
                                style: TextStyle(),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const VerticalSpacerBox(size: SpacerSize.small),
                      Row(
                        children: [
                          AuthFormField3(
                            label: '',
                            isPassword: false,
                            inputType: TextInputType.streetAddress,
                            onChanged: (String value) {},
                            backgroundColor:
                                kOnBackgroundColorText, // Correctly placed
                          ),
                          const HorizontalSpacerBox(size: SpacerSize.small),
                          AuthFormField2(
                            label: '',
                            isPassword: false,
                            inputType: TextInputType.streetAddress,
                            onChanged: (String value) {},
                            backgroundColor:
                                kOnBackgroundColorText, // Correctly placed
                          ),
                        ],
                      ),
// Repeat this correction for all instances where you are using these widgets

                      const VerticalSpacerBox(size: SpacerSize.small),

                      const VerticalSpacerBox(size: SpacerSize.small),
                      const Row(
                        children: [
                          Text(
                            'Complemento',
                          ),
                        ],
                      ),
                      const VerticalSpacerBox(size: SpacerSize.small),
                      AuthFormField(
                        label: '',
                        isPassword: false,
                        inputType: TextInputType.text,
                        onChanged: (String value) {},
                        backgroundColor:
                            kOnBackgroundColorText, // Correctly placed within the constructor call
                      ),
                      const VerticalSpacerBox(size: SpacerSize.small),
                      const Row(
                        children: [
                          Text(
                            'CEP',
                          ),
                        ],
                      ),
                      const VerticalSpacerBox(size: SpacerSize.small),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: AuthFormField3(
                          label: '',
                          isPassword: false,
                          inputType: TextInputType.streetAddress,
                          onChanged: (String value) {},
                          backgroundColor:
                              kOnBackgroundColorText, // Correctly placed
                        ),
                      ),
                      const VerticalSpacerBox(size: SpacerSize.large),
                      const VerticalSpacerBox(size: SpacerSize.large),
                      PrimaryButton(
                        text: 'Salvar',
                        onPressed: () {
                          Navigator.pushNamed(context, Screens.selectAdress);
                        },
                        color: kDetailColor,
                      ),
                    ])))
              ],
            ),
          )),
    );
  }
}
