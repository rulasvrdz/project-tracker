import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/primary_button.dart';
import '../state/projects_provider.dart';
import '../widgets/project_card.dart';
import 'project_detail_screen.dart';
import 'project_form_screen.dart';

class ProjectListScreen extends StatelessWidget {
  const ProjectListScreen({super.key});

  void _openForm(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const ProjectFormScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final projects = context.watch<ProjectsProvider>().projects;

    return Scaffold(
      appBar: AppBar(title: const Text('Proyectos')),
      body: projects.isEmpty
          ? EmptyState(
              icon: Icons.folder_off_rounded,
              title: 'Sin proyectos todavía',
              description: 'Crea tu primer proyecto para empezar a darle seguimiento.',
              action: PrimaryButton(
                label: 'Nuevo proyecto',
                icon: Icons.add_rounded,
                onPressed: () => _openForm(context),
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(20),
              itemCount: projects.length,
              separatorBuilder: (_, _) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final project = projects[index];
                return ProjectCard(
                  project: project,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => ProjectDetailScreen(projectId: project.id),
                      ),
                    );
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openForm(context),
        icon: const Icon(Icons.add_rounded),
        label: const Text('Nuevo proyecto'),
      ),
    );
  }
}
