import 'package:flutter/material.dart';
import 'package:ecommerceassim/shared/constants/style_constants.dart';
import 'package:ecommerceassim/screens/screens_index.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        'APP-ASSIM',
        style: TextStyle(
          color: kDetailColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      iconTheme: const IconThemeData(color: kDetailColor),
      backgroundColor: kOnSurfaceColor,
      elevation: 0,
      actions: <Widget>[
        IconButton(
          icon: const Icon(
            Icons.menu,
            color: kDetailColor,
          ),
          onPressed: () {
            Navigator.pushNamed(context, Screens.profile);
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
