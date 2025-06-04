import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'models/agendamento.dart';
import 'screens/cadastrar_barbeiro.dart';

void main() {
  runApp(const AgendaBarbeariaApp());
}

class AgendaBarbeariaApp extends StatelessWidget {
  const AgendaBarbeariaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Agenda Barbearia',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TelaAgendamento(),
    );
  }
}

class TelaAgendamento extends StatefulWidget {
  const TelaAgendamento({super.key});

  @override
  State<TelaAgendamento> createState() => _TelaAgendamentoState();
}

class _TelaAgendamentoState extends State<TelaAgendamento> {
  final _formKey = GlobalKey<FormState>();
  String nome = '';
  String telefone = '';
  String observacao = '';
  DateTime? dataHora;

  void _selecionarDataHora() async {
    final data = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );

    if (!mounted) return;

    if (data != null) {
      final hora = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (!mounted) return;

      if (hora != null) {
        setState(() {
          dataHora = DateTime(data.year, data.month, data.day, hora.hour, hora.minute);
        });
      }
    }
  }

  void _enviarAgendamento() async {
    if (_formKey.currentState!.validate() && dataHora != null) {
      final agendamento = Agendamento(
        dataHora: dataHora!,
        observacao: observacao,
        clienteId: 1,   // por enquanto, use ID fixo para testes
        barbeiroId: 1,  // por enquanto, use ID fixo para testes
      );

      final url = Uri.parse('http://localhost:5099/api/agendamentos');
      final headers = {'Content-Type': 'application/json'};
      final body = jsonEncode(agendamento.toJson());

      try {
        final response = await http.post(url, headers: headers, body: body);

        if (response.statusCode == 201 || response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Agendamento enviado com sucesso!')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Erro: ${response.statusCode}')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Erro ao conectar com a API')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preencha todos os campos')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Agendar Horário')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Nome'),
                validator: (value) => value!.isEmpty ? 'Informe o nome' : null,
                onChanged: (value) => nome = value,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Telefone'),
                validator: (value) => value!.isEmpty ? 'Informe o telefone' : null,
                onChanged: (value) => telefone = value,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Observações'),
                onChanged: (value) => observacao = value,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _selecionarDataHora,
                child: Text(
                  dataHora == null
                      ? 'Selecionar Data e Hora'
                      : 'Selecionado: ${dataHora.toString()}',
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _enviarAgendamento,
                child: const Text('Agendar'),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const CadastrarBarbeiro()),
                  );
                },
                child: const Text('Cadastrar Barbeiro'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
