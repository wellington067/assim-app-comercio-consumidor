class ProdutoModel {
  int id;
  String descricao;
  String tipoUnidade;
  String preco;
  String custo;
  int estoque;
  int disponivel;
  int bancaId;
  int produtoTabeladoId;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime? deletedAt; // Pode ser nulo

  ProdutoModel({
    required this.id,
    required this.descricao,
    required this.tipoUnidade,
    required this.estoque,
    required this.preco,
    required this.custo,
    required this.disponivel,
    required this.bancaId,
    required this.produtoTabeladoId,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory ProdutoModel.fromJson(Map<String, dynamic> json) {
    return ProdutoModel(
      id: json['id'],
      descricao: json['descricao'],
      tipoUnidade: json['tipo_unidade'],
      estoque: json['estoque'],
      preco: json['preco'],
      custo: json['custo'],
      disponivel: json['disponivel'],
      bancaId: json['banca_id'],
      produtoTabeladoId: json['produto_tabelado_id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      deletedAt: json['deleted_at'] != null
          ? DateTime.parse(json['deleted_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['descricao'] = descricao;
    data['tipo_unidade'] = tipoUnidade;
    data['estoque'] = estoque;
    data['preco'] = preco;
    data['custo'] = custo;
    data['disponivel'] = disponivel;
    data['banca_id'] = bancaId;
    data['produto_tabelado_id'] = produtoTabeladoId;
    data['created_at'] = createdAt.toIso8601String();
    data['updated_at'] = updatedAt.toIso8601String();
    data['deleted_at'] = deletedAt?.toIso8601String();
    return data;
  }
}
