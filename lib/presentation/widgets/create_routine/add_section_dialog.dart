import 'package:flutter/material.dart';

class AddSectionDialog extends StatefulWidget {
  const AddSectionDialog({
    super.key,
    required this.onSectionAdded,
  });

  final Function(String, bool) onSectionAdded;

  @override
  State<AddSectionDialog> createState() => _AddSectionDialogState();
}

class _AddSectionDialogState extends State<AddSectionDialog> {
  final _controller = TextEditingController();
  bool isCircuit = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Agregar Sección'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildTextField(),
          const SizedBox(height: 16),
          _buildCircuitSwitch(),
        ],
      ),
      actions: [
        _buildCancelButton(context),
        _buildAddButton(context),
      ],
    );
  }

  Widget _buildTextField() {
    return TextField(
      controller: _controller,
      decoration: const InputDecoration(
        labelText: 'Nombre de la sección',
        hintText: 'Ej: Calentamiento, Fuerza, Circuito final',
      ),
      textCapitalization: TextCapitalization.words,
      onChanged: (value) => setState(() {}),
    );
  }

  Widget _buildCircuitSwitch() {
    return SwitchListTile(
      title: const Text('Es circuito'),
      subtitle: const Text('Los ejercicios se harán en secuencia'),
      value: isCircuit,
      onChanged: (value) => setState(() => isCircuit = value),
    );
  }

  Widget _buildCancelButton(BuildContext context) {
    return TextButton(
      onPressed: () => Navigator.pop(context),
      child: const Text('Cancelar'),
    );
  }

  Widget _buildAddButton(BuildContext context) {
    return FilledButton(
      onPressed: _canAdd() ? _handleAdd : null,
      child: const Text('Agregar'),
    );
  }

  bool _canAdd() => _controller.text.trim().isNotEmpty;

  void _handleAdd() {
    widget.onSectionAdded(_controller.text.trim(), isCircuit);
    Navigator.pop(context);
  }
}
