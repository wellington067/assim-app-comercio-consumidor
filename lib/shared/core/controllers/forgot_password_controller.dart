import 'package:flutter/material.dart';
import 'package:ecommerceassim/shared/core/repositories/sign_in_repository.dart';

enum ForgotPasswordStatus {
  idle,
  loading,
  done,
  error,
}

class ForgotPasswordController with ChangeNotifier {
  final SignInRepository _repository = SignInRepository();
  String? errorMessage;
  var status = ForgotPasswordStatus.idle;

  final TextEditingController emailController = TextEditingController();

  Future<void> sendResetPasswordEmail() async {
    try {
      if (emailController.text.isEmpty) {
        throw Exception("Por favor, forneça seu email.");
      }

      status = ForgotPasswordStatus.loading;
      notifyListeners();

      // Vamos tentar enviar o email diretamente, sem verificação prévia
      await _repository.sendResetPasswordEmail(emailController.text);

      if (!emailController.hasListeners) return;
      status = ForgotPasswordStatus.done;
      notifyListeners();
    } catch (e) {
      if (!emailController.hasListeners) return;
      status = ForgotPasswordStatus.error;
      notifyListeners();
      
      String errorMsg = e is Exception
        ? e.toString().replaceAll('Exception: ', '')
        : 'Falha ao enviar email de redefinição de senha. Tente novamente mais tarde.';
      
      setErrorMessage(errorMsg);
      throw e;
    }
  }

  void setErrorMessage(String value) async {
    errorMessage = value;
    notifyListeners();
    
    await Future.delayed(const Duration(seconds: 3));
    
    if (!emailController.hasListeners) return;
    errorMessage = null;
    status = ForgotPasswordStatus.idle;
    notifyListeners();
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }
}