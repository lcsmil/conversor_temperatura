import 'package:flutter/material.dart';

void main() {
  runApp(ConversorTemperatura());
}

class ConversorTemperatura extends StatelessWidget {
  @override
  build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: TempApp(),
    );
  }
}

class TempApp extends StatefulWidget {
  @override
  TempState createState() => TempState();
}

class TempState extends State<TempApp> {
  double entrada;
  double saida;
  bool fOrC;

  @override
  void initState() {
    super.initState();
    entrada = 0.0;
    saida = 0.0;
    fOrC = true;
  }

  @override
  Widget build(BuildContext context) {
    TextField inputField = TextField(
      keyboardType: TextInputType.number,
      onChanged: (str) {
        try {
          entrada = double.parse(str);
        } catch (e) {
          entrada = 0.0;
        }
      },
      decoration: InputDecoration(
        labelText:
            "Insira um valor em ${fOrC == false ? "Fahrenheit" : "Celsius"}",
      ),
      textAlign: TextAlign.center,
    );

    AppBar appBar = AppBar(
      title: Text("Calculadora de temperatura"),
      centerTitle: true,
    );

    Container tempSwitch = Container(
      padding: EdgeInsets.all(15.0),
      child: Row(
        children: <Widget>[
          Text(
            "F",
            style: TextStyle(fontSize: 20),
          ),
          Radio<bool>(
              groupValue: fOrC,
              value: false,
              onChanged: (v) {
                setState(() {
                  fOrC = v;
                });
              }),
          Text("C", style: TextStyle(fontSize: 20)),
          Radio<bool>(
              groupValue: fOrC,
              value: true,
              onChanged: (v) {
                setState(() {
                  fOrC = v;
                });
              }),
        ],
      ),
    );

    Container calcBtn = Container(
      child: RaisedButton(
        child: Text("Calcular", style: TextStyle(fontSize: 20)),
        onPressed: () {
          setState(() {
            fOrC == false
                ? saida = (entrada - 32) * (5 / 9)
                : saida = (entrada * 9 / 5) + 32;
          });
          AlertDialog dialog = AlertDialog(
            content: fOrC == false
                ? Text(
                    "${entrada.toStringAsFixed(2)} F : ${saida.toStringAsFixed(2)} C")
                : Text(
                    "${entrada.toStringAsFixed(2)} C : ${saida.toStringAsFixed(2)} F"),
          );
          showDialog(context: context, child: dialog);
        },
      ),
    );

    return Scaffold(
      appBar: appBar,
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            inputField,
            tempSwitch,
            calcBtn,
          ],
        ),
      ),
    );
  }
}
