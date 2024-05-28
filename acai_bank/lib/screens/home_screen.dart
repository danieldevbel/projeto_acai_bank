import 'package:acai_bank/models/balance_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Tela inicial da aplicação
class HomeScreen extends StatelessWidget {
  final String userName;

  const HomeScreen({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Açai Bank'), // Título no cabeçalho da tela
        actions: [
          IconButton(
            icon: Icon(Icons.logout), // Ícone de logout
            onPressed: () {
              Navigator.pushReplacementNamed(
                  context, '/'); // Navega para a página de login
            },
          ),
        ],
      ),
      body: HomeContent(userName: userName), // Conteúdo principal da tela
    );
  }
}

// Conteúdo principal da tela inicial
class HomeContent extends StatefulWidget {
  final String userName;

  const HomeContent({super.key, required this.userName});

  @override
  _HomeContentState createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  bool _isBalanceHidden = false;

  @override
  Widget build(BuildContext context) {
    // Obtém o saldo atual do BalanceModel usando context.watch
    var balance = context.watch<BalanceModel>().balance;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0), // Espaçamento interno
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start, // Alinhamento dos elementos na coluna
        children: [
          // Saudação ao usuário
          Text(
            'Olá, ${widget.userName}!',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 70, 11, 70), // Cor principal
            ),
          ),
          SizedBox(height: 20), // Espaço entre os elementos

          // Card de saldo
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              color: Color.fromARGB(255, 230, 230, 250), // Fundo mais claro
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8.0,
                  spreadRadius: 2.0,
                  offset: Offset(2.0, 2.0),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Seu saldo',
                      style: TextStyle(
                        fontSize: 18,
                        color: Color.fromARGB(255, 70, 11, 70), // Cor principal
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        _isBalanceHidden
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Color.fromARGB(255, 70, 11, 70), // Cor principal
                      ),
                      onPressed: () {
                        setState(() {
                          _isBalanceHidden = !_isBalanceHidden;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height: 10), // Espaço entre os textos
                Text(
                  _isBalanceHidden
                      ? 'R\$ ****'
                      : 'R\$ $balance', // Valor do saldo (dinâmico)
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 70, 11, 70), // Cor principal
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 40), // Espaço entre os elementos

          // Linha com botões de ação
          Column(
            children: [
              // Botão de Transferência
              ElevatedButton(
                onPressed: () {
                  // Navega para a tela de transferência
                  Navigator.pushNamed(context, '/transfer');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Color.fromARGB(255, 70, 11, 70), // Cor principal do botão
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0)),
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 20),
                  textStyle: TextStyle(fontSize: 18),
                  minimumSize:
                      Size(double.infinity, 60), // Tamanho do botão aumentado
                ),
                child:
                    Text('Transferir', style: TextStyle(color: Colors.white)),
              ),
              SizedBox(height: 20), // Espaço entre os botões

              // Botão de Tela Cotação
              ElevatedButton(
                onPressed: () {
                  // Navega para a nova tela
                  Navigator.pushNamed(context, '/conversor');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Color.fromARGB(255, 70, 11, 70), // Cor principal do botão
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0)),
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 20),
                  textStyle: TextStyle(fontSize: 18),
                  minimumSize:
                      Size(double.infinity, 60), // Tamanho do botão aumentado
                ),
                child: Text('Conversor de moedas',
                    style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
