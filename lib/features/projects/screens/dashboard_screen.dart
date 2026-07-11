import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_colors.dart';
import '../state/projects_provider.dart';
import '../widgets/summary_stat_card.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ProjectsProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: provider.isLoading
          ? const Center(
              child: CircularProgressIndicator(color: AppColors.copper),
            )
          : GridView.count(
              padding: const EdgeInsets.all(20),
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 1.3,
              children: [
                SummaryStatCard(
                  icon: Icons.folder_rounded,
                  label: 'Proyectos totales',
                  value: '${provider.totalProjects}',
                  accentColor: AppColors.copper,
                ),
                SummaryStatCard(
                  icon: Icons.trending_up_rounded,
                  label: 'En progreso',
                  value: '${provider.inProgressCount}',
                  accentColor: AppColors.steelBlue,
                ),
                SummaryStatCard(
                  icon: Icons.checklist_rounded,
                  label: 'Tareas pendientes',
                  value: '${provider.pendingTasksCount}',
                  accentColor: AppColors.priorityMedium,
                ),
                SummaryStatCard(
                  icon: Icons.check_circle_rounded,
                  label: 'Tareas completadas',
                  value: '${provider.completedTasksCount}',
                  accentColor: AppColors.success,
                ),
              ],
            ),
    );
  }
}
