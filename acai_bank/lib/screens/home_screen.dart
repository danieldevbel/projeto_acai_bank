import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/balance_model.dart';

// Tela inicial da aplicação
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Banco Digital'), // Título no cabeçalho da tela
      ),
      body: HomeContent(), // Conteúdo principal da tela
    );
  }
}

// Conteúdo principal da tela inicial
class HomeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Obtém o saldo atual do BalanceModel usando context.watch
    var balance = context.watch<BalanceModel>().balance;

    return Padding(
      padding: const EdgeInsets.all(16.0), // Espaçamento interno
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start, // Alinhamento dos elementos na coluna
        children: [
          // Saudação ao usuário
          Text(
            'Olá, Usuário!',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20), // Espaço entre os elementos

          // Texto de saldo
          Text(
            'Seu saldo',
            style: TextStyle(fontSize: 18),
          ),
          Text(
            'R\$ $balance', // Valor do saldo (dinâmico)
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 40), // Espaço entre os elementos

          // Linha com botões de ação
          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceAround, // Distribuição dos botões
            children: [
              // Botão de Transferência
              ElevatedButton(
                onPressed: () {
                  // Navega para a tela de transferência
                  Navigator.pushNamed(context, '/transfer');
                },
                child: Text('Transferir'),
              ),
              // Botão de Pagamento
              ElevatedButton(
                onPressed: () {},
                child: Text('Pagar'),
              ),
            ],
          ),
          SizedBox(height: 20), // Espaço entre os elementos

          // Botão de Extrato (largura total)
          ElevatedButton(
            onPressed: () {}, // Ação ao clicar no botão (vazio por enquanto)
            child: Text('Extrato'),
            style: ElevatedButton.styleFrom(
              minimumSize: Size(double.infinity, 40), // Botão de largura total
            ),
          ),

          // Botão para Nova Tela (largura total)
          ElevatedButton(
            onPressed: () {
              // Navega para a nova tela
              Navigator.pushNamed(context, '/newScreen');
            },
            child: Text('Nova Tela'),
            style: ElevatedButton.styleFrom(
              minimumSize: Size(double.infinity, 40), // Botão de largura total
            ),
          ),
        ],
      ),
    );
  }
}
