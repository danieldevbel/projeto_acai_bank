import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../models/balance_model.dart';

  // Controlador para o campo de texto de valor
class TransferScreen extends StatefulWidget {
  TransferScreen({Key? key}) : super(key: key);

  @override
  _TransferScreenState createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  final TextEditingController _valueController = TextEditingController();
  final TextEditingController _pixKeyController = TextEditingController();
  String? _selectedPixKeyType;

  void _shareTransferDetails(String details) {
    Share.share(details);
  }

  void _selectPixKeyType(String type) {
    setState(() {
      _selectedPixKeyType = type;
      _pixKeyController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final balance = context.watch<BalanceModel>().balance;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Transferir'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Saldo Atual: \$${balance.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text('Escolha o tipo de chave PIX:', style: TextStyle(fontSize: 16)),
            Wrap(
              spacing: 10.0,
              children: [
                ChoiceChip(
                  label: Text('CPF'),
                  selected: _selectedPixKeyType == 'CPF',
                  onSelected: (selected) {
                    _selectPixKeyType('CPF');
                  },
                ),
                ChoiceChip(
                  label: Text('Número de Telefone'),
                  selected: _selectedPixKeyType == 'Número de Telefone',
                  onSelected: (selected) {
                    _selectPixKeyType('Número de Telefone');
                  },
                ),
                ChoiceChip(
                  label: Text('Email'),
                  selected: _selectedPixKeyType == 'Email',
                  onSelected: (selected) {
                    _selectPixKeyType('Email');
                  },
                ),
                ChoiceChip(
                  label: Text('Chave Aleatória'),
                  selected: _selectedPixKeyType == 'Chave Aleatória',
                  onSelected: (selected) {
                    _selectPixKeyType('Chave Aleatória');
                  },
                ),
              ],
            ),
            if (_selectedPixKeyType != null) ...[
              SizedBox(height: 20),
              TextField(
                controller: _pixKeyController,
                decoration: InputDecoration(
                  labelText: 'Insira a $_selectedPixKeyType',
                ),
                keyboardType: _selectedPixKeyType == 'CPF' || _selectedPixKeyType == 'Número de Telefone'
                    ? TextInputType.number
                    : TextInputType.text,
              ),
            ],
            SizedBox(height: 20),
            TextField(
              controller: _valueController,
              decoration: InputDecoration(labelText: 'Valor a Transferir'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                double? amount = double.tryParse(_valueController.text);
                String pixKey = _pixKeyController.text;

                if (amount == null || amount <= 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Por favor, insira um valor válido para a transferência.')),
                  );
                  return;
                }

                if (pixKey.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Por favor, insira a chave PIX.')),
                  );
                  return;
                }

                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Confirmar Transferência'),
                    content: Text('Você deseja transferir \$${amount.toStringAsFixed(2)} para a chave PIX $_selectedPixKeyType: $pixKey?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Cancelar'),
                      ),
                      TextButton(
                        onPressed: () {
                          context.read<BalanceModel>().transfer(amount);
                          Navigator.pop(context); // Fecha o diálogo de confirmação
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text('Transferência Concluída'),
                              content: Text('Você enviou \$${amount.toStringAsFixed(2)} para a chave PIX $_selectedPixKeyType: $pixKey.'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context); // Fecha o comprovante
                                    Navigator.pop(context); // Fecha a tela de transferência
                                  },
                                  child: Text('Ok'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    _shareTransferDetails('Transferi \$${amount.toStringAsFixed(2)} para a chave PIX $_selectedPixKeyType: $pixKey.');
                                  },
                                  child: Text('Compartilhar'),
                                ),
                              ],
                            ),
                          );
                        },
                        child: Text('Confirmar'),
                      ),
                    ],
                  ),
                );
              },
              child: Text('Transferir'),
            ),
          ],
        ),
      ),
    );
  }
}
