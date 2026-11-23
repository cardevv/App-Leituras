// TP7 - App de Organização de Leituras
// Integrante: Carlos Eduardo da Silva Santos

import 'package:flutter/material.dart';

import '../models/livro.dart';

/// Segunda tela: formulário para cadastrar um novo livro.
/// Ao salvar, devolve o [Livro] criado para a tela inicial via Navigator.pop.
class CadastroScreen extends StatefulWidget {
  const CadastroScreen({super.key});

  @override
  State<CadastroScreen> createState() => _CadastroScreenState();
}

class _CadastroScreenState extends State<CadastroScreen> {
  final _tituloController = TextEditingController();
  final _autorController = TextEditingController();
  String _statusSelecionado = statusLeitura.first;

  @override
  void dispose() {
    _tituloController.dispose();
    _autorController.dispose();
    super.dispose();
  }

  void _salvar() {
    final titulo = _tituloController.text.trim();
    final autor = _autorController.text.trim();

    if (titulo.isEmpty || autor.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preencha o título e o autor.')),
      );
      return;
    }

    final livro = Livro(
      titulo: titulo,
      autor: autor,
      status: _statusSelecionado,
    );

    // Volta para a tela inicial devolvendo o livro cadastrado.
    Navigator.pop(context, livro);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Cadastrar livro'),
            Text(
              'Carlos Eduardo da Silva Santos',
              style: TextStyle(fontSize: 13),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _tituloController,
              decoration: const InputDecoration(
                labelText: 'Título',
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _autorController,
              decoration: const InputDecoration(
                labelText: 'Autor',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            InputDecorator(
              decoration: const InputDecoration(
                labelText: 'Status da leitura',
                border: OutlineInputBorder(),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _statusSelecionado,
                  isExpanded: true,
                  isDense: true,
                  items: statusLeitura
                      .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                      .toList(),
                  onChanged: (valor) {
                    if (valor != null) {
                      setState(() => _statusSelecionado = valor);
                    }
                  },
                ),
              ),
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: _salvar,
              icon: const Icon(Icons.save),
              label: const Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }
}
