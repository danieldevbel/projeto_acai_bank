import 'package:flutter/material.dart';

// Classe que define um campo de texto customizado para moedas
class CurrencyTextField extends StatelessWidget {
  // Variáveis finais que guardam os valores do rótulo, prefixo, controlador e callback
  final String label; // O texto que aparece como rótulo do campo
  final String
      prefix; // O prefixo que aparece antes do valor no campo (ex: R$, $)
  final TextEditingController
      controller; // Controlador para manipular o valor do campo
  final Function(String)?
      onChanged; // Função callback chamada quando o texto muda

  // Construtor que inicializa os atributos e define a chave super.key
  const CurrencyTextField({
    super.key,
    required this.label,
    required this.prefix,
    required this.controller,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller, // Controlador do campo de texto
      decoration: InputDecoration(
        labelText: label, // Define o texto do rótulo
        labelStyle: const TextStyle(
            color: Color.fromARGB(255, 70, 11, 70)), // Estilo do rótulo
        border: const OutlineInputBorder(), // Define a borda do campo
        prefixText: prefix, // Define o prefixo do campo
      ),
      style: const TextStyle(
          color: Color.fromARGB(255, 70, 11, 70),
          fontSize: 25.0), // Estilo do texto dentro do campo
      onChanged: onChanged, // Chama a função passada quando o texto muda
      keyboardType: const TextInputType.numberWithOptions(
          decimal:
              true), // Define o tipo de teclado (numérico com opção de decimal)
    );
  }
}
