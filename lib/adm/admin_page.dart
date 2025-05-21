import 'package:flutter/material.dart';
import '../widget/button.dart';
import 'package:pesquisa_satisfacao/home_page.dart'; // caminho correto

class AdminPage extends StatelessWidget {
  const AdminPage({Key? key}) : super(key: key);

  Color hexToColor(String hex) {
    hex = hex.replaceAll('#', '');
    if (hex.length == 6) hex = 'FF$hex';
    return Color(int.parse(hex, radix: 16));
  }

  @override
  Widget build(BuildContext context) {
    final Color botaoCor = hexToColor('275316');

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Administração',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: botaoCor,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            tooltip: 'Logoff',
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(hexToColor: hexToColor),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BotaoPadrao(
              texto: 'Relatório',
              icone: Icons.insert_drive_file,
              backgroundColor: botaoCor,
              onPressed: () {
                // TODO: Navegar para tela de relatório
              },
            ),
            const SizedBox(height: 16),
            BotaoPadrao(
              texto: 'Estatística',
              icone: Icons.bar_chart,
              backgroundColor: botaoCor,
              onPressed: () {
                // TODO: Navegar para tela de estatísticas
              },
            ),
            const SizedBox(height: 16),
            BotaoPadrao(
              texto: 'Horário',
              icone: Icons.schedule,
              backgroundColor: botaoCor,
              onPressed: () {
                // TODO: Navegar para configuração de horários
              },
            ),
            const SizedBox(height: 16),
            BotaoPadrao(
              texto: 'Perguntas',
              icone: Icons.question_answer,
              backgroundColor: botaoCor,
              onPressed: () {
                // TODO: Navegar para tela de edição de perguntas
              },
            ),
          ],
        ),
      ),
    );
  }
}
