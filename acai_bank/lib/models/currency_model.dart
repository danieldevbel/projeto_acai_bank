// Classe que representa a cotação das moedas
class Currency {
  // Atributos para guardar as cotações
  final double dolar;
  final double euro;
  final double bitcoin;

  // Construtor que inicializa os atributos com os valores passados
  Currency({required this.dolar, required this.euro, required this.bitcoin});

  // Método de fábrica que cria uma instância de Currency a partir de um JSON
  factory Currency.fromJson(Map<String, dynamic> json) {
    return Currency(
      // Pegando os valores de compra das moedas do JSON
      dolar: json["USD"]["buy"],
      euro: json["EUR"]["buy"],
      bitcoin: json["BTC"]["buy"],
    );
  }
}
