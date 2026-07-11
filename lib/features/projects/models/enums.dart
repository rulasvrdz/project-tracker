import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

enum ProjectStatus { idea, inProgress, inReview, delivered, paid }

extension ProjectStatusX on ProjectStatus {
  String get label => switch (this) {
        ProjectStatus.idea => 'Idea',
        ProjectStatus.inProgress => 'En progreso',
        ProjectStatus.inReview => 'En revisión',
        ProjectStatus.delivered => 'Entregado',
        ProjectStatus.paid => 'Cobrado',
      };

  Color get color => switch (this) {
        ProjectStatus.idea => AppColors.statusIdea,
        ProjectStatus.inProgress => AppColors.statusInProgress,
        ProjectStatus.inReview => AppColors.statusInReview,
        ProjectStatus.delivered => AppColors.statusDelivered,
        ProjectStatus.paid => AppColors.statusPaid,
      };
}

enum ProjectPriority { low, medium, high }

extension ProjectPriorityX on ProjectPriority {
  String get label => switch (this) {
        ProjectPriority.low => 'Baja',
        ProjectPriority.medium => 'Media',
        ProjectPriority.high => 'Alta',
      };

  Color get color => switch (this) {
        ProjectPriority.low => AppColors.priorityLow,
        ProjectPriority.medium => AppColors.priorityMedium,
        ProjectPriority.high => AppColors.priorityHigh,
      };
}
