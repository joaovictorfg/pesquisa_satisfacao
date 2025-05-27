import 'package:flutter/material.dart';
import 'form/form_page.dart';
import 'widget/button.dart';

class HomePage extends StatelessWidget {
  final Color Function(String) hexToColor;
  const HomePage({Key? key, required this.hexToColor}) : super(key: key);

  bool _estaPermitidoHorario() {
    final agora = TimeOfDay.now();

    final horariosPermitidos = [
      {'inicio': const TimeOfDay(hour: 1, minute: 0), 'fim': const TimeOfDay(hour: 23, minute: 0)},
      {'inicio': const TimeOfDay(hour: 11, minute: 0), 'fim': const TimeOfDay(hour: 14, minute: 0)},
      {'inicio': const TimeOfDay(hour: 19, minute: 0), 'fim': const TimeOfDay(hour: 21, minute: 0)},
      {'inicio': const TimeOfDay(hour: 1, minute: 0), 'fim': const TimeOfDay(hour: 3, minute: 0)},
    ];

    return horariosPermitidos.any((intervalo) {
      final inicio = intervalo['inicio']!;
      final fim = intervalo['fim']!;
      bool afterStart = agora.hour > inicio.hour || (agora.hour == inicio.hour && agora.minute >= inicio.minute);
      bool beforeEnd = agora.hour < fim.hour || (agora.hour == fim.hour && agora.minute <= fim.minute);
      return afterStart && beforeEnd;
    });
  }

  @override
  Widget build(BuildContext context) {
    final permitido = _estaPermitidoHorario();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Pesquisa de Satisfação', style: TextStyle(color: Colors.white)),
        backgroundColor: hexToColor('275316'),
        centerTitle: true,
      ),
      body: Center(
        child: permitido
            ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Hero(
              tag: 'logoApp',
              child: Image(
                image: AssetImage('assets/images/logo3.png'),
                width: 300,
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: 300,
              child: BotaoPadrao(
                texto: 'Iniciar Pesquisa',
                icone: Icons.insert_drive_file,
                onPressed: () {
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      transitionDuration: const Duration(milliseconds: 600),
                      pageBuilder: (context, animation, secondaryAnimation) => const FormPage(),
                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                        const begin = Offset(1.0, 0.0);
                        const end = Offset.zero;
                        const curve = Curves.easeInOut;
                        final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                        return SlideTransition(position: animation.drive(tween), child: child);
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        )
            : Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.lock_clock, size: 60, color: Colors.grey),
              SizedBox(height: 20),
              Text(
                'Fora do horário de atendimento',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 12),
              Text(
                'O aplicativo está disponível apenas nos seguintes horários:\n\n'
                    '• 01:00 - 03:00\n'
                    '• 07:00 - 08:00\n'
                    '• 11:00 - 14:00\n'
                    '• 19:00 - 21:00',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
