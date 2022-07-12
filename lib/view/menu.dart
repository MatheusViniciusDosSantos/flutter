import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  Widget criarBotao(String nomeBotao, VoidCallback? acaoBotao) {
    return ElevatedButton(
      child: Text(nomeBotao),
      onPressed: acaoBotao,
    );
  }

  @override
  Widget build(BuildContext context) {
    var primeiroBotao = ElevatedButton(
      child: const Text("Primeiro Botão"),
      onPressed: () {
        print('Hello world');
      },
    );

    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          criarBotao("Olá mundo!", () => print("Hello World")),
          criarBotao("Calcular idade",
              () => Navigator.pushNamed(context, "/calcularIdade")),
          criarBotao("Hello World", () => Navigator.pushNamed(context, "/helloWorld")),
          criarBotao("Calculadora", () => Navigator.pushNamed(context, "/calculadora"))
        ],
      ),
    ));
  }
}
