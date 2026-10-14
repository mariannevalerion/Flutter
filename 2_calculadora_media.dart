import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: CalculadoraMedia(),
    );
  }
}

class CalculadoraMedia extends StatefulWidget {
  const CalculadoraMedia({super.key});

  @override
  State<CalculadoraMedia> createState() => _CalculadoraMediaState();
}

class _CalculadoraMediaState extends State<CalculadoraMedia> {
  final _nota1Controller = TextEditingController();
  final _nota2Controller = TextEditingController();
  final _nota3Controller = TextEditingController();
  String _resultado = '';

  void _calcularMedia() {
    double? n1 = double.tryParse(_nota1Controller.text);
    double? n2 = double.tryParse(_nota2Controller.text);
    double? n3 = double.tryParse(_nota3Controller.text);

    if (n1 != null && n2 != null && n3 != null) {
      double media = (n1 + n2 + n3) / 3;
      setState(() {
        _resultado = 'Média: ${media.toStringAsFixed(2)}';
      });
    } else {
      setState(() {
        _resultado = 'Preencha todas as notas corretamente.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calculadora de Média')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nota1Controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Nota 1'),
            ),
            TextField(
              controller: _nota2Controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Nota 2'),
            ),
            TextField(
              controller: _nota3Controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Nota 3'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calcularMedia,
              child: const Text('Calcular'),
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
