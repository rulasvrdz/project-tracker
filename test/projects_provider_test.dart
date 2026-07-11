import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:client_tracker/features/projects/data/projects_repository.dart';
import 'package:client_tracker/features/projects/models/enums.dart';
import 'package:client_tracker/features/projects/state/projects_provider.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  test('carga datos semilla la primera vez y calcula los totales del dashboard',
      () async {
    final provider = ProjectsProvider(ProjectsRepository());
    await provider.loadProjects();

    expect(provider.totalProjects, greaterThan(0));
    expect(provider.completedTasksCount, greaterThan(0));
  });

  test('addProject agrega un proyecto y persiste', () async {
    final provider = ProjectsProvider(ProjectsRepository());
    await provider.loadProjects();
    final before = provider.totalProjects;

    await provider.addProject(
      clientName: 'Cliente X',
      projectName: 'Proyecto X',
      description: 'desc',
      status: ProjectStatus.idea,
      priority: ProjectPriority.low,
    );

    expect(provider.totalProjects, before + 1);
  });

  test('toggleTask marca y desmarca una tarea, actualizando el progreso',
      () async {
    final provider = ProjectsProvider(ProjectsRepository());
    await provider.loadProjects();

    await provider.addProject(
      clientName: 'Cliente Y',
      projectName: 'Proyecto Y',
      description: '',
      status: ProjectStatus.inProgress,
      priority: ProjectPriority.medium,
    );
    final project = provider.projects.last;

    await provider.addTask(project.id, 'Tarea 1');
    final taskId = provider.getById(project.id)!.tasks.first.id;

    await provider.toggleTask(project.id, taskId);
    expect(provider.getById(project.id)!.tasks.first.isCompleted, true);

    await provider.toggleTask(project.id, taskId);
    expect(provider.getById(project.id)!.tasks.first.isCompleted, false);
  });
}
