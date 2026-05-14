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
  List controladores = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFFF4EBDC),

      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: 400,
            padding: const EdgeInsets.all(30),

            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),

            child: Column(
              mainAxisSize: MainAxisSize.min,

              children: [
                const Text(
                  "Login",

                  style: TextStyle(
                    color: Color(0XFFFC742C),
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Spaces(),

                // email
                TextField(
                  decoration: InputDecoration(
                    labelText: "E-mail:",

                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0XFFFC742C),
                      ),
                    ),

                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0XFFFC742C),
                        width: 2,
                      ),
                    ),
                  ),
                ),

                Spaces(),

                // senha
                TextField(
                  obscureText: true,

                  decoration: InputDecoration(
                    labelText: "Senha:",

                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0XFFFC742C),
                      ),
                    ),

                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0XFFFC742C),
                        width: 2,
                      ),
                    ),
                  ),
                ),

                Spaces(),

                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: const Color(0XFFFC742C),

                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 15,
                    ),

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),

                  onPressed: () {
                    Navigator.push(
                      context,

                      MaterialPageRoute(
                        builder: (context) => const Home(),
                      ),
                    );
                  },

                  child: const Text(
                    "Login",

                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}