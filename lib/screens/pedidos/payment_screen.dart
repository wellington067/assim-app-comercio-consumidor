// ignore_for_file: sized_box_for_whitespace

import 'package:ecommerceassim/shared/constants/style_constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommerceassim/shared/core/controllers/pagamento_controller.dart';
import 'package:ecommerceassim/shared/core/repositories/pagamento_repository.dart';
import 'package:ecommerceassim/components/appBar/custom_app_bar.dart';
import 'package:ecommerceassim/shared/components/bottomNavigation/BottomNavigation.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final int orderId = arguments['orderId'];

    return ChangeNotifierProvider(
      create: (_) => PagamentoController(PagamentoRepository()),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: const CustomAppBar(),
        bottomNavigationBar: BottomNavigation(
          paginaSelecionada: 2,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Consumer<PagamentoController>(
            builder: (context, controller, child) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (controller.comprovante != null) ...[
                      const SizedBox(height: 16),
                      if (controller.comprovanteType == 'pdf')
                        FutureBuilder(
                          future: controller.loadPDF(controller.pdfPath),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              if (snapshot.hasError) {
                                return const Text('Erro ao carregar PDF');
                              }
                              return SizedBox(
                                height: 450,
                                child: PDFView(
                                  filePath: controller.pdfPath!,
                                ),
                              );
                            } else {
                              return const Center(
                                child: CircularProgressIndicator(
                                  color: kDetailColor,
                                ),
                              );
                            }
                          },
                        )
                      else if (controller.comprovanteType != 'pdf')
                        SizedBox(
                          height: 450,
                          child: Image.file(controller.comprovante!),
                        ),
                    ],
                    const SizedBox(height: 16),
                    Center(
                      child: Column(
                        children: [
                          ElevatedButton(
                            onPressed: controller.pickComprovante,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: kDetailColor,
                              foregroundColor: Colors.white,
                            ),
                            child: const Text('Escolher Comprovante'),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () =>
                                controller.uploadComprovante(orderId, context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: kDetailColor,
                              foregroundColor: Colors.white,
                            ),
                            child: const Text('Enviar Comprovante'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
