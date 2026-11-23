// TP7 - App de Organização de Leituras
// Integrante: Carlos Eduardo da Silva Santos

import 'package:flutter/material.dart';

import '../models/livro.dart';
import 'cadastro_screen.dart';

/// Tela inicial: exibe a lista de livros cadastrados.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Livro> _livros = [];

  Future<void> _abrirCadastro() async {
    // Navega para a tela de cadastro e aguarda o livro retornado.
    final novoLivro = await Navigator.push<Livro>(
      context,
      MaterialPageRoute(builder: (context) => const CadastroScreen()),
    );

    if (novoLivro == null || !mounted) return;

    setState(() => _livros.add(novoLivro));

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('"${novoLivro.titulo}" adicionado à lista.')),
    );
  }

  void _removerLivro(int index) {
    final removido = _livros[index];
    setState(() => _livros.removeAt(index));

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('"${removido.titulo}" removido da lista.')),
    );
  }

  IconData _iconeStatus(String status) {
    switch (status) {
      case 'Lendo':
        return Icons.menu_book;
      case 'Concluído':
        return Icons.check_circle;
      default:
        return Icons.bookmark_border;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Minhas Leituras'),
            Text(
              'Carlos Eduardo da Silva Santos',
              style: TextStyle(fontSize: 13),
            ),
          ],
        ),
      ),
      body: _livros.isEmpty
          ? const Center(
              child: Text(
                'Nenhum livro cadastrado.\nToque em + para adicionar.',
                textAlign: TextAlign.center,
              ),
            )
          : ListView.builder(
              itemCount: _livros.length,
              itemBuilder: (context, index) {
                final livro = _livros[index];
                return ListTile(
                  leading: Icon(_iconeStatus(livro.status)),
                  title: Text(livro.titulo),
                  subtitle: Text('${livro.autor} • ${livro.status}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline),
                    tooltip: 'Remover',
                    onPressed: () => _removerLivro(index),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _abrirCadastro,
        tooltip: 'Adicionar livro',
        child: const Icon(Icons.add),
      ),
    );
  }
}
