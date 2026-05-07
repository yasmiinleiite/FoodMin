import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/spaces.dart';
import 'package:flutter_application_1/pages/home.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  List listaApi = [];
  List controladores = []; // corrigido nome

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFFF4EBDC),

      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text("Login", style: TextStyle(color: Color(0XFFFC742C))),

              TextField(
                decoration: InputDecoration(
                  labelText: "E-mail:",
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0XFFFC742C)),
                  ),
                  focusedBorder: OutlineInputBorder(),
                ),
              ),

              Spaces(),

              TextField(
                decoration: InputDecoration(
                  labelText: "Senha:",
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0XFFFC742C)),
                  ),
                  focusedBorder: OutlineInputBorder(),
                ),
              ),

              Spaces(),

              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Color(0XFFFC742C)),
                onPressed: () {
                  Navigator.push(context , 
                  MaterialPageRoute(builder: (context) => Home()));
                },
                child: Text( "Login", style: TextStyle(color: Colors.white))
              ),
            ],
          ), 
          ),
        ),
      );
    
  }
}