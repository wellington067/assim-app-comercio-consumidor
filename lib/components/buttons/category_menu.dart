import 'package:ecommerceassim/assets/index.dart';
import 'package:ecommerceassim/screens/screens_index.dart';
import 'package:flutter/material.dart';
import 'package:ecommerceassim/shared/constants/style_constants.dart';

class CategoryMenu extends StatelessWidget {
  final String categoryName;
  final String assetPath;

  const CategoryMenu({
    super.key,
    required this.categoryName,
    required this.assetPath,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, Screens.menu);
      },
      child: Container(
        width: 64,
        height: 70,
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Image.asset(
                assetPath,
                fit: BoxFit.cover,
                height: 25,
                color: Colors.white,
              ),
            ),
            Text(
              categoryName,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryMenuList extends StatelessWidget {
  const CategoryMenuList({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> categories = [
      {"categoryName": "Vegetais", "assetPath": Assets.vegetais},
      {"categoryName": "Frutas", "assetPath": Assets.frutas},
      {"categoryName": "Folhosos", "assetPath": Assets.folhosos},
      {"categoryName": "Carnes", "assetPath": Assets.carnes},
      {"categoryName": "Leite e Ovos", "assetPath": Assets.leiteOvos},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: (64 / 70),
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return CategoryMenu(
            categoryName: categories[index]["categoryName"]!,
            assetPath: categories[index]["assetPath"]!,
          );
        },
      ),
    );
  }
}
