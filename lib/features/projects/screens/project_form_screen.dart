import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/primary_button.dart';
import '../models/enums.dart';
import '../state/projects_provider.dart';

/// Formulario de creación de proyecto. Guarda vía [ProjectsProvider] y
/// regresa a la pantalla anterior.
class ProjectFormScreen extends StatefulWidget {
  const ProjectFormScreen({super.key});

  @override
  State<ProjectFormScreen> createState() => _ProjectFormScreenState();
}

class _ProjectFormScreenState extends State<ProjectFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _clientController = TextEditingController();
  final _projectController = TextEditingController();
  final _descriptionController = TextEditingController();

  ProjectStatus _status = ProjectStatus.idea;
  ProjectPriority _priority = ProjectPriority.medium;

  @override
  void dispose() {
    _clientController.dispose();
    _projectController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;

    context.read<ProjectsProvider>().addProject(
          clientName: _clientController.text.trim(),
          projectName: _projectController.text.trim(),
          description: _descriptionController.text.trim(),
          status: _status,
          priority: _priority,
        );

    Navigator.of(context).pop();
  }

  String? _requiredValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Este campo es obligatorio';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nuevo proyecto')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            TextFormField(
              controller: _clientController,
              decoration: const InputDecoration(labelText: 'Cliente'),
              validator: _requiredValidator,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _projectController,
              decoration: const InputDecoration(labelText: 'Nombre del proyecto'),
              validator: _requiredValidator,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Descripción'),
              maxLines: 4,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<ProjectStatus>(
              initialValue: _status,
              decoration: const InputDecoration(labelText: 'Estado'),
              items: [
                for (final status in ProjectStatus.values)
                  DropdownMenuItem(value: status, child: Text(status.label)),
              ],
              onChanged: (value) => setState(() => _status = value!),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<ProjectPriority>(
              initialValue: _priority,
              decoration: const InputDecoration(labelText: 'Prioridad'),
              items: [
                for (final priority in ProjectPriority.values)
                  DropdownMenuItem(value: priority, child: Text(priority.label)),
              ],
              onChanged: (value) => setState(() => _priority = value!),
            ),
            const SizedBox(height: 24),
            PrimaryButton(
              label: 'Guardar proyecto',
              icon: Icons.check_rounded,
              onPressed: _save,
            ),
          ],
        ),
      ),
    );
  }
}
