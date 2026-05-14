import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/api_carrinho.dart';

class Lixeira extends StatelessWidget {
  final int id;
  final String titulo;
  final VoidCallback onDeletado;

  const Lixeira({
    super.key,
    required this.id,
    required this.titulo,
    required this.onDeletado,
  });

  void _confirmarDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Remover item'),
        content: Text('Tem certeza que deseja remover "$titulo" do carrinho?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              await CarrinhoService.removerItem(id);
              onDeletado();
            },
            child: const Text('Remover', style: TextStyle(color: Colors.brown)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.delete, color: Colors.brown),
      onPressed: () => _confirmarDelete(context),
    );
  }
}