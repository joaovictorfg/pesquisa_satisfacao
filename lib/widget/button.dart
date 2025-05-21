import 'package:flutter/material.dart';

class BotaoPadrao extends StatelessWidget {
  final String texto;
  final IconData icone;
  final VoidCallback onPressed;
  final Color backgroundColor;

  const BotaoPadrao({
    Key? key,
    required this.texto,
    required this.icone,
    required this.onPressed,
    this.backgroundColor = const Color(0xFF275316),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icone, color: Colors.white),
        label: Text(
          texto,
          style: const TextStyle(color: Colors.white),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
