import 'package:ecommerceassim/assets/index.dart';
import 'package:ecommerceassim/screens/screens_index.dart';
import 'package:ecommerceassim/shared/components/dialogs/finish_dialog.dart';
import 'package:ecommerceassim/shared/constants/app_enums.dart';
import 'package:flutter/material.dart';
import 'package:ecommerceassim/components/utils/horizontal_spacer_box.dart';
import 'package:ecommerceassim/components/utils/vertical_spacer_box.dart';
import 'package:ecommerceassim/shared/constants/style_constants.dart';

class CategoryMenu extends StatelessWidget {
  final String categoryName;
  final String assetPath;

  const CategoryMenu({
    Key? key,
    required this.categoryName,
    required this.assetPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, Screens.menu);
      },
      child: Container(
        width: 84,
        height: 90,
        decoration: BoxDecoration(
          color: kDetailColor,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
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
              Center(
                child: Image.asset(
                  assetPath,
                  fit: BoxFit.cover,
                  height: 48,
                  color: Colors.white,
                ),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                child: Text(
                  categoryName,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryMenuList extends StatelessWidget {
  const CategoryMenuList({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CategoryMenu(
          categoryName: 'Vegetais',
          assetPath: Assets.vegetais,
        ),
        CategoryMenu(
          categoryName: 'Frutas',
          assetPath: Assets.frutas,
        ),
        CategoryMenu(
          categoryName: 'Folhosos',
          assetPath: Assets.folhosos,
        ),
        CategoryMenu(
          categoryName: 'Carnes',
          assetPath: Assets.carnes,
        ),
        CategoryMenu(
          categoryName: 'Leite e Ovos',
          assetPath: Assets.leiteOvos,
        ),
      ],
    );
  }
}
