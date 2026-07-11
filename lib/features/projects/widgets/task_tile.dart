import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../models/task.dart';

/// Fila de una tarea: checkbox para completar + texto + botón eliminar.
class TaskTile extends StatelessWidget {
  const TaskTile({
    super.key,
    required this.task,
    required this.onToggle,
    required this.onDelete,
  });

  final Task task;
  final VoidCallback onToggle;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Checkbox(
            value: task.isCompleted,
            activeColor: AppColors.copper,
            onChanged: (_) => onToggle(),
          ),
          Expanded(
            child: Text(
              task.title,
              style: TextStyle(
                color:
                    task.isCompleted ? AppColors.textMuted : AppColors.textPrimary,
                decoration:
                    task.isCompleted ? TextDecoration.lineThrough : null,
                fontSize: 14,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.delete_outline_rounded,
              color: AppColors.textMuted,
              size: 20,
            ),
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }
}
