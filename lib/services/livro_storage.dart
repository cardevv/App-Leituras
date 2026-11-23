// TP7 - App de Organização de Leituras
// Integrantes: Carlos Eduardo da Silva Santos
//              Ana Carolina dos Santos Sabino

import 'package:shared_preferences/shared_preferences.dart';

import '../models/livro.dart';

/// Responsável por salvar e recuperar a lista de livros localmente.
///
/// Como o SharedPreferences é um armazenamento chave-valor que não aceita
/// objetos, a coleção é guardada sob uma única chave como `List<String>`,
/// em que cada String é um livro codificado em JSON.
class LivroStorage {
  static const String _chave = 'livros';

  static Future<List<Livro>> carregar() async {
    final prefs = await SharedPreferences.getInstance();
    final lista = prefs.getStringList(_chave) ?? [];
    return lista.map(Livro.fromJson).toList();
  }

  static Future<void> salvar(List<Livro> livros) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
      _chave,
      livros.map((livro) => livro.toJson()).toList(),
    );
  }
}
