import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:client_tracker/features/projects/data/projects_repository.dart';
import 'package:client_tracker/features/projects/models/enums.dart';
import 'package:client_tracker/features/projects/models/project.dart';
import 'package:client_tracker/features/projects/models/task.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  test('guarda y carga proyectos correctamente (roundtrip JSON)', () async {
    final repo = ProjectsRepository();

    final project = Project(
      id: '1',
      clientName: 'Estudio Fénix',
      projectName: 'App Web',
      description: 'Landing + dashboard',
      status: ProjectStatus.inProgress,
      priority: ProjectPriority.high,
      tasks: const [
        Task(id: 't1', title: 'Diseño', isCompleted: true),
        Task(id: 't2', title: 'Backend', isCompleted: false),
      ],
    );

    await repo.saveProjects([project]);
    final loaded = await repo.loadProjects();

    expect(loaded.length, 1);
    expect(loaded.first.projectName, 'App Web');
    expect(loaded.first.tasks.length, 2);
    expect(loaded.first.progress, 0.5);
  });

  test('devuelve lista vacía cuando no hay datos guardados', () async {
    final repo = ProjectsRepository();
    final loaded = await repo.loadProjects();
    expect(loaded, isEmpty);
  });
}
