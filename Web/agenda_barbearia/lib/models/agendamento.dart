class Agendamento {
  final DateTime dataHora;
  final String observacao;
  final int clienteId;
  final int barbeiroId;

  Agendamento({
    required this.dataHora,
    required this.observacao,
    required this.clienteId,
    required this.barbeiroId,
  });

  Map<String, dynamic> toJson() {
    return {
      'dataHora': dataHora.toIso8601String(),
      'observacao': observacao,
      'clienteId': clienteId,
      'barbeiroId': barbeiroId,
    };
  }
}
