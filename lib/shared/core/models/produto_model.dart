class ProdutoModel {
  int id;
  String descricao;
  String tipoUnidade;
  String preco;
  String custo;
  int estoque;
  int bancaId;
  int produtoTabeladoId;

  ProdutoModel({
    required this.descricao,
    required this.tipoUnidade,
    required this.estoque,
    required this.preco,
    required this.custo,
    required this.id,
    required this.produtoTabeladoId,
    required this.bancaId,
  });

  factory ProdutoModel.fromJson(Map<String, dynamic> json) {
    return ProdutoModel(
      id: json['id'],
      descricao: json['descricao'],
      tipoUnidade: json['tipo_unidade'],
      estoque: json['estoque'],
      preco: json['preco'],
      custo: json['custo'],
      bancaId: json['banca_id'],
      produtoTabeladoId: json['produto_tabelado_id'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['descricao'] = descricao;
    data['tipo_unidade'] = tipoUnidade;
    data['estoque'] = estoque;
    data['preco'] = preco;
    data['produto_tabelado_id'] = produtoTabeladoId;
    data['banca_id'] = bancaId;
    return data;
  }
}
