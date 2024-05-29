import 'dart:convert';

import 'package:http/http.dart' as http;

// Função assíncrona para obter dados da API
Future<Map> getData() async {
  // URL da API com a chave de acesso
  var url =
      Uri.parse('https://api.hgbrasil.com/finance?format=json&key=9525e6c5');

  // Faz uma requisição GET para a URL
  http.Response response = await http.get(url);

  // Imprime o status da resposta (200, 404, etc.)
  print('Response status: ${response.statusCode}');

  // Imprime o corpo da resposta (os dados em JSON)
  print('Response body: ${response.body}');

  // Converte o JSON da resposta para um Map e retorna
  return json.decode(response.body);
}
