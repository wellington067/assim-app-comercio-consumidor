// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:ecommerceassim/shared/core/models/pagamento_model.dart';
import 'package:ecommerceassim/shared/core/repositories/pagamento_repository.dart';

class PagamentoController with ChangeNotifier {
  final PagamentoRepository _repository;
  File? _comprovante;
  String? _comprovanteType;
  String? _pdfPath;

  PagamentoController(this._repository);

  File? get comprovante => _comprovante;
  String? get comprovanteType => _comprovanteType;
  String? get pdfPath => _pdfPath;

  Future<void> pickComprovante() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
      );

      if (result != null && result.files.single.path != null) {
        _comprovante = File(result.files.single.path!);
        _comprovanteType = result.files.single.extension;
        _pdfPath = (_comprovanteType == 'pdf') ? _comprovante!.path : null;
        notifyListeners();
      } else {
        debugPrint('Nenhum arquivo selecionado');
      }
    } catch (e) {
      debugPrint('Erro ao selecionar arquivo: $e');
    }
  }

  Future<void> loadPDF(String? path) async {
    try {
      if (path != null && path.isNotEmpty) {
        await Future.delayed(const Duration(milliseconds: 500));
      }
    } catch (e) {
      debugPrint('Erro ao carregar PDF: $e');
      throw Exception('Erro ao carregar PDF');
    }
  }

  Future<void> uploadComprovante(int orderId, BuildContext context) async {
    if (_comprovante == null) {
      debugPrint('Nenhum comprovante selecionado');
      return;
    }

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
