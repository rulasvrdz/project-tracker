import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

/// Campo para escribir y agregar una nueva tarea. Limpia el texto
/// automáticamente después de agregar.
class AddTaskInput extends StatefulWidget {
  const AddTaskInput({super.key, required this.onAdd});

  final ValueChanged<String> onAdd;

  @override
  State<AddTaskInput> createState() => _AddTaskInputState();
}

class _AddTaskInputState extends State<AddTaskInput> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    widget.onAdd(text);
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _controller,
            decoration: const InputDecoration(hintText: 'Nueva tarea...'),
            onSubmitted: (_) => _submit(),
          ),
        ),
        const SizedBox(width: 8),
        IconButton.filled(
          onPressed: _submit,
          icon: const Icon(Icons.add_rounded),
          style: IconButton.styleFrom(
            backgroundColor: AppColors.copper,
            foregroundColor: Colors.black,
          ),
        ),
      ],
    );
  }
}
