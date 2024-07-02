import 'package:flutter/material.dart';
import 'package:ecommerceassim/shared/constants/style_constants.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool automaticallyImplyLeading;

  const CustomAppBar({super.key, this.automaticallyImplyLeading = false});

  @override
  Widget build(BuildContext context) {

    return AppBar(
      automaticallyImplyLeading: automaticallyImplyLeading,
      title: const Text(
        "ASSIM",
        style: TextStyle(
          color: kDetailColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      iconTheme: const IconThemeData(color: kDetailColor),
      backgroundColor: kOnSurfaceColor,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
