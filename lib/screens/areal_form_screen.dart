import 'package:flutter/material.dart';
import 'package:flutter_areal_app/models/areal.dart';
import 'package:flutter_areal_app/services/api_service.dart';

class ArealFormScreen extends StatefulWidget {
  const ArealFormScreen({super.key});

  @override
  State<ArealFormScreen> createState() => _ArealFormScreenState();
}

class _ArealFormScreenState extends State<ArealFormScreen> {
  final _formKey = GlobalKey<FormState>();
  
  // Controllers para os campos do formulário
  final _motoristaController = TextEditingController();
  final _valorController = TextEditingController();
  final _placaController = TextEditingController();
  
  // Valores selecionados
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  
  // Estado de carregamento
  bool _isLoading = false;
  
  @override
  void dispose() {
    _motoristaController.dispose();
    _valorController.dispose();
    _placaController.dispose();
    super.dispose();
  }
  
  // Função para selecionar data
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }
  
  // Função para selecionar hora
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }
  
  // Função para enviar os dados
  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      
      final areal = Areal(
        motorista: _motoristaController.text,
        valor: double.parse(_valorController.text),
        data: _selectedDate,
        hora: _selectedTime,
        placaDoVeiculo: _placaController.text,
      );
      
      final success = await ApiService().insertAreal(areal);
      
      setState(() {
        _isLoading = false;
      });
      
      if (success) {
        // Limpar o formulário após sucesso
        _formKey.currentState!.reset();
        _motoristaController.clear();
        _valorController.clear();
        _placaController.clear();
        
        // Mostrar mensagem de sucesso
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Dados inseridos com sucesso!'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        // Mostrar mensagem de erro
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Erro ao inserir dados. Tente novamente.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro de Areal'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Campo Motorista
              TextFormField(
                controller: _motoristaController,
                decoration: const InputDecoration(
                  labelText: 'Motorista',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, informe o nome do motorista';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              
              // Campo Valor
              TextFormField(
                controller: _valorController,
                decoration: const InputDecoration(
                  labelText: 'Valor (R\$)',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, informe o valor';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Por favor, informe um valor válido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              
              // Campo Data
              InkWell(
                onTap: () => _selectDate(context),
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Data',
                    border: OutlineInputBorder(),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                      ),
                      const Icon(Icons.calendar_today),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              
              // Campo Hora
              InkWell(
                onTap: () => _selectTime(context),
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Hora',
                    border: OutlineInputBorder(),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${_selectedTime.hour.toString().padLeft(2, '0')}:${_selectedTime.minute.toString().padLeft(2, '0')}',
                      ),
                      const Icon(Icons.access_time),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              
              // Campo Placa do Veículo
              TextFormField(
                controller: _placaController,
                decoration: const InputDecoration(
                  labelText: 'Placa do Veículo',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, informe a placa do veículo';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              
              // Botão de envio
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _submitForm,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(16),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator()
                      : const Text(
                          'Registrar',
                          style: TextStyle(fontSize: 18),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}