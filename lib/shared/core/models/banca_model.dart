class BancaModel {
  int id;
  String nome;
  String descricao;
  String horarioAbertura;
  String horarioFechamento;
  int feiraId;
  int agricultorId;
  int precoMinimo;
  bool entrega; // Added this field to match the JSON structure

  BancaModel({
    required this.id,
    required this.nome,
    required this.descricao,
    required this.horarioAbertura,
    required this.horarioFechamento,
    required this.feiraId,
    required this.agricultorId,
    required this.precoMinimo,
    required this.entrega, // Don't forget to require this in the constructor if it's a non-nullable field
  });

  factory BancaModel.fromJson(Map<String, dynamic> json) {
    return BancaModel(
      id: json['id'],
      nome: json['nome'],
      descricao: json['descricao'],
      horarioAbertura: json['horario_abertura'],
      horarioFechamento: json['horario_fechamento'],
      feiraId: json['feira_id'],
      agricultorId: json['agricultor_id'],
      precoMinimo: int.parse(json['preco_minimo']),
      entrega: json['entrega'] ??
          false, // Assumes 'entrega' is optional and defaults to false if not present
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nome'] = nome;
    data['descricao'] = descricao;
    data['horario_abertura'] = horarioAbertura;
    data['horario_fechamento'] = horarioFechamento;
    data['feira_id'] = feiraId;
    data['agricultor_id'] = agricultorId;
    data['preco_minimo'] = precoMinimo
        .toString(); // Ensuring this is a string as in the JSON structure
    data['entrega'] = entrega; // Add 'entrega' to the JSON map
    return data;
  }
}
