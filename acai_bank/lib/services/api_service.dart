import 'dart:convert';

import 'package:http/http.dart' as http;

Future<Map> getData() async {
  var url =
      Uri.parse('https://api.hgbrasil.com/finance?format=json&key=9525e6c5');

  http.Response response = await http.get(url);
  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');
  return json.decode(response.body);
}
