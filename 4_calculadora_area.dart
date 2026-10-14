import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => const MaterialApp(home: CalculadoraArea());
}

class CalculadoraArea extends StatefulWidget {
  const CalculadoraArea({super.key});

  @override
  State<CalculadoraArea> createState() => _CalculadoraAreaState();
}

class _CalculadoraAreaState extends State<CalculadoraArea> {
  final _larguraController = TextEditingController();
  final _alturaController = TextEditingController();
  String _resultado = '';

  void _calcularArea() {
    double? largura = double.tryParse(_larguraController.text);
    double? altura = double.tryParse(_alturaController.text);

    if (largura != null && altura != null) {
      double area = largura * altura;
      setState(() {
        _resultado = 'Área: ${area.toStringAsFixed(2)}';
      });
    } else {
      setState(() {
        _resultado = 'Valores inválidos';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Área do Retângulo')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _larguraController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Largura'),
            ),
            TextField(
              controller: _alturaController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Altura'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calcularArea,
              child: const Text('Calcular Área'),
            ),
            const SizedBox(height: 20),
            Text(
              _resultado,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
