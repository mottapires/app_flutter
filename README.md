# Flutter Areal App

Aplicativo Flutter para inserir dados na tabela `areal` do banco de dados MySQL.

## Estrutura do Projeto

- `lib/main.dart` - Ponto de entrada do aplicativo
- `lib/models/areal.dart` - Modelo de dados para a tabela areal
- `lib/screens/areal_form_screen.dart` - Tela com formulário para inserção de dados
- `lib/services/api_service.dart` - Serviço para comunicação com a API REST

## Configuração para Build no Codemagic

O arquivo `codemagic.yaml` contém a configuração necessária para builds automatizados no Codemagic.

## API Backend

Este aplicativo requer uma API REST para se comunicar com o banco de dados MySQL. A URL da API está configurada em `lib/services/api_service.dart`.