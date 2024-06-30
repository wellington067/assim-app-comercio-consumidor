import 'package:flutter/material.dart';
import 'package:ecommerceassim/shared/constants/style_constants.dart';

/* import 'package:ecommerceassim/shared/core/user_storage.dart';
 */
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool automaticallyImplyLeading;

  const CustomAppBar({super.key, this.automaticallyImplyLeading = false});

  @override
  Widget build(BuildContext context) {
/*     final UserStorage userStorage = UserStorage(); */

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
      /* actions: <Widget>[
        IconButton(
          icon: const Icon(
            Icons.exit_to_app,
            color: kDetailColor,
          ),
          onPressed: () async {
            await userStorage.clearUserCredentials();

            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => SignInScreen()),
              (Route<dynamic> route) => false,
            );
          },
        ),
      ], */
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
