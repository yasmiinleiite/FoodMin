import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/api_carrinho.dart';

class Produto extends StatelessWidget {
  String titulo;
  double valor;
  String imagem;
  Produto({super.key, required this.titulo, required this.valor, required this.imagem});

  void _mostrarSeletor(BuildContext context) {
    int quantidade = 1;

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(titulo,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text('R\$ ${valor.toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 16, color: Colors.grey)),
                  const SizedBox(height: 24),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove_circle_outline),
                        onPressed: quantidade > 1
                            ? () => setModalState(() => quantidade--)
                            : null,
                      ),
                      Text('$quantidade', style: const TextStyle(fontSize: 22)),
                      IconButton(
                        icon: const Icon(Icons.add_circle_outline),
                        onPressed: () => setModalState(() => quantidade++),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.brown,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () async {
                        Navigator.pop(context);
                        await CarrinhoService.adicionarItem(ItemCarrinho(
                          titulo: titulo,
                          valor: valor,
                          imagem: imagem,
                          quantidade: quantidade,
                        ));
                      },
                      child: const Text('Adicionar ao carrinho',
                          style: TextStyle(color: Colors.white, fontSize: 16)),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    print('imagem: $imagem');
    print('starts with http: ${imagem.startsWith('http')}');

    return Card(
      child: Container(
        width: 400,
        padding: const EdgeInsets.all(30),
        child: Row(
          children: [
            imagem.startsWith('http')
                ? Image.network(
                    imagem,
                    height: 80,
                    width: 80,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) =>
                        const Icon(Icons.fastfood, size: 80),
                  )
                : Image.asset(imagem, height: 80),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(titulo,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold)),
                Row(
                  children: [
                    const SizedBox(width: 100),
                    Text("R\$ ${valor.toStringAsFixed(2)}"),
                    IconButton(
                      icon: const Icon(Icons.add_shopping_cart, color: Colors.brown),
                      onPressed: () => _mostrarSeletor(context),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}