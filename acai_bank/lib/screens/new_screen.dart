import 'package:flutter/material.dart';

// Nova Tela
class NewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nova Tela'), // Título no cabeçalho da tela
      ),
      body: Center(
        child: Text(
          'Conteúdo da Nova Tela',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
