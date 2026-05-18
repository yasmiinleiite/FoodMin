import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/api_historico.dart';

class Historico extends StatefulWidget {
  const Historico({super.key});

  @override
  State<Historico> createState() => _HistoricoState();
}

class _HistoricoState extends State<Historico> {
  Future<List<Compra>> _futureHistorico = HistoricoService.buscarHistorico();

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
          child: FutureBuilder<List<Compra>>(
            future: _futureHistorico,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return const Center(child: Text('Erro ao carregar histórico.'));
              }

              final historico = snapshot.data!;

              if (historico.isEmpty) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(40),
                    child: Text('Nenhuma compra realizada ainda.',
                        style: TextStyle(fontSize: 16, color: Colors.grey)),
                  ),
                );
              }

              return ListView.builder(
                itemCount: historico.length,
                itemBuilder: (context, index) {
                  final compra = historico.reversed.toList()[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 8),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Compra #${compra.id}',
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                              Text(compra.data,
                                  style: const TextStyle(
                                      fontSize: 13, color: Colors.grey)),
                            ],
                          ),
                          const Divider(),
                          ...compra.itens.map((item) => Padding(
                                padding: const EdgeInsets.symmetric(vertical: 4),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(item['titulo'],
                                        style: const TextStyle(fontSize: 14)),
                                    Text('Qtd: ${item['quantidade']}',
                                        style: const TextStyle(
                                            color: Colors.grey)),
                                  ],
                                ),
                              )),
                          const Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Total:',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15)),
                              Text(
                                'R\$ ${compra.total.toStringAsFixed(2)}',
                                style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.brown),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}