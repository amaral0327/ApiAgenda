import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CadastrarBarbeiro extends StatefulWidget {
  const CadastrarBarbeiro({super.key});

  @override
  State<CadastrarBarbeiro> createState() => _CadastrarBarbeiroState();
}

class _CadastrarBarbeiroState extends State<CadastrarBarbeiro> {
  final _formKey = GlobalKey<FormState>();
  String nome = '';

  void _cadastrar() async {
    if (_formKey.currentState!.validate()) {
      final url = Uri.parse('http://localhost:5099/api/barbeiros');
      final headers = {'Content-Type': 'application/json'};
      final body = jsonEncode({'nome': nome});

      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 201 || response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Barbeiro cadastrado!')),
        );
        Navigator.pop(context); // volta pra tela anterior
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro: ${response.statusCode}')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastrar Barbeiro')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Nome do Barbeiro'),
                validator: (value) => value!.isEmpty ? 'Informe o nome' : null,
                onChanged: (value) => nome = value,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _cadastrar,
                child: const Text('Cadastrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
