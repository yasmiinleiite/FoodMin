// import 'package:flutter/material.dart';

// class Descricao extends StatelessWidget {
//   const Descricao({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Text("Massa de mandioca, requeijão com tomate")
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';

class Descricao extends StatelessWidget {
  String texto;
  Color cor;
  Descricao({super.key, required this.texto, required this.cor}); 
  //Tiramos o const pois o componente irá receber o valor de uma variavel 


  @override
  Widget build(BuildContext context) {
    return Text(texto, 
    style: TextStyle(
      fontSize: 40,
      fontWeight: FontWeight.bold,
      letterSpacing: 2,
      color: cor
    ),);
  }
}