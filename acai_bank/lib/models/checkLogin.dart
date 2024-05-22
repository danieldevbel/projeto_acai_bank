import 'dart:async';

import 'package:flutter/services.dart' show rootBundle;

// Função para verificar o login
Future<String?> checkLogin(String email, String password) async {
  try {
    // Carrega o arquivo de logins dos assets
    final String fileContent = await rootBundle.loadString('assets/logins.txt');
    List<String> lines = fileContent.split('\n');

    for (String line in lines) {
      List<String> credentials = line.split(',');
      if (credentials.length == 3 &&
          credentials[0].trim() == email &&
          credentials[1].trim() == password) {
        // Retorna o nome de usuário se as credenciais forem válidas
        return credentials[2].trim();
      }
    }
  } catch (e) {
    print("Erro ao ler o arquivo: $e");
  }
  // Retorna null se as credenciais não forem válidas
  return null;
}
