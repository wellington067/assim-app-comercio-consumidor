class PedidoModel {
  int id;
  String status;
  String tipoEntrega;
  double subtotal;
  double taxaEntrega;
  double total;
  DateTime? dataPedido;
  DateTime? dataConfirmacao;
  DateTime? dataCancelamento;
  DateTime? dataPagamento;
  DateTime? dataEnvio;
  DateTime? dataEntrega;
  int formaPagamentoId;
  int consumidorId;
  int bancaId;
  String? bancaNome;
  String? pix; // Adicionando campo para guardar o pix da banca

  PedidoModel({
    required this.id,
    required this.status,
    required this.tipoEntrega,
    required this.subtotal,
    required this.taxaEntrega,
    required this.total,
    this.dataPedido,
    this.dataConfirmacao,
    this.dataCancelamento,
    this.dataPagamento,
    this.dataEnvio,
    this.dataEntrega,
    required this.formaPagamentoId,
    required this.consumidorId,
    required this.bancaId,
    this.bancaNome,
    this.pix,
  });

  factory PedidoModel.fromJson(Map<String, dynamic> json) {
    try {
      // Extrair dados do pedido (podem estar dentro de 'venda')
      final data = json['venda'] ?? json;
      
      // Extrair o PIX da banca, se disponível
      String? pixValue;
      if (data['banca'] != null && data['banca']['pix'] != null) {
        pixValue = data['banca']['pix'].toString();
      }
      
      // Extrair nome da banca, se disponível
      String? bancaNome;
      if (data['banca'] != null && data['banca']['nome'] != null) {
        bancaNome = data['banca']['nome'].toString();
      } else {
        bancaNome = data['banca_nome'];
      }
      
      return PedidoModel(
        id: data['id'],
        status: data['status'],
        tipoEntrega: data['tipo_entrega'],
        subtotal: double.parse(data['subtotal'].toString()),
        taxaEntrega: double.parse(data['taxa_entrega'].toString()),
        total: double.parse(data['total'].toString()),
        dataPedido: data['data_pedido'] != null
            ? DateTime.parse(data['data_pedido'])
            : null,
        dataConfirmacao: data['data_confirmacao'] != null
            ? DateTime.parse(data['data_confirmacao'])
            : null,
        dataCancelamento: data['data_cancelamento'] != null
            ? DateTime.parse(data['data_cancelamento'])
            : null,
        dataPagamento: data['data_pagamento'] != null
            ? DateTime.parse(data['data_pagamento'])
            : null,
        dataEnvio: data['data_envio'] != null
            ? DateTime.parse(data['data_envio'])
            : null,
        dataEntrega: data['data_entrega'] != null
            ? DateTime.parse(data['data_entrega'])
            : null,
        formaPagamentoId: data['forma_pagamento_id'],
        consumidorId: data['consumidor_id'],
        bancaId: data['banca_id'],
        bancaNome: bancaNome,
        pix: pixValue,
      );
    } catch (e) {
      print('Erro ao converter JSON para PedidoModel: $e');
      print('JSON recebido: $json');
      rethrow; // Relança a exceção para ser tratada em nível superior
    }
  }
}