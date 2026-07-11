import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/priority_chip.dart';
import '../../../core/widgets/progress_bar.dart';
import '../../../core/widgets/status_chip.dart';
import '../models/enums.dart';
import '../models/project.dart';

/// Card de proyecto para la lista. Muestra cliente, nombre, estado,
/// prioridad y progreso; navega al detalle al tocarla.
class ProjectCard extends StatelessWidget {
  const ProjectCard({super.key, required this.project, required this.onTap});

  final Project project;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            project.projectName,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            project.clientName,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              StatusChip(label: project.status.label, color: project.status.color),
              PriorityChip(
                label: project.priority.label,
                color: project.priority.color,
              ),
            ],
          ),
          const SizedBox(height: 16),
          AppProgressBar(value: project.progress),
        ],
      ),
    );
  }
}
