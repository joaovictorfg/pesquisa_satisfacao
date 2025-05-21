import 'package:flutter/material.dart';
import '/widget/button.dart';

class FormPage extends StatefulWidget {
  const FormPage({Key? key}) : super(key: key);

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();
  bool enviado = false;

  final Map<String, dynamic> respostas = {
    'refeicoes': null,
    'atendimento': null,
    'ambiente': null,
    'higiene': null,
    'escala': null,
    'bem': '',
    'melhorar': '',
  };

  void _enviarFormulario() {
    bool camposObrigatoriosPreenchidos = respostas['refeicoes'] != null &&
        respostas['atendimento'] != null &&
        respostas['ambiente'] != null &&
        respostas['higiene'] != null &&
        respostas['escala'] != null;

    if (!camposObrigatoriosPreenchidos) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Para enviar as respostas é necessário responder as perguntas de 1 ao 5.',
          ),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ),
      );
      return;
    }

    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() => enviado = true);
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.of(context).pop();
      });
    }
  }

  Widget _buildRadioPergunta(String titulo, String campo, List<String> opcoes) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(titulo, style: const TextStyle(fontWeight: FontWeight.bold)),
        Wrap(
          spacing: 8.0,
          children: opcoes.map((opcao) {
            return FilterChip(
              label: Text(opcao, style: const TextStyle(color: Colors.white)),
              selected: respostas[campo] == opcao,
              onSelected: (_) => setState(() => respostas[campo] = opcao),
              selectedColor: const Color(0xFF275316),
              backgroundColor: Colors.grey,
              checkmarkColor: Colors.white,
              showCheckmark: true,
            );
          }).toList(),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildCampoAberto(String titulo, String campo) {
    return TextFormField(
      maxLines: 2,
      decoration: InputDecoration(
        labelText: titulo,
        border: const OutlineInputBorder(),
      ),
      onSaved: (val) => respostas[campo] = val ?? '',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF275316),
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('Pesquisa de Satisfação', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Center(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          child: enviado
              ? const Text(
            'Obrigado por responder!',
            key: ValueKey('mensagemEnviado'),
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          )
              : Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  _buildRadioPergunta('1) Como você avalia a qualidade das refeições?', 'refeicoes', ['Ótimo', 'Bom', 'Regular', 'Ruim']),
                  _buildRadioPergunta('2) Como você avalia o atendimento?', 'atendimento', ['Ótimo', 'Bom', 'Regular', 'Ruim']),
                  _buildRadioPergunta('3) Como você avalia o ambiente?', 'ambiente', ['Ótimo', 'Bom', 'Regular', 'Ruim']),
                  _buildRadioPergunta('4) Como você avalia a higiene?', 'higiene', ['Ótimo', 'Bom', 'Regular', 'Ruim']),
                  _buildRadioPergunta('5) Qual a sua nota para o serviço geral?', 'escala', ['1', '2', '3', '4', '5']),
                  _buildCampoAberto('6) O que você mais gostou?', 'bem'),
                  const SizedBox(height: 16),
                  _buildCampoAberto('7) O que poderia melhorar?', 'melhorar'),
                  const SizedBox(height: 30),
                  BotaoPadrao(texto: 'Enviar', icone: Icons.insert_drive_file, onPressed: _enviarFormulario),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
