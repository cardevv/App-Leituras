// TP7 - App de Organização de Leituras
// Integrante: Carlos Eduardo da Silva Santos

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:app_leituras/main.dart';
import 'package:app_leituras/models/livro.dart';
import 'package:app_leituras/services/livro_storage.dart';

void main() {
  setUp(() => SharedPreferences.setMockInitialValues({}));

  testWidgets('Tela inicial mostra o nome do integrante', (tester) async {
    await tester.pumpWidget(const AppLeituras());
    await tester.pumpAndSettle();

    expect(find.text('Minhas Leituras'), findsOneWidget);
    expect(find.text('Carlos Eduardo da Silva Santos'), findsOneWidget);
  });

  testWidgets('Cadastra, persiste e remove um livro', (tester) async {
    await tester.pumpWidget(const AppLeituras());
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    await tester.enterText(
      find.widgetWithText(TextField, 'Título'),
      'Dom Casmurro',
    );
    await tester.enterText(
      find.widgetWithText(TextField, 'Autor'),
      'Machado de Assis',
    );
    await tester.tap(find.text('Quero ler'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Lendo').last);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Salvar'));
    await tester.pumpAndSettle();

    expect(find.text('Dom Casmurro'), findsOneWidget);
    expect(find.text('Machado de Assis • Lendo'), findsOneWidget);
    expect(find.text('"Dom Casmurro" adicionado à lista.'), findsOneWidget);

    // Simula reabrir o app: os dados devem vir do SharedPreferences.
    final salvos = await LivroStorage.carregar();
    expect(salvos.single.titulo, 'Dom Casmurro');
    expect(salvos.single.status, 'Lendo');

    await tester.tap(find.byIcon(Icons.delete_outline));
    await tester.pumpAndSettle();
    expect(find.text('Machado de Assis • Lendo'), findsNothing);
    expect(await LivroStorage.carregar(), isEmpty);
  });

  testWidgets('Carrega livros salvos ao iniciar', (tester) async {
    SharedPreferences.setMockInitialValues({
      'livros': [
        Livro(
          titulo: '1984',
          autor: 'George Orwell',
          status: 'Concluído',
        ).toJson(),
      ],
    });

    await tester.pumpWidget(const AppLeituras());
    await tester.pumpAndSettle();

    expect(find.text('1984'), findsOneWidget);
    expect(find.text('George Orwell • Concluído'), findsOneWidget);
  });
}
