class FeiraModel {
  int id;
  List<String> funcionamento;
  String horarioAbertura;
  String horarioFechamento;
  int bairroId;

  FeiraModel({
    required this.id,
    required this.funcionamento,
    required this.horarioAbertura,
    required this.horarioFechamento,
    required this.bairroId,
  });

  factory FeiraModel.fromJson(Map<String, dynamic> json) {
    return FeiraModel(
      id: json['id'],
      funcionamento: List<String>.from(json['funcionamento']),
      horarioAbertura: json['horario_abertura'],
      horarioFechamento: json['horario_fechamento'],
      bairroId: json['bairro_id'],
    );
  }
}
