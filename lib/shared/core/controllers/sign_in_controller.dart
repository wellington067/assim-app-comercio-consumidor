// ignore_for_file: use_build_context_synchronously

import 'package:ecommerceassim/screens/screens_index.dart';
import 'package:ecommerceassim/shared/core/repositories/sign_in_repository.dart';
import 'package:flutter/material.dart';

enum SignInStatus {
  done,
  error,
  loading,
  idle,
}

class SignInController with ChangeNotifier {
  final SignInRepository _repository = SignInRepository();
  String? email;
  String? password;
  String? _userName;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? errorMessage;
  String? get userName => _userName;
  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;
  var status = SignInStatus.idle;
  void signIn(BuildContext context) async {
    try {
      // Verifica se os campos de email e senha estão preenchidos
      if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
        throw Exception("Por favor, forneça seu email e senha.");
      }

      status = SignInStatus.loading;
      notifyListeners();

      // Tenta fazer o login e obtém o token do usuário
      var userToken = await _repository.signIn(
        email: _emailController.text,
        password: _passwordController.text,
      );

      // Verifica se o token do usuário é nulo ou vazio
      if (userToken == null) {
        throw Exception(
            "Não foi possível obter o token do usuário. Por favor, tente novamente.");
      }

      status = SignInStatus.done;
      notifyListeners();

      // Se o token do usuário for válido, navega para a tela home
      Navigator.pushReplacementNamed(context, Screens.home,
          arguments: userToken);
    } catch (e) {
      status = SignInStatus.error;
      notifyListeners();

      // Define uma pequena espera antes de alterar o status para 'idle'
      await Future.delayed(const Duration(milliseconds: 500));
      status = SignInStatus.idle;

      // Ajusta a mensagem de erro com base no tipo de exceção
      if (e is Exception) {
        setErrorMessage(e.toString());
      } else {
        setErrorMessage('Credenciais inválidas. Verifique seus dados.');
      }
      notifyListeners();
    }
  }

  void logout(BuildContext context) {
    String? displayName = _userName ?? email?.split('@').first;

    email = null;
    password = null;
    _userName = null;
    _emailController.clear();
    _passwordController.clear();
    errorMessage = null;

    status = SignInStatus.idle;
    notifyListeners();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Você foi desconectado.'),
      ),
    );
    Navigator.pushReplacementNamed(context, Screens.first,
        arguments: displayName);
  }

  void setErrorMessage(String value) async {
    errorMessage = value;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 2));
    errorMessage = null;
    notifyListeners();
  }
}
