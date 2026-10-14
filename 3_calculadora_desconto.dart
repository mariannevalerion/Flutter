import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class ProdutoDesconto {
  final double precoOriginal;
  final double porcentagem;
  final double precoFinal;
  ProdutoDesconto(this.precoOriginal, this.porcentagem, this.precoFinal);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) => const MaterialApp(home: CalculadoraDesconto());
}

class CalculadoraDesconto extends StatefulWidget {
  const CalculadoraDesconto({super.key});

  @override
  State<CalculadoraDesconto> createState() => _CalculadoraDescontoState();
}

class _CalculadoraDescontoState extends State<CalculadoraDesconto> {
  final _precoController = TextEditingController();
  final _descontoController = TextEditingController();
  final List<ProdutoDesconto> _produtos = [];

  void _calcularEAdicionar() {
    double? preco = double.tryParse(_precoController.text);
    double? desc = double.tryParse(_descontoController.text);

    if (preco != null && desc != null) {
      double precoFinal = preco - (preco * (desc / 100));
      setState(() {
        _produtos.add(ProdutoDesconto(preco, desc, precoFinal));
      });
      _precoController.clear();
      _descontoController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calculadora de Desconto')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _precoController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Preço Original (R\$)'),
            ),
            TextField(
              controller: _descontoController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Desconto (%)'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _calcularEAdicionar,
              child: const Text('Calcular e Adicionar'),
            ),
            const Divider(),
            Expanded(
              child: ListView.builder(
                itemCount: _produtos.length,
                itemBuilder: (context, index) {
                  final p = _produtos[index];
                  return ListTile(
                    title: Text('Preço Final: R\$ ${p.precoFinal.toStringAsFixed(2)}'),
                    subtitle: Text('Original: R\$ ${p.precoOriginal.toStringAsFixed(2)} | Desconto: ${p.porcentagem}%'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
