class Currency {
  final double dolar;
  final double euro;
  final double bitcoin;

  Currency({required this.dolar, required this.euro, required this.bitcoin});

  factory Currency.fromJson(Map<String, dynamic> json) {
    return Currency(
      dolar: json["USD"]["buy"],
      euro: json["EUR"]["buy"],
      bitcoin: json["BTC"]["buy"],
    );
  }
}
