import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/api_carrinho.dart';

class Editar extends StatelessWidget {
  final ItemCarrinho item;
  final VoidCallback onAtualizado;

  const Editar({
    super.key,
    required this.item,
    required this.onAtualizado,
  });

  void _mostrarEdicao(BuildContext context) {
    int novaQuantidade = item.quantidade;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) {
          return AlertDialog(
            title: Text(item.titulo),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.remove_circle_outline),
                  onPressed: novaQuantidade > 1
                      ? () => setDialogState(() => novaQuantidade--)
                      : null,
                ),
                Text('$novaQuantidade',
                    style: const TextStyle(fontSize: 22)),
                IconButton(
                  icon: const Icon(Icons.add_circle_outline),
                  onPressed: () => setDialogState(() => novaQuantidade++),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancelar'),
              ),
              TextButton(
                onPressed: () async {
                  Navigator.pop(context);
                  await CarrinhoService.atualizarItem(ItemCarrinho(
                    id: item.id,
                    titulo: item.titulo,
                    valor: item.valor,
                    imagem: item.imagem,
                    quantidade: novaQuantidade,
                  ));
                  onAtualizado();
                },
                child: const Text('Salvar',
                    style: TextStyle(color: Colors.brown)),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.edit, color: Colors.brown),
      onPressed: () => _mostrarEdicao(context),
    );
  }
}