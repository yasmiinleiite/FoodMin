import 'dart:convert';
import 'package:http/http.dart' as http;

class ProdutoItem {
  final int id;
  final String titulo;
  final double valor;
  final String imagem;

  ProdutoItem({
    required this.id,
    required this.titulo,
    required this.valor,
    required this.imagem,
  });

  factory ProdutoItem.fromJson(Map<String, dynamic> json) => ProdutoItem(
    id: json['id'],
    titulo: json['titulo'],
    valor: (json['valor'] as num).toDouble(),
    imagem: json['imagem'],
  );
}

class ProdutosService {
  static const String _baseUrl = 'http://localhost:3000';

  static Future<List<ProdutoItem>> buscarProdutos() async {
    final response = await http.get(Uri.parse('$_baseUrl/produtos'));
    final List data = jsonDecode(response.body);
    return data.map((e) => ProdutoItem.fromJson(e)).toList();
  }
}