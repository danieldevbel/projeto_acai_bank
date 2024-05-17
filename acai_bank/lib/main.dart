import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/balance_model.dart';
import 'screens/home_screen.dart';
import 'screens/new_screen.dart'; // Importar a nova tela
import 'screens/transfer_screen.dart';

// Ponto de entrada da aplicação
void main() {
  runApp(
    // Envolve o MyApp com ChangeNotifierProvider para fornecer BalanceModel para toda a aplicação
    ChangeNotifierProvider(
      create: (context) => BalanceModel(),
      child: MyApp(),
    ),
  );
}

// Widget principal da aplicação
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Banco Digital', // Título da aplicação
      theme: ThemeData(
        primarySwatch: Colors.blue, // Tema principal da aplicação
      ),
      initialRoute: '/', // Rota inicial
      routes: {
        '/': (context) => HomeScreen(), // Tela inicial
        '/transfer': (context) => TransferScreen(), // Tela de transferência
        '/newScreen': (context) => NewScreen(), // Nova tela
      },
    );
  }
}
