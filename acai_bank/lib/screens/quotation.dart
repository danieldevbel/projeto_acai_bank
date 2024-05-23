import 'package:flutter/material.dart';

import '../services/api_service.dart';
import '../widgets/currency_text_field.dart';

class Quotation extends StatefulWidget {
  const Quotation({super.key});

  @override
  _QuotationState createState() => _QuotationState();
}

class _QuotationState extends State<Quotation> {
  final realController = TextEditingController();
  final dolarController = TextEditingController();
  final euroController = TextEditingController();
  double dolar = 0.0;
  double euro = 0.0;

  VoidCallback? _realChanged(String text) {
    if (text.isEmpty) {
      dolarController.text = "";
      euroController.text = "";
      return null;
    }
    double real = double.parse(text);
    dolarController.text = (real / dolar).toStringAsFixed(2);
    euroController.text = (real / euro).toStringAsFixed(2);
  }

  VoidCallback? _dolarChanged(String text) {
    if (text.isEmpty) {
      realController.text = "";
      euroController.text = "";
      return null;
    }
    double dolar = double.parse(text);
    realController.text = (dolar * this.dolar).toStringAsFixed(2);
    euroController.text = (dolar * this.dolar / euro).toStringAsFixed(2);
  }

  VoidCallback? _euroChanged(String text) {
    if (text.isEmpty) {
      realController.text = "";
      dolarController.text = "";
      return null;
    }
    double euro = double.parse(text);
    realController.text = (euro * this.euro).toStringAsFixed(2);
    dolarController.text = (euro * this.euro / dolar).toStringAsFixed(2);
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
              return const Center(
                child: Text(
                  "Aguarde...",
                  style: TextStyle(color: Colors.green, fontSize: 30.0),
                  textAlign: TextAlign.center,
                ),
              );
            default:
              if (snapshot.hasError) {
                String? erro = snapshot.error.toString();
                return Center(
                  child: Text(
                    "Ops, houve uma falha ao buscar os dados : $erro",
                    style: const TextStyle(color: Colors.green, fontSize: 25.0),
                    textAlign: TextAlign.center,
                  ),
                );
              } else {
                dolar = snapshot.data!["results"]["currencies"]["USD"]["buy"];
                euro = snapshot.data!["results"]["currencies"]["EUR"]["buy"];
                return SingleChildScrollView(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      const Icon(Icons.attach_money,
                          size: 180.0, color: Colors.green),
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
