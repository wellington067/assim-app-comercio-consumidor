import 'package:ecommerceassim/screens/screens_index.dart';
import 'package:ecommerceassim/shared/core/repositories/sign_in_repository.dart';
import 'package:flutter/cupertino.dart';
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
      status = SignInStatus.loading;
      notifyListeners();

      var succ = await _repository.signIn(
        email: _emailController.text,
        password: _passwordController.text,
      );
      if (succ == 1) {
        status = SignInStatus.done;
        _userName = _emailController.text.split('@').first;
        notifyListeners();

        // ignore: use_build_context_synchronously
        Navigator.pushReplacementNamed(context, Screens.home);
      } else {
        status = SignInStatus.error;
        setErrorMessage('Credenciais inválidas, verifique seus dados');
        notifyListeners();
      }
      notifyListeners();
    } catch (e) {
      status = SignInStatus.error;
      setErrorMessage('Credenciais inválidas verifique seus dados');
      notifyListeners();
    }
  }

  void logout(BuildContext context) {
    // Save the display name before clearing other information
    String? displayName = _userName ?? email?.split('@').first;

    // Clear all user data
    email = null;
    password = null;
    _userName = null;
    _emailController.clear();
    _passwordController.clear();
    errorMessage = null;

    // Update UI
    status = SignInStatus.idle;
    notifyListeners();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('You have been logged out.'),
      ),
    );
    // Pass the displayName to the route
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
