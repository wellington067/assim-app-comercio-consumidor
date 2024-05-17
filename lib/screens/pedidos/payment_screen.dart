import 'package:ecommerceassim/components/appBar/custom_app_bar.dart';
import 'package:ecommerceassim/shared/components/bottomNavigation/BottomNavigation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommerceassim/shared/core/controllers/pagamento_controller.dart';
import 'package:ecommerceassim/shared/core/repositories/pagamento_repository.dart';

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
        appBar: const CustomAppBar(),
        bottomNavigationBar: BottomNavigation(
          paginaSelecionada: 2,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Consumer<PagamentoController>(
            builder: (context, controller, child) {
              return Column(
                children: [
                  if (controller.comprovante != null)
                    Image.file(controller.comprovante!),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: controller.pickComprovante,
                    child: const Text('Escolher Comprovante'),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () =>
                        controller.uploadComprovante(orderId, context),
                    child: const Text('Enviar Comprovante'),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
