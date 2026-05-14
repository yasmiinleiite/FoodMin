import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/api_carrinho.dart';
import 'package:flutter_application_1/icons/lixeira.dart'; 
import 'package:flutter_application_1/icons/editar.dart';

class Carrinho extends StatefulWidget {
  const Carrinho({super.key});

  @override
  State<Carrinho> createState() => _CarrinhoState();
}

class _CarrinhoState extends State<Carrinho> {
  late Future<List<ItemCarrinho>> _futureItens;
  late Future<double> _futureTotal;

  @override
  void initState() {
    super.initState();
    _carregarDados();
  }

  void _carregarDados() {
    _futureItens = CarrinhoService.buscarItens();
    _futureTotal = CarrinhoService.calcularTotal();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFFF4EBDC),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
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
          child: FutureBuilder<List<ItemCarrinho>>(
            future: _futureItens,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return const Center(child: Text('Erro ao carregar carrinho.'));
              }

              final itens = snapshot.data!;

              if (itens.isEmpty) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(40),
                    child: Text('Seu carrinho está vazio.',
                        style: TextStyle(fontSize: 16, color: Colors.grey)),
                  ),
                );
              }

              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: itens.length,
                      itemBuilder: (context, index) {
                        final item = itens[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              children: [
                                item.imagem.startsWith('http')
                                    ? Image.network(
                                        item.imagem,
                                        height: 80,
                                        width: 80,
                                        fit: BoxFit.cover,
                                        errorBuilder: (_, __, ___) =>
                                            const Icon(Icons.fastfood, size: 80),
                                      )
                                    : Image.asset(item.imagem,
                                        height: 80, fit: BoxFit.cover),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(item.titulo,
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold)),
                                      const SizedBox(height: 4),
                                      Text('Qtd: ${item.quantidade}',
                                          style: const TextStyle(
                                              color: Colors.grey)),
                                      Text(
                                        'R\$ ${(item.valor * item.quantidade).toStringAsFixed(2)}',
                                        style: const TextStyle(
                                            fontSize: 15, color: Colors.brown),
                                      ),
                                    ],
                                  ),
                                ),
                                Editar(
                                  item: item,
                                  onAtualizado: () => setState(() {
                                    _carregarDados();
                                  }),
                                ),
                                Lixeira(                        
                                  id: item.id!,
                                  titulo: item.titulo,
                                  onDeletado: () => setState(() {
                                    _carregarDados();
                                  }),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  FutureBuilder<double>(
                    future: _futureTotal,
                    builder: (context, snapshot) {
                      final total = snapshot.data ?? 0.0;
                      return Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                              top: BorderSide(color: Colors.brown.shade100)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Total:',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold)),
                            Text(
                              'R\$ ${total.toStringAsFixed(2)}',
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.brown),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}