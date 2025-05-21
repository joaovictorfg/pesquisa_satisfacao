import 'package:flutter/material.dart';
import '/widget/button.dart';
import '/adm/admin_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usuarioController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  Color hexToColor(String code) {
    code = code.replaceAll('#', '');
    if (code.length == 6) code = 'FF$code';
    return Color(int.parse(code, radix: 16));
  }

  void _tentarLogin() {
    if (_formKey.currentState!.validate()) {
      final usuario = _usuarioController.text;
      final senha = _senhaController.text;

      // Login provisório
      if (usuario == 'admin' && senha == '1234') {
        Navigator.of(context).pop(true); // Retorna "login bem-sucedido" para a HomePage
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Usuário ou senha incorretos')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Administrativo', style: TextStyle(color: Colors.white)),
        backgroundColor: hexToColor('#275316'),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _usuarioController,
                decoration: const InputDecoration(labelText: 'Usuário'),
                validator: (value) =>
                (value == null || value.isEmpty) ? 'Informe o usuário' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _senhaController,
                decoration: const InputDecoration(labelText: 'Senha'),
                obscureText: true,
                validator: (value) =>
                (value == null || value.isEmpty) ? 'Informe a senha' : null,
              ),
              const SizedBox(height: 32),
              BotaoPadrao(
                texto: 'Entrar', icone: Icons.insert_drive_file,
                onPressed: _tentarLogin,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
