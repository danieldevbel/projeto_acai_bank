import 'package:flutter/material.dart';

import '../services/api_service.dart';
import '../widgets/currency_text_field.dart';

class Quotation extends StatefulWidget {
  const Quotation({super.key});

  @override
  _QuotationState createState() => _QuotationState();
}

class _QuotationState extends State<Quotation> with TickerProviderStateMixin {
  final realController = TextEditingController();
  final dolarController = TextEditingController();
  final euroController = TextEditingController();
  final bitcoinController = TextEditingController();

  double dolar = 0.0;
  double euro = 0.0;
  double bitcoin = 0.0;

  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);
    _animation =
        Tween<double>(begin: 0.8, end: 1.2).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  VoidCallback? _realChanged(String text) {
    if (text.isEmpty) {
      dolarController.text = "";
      euroController.text = "";
      bitcoinController.text = "";
      return null;
    }
    double real = double.parse(text);
    dolarController.text = (real / dolar).toStringAsFixed(2);
    euroController.text = (real / euro).toStringAsFixed(2);
    bitcoinController.text = (real / bitcoin).toStringAsFixed(8);
  }

  VoidCallback? _dolarChanged(String text) {
    if (text.isEmpty) {
      realController.text = "";
      euroController.text = "";
      bitcoinController.text = "";
      return null;
    }
    double dolar = double.parse(text);
    realController.text = (dolar * this.dolar).toStringAsFixed(2);
    euroController.text = (dolar * this.dolar / euro).toStringAsFixed(2);
    bitcoinController.text = (dolar * this.dolar / bitcoin).toStringAsFixed(8);
  }

  VoidCallback? _euroChanged(String text) {
    if (text.isEmpty) {
      realController.text = "";
      dolarController.text = "";
      bitcoinController.text = "";
      return null;
    }
    double euro = double.parse(text);
    realController.text = (euro * this.euro).toStringAsFixed(2);
    dolarController.text = (euro * this.euro / dolar).toStringAsFixed(2);
    bitcoinController.text = (euro * this.euro / bitcoin).toStringAsFixed(8);
  }

  VoidCallback? _bitcoinChanged(String text) {
    if (text.isEmpty) {
      realController.text = "";
      dolarController.text = "";
      euroController.text = "";
      return null;
    }
    double bitcoin = double.parse(text);
    realController.text = (bitcoin * this.bitcoin).toStringAsFixed(2);
    dolarController.text = (bitcoin * this.bitcoin / dolar).toStringAsFixed(2);
    euroController.text = (bitcoin * this.bitcoin / euro).toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Conversor de Moedas'),
      ),
      body: FutureBuilder<Map>(
        future: getData(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                child: AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _animation.value,
                      child: Icon(
                        Icons.attach_money,
                        color: Color.fromARGB(255, 70, 11, 70),
                        size: 100.0,
                      ),
                    );
                  },
                ),
              );
            default:
              if (snapshot.hasError) {
                String? erro = snapshot.error.toString();
                return Center(
                  child: Text(
                    "Ops, houve uma falha ao buscar os dados : $erro",
                    style: const TextStyle(
                        color: Color.fromARGB(255, 70, 11, 70), fontSize: 25.0),
                    textAlign: TextAlign.center,
                  ),
                );
              } else {
                dolar = snapshot.data!["results"]["currencies"]["USD"]["buy"];
                euro = snapshot.data!["results"]["currencies"]["EUR"]["buy"];
                bitcoin = snapshot.data!["results"]["currencies"]["BTC"]["buy"];
                return SingleChildScrollView(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      const Icon(Icons.attach_money,
                          size: 160.0, color: Color.fromARGB(255, 70, 11, 70)),
                      CurrencyTextField(
                          label: "Reais",
                          prefix: "R\$ ",
                          controller: realController,
                          onChanged: _realChanged),
                      const Divider(),
                      CurrencyTextField(
                          label: "Euros",
                          prefix: "€ ",
                          controller: euroController,
                          onChanged: _euroChanged),
                      const Divider(),
                      CurrencyTextField(
                          label: "Dólares",
                          prefix: "US\$ ",
                          controller: dolarController,
                          onChanged: _dolarChanged),
                      const Divider(),
                      CurrencyTextField(
                          label: "Bitcoin",
                          prefix: "₿ ",
                          controller: bitcoinController,
                          onChanged: _bitcoinChanged),
                    ],
                  ),
                );
              }
          }
        },
      ),
    );
  }
}
