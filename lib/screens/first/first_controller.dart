import 'package:ecommerceassim/screens/first/first_repository.dart';
import 'package:ecommerceassim/shared/core/user_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../shared/core/navigator.dart';
import '../screens_index.dart';

class FirstController extends GetxController {
  UserStorage userStorage = UserStorage();
  FirstRepository firstRepository = FirstRepository();
  String? userToken;
  String? userId;
  String userName = 'teste';

  Future StartVeri(BuildContext context) async {
    var succ = await firstRepository.Start(
      userToken = await userStorage.getUserToken(),
      userId = await userStorage.getUserId(),
    );
    if (succ == 1) {
      navigatorKey.currentState!.pushReplacementNamed(Screens.home);
      print('home');
    } else {
      print('erro');
    }
  }

  Future getUserName() async {
    userName = await userStorage.getUserName();
    update();
  }

  @override
  void onInit() {
    super.onInit();
    getUserName();
  }
}
