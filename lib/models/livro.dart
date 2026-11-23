// TP7 - App de Organização de Leituras
// Integrantes: Carlos Eduardo da Silva Santos
//              Ana Carolina dos Santos Sabino

import 'dart:convert';

/// Status possíveis de leitura de um livro.
const List<String> statusLeitura = ['Quero ler', 'Lendo', 'Concluído'];

/// Representa um livro cadastrado na lista pessoal de leituras.
class Livro {
  final String titulo;
  final String autor;
  final String status;

  Livro({required this.titulo, required this.autor, required this.status});

  /// Converte o livro em um Map, para poder ser serializado em JSON.
  Map<String, dynamic> toMap() => {
    'titulo': titulo,
    'autor': autor,
    'status': status,
  };

  /// Cria um livro a partir de um Map (lido do JSON armazenado).
  factory Livro.fromMap(Map<String, dynamic> map) => Livro(
    titulo: map['titulo'] as String,
    autor: map['autor'] as String,
    status: statusLeitura.contains(map['status'])
        ? map['status'] as String
        : statusLeitura.first,
  );

  /// O SharedPreferences só guarda tipos simples (String, int, bool,
  /// double e `List<String>`). Por isso cada livro vira uma String JSON.
  String toJson() => jsonEncode(toMap());

  factory Livro.fromJson(String source) =>
      Livro.fromMap(jsonDecode(source) as Map<String, dynamic>);
}
