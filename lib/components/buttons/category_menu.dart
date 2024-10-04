import 'package:ecommerceassim/assets/index.dart';
import 'package:ecommerceassim/components/spacer/verticalSpacer.dart';
import 'package:ecommerceassim/shared/constants/style_constants.dart';
import 'package:ecommerceassim/shared/core/controllers/products_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryMenu extends StatelessWidget {
  final String categoryName;
  final String assetPath;
  final VoidCallback onTap;

  const CategoryMenu({
    super.key,
    required this.categoryName,
    required this.assetPath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 75,
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
                height: categoryName == "Mel" ? 20 : 25,
                color: Colors.white,
              ),
            ),
            if (categoryName != "Plantas/Ervas Medicinais" &&
                categoryName != "Polpa de Frutas" &&
                categoryName != "Produtos Beneficiados")
              const Padding(padding: EdgeInsets.only(top: 12.0)),
            if (categoryName == "Polpa de Frutas" ||
                categoryName == "Produtos Beneficiados")
              const Padding(padding: EdgeInsets.only(top: 4.0)),
            if (categoryName == "Mel")
              const Padding(padding: EdgeInsets.only(top: 5.0)),
            if (categoryName == "Plantas/Ervas Medicinais")
              const VerticalSpacer(size: 5),
            Text(
              categoryName,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryMenuList extends StatefulWidget {
  const CategoryMenuList({super.key});

  @override
  _CategoryMenuListState createState() => _CategoryMenuListState();
}

class _CategoryMenuListState extends State<CategoryMenuList> {
  late ProductsController produtoController;

  @override
  void initState() {
    super.initState();
    produtoController = Get.find<ProductsController>();
    produtoController.addListener(() {
      setState(() {}); // Recarrega a tela quando o estado muda
    });
  }

  @override
  void dispose() {
    produtoController.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final availableCategories = produtoController.getAvailableCategories();

    final List<Map<String, String>> categories = [
      {"categoryName": "Todos", "assetPath": Assets.shoppingBag},
      {"categoryName": "Mel", "assetPath": Assets.mel},
      {"categoryName": "Legumes", "assetPath": Assets.vegetais},
      {"categoryName": "Polpa de Frutas", "assetPath": Assets.polpa},
      {"categoryName": "Grãos", "assetPath": Assets.graos},
      {"categoryName": "Verduras", "assetPath": Assets.folhosos},
      {"categoryName": "Raízes", "assetPath": Assets.raizes},
      {"categoryName": "Frutas", "assetPath": Assets.frutas},
      {
        "categoryName": "Produtos Beneficiados",
        "assetPath": Assets.beneficiados
      },
      {
        "categoryName": "Plantas/Ervas Medicinais",
        "assetPath": Assets.medicinal
      }
    ];

    void handleCategoryTap(int index) {
      if (index == 0) {
        // Exibir todos os produtos
        produtoController.filterProdutosByCategoryIndex(-1);
      } else {
        // Exibir produtos pela categoria
        produtoController.filterProdutosByCategoryIndex(index - 1);
      }
    }

    return SizedBox(
      height: 80,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: availableCategories.length + 1, // +1 para incluir "Todos"
        itemBuilder: (context, index) {
          final categoryIndex = index == 0 ? 0 : availableCategories[index - 1];
          return Padding(
            padding: EdgeInsets.only(left: index == 0 ? 22.0 : 0, right: 10.0),
            child: CategoryMenu(
              categoryName: categories[categoryIndex]["categoryName"]!,
              assetPath: categories[categoryIndex]["assetPath"]!,
              onTap: () => handleCategoryTap(categoryIndex),
            ),
          );
        },
      ),
    );
  }
}
