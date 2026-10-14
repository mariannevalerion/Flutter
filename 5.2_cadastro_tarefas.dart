import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

enum Prioridade { baixa, media, alta }

class Tarefa {
  String nome;
  String descricao;
  bool concluida;
  Prioridade prioridade;

  Tarefa({required this.nome, required this.descricao, this.concluida = false, required this.prioridade});
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) => const MaterialApp(home: CadastroTarefas());
}

class CadastroTarefas extends StatefulWidget {
  const CadastroTarefas({super.key});
  @override
  State<CadastroTarefas> createState() => _CadastroTarefasState();
}

class _CadastroTarefasState extends State<CadastroTarefas> {
  final _nomeController = TextEditingController();
  final _descController = TextEditingController();
  Prioridade _prioridade = Prioridade.baixa;
  final List<Tarefa> _tarefas = [];

  void _adicionar() {
    if (_nomeController.text.isNotEmpty) {
      setState(() {
        _tarefas.add(Tarefa(
          nome: _nomeController.text,
          descricao: _descController.text,
          prioridade: _prioridade,
        ));
      });
      _nomeController.clear();
      _descController.clear();
      setState(() {
        _prioridade = Prioridade.baixa;
      });
    }
  }

  String _prioridadeStr(Prioridade p) {
    switch (p) {
      case Prioridade.baixa: return 'Baixa';
      case Prioridade.media: return 'Média';
      case Prioridade.alta: return 'Alta';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tarefas Diárias')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: _nomeController, decoration: const InputDecoration(labelText: 'Nome da Tarefa')),
            TextField(controller: _descController, decoration: const InputDecoration(labelText: 'Descrição')),
            const SizedBox(height: 10),
            const Text('Prioridade:'),
            Row(
              children: Prioridade.values.map((p) {
                return Expanded(
                  child: RadioListTile<Prioridade>(
                    title: Text(_prioridadeStr(p), style: const TextStyle(fontSize: 12)),
                    value: p,
                    groupValue: _prioridade,
                    onChanged: (val) {
                      setState(() {
                        _prioridade = val!;
                      });
                    },
                    contentPadding: EdgeInsets.zero,
                  ),
                );
              }).toList(),
            ),
            ElevatedButton(
              onPressed: _adicionar,
              child: const Text('Adicionar Tarefa'),
            ),
            const Divider(),
            Expanded(
              child: ListView.builder(
                itemCount: _tarefas.length,
                itemBuilder: (context, index) {
                  final t = _tarefas[index];
                  return CheckboxListTile(
                    title: Text(t.nome, style: TextStyle(decoration: t.concluida ? TextDecoration.lineThrough : null)),
                    subtitle: Text('\${t.descricao} (Prioridade: \${_prioridadeStr(t.prioridade)})'),
                    value: t.concluida,
                    onChanged: (val) {
                      setState(() {
                        t.concluida = val ?? false;
                      });
                    },
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
