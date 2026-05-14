import 'package:flutter/material.dart';

class Descricao extends StatelessWidget {
  String texto;
  Color cor;
  Descricao({super.key, required this.texto, required this.cor}); 


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