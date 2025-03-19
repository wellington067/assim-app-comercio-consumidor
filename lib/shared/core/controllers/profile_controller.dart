// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ecommerceassim/shared/constants/app_text_constants.dart';
import 'package:ecommerceassim/shared/core/models/endereco_model.dart';
import 'package:ecommerceassim/shared/core/user_storage.dart';
import 'package:http/http.dart' as http;

class ProfileController with ChangeNotifier {
  List<AddressModel> addresses = [];
  Map<int, String> bairros = {};
  Map<int, String> cidades = {};
  Map<int, int> bairroToCidadeId = {};
  bool isLoading = false;

  final UserStorage _userStorage = UserStorage();
  final Dio _dio = Dio();

  // Inicializar com configurações comuns
  ProfileController() {
    _dio.options.validateStatus = (status) {
      return status! < 500;
    };
    _dio.options.connectTimeout = const Duration(seconds: 30);
    _dio.options.receiveTimeout = const Duration(seconds: 30);
  }

  Future<void> fetchUserAddresses() async {
    try {
      String userToken = await _userStorage.getUserToken();
      if (userToken.isEmpty) {
        print('Token de usuário não encontrado.');
        return;
      }
      
      await _fetchBairros(userToken);
      await _fetchCidades(userToken);
      
      final userId = await _userStorage.getUserId();
      
      final url = Uri.parse('$kBaseURL/users/enderecos');
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $userToken',
        },
      );

      if (response.statusCode == 200) {
        print('Resposta de endereços: ${response.body}');
        final List<dynamic> addressesData = json.decode(response.body);
        
        addresses = addressesData.map((json) {
          var address = AddressModel.fromJson(json);
          int bairroId = address.bairroId;
          address.bairroNome = bairros[bairroId];
          int? cidadeId = bairroToCidadeId[bairroId];
          address.cidadeId = cidadeId;
          address.cidadeNome = cidadeId != null ? cidades[cidadeId] : null;
          return address;
        }).toList();
        
        notifyListeners();
      } else {
        print('Erro ao buscar endereços: Status code ${response.statusCode}');
        print('Resposta do servidor: ${response.body}');
      }
    } catch (e) {
      print('Erro ao buscar endereços: $e');
    }
  }

  Future<bool> updateUserProfile(String name, String phone) async {
  isLoading = true;
  notifyListeners();

  try {
    String userToken = await _userStorage.getUserToken();
    String userId = await _userStorage.getUserId();
    
    if (userToken.isEmpty || userId.isEmpty) {
      print('Token ou ID de usuário não encontrado.');
      isLoading = false;
      notifyListeners();
      return false;
    }
    
    // Obter o email atual do usuário
    String email = await _userStorage.getUserEmail();
    
    // Formatar o telefone para o formato exigido "(99) 99999-9999"
    // Primeiro, remover todos os caracteres não numéricos
    String cleanPhone = phone.replaceAll(RegExp(r'[^0-9]'), '');
    
    // Depois, formatar para o padrão exigido
    String formattedPhone = cleanPhone;
    if (cleanPhone.length >= 11) {
      formattedPhone = "(${cleanPhone.substring(0, 2)}) ${cleanPhone.substring(2, 7)}-${cleanPhone.substring(7)}";
    }
    
    final url = Uri.parse('$kBaseURL/users/$userId');
    
    Map<String, dynamic> userData = {
      'name': name,
      'telefone': formattedPhone,
      'email': email,           // Campo obrigatório
      'ativo': true,            // Campo obrigatório
      'roles': [5]              // Mantém o mesmo papel do usuário
    };
    
    print('Enviando dados para atualização: $userData');
    
    final response = await http.patch(
      url,
      body: json.encode(userData),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $userToken',
      },
    );

    print('Resposta da atualização: ${response.statusCode} - ${response.body}');

    if (response.statusCode == 200) {
      // Atualiza os dados no armazenamento local
      await _userStorage.saveUserCredentials(id: userId, token: userToken, nome: name);
      
      isLoading = false;
      notifyListeners();
      return true;
    } else {
      print('Erro ao atualizar perfil: Status code ${response.statusCode}');
      print('Resposta do servidor: ${response.body}');
      isLoading = false;
      notifyListeners();
      return false;
    }
  } catch (e) {
    print('Erro ao atualizar perfil: $e');
    isLoading = false;
    notifyListeners();
    return false;
  }
}

  Future<Map<String, dynamic>> getUserProfile() async {
    isLoading = true;
    
    try {
      String userToken = await _userStorage.getUserToken();
      String userId = await _userStorage.getUserId();
      
      if (userToken.isEmpty || userId.isEmpty) {
        isLoading = false;
        notifyListeners();
        return {};
      }

      // Busca dados do usuário do servidor
      final url = Uri.parse('$kBaseURL/users/$userId');
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $userToken',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final user = data['user'];
        final contact = user['contato'];
        
        String name = user['name'] ?? '';
        String email = user['email'] ?? '';
        String phone = contact['telefone'] ?? '';
        
        // Atualiza dados locais
        await _userStorage.saveUserCredentials(id: userId, token: userToken, nome: name);
        
        isLoading = false;
        notifyListeners();
        
        return {
          'name': name,
          'email': email,
          'phone': phone
        };
      } else {
        // Se falhar, usa dados armazenados localmente
        print('Erro ao buscar dados do servidor: ${response.statusCode}');
      }
      
      isLoading = false;
      notifyListeners();
      
      // Retorna dados vazios em caso de falha
      return {};
    } catch (e) {
      print('Erro ao buscar dados do perfil: $e');
      isLoading = false;
      notifyListeners();
      return {};
    }
  }

  Future<void> _fetchBairros(String userToken) async {
    try {
      final url = Uri.parse('$kBaseURL/bairros');
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $userToken',
        },
      );

      if (response.statusCode == 200) {
        print('Resposta de bairros: ${response.body}');
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> bairrosData = data['bairros'];
        
        for (var bairro in bairrosData) {
          bairros[bairro['id']] = bairro['nome'];
          bairroToCidadeId[bairro['id']] = bairro['cidade_id'];
        }
      } else {
        print('Erro ao buscar bairros: Status code ${response.statusCode}');
        print('Resposta do servidor: ${response.body}');
      }
    } catch (e) {
      print('Erro ao buscar bairros: $e');
    }
  }

  Future<void> _fetchCidades(String userToken) async {
    try {
      final url = Uri.parse('$kBaseURL/cidades');
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $userToken',
        },
      );

      if (response.statusCode == 200) {
        print('Resposta de cidades: ${response.body}');
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> cidadesData = data['cidades'];
        
        for (var cidade in cidadesData) {
          cidades[cidade['id']] = cidade['nome'];
        }
      } else {
        print('Erro ao buscar cidades: Status code ${response.statusCode}');
        print('Resposta do servidor: ${response.body}');
      }
    } catch (e) {
      print('Erro ao buscar cidades: $e');
    }
  }
}