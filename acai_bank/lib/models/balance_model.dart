import 'package:flutter/foundation.dart';

// Classe para gerenciar o saldo
class BalanceModel with ChangeNotifier {
  double _balance = 1000.0; // Saldo inicial

  // Getter para obter o saldo atual
  double get balance => _balance;

  // Método para realizar transferência
  void transfer(double amount) {
    // Verifica se o saldo é suficiente para a transferência
    if (_balance >= amount) {
      _balance -= amount; // Deduz o valor transferido do saldo
      notifyListeners(); // Notifica ouvintes sobre a mudança no saldo
    }
  }
}
