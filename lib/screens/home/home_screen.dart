import 'package:ecommerceassim/components/appBar/custom_app_bar.dart';
import 'package:ecommerceassim/screens/feiras/feiras_screen.dart';
import 'package:ecommerceassim/shared/core/controllers/home_screen_controller.dart';
import 'package:ecommerceassim/shared/components/BottomNavigation.dart';
import 'package:ecommerceassim/shared/constants/style_constants.dart';
import 'package:ecommerceassim/shared/core/user_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    int selectedIndex = 0;
    Size size = MediaQuery.of(context).size;
    return ChangeNotifierProvider(
      create: (_) => HomeScreenController(),
      builder: (context, child) => Consumer<HomeScreenController>(
        builder: ((context, controller, child) => Scaffold(
              appBar: const CustomAppBar(),
              bottomNavigationBar:
                  BottomNavigation(selectedIndex: selectedIndex),
              body: Container(
                color: kOnSurfaceColor,
                width: size.width,
                padding: const EdgeInsets.all(20),
                child: const FeirasScreen(),
              ),
            )),
      ),
    );
  }
}
