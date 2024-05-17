import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ecommerceassim/shared/core/models/pagamento_model.dart';
import 'package:ecommerceassim/shared/core/repositories/pagamento_repository.dart';

class PagamentoController with ChangeNotifier {
  final PagamentoRepository _repository;
  File? _comprovante;

  PagamentoController(this._repository);

  File? get comprovante => _comprovante;

  Future<void> pickComprovante() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      _comprovante = File(pickedFile.path);
      notifyListeners();
    }
  }

  Future<void> uploadComprovante(int orderId, BuildContext context) async {
    if (_comprovante == null) return;

    final pagamento = PagamentoModel(comprovante: _comprovante!);

    try {
      await _repository.uploadComprovante(pagamento, orderId);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Comprovante enviado com sucesso!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }
}
