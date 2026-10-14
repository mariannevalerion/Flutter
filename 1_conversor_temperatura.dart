import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ConversorTemperatura(),
    );
  }
}

class ConversorTemperatura extends StatefulWidget {
  const ConversorTemperatura({super.key});

  @override
  State<ConversorTemperatura> createState() => _ConversorTemperaturaState();
}

class _ConversorTemperaturaState extends State<ConversorTemperatura> {
  final TextEditingController _celsiusController = TextEditingController();
  String _resultado = '';

  void _converter() {
    double? celsius = double.tryParse(_celsiusController.text);
    if (celsius != null) {
      double fahrenheit = (celsius * 9 / 5) + 32;
      setState(() {
        _resultado = '${fahrenheit.toStringAsFixed(2)} °F';
      });
    } else {
      setState(() {
        _resultado = 'Valor inválido';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Conversor Celsius para Fahrenheit')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _celsiusController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Temperatura em °C'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _converter,
              child: const Text('Converter'),
            ),
            const SizedBox(height: 20),
            Text(
              _resultado,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
