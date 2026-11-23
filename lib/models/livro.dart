// TP7 - App de Organização de Leituras
// Integrante: Carlos Eduardo da Silva Santos

/// Status possíveis de leitura de um livro.
const List<String> statusLeitura = ['Quero ler', 'Lendo', 'Concluído'];

/// Representa um livro cadastrado na lista pessoal de leituras.
class Livro {
  final String titulo;
  final String autor;
  final String status;

  Livro({required this.titulo, required this.autor, required this.status});
}
