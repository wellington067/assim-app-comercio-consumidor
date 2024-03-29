// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:ecommerceassim/components/forms/custom_text_form_field.dart';
import 'package:ecommerceassim/shared/constants/app_text_constants.dart';
import 'package:ecommerceassim/shared/constants/style_constants.dart';
import 'package:flutter/material.dart';
import 'package:ecommerceassim/components/appBar/custom_app_bar.dart';
import 'package:ecommerceassim/shared/components/BottomNavigation.dart';
import 'package:ecommerceassim/shared/core/user_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({super.key});

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  final UserStorage userStorage = UserStorage();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  var phoneFormatter = MaskTextInputFormatter(
    mask: '(##) #####-####',
    filter: {"#": RegExp(r'[0-9]')},
  );

  bool isEditing = false;
  int selectedIndex = 3;

  String originalName = '';
  String originalPhone = '';

  @override
  void initState() {
    super.initState();
    loadUserDetails();
  }

  void loadUserDetails() async {
    try {
      final String userId = await userStorage.getUserId();
      final String token = await userStorage.getUserToken();
      final Uri url = Uri.parse('$kBaseURL/users/$userId');

      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final user = data['user'];
        final contact = user['contato'];

        setState(() {
          originalName = user['name'];
          originalPhone = contact['telefone'];
          nameController.text = originalName;
          phoneController.text = originalPhone;
        });
      } else {
        print(
            'Failed to load user details. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching user details: $e');
    }
  }

  Future<void> saveUserProfile(String newName, String newPhone) async {
    final String oldName = nameController.text;
    final String oldPhone = phoneController.text;

    try {
      final String userId = await userStorage.getUserId();
      final String token = await userStorage.getUserToken();
      final Uri url = Uri.parse('$kBaseURL/users/$userId');
      final response = await http.patch(
        url,
        body: json.encode({'name': newName, 'telefone': newPhone}),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Colors.white,
              title: const Text(
                'Sucesso!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: kDetailColor,
                ),
              ),
              content: const Text(
                'Perfil atualizado com sucesso!',
                textAlign: TextAlign.center,
              ),
              actions: <Widget>[
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: kDetailColor,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'Ok',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      } else {
        showErrorDialog(
            context, 'Erro ao atualizar perfil. Tente novamente mais tarde.');
        revertChanges(oldName, oldPhone);
      }
    } catch (e) {
      showErrorDialog(context, 'Ocorreu um erro ao atualizar o perfil: $e');
      revertChanges(oldName, oldPhone);
    }
  }

  void showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text(
            'Erro!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
          content: Text(
            message,
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Ok',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void revertChanges(String oldName, String oldPhone) {
    setState(() {
      nameController.text = oldName;
      phoneController.text = oldPhone;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      bottomNavigationBar: BottomNavigation(selectedIndex: selectedIndex),
      body: Material(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.grey.shade300,
                      child: const Icon(
                        Icons.person,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text('Nome',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    CustomTextFormField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: kDetailColor),
                        ),
                      ),
                      enabled: isEditing,
                    ),
                    const SizedBox(height: 16),
                    const Text('Telefone',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    CustomTextFormField(
                      controller: phoneController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: kDetailColor),
                        ),
                      ),
                      keyboardType: TextInputType.phone,
                      maskFormatter: phoneFormatter,
                      enabled: isEditing,
                    ),
                  ],
                ),
              ),
              if (!isEditing)
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isEditing = true;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: kDetailColor,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    side: const BorderSide(color: kDetailColor),
                    fixedSize: const Size.fromHeight(50),
                  ),
                  child: const Text('Editar Perfil',
                      style: TextStyle(fontSize: 18)),
                ),
              if (isEditing)
                ElevatedButton(
                  onPressed: () {
                    saveUserProfile(nameController.text, phoneController.text);
                    setState(() {
                      isEditing = false; // Sai do modo de edição
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: kDetailColor,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    side: const BorderSide(color: kDetailColor),
                    fixedSize: const Size.fromHeight(50),
                  ),
                  child: const Text('Salvar', style: TextStyle(fontSize: 18)),
                ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
