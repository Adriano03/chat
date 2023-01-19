import 'package:chat/pages/call_page.dart';
import 'package:flutter/material.dart';

class ShowModal extends StatefulWidget {
  const ShowModal({super.key});

  @override
  State<ShowModal> createState() => _ShowModalState();
}

class _ShowModalState extends State<ShowModal> {
  final callId = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  _submit() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) {
      return;
    }
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CallPage(callId: callId.text),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(
          width: 2.5,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      child: ListView(
        children: [
          const ListTile(
            title: Text(
              'Chamada de Vídeo',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(height: 20),
          Form(
            key: _formKey,
            child: TextFormField(
              keyboardType: TextInputType.number,
              controller: callId,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                icon: Icon(Icons.key),
                label: Text('Insira o número da sala.'),
              ),
              validator: (callIdForm) {
                final callId = callIdForm ?? '';
                if (callId.isEmpty) {
                  return 'Digite o número da sala.';
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 30),
          Row(
            children: [
              ElevatedButton.icon(
                icon: const Icon(Icons.close),
                label: const Text('Fechar'),
                style: const ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll<Color>(Color.fromARGB(255, 224, 84, 74)),
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.group_outlined),
                  label: const Text('Conectar a sala'),
                  onPressed: _submit,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
