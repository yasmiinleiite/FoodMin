import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Compra {
  final int id;
  final double total;
  final String data;
  final List<Map<String, dynamic>> itens;

  Compra({
    required this.id,
    required this.total,
    required this.data,
    required this.itens,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'total': total,
    'data': data,
    'itens': itens,
  };

  factory Compra.fromJson(Map<String, dynamic> json) => Compra(
    id: json['id'],
    total: (json['total'] as num).toDouble(),
    data: json['data'],
    itens: List<Map<String, dynamic>>.from(json['itens']),
  );
}

class HistoricoService {
  static const String _chave = 'historico';

  static Future<List<Compra>> buscarHistorico() async {
    final prefs = await SharedPreferences.getInstance();
    final String? dados = prefs.getString(_chave);
    if (dados == null) return [];
    final List lista = jsonDecode(dados);
    return lista.map((e) => Compra.fromJson(e)).toList();
  }

  static Future<void> salvarCompra({
    required double total,
    required List<Map<String, dynamic>> itens,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final historico = await buscarHistorico();

    final novaCompra = Compra(
      id: historico.length + 1,
      total: total,
      data: DateTime.now().toString().substring(0, 16),
      itens: itens,
    );

    historico.add(novaCompra);
    await prefs.setString(_chave, jsonEncode(historico.map((e) => e.toJson()).toList()));
  }
}