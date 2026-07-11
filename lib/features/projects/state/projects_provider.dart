import 'package:flutter/foundation.dart';

import '../../../core/utils/id_generator.dart';
import '../data/projects_repository.dart';
import '../models/enums.dart';
import '../models/project.dart';
import '../models/task.dart';

/// Estado central de proyectos. Similar a un Context + reducer de React:
/// expone el estado actual y métodos para modificarlo; los widgets que
/// escuchan (context.watch / Consumer) se reconstruyen automáticamente.
class ProjectsProvider extends ChangeNotifier {
  ProjectsProvider(this._repository);

  final ProjectsRepository _repository;

  List<Project> _projects = [];
  bool _isLoading = true;

  List<Project> get projects => List.unmodifiable(_projects);
  bool get isLoading => _isLoading;

  Future<void> loadProjects() async {
    final loaded = await _repository.loadProjects();
    if (loaded.isEmpty) {
      _projects = _seedProjects();
      await _repository.saveProjects(_projects);
    } else {
      _projects = loaded;
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> _persist() => _repository.saveProjects(_projects);

  Future<void> addProject({
    required String clientName,
    required String projectName,
    required String description,
    required ProjectStatus status,
    required ProjectPriority priority,
  }) async {
    final project = Project(
      id: generateId(),
      clientName: clientName,
      projectName: projectName,
      description: description,
      status: status,
      priority: priority,
    );
    _projects = [..._projects, project];
    notifyListeners();
    await _persist();
  }

  Future<void> updateProject(Project updated) async {
    _projects = [
      for (final p in _projects) p.id == updated.id ? updated : p,
    ];
    notifyListeners();
    await _persist();
  }

  Future<void> deleteProject(String projectId) async {
    _projects = _projects.where((p) => p.id != projectId).toList();
    notifyListeners();
    await _persist();
  }

  Project? getById(String id) {
    for (final p in _projects) {
      if (p.id == id) return p;
    }
    return null;
  }

  Future<void> addTask(String projectId, String title) {
    return _updateProjectTasks(
      projectId,
      (tasks) => [...tasks, Task(id: generateId(), title: title)],
    );
  }

  Future<void> toggleTask(String projectId, String taskId) {
    return _updateProjectTasks(
      projectId,
      (tasks) => [
        for (final t in tasks)
          t.id == taskId ? t.copyWith(isCompleted: !t.isCompleted) : t,
      ],
    );
  }

  Future<void> deleteTask(String projectId, String taskId) {
    return _updateProjectTasks(
      projectId,
      (tasks) => tasks.where((t) => t.id != taskId).toList(),
    );
  }

  Future<void> _updateProjectTasks(
    String projectId,
    List<Task> Function(List<Task> tasks) update,
  ) async {
    final project = getById(projectId);
    if (project == null) return;
    await updateProject(project.copyWith(tasks: update(project.tasks)));
  }

  // Agregados usados por el Dashboard.
  int get totalProjects => _projects.length;

  int get inProgressCount =>
      _projects.where((p) => p.status == ProjectStatus.inProgress).length;

  int get pendingTasksCount =>
      _projects.fold(0, (sum, p) => sum + p.pendingTasksCount);

  int get completedTasksCount =>
      _projects.fold(0, (sum, p) => sum + p.completedTasksCount);

  /// Datos de ejemplo para el primer arranque, antes de que exista el
  /// formulario de creación (Fase 6). Solo se usan si no hay nada guardado.
  List<Project> _seedProjects() => [
        Project(
          id: generateId(),
          clientName: 'Estudio Fénix',
          projectName: 'App Web de Reservas',
          description: 'Landing page + dashboard de reservas para clientes.',
          status: ProjectStatus.inProgress,
          priority: ProjectPriority.high,
          tasks: [
            Task(id: generateId(), title: 'Diseño de UI', isCompleted: true),
            Task(id: generateId(), title: 'Setup del backend', isCompleted: true),
            Task(id: generateId(), title: 'Integrar pagos', isCompleted: false),
          ],
        ),
        Project(
          id: generateId(),
          clientName: 'Café Luna',
          projectName: 'Rediseño de marca',
          description: 'Nuevo logo, paleta y guía de estilo.',
          status: ProjectStatus.idea,
          priority: ProjectPriority.medium,
        ),
        Project(
          id: generateId(),
          clientName: 'TechNova',
          projectName: 'Landing de producto',
          description: 'Página de aterrizaje para el lanzamiento.',
          status: ProjectStatus.delivered,
          priority: ProjectPriority.low,
          tasks: [
            Task(id: generateId(), title: 'Copy y SEO', isCompleted: true),
            Task(id: generateId(), title: 'Despliegue', isCompleted: true),
          ],
        ),
      ];
}
