import 'package:device_preview/device_preview.dart';
import 'package:ecommerceassim/screens/banca/banca_screen.dart';
import 'package:ecommerceassim/screens/feiras/feiras_screen.dart';
import 'package:ecommerceassim/screens/first/first_screen.dart';
import 'package:ecommerceassim/screens/cesta/cart.screen.dart';
import 'package:ecommerceassim/screens/favorito/favorite_screen.dart';
import 'package:ecommerceassim/screens/favorito/favorite_seller_screen.dart';
import 'package:ecommerceassim/screens/produto/detalhes/products_details_screen.dart';
import 'package:ecommerceassim/screens/produto/products_screen.dart';
import 'package:ecommerceassim/screens/pedidos/finalizar/finalize_purchase_screen.dart';
import 'package:ecommerceassim/screens/home/home_screen.dart';
import 'package:ecommerceassim/screens/profile/endereco/adress_screen.dart';
import 'package:ecommerceassim/screens/profile/editar/profile_edit_screen.dart';
import 'package:ecommerceassim/screens/profile/profile_screen.dart';
import 'package:ecommerceassim/screens/profile/endereco/select_adress_screen.dart';
import 'package:ecommerceassim/screens/signup/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:ecommerceassim/screens/screens_index.dart';
import 'screens/pedidos/purchases_screen.dart';
import 'screens/signin/sign_in_screen.dart';
import 'screens/splash/splash_screen.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // ignore: deprecated_member_use
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: (context, child) {
        return DevicePreview.appBuilder(
          context,
          ResponsiveBreakpoints.builder(
            child: child!,
            breakpoints: [
              const Breakpoint(start: 0, end: 450, name: MOBILE),
              const Breakpoint(start: 451, end: 800, name: TABLET),
              const Breakpoint(start: 801, end: 1920, name: DESKTOP),
              const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
            ],
          ),
        );
      },
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      routes: {
        Screens.splash: (BuildContext context) => const SplashScreen(),
        // Screens.carrousel: (BuildContext context) => const CarrouselScreen(),
        Screens.home: (BuildContext context) => const HomeScreen(),
        Screens.signin: (BuildContext context) => const SignInScreen(),
        Screens.register: (BuildContext context) => const SignUpScreen(),
        Screens.first: (BuildContext context) => const FirstScreen(),
        Screens.profile: (BuildContext context) => const ProfileScreen(),
        Screens.favorite: (BuildContext context) => const FavoriteScreen(),
        Screens.purchases: (BuildContext context) => const PurchasesScreen(),
        Screens.adress: (BuildContext context) => const AdressScreen(),
        Screens.selectAdress: (BuildContext context) => const SelectAdress(),
        Screens.menuSeller: (BuildContext context) => const MenuSellerScreen(),
        Screens.menuProducts: (BuildContext context) =>
            const MenuProductsScreen(),
        Screens.cart: (BuildContext context) => const CartScreen(),
        Screens.feiras: (BuildContext context) => const FeirasScreen(),
        Screens.bancas: (BuildContext context) => const Bancas(),
        Screens.produtoDetalhe: (BuildContext context) =>
            const ProdutoDetalheScreen(),
        Screens.perfilEditar: (BuildContext context) =>
            const ProfileEditScreen(),
        Screens.finalizePurchase: (BuildContext context) =>
            const FinalizePurchaseScreen(),
      },
    );
  }
}
