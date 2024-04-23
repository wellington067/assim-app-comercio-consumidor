class PedidoModel {
  final int id;
  final String status;
  final String tipoEntrega;
  final double subtotal;
  final double taxaEntrega;
  final double total;
  final DateTime? dataPedido;
  final DateTime? dataConfirmacao;
  final DateTime? dataCancelamento;
  final DateTime? dataPagamento;
  final DateTime? dataEnvio;
  final DateTime? dataEntrega;
  final int formaPagamentoId;
  final int consumidorId;
  final int bancaId;
  final DateTime createdAt;
  final DateTime updatedAt;

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
    required this.createdAt,
    required this.updatedAt,
  });

  factory PedidoModel.fromJson(Map<String, dynamic> json) {
    return PedidoModel(
      id: json['id'],
      status: json['status'],
      tipoEntrega: json['tipo_entrega'],
      subtotal: double.parse(json['subtotal']),
      taxaEntrega: double.parse(json['taxa_entrega']),
      total: double.parse(json['total']),
      dataPedido: json['data_pedido'] != null
          ? DateTime.parse(json['data_pedido'])
          : null,
      dataConfirmacao: json['data_confirmacao'] != null
          ? DateTime.parse(json['data_confirmacao'])
          : null,
      dataCancelamento: json['data_cancelamento'] != null
          ? DateTime.parse(json['data_cancelamento'])
          : null,
      dataPagamento: json['data_pagamento'] != null
          ? DateTime.parse(json['data_pagamento'])
          : null,
      dataEnvio: json['data_envio'] != null
          ? DateTime.parse(json['data_envio'])
          : null,
      dataEntrega: json['data_entrega'] != null
          ? DateTime.parse(json['data_entrega'])
          : null,
      formaPagamentoId: json['forma_pagamento_id'],
      consumidorId: json['consumidor_id'],
      bancaId: json['banca_id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'status': status,
        'tipo_entrega': tipoEntrega,
        'subtotal': subtotal,
        'taxa_entrega': taxaEntrega,
        'total': total,
        'data_pedido': dataPedido?.toIso8601String(),
        'data_confirmacao': dataConfirmacao?.toIso8601String(),
        'data_cancelamento': dataCancelamento?.toIso8601String(),
        'data_pagamento': dataPagamento?.toIso8601String(),
        'data_envio': dataEnvio?.toIso8601String(),
        'data_entrega': dataEntrega?.toIso8601String(),
        'forma_pagamento_id': formaPagamentoId,
        'consumidor_id': consumidorId,
        'banca_id': bancaId,
        'created_at': createdAt.toIso8601String(),
        'updated_at': updatedAt.toIso8601String(),
      };
}
