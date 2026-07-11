import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/priority_chip.dart';
import '../../../core/widgets/progress_bar.dart';
import '../../../core/widgets/status_chip.dart';
import '../models/enums.dart';
import '../state/projects_provider.dart';
import '../widgets/add_task_input.dart';
import '../widgets/task_tile.dart';

class ProjectDetailScreen extends StatelessWidget {
  const ProjectDetailScreen({super.key, required this.projectId});

  final String projectId;

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ProjectsProvider>();
    final project = provider.getById(projectId);

    if (project == null) {
      return const Scaffold(
        body: Center(
          child: Text(
            'Proyecto no encontrado',
            style: TextStyle(color: AppColors.textSecondary),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(project.projectName)),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            project.clientName,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            children: [
              StatusChip(label: project.status.label, color: project.status.color),
              PriorityChip(
                label: project.priority.label,
                color: project.priority.color,
              ),
            ],
          ),
          const SizedBox(height: 20),
          AppProgressBar(value: project.progress),
          const SizedBox(height: 20),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Descripción',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  project.description.isEmpty
                      ? 'Sin descripción.'
                      : project.description,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tareas (${project.completedTasksCount}/${project.tasks.length})',
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                if (project.tasks.isEmpty)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Text(
                      'Sin tareas todavía.',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 13,
                      ),
                    ),
                  )
                else
                  for (final task in project.tasks)
                    TaskTile(
                      task: task,
                      onToggle: () => provider.toggleTask(project.id, task.id),
                      onDelete: () => provider.deleteTask(project.id, task.id),
                    ),
                const Divider(height: 24),
                AddTaskInput(
                  onAdd: (title) => provider.addTask(project.id, title),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
