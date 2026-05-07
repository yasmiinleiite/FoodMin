// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/services/api_carrinho.dart';

// class CarrinhoPage extends StatefulWidget {
//   const CarrinhoPage({super.key});

//   @override
//   State<CarrinhoPage> createState() => _CarrinhoPageState();
// }

// class _CarrinhoPageState extends State<CarrinhoPage> {
//   Future<List<ItemCarrinho>> _futureItens = CarrinhoService.buscarItens();
//   Future<double> _futureTotal = CarrinhoService.calcularTotal();


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0XFFF4EBDC),
//       appBar: AppBar(
//         flexibleSpace: Container(
//           decoration: const BoxDecoration(
//             image: DecorationImage(
//               image: AssetImage("assets/food_copi2.jpg"),
//               fit: BoxFit.cover,
//             ),
//           ),
//         ),
//       ),

//       body: Center(
//         child: Container(
//           width: 500,
//           color: Colors.white,
//           child: FutureBuilder<List<ItemCarrinho>>(
//             future: _futureItens,
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return const Center(child: CircularProgressIndicator());
//               }
//               if (snapshot.hasError) {
//                 return const Center(child: Text('Erro ao carregar carrinho.'));
//               }

//               final itens = snapshot.data!;

//               if (itens.isEmpty) {
//                 return const Center(
//                   child: Padding(
//                     padding: EdgeInsets.all(40),
//                     child: Text('Seu carrinho está vazio.',
//                         style: TextStyle(fontSize: 16, color: Colors.grey)),
//                   ),
//                 );
//               }

//               return Column(
//                 children: [
//                   Expanded(
//                     child: ListView.builder(
//                       itemCount: itens.length,
//                       itemBuilder: (context, index) {
//                         final item = itens[index];
//                         return Card(
//                           margin: const EdgeInsets.symmetric(
//                               horizontal: 12, vertical: 8),
//                           child: Container(
//                             padding: const EdgeInsets.all(16),
//                             child: Row(
//                               children: [
//                                 Image.asset(item.imagem,
//                                     height: 80, fit: BoxFit.cover),
//                                 const SizedBox(width: 16),
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(item.titulo,
//                                         style: const TextStyle(
//                                             fontSize: 16,
//                                             fontWeight: FontWeight.bold)),
//                                     const SizedBox(height: 4),
//                                     Text('Qtd: ${item.quantidade}',
//                                         style: const TextStyle(color: Colors.grey)),
//                                     Text(
//                                       'R\$ ${(item.valor * item.quantidade).toStringAsFixed(2)}',
//                                       style: const TextStyle(
//                                           fontSize: 15, color: Colors.brown),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   ),

//                   FutureBuilder<double>(
//                     future: _futureTotal,
//                     builder: (context, snapshot) {
//                       final total = snapshot.data ?? 0.0;
//                       return Container(
//                         padding: const EdgeInsets.all(20),
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           border: Border(
//                               top: BorderSide(color: Colors.brown.shade100)),
//                         ),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             const Text('Total:',
//                                 style: TextStyle(
//                                     fontSize: 18, fontWeight: FontWeight.bold)),
//                             Text(
//                               'R\$ ${total.toStringAsFixed(2)}',
//                               style: const TextStyle(
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.brown),
//                             ),
//                           ],
//                         ),
//                       );
//                     },
//                   ),
//                 ],
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/api_carrinho.dart';

class CarrinhoPage extends StatefulWidget {
  const CarrinhoPage({super.key});

  @override
  State<CarrinhoPage> createState() => _CarrinhoPageState();
}

class _CarrinhoPageState extends State<CarrinhoPage> {
  Future<List<ItemCarrinho>> _futureItens = CarrinhoService.buscarItens();
  Future<double> _futureTotal = CarrinhoService.calcularTotal();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFFF4EBDC),
      appBar: AppBar(
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
                                Image.asset(item.imagem,
                                    height: 80, fit: BoxFit.cover),
                                const SizedBox(width: 16),
                                Expanded(                              // ✅ adicionado
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(item.titulo,
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold)),
                                      const SizedBox(height: 4),
                                      Text('Qtd: ${item.quantidade}',
                                          style: const TextStyle(color: Colors.grey)),
                                      Text(
                                        'R\$ ${(item.valor * item.quantidade).toStringAsFixed(2)}',
                                        style: const TextStyle(
                                            fontSize: 15, color: Colors.brown),
                                      ),
                                    ],
                                  ),
                                ),
                                IconButton(                            // ✅ adicionado
                                  icon: const Icon(Icons.delete, color: Colors.red),
                                  onPressed: () async {
                                    await CarrinhoService.removerItem(item.id!);
                                    setState(() {
                                      _futureItens = CarrinhoService.buscarItens();
                                      _futureTotal = CarrinhoService.calcularTotal();
                                    });
                                  },
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
                                    fontSize: 18, fontWeight: FontWeight.bold)),
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