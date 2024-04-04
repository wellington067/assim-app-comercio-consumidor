import 'package:brasil_fields/brasil_fields.dart';
import 'package:ecommerceassim/shared/core/models/bairro_model.dart';
import 'package:ecommerceassim/shared/core/models/cidade_model.dart';

mixin ValidationMixin {
  final RegExp nameRegExp = RegExp(r'^[a-zA-ZÀ-ÿ ]+$');

  isValidName(value) {
    if (value.isEmpty) {
      return 'Por favor, digite seu nome.';
    } else if (!nameRegExp.hasMatch(value)) {
      return 'Por favor, insira caracteres válidos.';
    } else if (value.length <= 3) {
      return 'Nome tem que ter no minimo 4 caracteres.';
    }
    return null;
  }

  isValidCpf(value) {
    if (value.isEmpty) {
      return 'Por favor, digite um CPF.';
    } else if (value.length != 14) {
      return 'CPF deve conter 11 dígitos.';
    } else if (RegExp(r'^(\d)\1*$').hasMatch(value)) {
      return 'CPF inválido.';
    } else if (!CPFValidator.isValid(value)) {
      return 'CPF inválido.';
    }
    return null;
  }

  isValidEmail(value) {
    if (value.isEmpty) {
      return 'Por favor, insira um E-mail.';
    } else if (!value.contains('@')) {
      return 'E-mail deve conter o simbolo "@".';
    } else if (!value.contains('.com')) {
      return 'E-mail deve conter o ".com" no final.';
    }
    return null;
  }

  isValidPhone(value) {
    List<String> validDDDCodes = ['11', '12', '13', '14', '15', '16', '17', '18', '19',
                                 '21', '22', '24', '27', '28', '31', '32', '33', '34',
                                 '35', '37', '38', '41', '42', '43', '44', '45', '46',
                                 '47', '48', '49', '51', '53', '54', '55', '61', '62',
                                 '63', '64', '65', '66', '67', '68', '69', '71', '73',
                                 '74', '75', '77', '79', '81', '82', '83', '84', '85',
                                 '86', '87', '88', '89', '91', '92', '93', '94', '95',
                                 '96', '97', '98', '99'];
    if (value.isEmpty) {
      return 'Por favor, informe um número de telefone.';
    } else if (value.length != 15) {
      return 'Número deve conter 10 ou 11 digitos.';
    } else if (!validDDDCodes.contains(value.substring(1, 3))) {
      return 'DDD inválido.';
    }
    return null;
  }

  isValidPassword(value) {
    if (value.isEmpty) {
      return 'Por favor, informe uma senha.';
    } else if (value.length < 8) {
      return 'A senha deve ter no minimo 8 caracteres.';
    }
    return null;
  }

  isValidCidade(CidadeModel? value){
    if(value == null){
      return 'Selecione uma opção.';
    }
    return null;
  }

  isValidBairro(BairroModel? value){
    if(value == null){
      return 'Selecione uma opção.';
    }
    return null;
  }

  isValidRua(value) {
    if (value.isEmpty) {
      return 'Informe o nome da rua.';
    }
    return null;
  }

  isValidCEP(value) {
    if (value.isEmpty) {
      return 'Informe seu CEP.';
    }
    return null;
  }

  isValidNumero(value) {
    if (value.isEmpty) {
      return 'Informe o número.';
    }
    return null;
  }

  isValidComplemento(value) {
    if (value.isEmpty) {
      return 'Informe um complemento.';
    }
    return null;
  }
}
