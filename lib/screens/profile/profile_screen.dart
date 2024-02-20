import 'package:ecommerceassim/components/navBar/custom_app_bar.dart';
import 'package:ecommerceassim/components/buttons/primary_button.dart';
import 'package:ecommerceassim/components/utils/horizontal_spacer_box.dart';
import 'package:ecommerceassim/screens/profile/components/custom_ink.dart';
import 'package:ecommerceassim/screens/screens_index.dart';
import 'package:ecommerceassim/shared/constants/app_enums.dart';
import 'package:ecommerceassim/shared/constants/app_number_constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../shared/constants/style_constants.dart';
import '../../shared/core/controllers/sign_in_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(),
        body: Container(
          color: kOnSurfaceColor,
          child: Column(
            children: [
              InkWell(
                onTap: () async {
                  Navigator.pushNamed(context, Screens.home);
                },
                child: Row(
                  children: [
                    SizedBox(
                      width: 480,
                      height: 100,
                      child: Center(
                        child: Wrap(
                          children: [
                            Row(
                              children: [
                                const HorizontalSpacerBox(
                                    size: SpacerSize.tiny),
                                const HorizontalSpacerBox(
                                    size: SpacerSize.small),
                                Container(
                                  width: 62.0,
                                  height: 62.0,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: NetworkImage(
                                          "https://upload.wikimedia.org/wikipedia/commons/b/bc/Unknown_person.jpg"),
                                    ),
                                  ),
                                ),
                                const HorizontalSpacerBox(
                                    size: SpacerSize.medium),
                                const Text(
                                  'Maria Eduarda',
                                  style: TextStyle(
                                      fontSize: 22, color: kTextButtonColor),
                                  textAlign: TextAlign.end,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              CustomInkWell(
                icon: Icons.list_alt,
                text: 'Pedidos',
                onTap: () {
                  Navigator.pushNamed(context, Screens.purchases);
                },
              ),
              CustomInkWell(
                icon: Icons.pin_drop,
                text: 'Endereços',
                onTap: () {
                  Navigator.pushNamed(context, Screens.selectAdress);
                },
              ),
              CustomInkWell(
                icon: Icons.credit_card,
                text: 'Pagamentos',
                onTap: () {
                  Navigator.pushNamed(context, Screens.selectCard);
                },
              ),
              CustomInkWell(
                icon: Icons.favorite,
                text: 'Favoritos',
                onTap: () {
                  Navigator.pushNamed(context, Screens.favorite);
                },
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.all(kDefaultPadding),
                child: PrimaryButton(
                  text: 'Sair',
                  onPressed: () {
                    Provider.of<SignInController>(context, listen: false)
                        .logout(context);
                  },
                  color: kDetailColor,
                ),
              ),
            ],
          ),
        ));
  }
}
