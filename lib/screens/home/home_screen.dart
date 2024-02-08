import 'package:ecommerceassim/components/navBar/custom_app_bar.dart';
import 'package:ecommerceassim/components/utils/vertical_spacer_box.dart';
import 'package:ecommerceassim/screens/banca/banca_screen.dart';
import 'package:ecommerceassim/screens/feiras/feiras_screen.dart';
import 'package:ecommerceassim/shared/core/controllers/home_screen_controller.dart';
import 'package:ecommerceassim/shared/components/BottomNavigation.dart';
import 'package:ecommerceassim/shared/constants/app_enums.dart';
import 'package:ecommerceassim/shared/constants/style_constants.dart';
import 'package:ecommerceassim/shared/core/user_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    UserStorage userStorage = UserStorage();

    final whats =
        Uri.parse('https://api.whatsapp.com/send?phone=5581997128484');
    int selectedIndex = 0;
    Size size = MediaQuery.of(context).size;
    return ChangeNotifierProvider(
      create: (_) => HomeScreenController(),
      builder: (context, child) => Consumer<HomeScreenController>(
        builder: ((context, controller, child) => Scaffold(
              appBar: const CustomAppBar(),
              endDrawer: buildCustomDrawer(context),
              bottomNavigationBar:
                  BottomNavigation(selectedIndex: selectedIndex),
              body: Container(
                color: kOnSurfaceColor,
                width: size.width,
                padding: const EdgeInsets.all(20),
                child: FeirasScreen(),
              ),
            )),
      ),
    );
  }
}
