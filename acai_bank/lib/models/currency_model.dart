class Currency {
  final double dolar;
  final double euro;

  Currency({required this.dolar, required this.euro});

  factory Currency.fromJson(Map<String, dynamic> json) {
    return Currency(
      dolar: json["USD"]["buy"],
      euro: json["EUR"]["buy"],
    );
  }
}
