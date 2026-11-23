# App de Organização de Leituras (TP7)

**Integrantes:**

- Carlos Eduardo da Silva Santos
- Ana Carolina dos Santos Sabino

Aplicativo Flutter para organizar uma lista pessoal de livros.

## Funcionalidades

- Tela inicial com `ListView` dos livros cadastrados (título, autor e status).
- Tela de cadastro com `TextField` para título e autor e `DropdownButton` para o status: **Quero ler**, **Lendo** ou **Concluído**.
- Adição e remoção de livros, com mensagens de confirmação via `SnackBar` / `ScaffoldMessenger`.
- Navegação entre as telas com `Navigator.push` / `Navigator.pop`.
- Atualização da interface com `StatefulWidget` e `setState`.
- Persistência local com `shared_preferences`: os dados continuam disponíveis após fechar e reabrir o app.

## Como a coleção é armazenada

O `SharedPreferences` é um armazenamento chave-valor que só aceita tipos simples
(`String`, `int`, `double`, `bool` e `List<String>`), não objetos. Por isso, cada
livro é convertido em um `Map` e codificado em JSON (`jsonEncode`), e a lista
inteira é salva como `List<String>` sob a chave `livros`. Ao iniciar o app, essa
lista é lida e cada String é decodificada de volta para um objeto `Livro`.

## Estrutura

```
lib/
├── main.dart                    # Ponto de entrada (MaterialApp)
├── models/livro.dart            # Modelo Livro + conversão JSON
├── services/livro_storage.dart  # Leitura/gravação no SharedPreferences
└── screens/
    ├── home_screen.dart         # Tela inicial (lista)
    └── cadastro_screen.dart     # Tela de cadastro
```

## Como executar

```bash
flutter pub get
flutter run
flutter test   # testes de cadastro, remoção e persistência
```
