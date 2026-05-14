import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/produtos.dart';
import 'package:flutter_application_1/icons/carrinho.dart';
import 'package:flutter_application_1/pages/carrinho.dart';
import 'package:flutter_application_1/services/api_produtos.dart'; 

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<List<ProdutoItem>> _futureProdutos = ProdutosService.buscarProdutos(); 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFFF4EBDC),
      appBar: AppBar(
        iconTheme: IconThemeData(
        color: Colors.white,),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
            image: AssetImage("assets/food_copi2.jpg"),
            fit: BoxFit.cover,
            ),
          ),
        ),
      ),

      body: Center(
        
        child: Container(
        width: 500,
        color: Colors.white,
        child: 
          Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: const Icon(Icons.shopping_cart, color: Colors.brown, size: 30),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const Carrinho()),
                  ),
                ),
              ),

              Expanded(
                child: FutureBuilder<List<ProdutoItem>>(
                  future: _futureProdutos,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return const Center(child: Text('Erro ao carregar produtos.'));
                    }

                    final produtos = snapshot.data!;

                    return ListView.builder(
                      itemCount: produtos.length,
                      itemBuilder: (context, index) {
                        final p = produtos[index];
                        return Produto(
                          titulo: p.titulo,
                          valor: p.valor,
                          imagem: p.imagem,
                        );
                      },
                    );
                  },
                ),
              ),
            ],
        ),
        ),
      ),
    );
  }
}