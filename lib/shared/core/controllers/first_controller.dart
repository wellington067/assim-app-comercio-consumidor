import 'package:ecommerceassim/shared/core/repositories/first_repository.dart';
import 'package:ecommerceassim/shared/core/user_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../navigator.dart';
import '../../../screens/screens_index.dart';

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

  String firstThreeWords(String? fullName) {
    if (fullName == null || fullName.isEmpty) return '';
    List<String> words = fullName.split(' ');
    return words.take(3).join(' ');
  }

  @override
  void onInit() {
    super.onInit();
    getUserName();
  }
}
