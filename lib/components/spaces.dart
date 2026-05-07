import 'package:flutter/material.dart';

class Spaces extends StatelessWidget {
  const Spaces ({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.05,
      height: MediaQuery.of(context).size.height * 0.05,
    );
  }
}