import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import '../models/balance_model.dart';

// Define a tela de transferência
class TransferScreen extends StatefulWidget {
  TransferScreen({Key? key}) : super(key: key);

  @override
  _TransferScreenState createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  // Controladores para os campos de texto
  final TextEditingController _valueController = TextEditingController();
  final TextEditingController _pixKeyController = TextEditingController();
  String? _selectedPixKeyType; // Armazena o tipo de chave PIX selecionada

  // Função para compartilhar detalhes da transferência
  void _shareTransferDetails(String details) {
    Share.share(details);
  }

  // Função para selecionar o tipo de chave PIX
  void _selectPixKeyType(String type) {
    setState(() {
      _selectedPixKeyType = type;
      _pixKeyController.clear();
    });

    // Navega para a tela de inserção de valor e chave PIX
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => _buildInsertValueAndPixScreen(context.watch<BalanceModel>().balance),
      ),
    );
  }

  // Constrói a tela para inserir valor e chave PIX
  Widget _buildInsertValueAndPixScreen(double balance) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transferir'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Exibe o saldo disponível
            Text(
              'Saldo Disponível',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 70, 11, 70)),
            ),
            SizedBox(height: 10),
            // Exibe o saldo formatado
            Text(
              'R\$${balance.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18, color: Color.fromARGB(255, 70, 11, 70)),
            ),
            SizedBox(height: 20),
            // Campo para inserir a chave PIX, dependendo do tipo selecionado
            if (_selectedPixKeyType != null) ...[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), // Aumenta o raio da borda
                  border: Border.all(color: Color.fromARGB(255, 70, 11, 70), width: 2), // Aumenta a largura da borda
                ),
                child: TextField(
                  controller: _pixKeyController,
                  decoration: InputDecoration(
                    labelText: _selectedPixKeyType == 'Número de Telefone'
                        ? 'Insira o número de telefone'
                        : 'Inserir $_selectedPixKeyType',
                    border: InputBorder.none, // Remove a borda padrão
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12), // Aumenta o padding do conteúdo
                  ),
                  keyboardType: _selectedPixKeyType == 'CPF' || _selectedPixKeyType == 'Número de Telefone'
                      ? TextInputType.number
                      : TextInputType.text,
                ),
              ),
            ],
            SizedBox(height: 20),
            // Campo para inserir o valor da transferência
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), // Aumenta o raio da borda
                border: Border.all(color: Color.fromARGB(255, 70, 11, 70), width: 2), // Aumenta a largura da borda
              ),
              child: TextField(
                controller: _valueController,
                decoration: InputDecoration(
                  labelText: 'Valor a Transferir',
                  border: InputBorder.none, // Remove a borda padrão
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12), // Aumenta o padding do conteúdo
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
      // Botão flutuante para confirmar a transferência
      floatingActionButton: Align(
        alignment: Alignment.bottomRight,
        child: FloatingActionButton(
          backgroundColor: Color.fromARGB(255, 70, 11, 70),
          onPressed: () {
            // Pega os valores dos campos de texto
            double? amount = double.tryParse(_valueController.text);
            String pixKey = _pixKeyController.text;

            // Verificações de validação
            if (amount == null || amount <= 0) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Por favor, insira um valor válido para a transferência.')),
              );
              return;
            }

            if (amount > balance) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Saldo insuficiente.')),
              );
              return;
            }

            if (_selectedPixKeyType == 'Número de Telefone' && pixKey.length != 11) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Número de telefone inválido.')),
              );
              return;
            }

            if (_selectedPixKeyType == 'CPF' && pixKey.length != 11) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('CPF deve ter 11 dígitos.')),
              );
              return;
            }

            if (pixKey.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Por favor, insira a chave PIX.')),
              );
              return;
            }

            // Mostra o diálogo de confirmação
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                backgroundColor: Color.fromARGB(255, 70, 11, 70),
                title: Text(
                  'Confirmar Transferência',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18.0),
                ),
                content: SingleChildScrollView(
                  child: Text(
                    'Você deseja transferir R\$${amount.toStringAsFixed(2)}?',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Cancelar', style: TextStyle(color: Colors.white)),
                      ),
                      TextButton(
                        onPressed: () {
                          // Realiza a transferência
                          context.read<BalanceModel>().transfer(amount);
                          Navigator.pop(context); // Fecha o diálogo de confirmação
                          // Mostra o diálogo de transferência concluída
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              backgroundColor: Color.fromARGB(255, 70, 11, 70),
                              title: Text(
                                'Transferência Concluída',
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18.0),
                              ),
                              content: SingleChildScrollView(
                                child: Text(
                                  'Você enviou R\$${amount.toStringAsFixed(2)} com sucesso.',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.popUntil(context, ModalRoute.withName('/home')); // Volta para a tela inicial
                                  },
                                  child: Text('Fechar', style: TextStyle(color: Colors.white)),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.popUntil(context, ModalRoute.withName('/home')); // Volta para a tela inicial
                                    _shareTransferDetails('Transferi R\$${amount.toStringAsFixed(2)} com sucesso.');
                                  },
                                  child: Text('Compartilhar', style: TextStyle(color: Colors.white)),
                                ),
                              ],
                            ),
                          );
                        },
                        child: Text('Transferir', style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
          child: Icon(Icons.arrow_forward, color: Colors.white), // Define a cor da seta como branca
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Color.fromARGB(255, 70, 11, 70),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Escolha o tipo de chave PIX:',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    SizedBox(height: 20), // Aumenta o espaçamento entre os itens
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            ChoiceChip(
                              label: Text('CPF', style: TextStyle(color: Colors.white)),
                              selected: _selectedPixKeyType == 'CPF',
                              onSelected: (selected) {
                                _selectPixKeyType('CPF');
                              },
                              backgroundColor: Color.fromARGB(255, 70, 11, 70),
                              labelStyle: TextStyle(fontSize: 18), // Aumenta o tamanho da fonte do label
                              padding: EdgeInsets.all(16), // Aumenta o padding
                            ),
                            SizedBox(height: 10),
                            ChoiceChip(
                              label: Text('Email', style: TextStyle(color: Colors.white)),
                              selected: _selectedPixKeyType == 'Email',
                              onSelected: (selected) {
                                _selectPixKeyType('Email');
                              },
                              backgroundColor: Color.fromARGB(255, 70, 11, 70),
                              labelStyle: TextStyle(fontSize: 18), // Aumenta o tamanho da fonte do label
                              padding: EdgeInsets.all(16), // Aumenta o padding
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            ChoiceChip(
                              label: Text('Número de Telefone', style: TextStyle(color: Colors.white)),
                              selected: _selectedPixKeyType == 'Número de Telefone',
                              onSelected: (selected) {
                                _selectPixKeyType('Número de Telefone');
                              },
                              backgroundColor: Color.fromARGB(255, 70, 11, 70),
                              labelStyle: TextStyle(fontSize: 18), // Aumenta o tamanho da fonte do label
                              padding: EdgeInsets.all(16), // Aumenta o padding
                            ),
                            SizedBox(height: 10),
                            ChoiceChip(
                              label: Text('Chave Aleatória', style: TextStyle(color: Colors.white)),
                              selected: _selectedPixKeyType == 'Chave Aleatória',
                              onSelected: (selected) {
                                _selectPixKeyType('Chave Aleatória');
                              },
                              backgroundColor: Color.fromARGB(255, 70, 11, 70),
                              labelStyle: TextStyle(fontSize: 18), // Aumenta o tamanho da fonte do label
                              padding: EdgeInsets.all(16), // Aumenta o padding
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
