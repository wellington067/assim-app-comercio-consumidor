// ignore_for_file: use_build_context_synchronously, avoid_print
import 'package:ecommerceassim/components/buttons/primary_button.dart';
import 'package:ecommerceassim/components/spacer/verticalSpacer.dart';
import 'package:ecommerceassim/screens/screens_index.dart';
import 'package:ecommerceassim/shared/components/bottomNavigation/BottomNavigation.dart';
import 'package:ecommerceassim/shared/constants/app_text_constants.dart';
import 'package:ecommerceassim/shared/core/user_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:ecommerceassim/components/appBar/custom_app_bar.dart';
import 'package:ecommerceassim/shared/core/controllers/profile_controller.dart';
import 'package:ecommerceassim/shared/constants/style_constants.dart';
import '../../../components/utils/vertical_spacer_box.dart';
import '../../../shared/constants/app_enums.dart';

class SelectAddress extends StatefulWidget {
  const SelectAddress({super.key});

  @override
  State<SelectAddress> createState() => _SelectAddressState();
}

class _SelectAddressState extends State<SelectAddress> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadAddresses();
    });
  }

  Future<void> _loadAddresses() async {
    setState(() {
      _isLoading = true;
    });
    
    await context.read<ProfileController>().fetchUserAddresses();
    
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _deleteAddress(String id, String token) async {
    setState(() {
      _isLoading = true;
    });
    
    final url = '$kBaseURL/users/enderecos/$id';
    try {
      final response = await http.delete(
        Uri.parse(url),
        headers: {'Authorization': 'Bearer $token'},
      );
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Endereço excluído com sucesso'),
            backgroundColor: Colors.green,
          ),
        );
        await context.read<ProfileController>().fetchUserAddresses();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Erro ao excluir endereço'),
            backgroundColor: Colors.red,
          ),
        );
        print('Falha ao excluir endereço: ${response.statusCode}');
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Erro ao excluir endereço'),
          backgroundColor: Colors.red,
        ),
      );
      print('Erro ao excluir endereço: $error');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      bottomNavigationBar: BottomNavigation(paginaSelecionada: 3),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, Screens.adress),
        backgroundColor: kDetailColor,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: RefreshIndicator(
        onRefresh: _loadAddresses,
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Cabeçalho com título e descrição
              Container(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 15),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: kDetailColor.withOpacity(0.1),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 26,
                          color: kDetailColor,
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'Meus Endereços',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Gerencie seus endereços',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
              
              // Lista de endereços
              Expanded(
                child: _isLoading 
                ? const Center(
                    child: CircularProgressIndicator(color: kDetailColor),
                  )
                : Consumer<ProfileController>(
                    builder: (context, controller, child) {
                      if (controller.addresses.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.location_off,
                                size: 80,
                                color: Colors.grey.shade400,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Nenhum endereço cadastrado',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey.shade600,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Adicione um novo endereço',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                              const SizedBox(height: 24),
                              SizedBox(
                                width: 250,
                                child: PrimaryButton(
                                  text: "Adicionar endereço",
                                  onPressed: () => Navigator.pushNamed(
                                    context, 
                                    Screens.adress
                                  ),
                                  color: kDetailColor,
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                      
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: ListView.builder(
                          padding: const EdgeInsets.only(top: 16, bottom: 80),
                          itemCount: controller.addresses.length,
                          itemBuilder: (context, index) {
                            final address = controller.addresses[index];
                            return Card(
                              margin: const EdgeInsets.only(bottom: 16),
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: Colors.grey.shade200,
                                    width: 1,
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Cabeçalho do card
                                    Container(
                                      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                                      decoration: BoxDecoration(
                                        color: kDetailColor.withOpacity(0.08),
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(12),
                                          topRight: Radius.circular(12),
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.home,
                                            size: 22,
                                            color: kDetailColor,
                                          ),
                                          const SizedBox(width: 8),
                                          Expanded(
                                            child: Text(
                                              "${address.rua}, ${address.numero}",
                                              style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    
                                    // Conteúdo do endereço
                                    Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          // CEP
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.pin_drop_outlined,
                                                size: 16,
                                                color: Colors.grey.shade600,
                                              ),
                                              const SizedBox(width: 6),
                                              Text(
                                                "CEP: ${address.cep}",
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.grey.shade700,
                                                ),
                                              ),
                                            ],
                                          ),
                                          
                                          const SizedBox(height: 6),
                                          
                                          // Bairro
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.location_city,
                                                size: 16,
                                                color: Colors.grey.shade600,
                                              ),
                                              const SizedBox(width: 6),
                                              Text(
                                                "Bairro: ${address.bairroNome ?? 'Não informado'}",
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.grey.shade700,
                                                ),
                                              ),
                                            ],
                                          ),
                                          
                                          const SizedBox(height: 6),
                                          
                                          // Cidade
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.location_on_outlined,
                                                size: 16,
                                                color: Colors.grey.shade600,
                                              ),
                                              const SizedBox(width: 6),
                                              Text(
                                                "Cidade: ${address.cidadeNome ?? 'Não informada'}",
                                                style: TextStyle(
                                                  fontSize: 15, 
                                                  color: Colors.grey.shade700,
                                                ),
                                              ),
                                            ],
                                          ),
                                          
                                          // Complemento (se existir)
                                          if (address.complemento != null && address.complemento!.isNotEmpty) ...[
                                            const SizedBox(height: 6),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.apartment,
                                                  size: 16,
                                                  color: Colors.grey.shade600,
                                                ),
                                                const SizedBox(width: 6),
                                                Expanded(
                                                  child: Text(
                                                    "Complemento: ${address.complemento}",
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.grey.shade700,
                                                    ),
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                          
                                          const SizedBox(height: 16),
                                          
                                          // Botões de ação
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              // Botão de editar
                                              OutlinedButton.icon(
                                                onPressed: () {
                                                  Navigator.pushNamed(
                                                    context,
                                                    Screens.addressEdit,
                                                    arguments: {
                                                      'id': address.id,
                                                      'rua': address.rua,
                                                      'numero': address.numero,
                                                      'cep': address.cep,
                                                      'complemento': address.complemento,
                                                      'bairroId': address.bairroId,
                                                      'cidadeId': address.cidadeId,
                                                      'bairroNome': address.bairroNome,
                                                      'cidadeNome': address.cidadeNome,
                                                    },
                                                  );
                                                },
                                                style: OutlinedButton.styleFrom(
                                                  foregroundColor: kDetailColor,
                                                  side: const BorderSide(color: kDetailColor),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(8),
                                                  ),
                                                ),
                                                icon: const Icon(Icons.edit, size: 18),
                                                label: const Text('Editar'),
                                              ),
                                              
                                              const SizedBox(width: 8),
                                              
                                              // Botão de excluir (se houver mais de um endereço)
                                              if (controller.addresses.length > 1)
                                                OutlinedButton.icon(
                                                  onPressed: () async {
                                                    final confirmDelete = await showDialog<bool>(
                                                      context: context,
                                                      builder: (context) => AlertDialog(
                                                        title: const Text(
                                                          'Excluir endereço',
                                                          textAlign: TextAlign.center,
                                                          style: TextStyle(fontWeight: FontWeight.bold),
                                                        ),
                                                        content: const Text(
                                                          'Tem certeza que deseja excluir este endereço?',
                                                          textAlign: TextAlign.center,
                                                        ),
                                                        actions: [
                                                          TextButton(
                                                            onPressed: () => Navigator.pop(context, false),
                                                            child: const Text('Cancelar'),
                                                          ),
                                                          ElevatedButton(
                                                            onPressed: () => Navigator.pop(context, true),
                                                            style: ElevatedButton.styleFrom(
                                                              backgroundColor: Colors.red,
                                                              foregroundColor: Colors.white,
                                                            ),
                                                            child: const Text('Excluir'),
                                                          ),
                                                        ],
                                                        actionsAlignment: MainAxisAlignment.spaceEvenly,
                                                      ),
                                                    );
                                                    
                                                    if (confirmDelete == true) {
                                                      final token = await UserStorage().getUserToken();
                                                      await _deleteAddress(address.id.toString(), token);
                                                    }
                                                  },
                                                  style: OutlinedButton.styleFrom(
                                                    foregroundColor: Colors.red,
                                                    side: const BorderSide(color: Colors.red),
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(8),
                                                    ),
                                                  ),
                                                  icon: const Icon(Icons.delete_outline, size: 18),
                                                  label: const Text('Excluir'),
                                                ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}