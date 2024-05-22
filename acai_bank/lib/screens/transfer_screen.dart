import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../models/balance_model.dart';

// Tela de Transferência
class TransferScreen extends StatelessWidget {
  // Controlador para o campo de texto de valor
  final TextEditingController _controller = TextEditingController();
  void _compartilhar(){
    Share.share("meu primeiro compartilharmento");
  }
  TransferScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transferir'), // Título no cabeçalho da tela
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Espaçamento interno
        child: Column(
          children: [
            // Campo de texto para inserir o valor da transferência
            TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: 'Valor a Transferir'),
              keyboardType: TextInputType.number, // Tipo de teclado numérico
            ),
            SizedBox(height: 20), // Espaço entre os elementos
            // Botão para confirmar a transferência
            ElevatedButton(
              onPressed: () {
                // Obtém o valor inserido, realiza a transferência e volta à tela inicial
                //double amount = double.tryParse(_controller.text) ?? 0;
                //context.read<BalanceModel>().transfer(amount);
                //Navigator.pop(context);
                _compartilhar();
                
              },
              child: Text('Transferir'),
            ),
          ],
        ),
      ),
    );
  }
}
