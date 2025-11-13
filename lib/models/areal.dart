import 'package:flutter/material.dart';

class Areal {
  final int? id;
  final String motorista;
  final double valor;
  final DateTime data;
  final TimeOfDay hora;
  final String placaDoVeiculo;

  Areal({
    this.id,
    required this.motorista,
    required this.valor,
    required this.data,
    required this.hora,
    required this.placaDoVeiculo,
  });

  Map<String, dynamic> toJson() {
    return {
      'motorista': motorista,
      'valor': valor,
      'data': '${data.year}-${data.month.toString().padLeft(2, '0')}-${data.day.toString().padLeft(2, '0')}',
      'hora': '${hora.hour.toString().padLeft(2, '0')}:${hora.minute.toString().padLeft(2, '0')}:00',
      'placa_do_veiculo': placaDoVeiculo,
    };
  }

  factory Areal.fromJson(Map<String, dynamic> json) {
    return Areal(
      id: json['id'],
      motorista: json['motorista'],
      valor: json['valor'].toDouble(),
      data: DateTime.parse(json['data']),
      hora: TimeOfDay(hour: int.parse(json['hora'].split(':')[0]), minute: int.parse(json['hora'].split(':')[1])),
      placaDoVeiculo: json['placa_do_veiculo'],
    );
  }
}