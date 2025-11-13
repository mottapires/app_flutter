import 'dart:convert';
import 'package:flutter_areal_app/models/areal.dart';
import 'package:http/http.dart' as http;

class ApiService {
  // URL da API real
  static const String baseUrl = 'https://smgengenharia.com.br/minerasys';
  
  // Endpoint para inserir dados na tabela areal
  static const String insertArealEndpoint = '/insert_areal.php';
  
  Future<bool> insertAreal(Areal areal) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl$insertArealEndpoint'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(areal.toJson()),
      );
      
      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonResponse = jsonDecode(response.body);
        return jsonResponse['success'] == true;
      } else {
        print('Erro na requisição: ${response.statusCode}');
        print('Resposta: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Erro ao inserir dados: $e');
      return false;
    }
  }
}