import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class ItemCompra {
  String nome;
  bool comprado;
  ItemCompra(this.nome, {this.comprado = false});
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) => const MaterialApp(home: ListaCompras());
}

class ListaCompras extends StatefulWidget {
  const ListaCompras({super.key});

  @override
  State<ListaCompras> createState() => _ListaComprasState();
}

class _ListaComprasState extends State<ListaCompras> {
  final _controller = TextEditingController();
  final List<ItemCompra> _itens = [];

  void _adicionarItem() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _itens.add(ItemCompra(_controller.text));
      });
      _controller.clear();
    }
  }

  void _removerItem(int index) {
    setState(() {
      _itens.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lista de Compras')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(labelText: 'Novo item'),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: _adicionarItem,
                )
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _itens.length,
                itemBuilder: (context, index) {
                  final item = _itens[index];
                  return CheckboxListTile(
                    title: Text(
                      item.nome,
                      style: TextStyle(decoration: item.comprado ? TextDecoration.lineThrough : null),
                    ),
                    value: item.comprado,
                    onChanged: (bool? val) {
                      setState(() {
                        item.comprado = val ?? false;
                      });
                    },
                    secondary: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _removerItem(index),
                    ),
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
