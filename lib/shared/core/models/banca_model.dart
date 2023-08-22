class BancaModel {
  int id;
  String nome;
  String descricao;
  String horarioAbertura;
  String horarioFechamento;
  bool funcionamento;
  String precoMinimo;

  BancaModel({
    required this.nome,
    required this.descricao,
    required this.horarioAbertura,
    required this.horarioFechamento,
    required this.id,
    required this.funcionamento,
    required this.precoMinimo,
  });

  factory BancaModel.fromJson(Map<String, dynamic> json) {
    return BancaModel(
      id: json['id'],
      nome: json['nome'],
      descricao: json['descricao'],
      horarioAbertura: json['horario_abertura'],
      horarioFechamento: json['horario_fechamento'],
      funcionamento: json['funcionamento'],
      precoMinimo: json['preco_minimo'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nome'] = nome;
    data['descricao'] = descricao;
    data['horario_abertura'] = horarioAbertura;
    data['horario_fechamento'] = horarioFechamento;
    data['funcionamento'] = funcionamento;
    data['preco_minimo'] = precoMinimo;
    return data;
  }
}
