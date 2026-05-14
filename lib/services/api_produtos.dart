import 'dart:convert';
import 'package:http/http.dart' as http;

class ProdutoItem {
  final String id;      
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
    id: json['idMeal'],           
    titulo: json['strMeal'],      
    valor: 8.00,                  
    imagem: json['strMealThumb'], 
  );
}

class ProdutosService {
  static const String _baseUrl = 'https://www.themealdb.com/api/json/v1/1'; 

  static Future<List<ProdutoItem>> buscarProdutos() async {
    final response = await http.get(Uri.parse('$_baseUrl/search.php?s='));   
    final data = jsonDecode(response.body);
    final List produtos = data['meals'] ?? [];
    return produtos.map((e) => ProdutoItem.fromJson(e)).toList();
  }
}