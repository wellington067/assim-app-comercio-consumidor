class FeiraModel {
  int id;
  String nome;
  String? descricao; // Pode ser nulo
  List<String> horariosFuncionamento;
  int bairroId;
  int associacaoId;

  FeiraModel({
    required this.id,
    required this.nome,
    this.descricao,
    required this.horariosFuncionamento,
    required this.bairroId,
    required this.associacaoId,
  });

  factory FeiraModel.fromJson(Map<String, dynamic> json) {
    return FeiraModel(
      id: json['id'],
      nome: json['nome'],
      descricao: json['descricao'], // Pode ser nulo
      horariosFuncionamento: List<String>.from(json['horarios_funcionamento']),
      bairroId: json['bairro_id'],
      associacaoId: json['associacao_id'],
    );
  }
}
