// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommerceassim/components/buttons/custom_search_field.dart';
import 'package:ecommerceassim/components/appBar/custom_app_bar.dart';
import 'package:ecommerceassim/components/spacer/verticalSpacer.dart';
import 'package:ecommerceassim/screens/screens_index.dart';
import 'package:ecommerceassim/shared/components/BottomNavigation.dart';
import 'package:ecommerceassim/shared/constants/style_constants.dart';
import 'package:ecommerceassim/shared/core/controllers/banca_controller.dart';
import 'package:ecommerceassim/shared/core/models/banca_model.dart';

class Bancas extends StatelessWidget {
  const Bancas({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final int feiraId = arguments['id'] as int;
    final String feiraNome = arguments['nome'];
    final dynamic horariosFuncionamentoDynamic = arguments['horarios'];

    // Converter dynamic para Map<String, List<String>> de forma mais genérica
    final Map<String, List<String>> horariosFuncionamento = {};
    if (horariosFuncionamentoDynamic != null &&
        horariosFuncionamentoDynamic is Map<dynamic, dynamic>) {
      horariosFuncionamentoDynamic.forEach((key, value) {
        if (value is List<dynamic>) {
          horariosFuncionamento[key.toString()] =
              value.map((e) => e.toString()).toList();
        }
      });
    }

    print(
        horariosFuncionamento); // Verificar se os horários foram convertidos corretamente

    // Função para extrair os horários de abertura e fechamento para cada dia
    String extractOpenCloseTime(List<String> times) {
      if (times.length == 1) {
        return times[
            0]; // Se houver apenas um horário, retorna o próprio horário
      } else {
        return '${times[0]} ás ${times[1]}';
      }
    }

    // Função para formatar os horários de funcionamento para exibição na interface
    String formatOpeningHours(Map<String, List<String>> hours) {
      final formattedHours = hours.entries.map((entry) {
        if (entry.value.length == 1) {
          return '${entry.key} das ${extractOpenCloseTime(entry.value)}';
        } else {
          return '${entry.key} das ${extractOpenCloseTime(entry.value[0].split('-'))} ás ${extractOpenCloseTime(entry.value[1].split('-'))}';
        }
      }).toList();

      if (formattedHours.length > 1) {
        final lastFormattedHour = formattedHours.removeLast();
        return '${formattedHours.join(', ')}, e $lastFormattedHour';
      } else {
        return formattedHours.join(', ');
      }
    }

    final String cidadeNome = arguments['cidadeNome'] ?? "";

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(),
      bottomNavigationBar: BottomNavigation(selectedIndex: 0),
      body: FutureBuilder(
        future: Provider.of<BancaController>(context, listen: false)
            .loadBancas(feiraId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(kDetailColor),
              ),
            );
          }

          if (snapshot.hasError) {
            return _buildErrorWidget('Ocorreu um erro ao carregar as bancas.');
          }

          final bancaController = Provider.of<BancaController>(context);
          if (bancaController.bancas.isEmpty) {
            return _buildEmptyListWidget();
          }

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(22.0, 15.0, 30.0, 0.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$cidadeNome - $feiraNome',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Dias de funcionamento entre ${formatOpeningHours(horariosFuncionamento)}.',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              const CustomSearchField(
                fillColor: kOnBackgroundColorText,
                iconColor: kDetailColor,
                hintText: 'Buscar por bancas',
                padding: EdgeInsets.fromLTRB(21.0, 21.0, 21.0, 10.0),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 22.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Bancas',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const VerticalSpacer(size: 5),
              Expanded(
                child: ListView.builder(
                  itemCount: bancaController.bancas.length,
                  itemBuilder: (context, index) {
                    BancaModel banca = bancaController.bancas[index];
                    return Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 22.0, vertical: 8.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(15.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              Screens.menuProducts,
                              arguments: {
                                'id': banca.id,
                                'nome': banca.nome,
                                'horario_abertura': banca.horarioAbertura,
                                'horario_fechamento': banca.horarioFechamento,
                              },
                            );
                          },
                          borderRadius: BorderRadius.circular(15.0),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              children: [
                                const CircleAvatar(
                                  radius: 25.0,
                                  backgroundImage: AssetImage(
                                      "lib/assets/images/banca-fruta.jpg"),
                                ),
                                const SizedBox(width: 16.0),
                                Expanded(
                                  child: Text(
                                    banca.nome,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildEmptyListWidget() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(Icons.storefront, color: kDetailColor, size: 80),
            const SizedBox(height: 20),
            const Text(
              'Nenhuma banca foi encontrada.',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: kDetailColor,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Não há bancas cadastradas para esta feira ou elas estão indisponíveis no momento.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorWidget(String message) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const VerticalSpacer(size: 220),
          const Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.error_outline, color: kDetailColor, size: 35),
                SizedBox(width: 8),
                Text('Oops!',
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: kDetailColor)),
              ],
            ),
          ),
          const Text('Nenhuma banca foi encontrada.',
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: kDetailColor)),
          const SizedBox(height: 10),
          Text(message,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey[600])),
        ],
      ),
    );
  }
}
