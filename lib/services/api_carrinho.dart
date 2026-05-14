import 'dart:convert';
import 'package:http/http.dart' as http;

class ItemCarrinho {
  int? id;
  final String titulo;
  final double valor;
  final String imagem;
  int quantidade;

  ItemCarrinho({
    this.id,
    required this.titulo,
    required this.valor,
    required this.imagem,
    required this.quantidade,
  });

  Map<String, dynamic> toJson() => {
    'titulo': titulo,
    'valor': valor,
    'imagem': imagem,
    'quantidade': quantidade,
  };

  factory ItemCarrinho.fromJson(Map<String, dynamic> json) => ItemCarrinho(
    id: json['id'],
    titulo: json['titulo'],
    valor: (json['valor'] as num).toDouble(),
    imagem: json['imagem'],
    quantidade: json['quantidade'],
  );
}

class CarrinhoService {
  static const String _baseUrl = 'http://localhost:3000';

  static Future<List<ItemCarrinho>> buscarItens() async {
    final response = await http.get(Uri.parse('$_baseUrl/carrinho'));
    final List data = jsonDecode(response.body);
    return data.map((e) => ItemCarrinho.fromJson(e)).toList();
  }

  static Future<void> atualizarItem(ItemCarrinho item) async {
  await http.put(
    Uri.parse('$_baseUrl/carrinho/${item.id}'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(item.toJson()));
  }

  static Future<void> adicionarItem(ItemCarrinho novoItem) async {
    final itens = await buscarItens();
    final existente = itens.firstWhere(
      (i) => i.titulo == novoItem.titulo,
      orElse: () => ItemCarrinho(titulo: '', valor: 0, imagem: '', quantidade: 0),
    );

    if (existente.titulo.isNotEmpty) {
      await http.patch(
        Uri.parse('$_baseUrl/carrinho/${existente.id}'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'quantidade': existente.quantidade + novoItem.quantidade}),
      );
    } else {
      await http.post(
        Uri.parse('$_baseUrl/carrinho'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(novoItem.toJson()),
      );
    }
  }

  static Future<double> calcularTotal() async {
    final itens = await buscarItens();
    return itens.fold<double>(0, (soma, item) => soma + item.valor * item.quantidade);
  }

  static Future<void> removerItem(int id) async {
  await http.delete(Uri.parse('$_baseUrl/carrinho/$id'));
}
}