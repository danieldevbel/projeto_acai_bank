import 'package:flutter/services.dart' show rootBundle;

Future<bool> checkLogin(String email, String password) async {
  try {
    // Carrega o conteúdo do arquivo de credenciais dos assets
    String content = await rootBundle.loadString('assets/logins.txt');
    List<String> lines = content.split('\n');
    for (String line in lines) {
      List<String> credentials = line.split(',');
      if (credentials.length == 2 &&
          credentials[0].trim() == email &&
          credentials[1].trim() == password) {
        // Se encontrar o email e senha, retorne true
        return true;
      }
    }
  } catch (e) {
    print("Erro ao ler o arquivo: $e");
  }
  // Se não encontrar as credenciais, retorne false
  return false;
}
