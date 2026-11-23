// TP7 - App de Organização de Leituras
// Integrante: Carlos Eduardo da Silva Santos

import 'package:flutter_test/flutter_test.dart';

import 'package:app_leituras/main.dart';

void main() {
  testWidgets('Tela inicial mostra o nome do integrante', (tester) async {
    await tester.pumpWidget(const AppLeituras());
    await tester.pumpAndSettle();

    expect(find.text('Minhas Leituras'), findsOneWidget);
    expect(find.text('Carlos Eduardo da Silva Santos'), findsOneWidget);
  });
}
