import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_areal_app/main.dart';
import 'package:flutter_areal_app/models/areal.dart';

void main() {
  testWidgets('Areal form screen has all required fields', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the app title is correct
    expect(find.text('Registro de Areal'), findsOneWidget);

    // Verify that all form fields are present
    expect(find.text('Motorista'), findsOneWidget);
    expect(find.text('Valor (R\$)'), findsOneWidget);
    expect(find.text('Data'), findsOneWidget);
    expect(find.text('Hora'), findsOneWidget);
    expect(find.text('Placa do Veículo'), findsOneWidget);
    
    // Verify that the submit button is present
    expect(find.text('Registrar'), findsOneWidget);
  });

  test('Areal model toJson conversion', () {
    final now = DateTime.now();
    final time = TimeOfDay.now();
    
    final areal = Areal(
      motorista: 'Test Driver',
      valor: 150.0,
      data: now,
      hora: time,
      placaDoVeiculo: 'ABC1234',
    );

    final json = areal.toJson();
    
    expect(json['motorista'], 'Test Driver');
    expect(json['valor'], 150.0);
    expect(json['placa_do_veiculo'], 'ABC1234');
    expect(json['data'], '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}');
  });
}