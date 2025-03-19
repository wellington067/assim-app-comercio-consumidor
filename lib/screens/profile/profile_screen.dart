// ignore_for_file: use_build_context_synchronously

import 'package:ecommerceassim/components/buttons/primary_button.dart';
import 'package:ecommerceassim/screens/signin/sign_in_screen.dart';
import 'package:ecommerceassim/shared/components/bottomNavigation/BottomNavigation.dart';
import 'package:ecommerceassim/shared/components/dialogs/confirm_dialog.dart';
import 'package:ecommerceassim/shared/core/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:ecommerceassim/components/appBar/custom_app_bar.dart';
import 'package:ecommerceassim/components/forms/custom_ink.dart';
import 'package:ecommerceassim/screens/screens_index.dart';
import 'package:ecommerceassim/shared/constants/style_constants.dart';
import 'package:ecommerceassim/shared/core/user_storage.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final UserStorage userStorage = UserStorage();
  String userName = '';
  bool isLoading = true;
  
  @override
  void initState() {
  super.initState();
  // Use addPostFrameCallback para adiar a operação até após a construção
  WidgetsBinding.instance.addPostFrameCallback((_) {
    _loadUserData();
  });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  Future<void> _loadUserData() async {
    setState(() {
      isLoading = true;
    });

    try {
      // Tenta carregar o nome do usuário
      final name = await userStorage.getUserName();
      setState(() {
        userName = name;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Erro ao carregar dados do usuário: $e');
    }
  }

  // Esta função é chamada quando o usuário retorna da tela de edição
  void _refreshProfile() {
    setState(() {}); // Força a reconstrução da UI
    _loadUserData(); // Recarrega os dados do usuário
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      bottomNavigationBar: BottomNavigation(
        paginaSelecionada: 3,
      ),
      body: RefreshIndicator(
        onRefresh: _loadUserData,
        child: Material(
          color: Colors.white,
          child: Column(
            children: [
              Container(
                color: kDetailColor,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.account_circle,
                        size: 60,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 16),
                      isLoading
                          ? const Text('Carregando...',
                              style: TextStyle(color: Colors.white, fontSize: 18))
                          : userName.isEmpty
                              ? const Text('Convidado',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500))
                              : Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        userName.split(' ').take(2).join(' '),
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      IconButton(
                                        icon: const Icon(
                                          Icons.edit,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                        onPressed: () async {
                                          await Navigator.pushNamed(context, Screens.perfilEditar);
                                          // Quando retornar, recarrega os dados
                                          _refreshProfile();
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    CustomInkWell(
                      icon: Icons.shopping_bag,
                      text: 'Pedidos',
                      onTap: () =>
                          Navigator.pushNamed(context, Screens.purchases),
                    ),
                    CustomInkWell(
                      icon: Icons.location_on,
                      text: 'Endereços',
                      onTap: () =>
                          Navigator.pushNamed(context, Screens.selectAdress),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8, bottom: 20),
                child: PrimaryButton(
                  text: 'Sair da conta',
                  onPressed: () {
                    confirmDialog(
                      context,
                      'Confirmação',
                      'Você tem certeza que deseja sair da conta?',
                      'Cancelar',
                      'Confirmar',
                      onConfirm: () async {
                        await userStorage.clearUserCredentials();
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => SignInScreen()),
                          (Route<dynamic> route) => false,
                        );
                      },
                    );
                  },
                  color: kDetailColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}