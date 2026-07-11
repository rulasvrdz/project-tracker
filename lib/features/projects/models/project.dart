import 'enums.dart';
import 'task.dart';

class Project {
  const Project({
    required this.id,
    required this.clientName,
    required this.projectName,
    required this.description,
    required this.status,
    required this.priority,
    this.tasks = const [],
  });

  final String id;
  final String clientName;
  final String projectName;
  final String description;
  final ProjectStatus status;
  final ProjectPriority priority;
  final List<Task> tasks;

  /// Progreso de 0.0 a 1.0 según tareas completadas.
  double get progress {
    if (tasks.isEmpty) return 0;
    return completedTasksCount / tasks.length;
  }

  int get completedTasksCount => tasks.where((t) => t.isCompleted).length;

  int get pendingTasksCount => tasks.length - completedTasksCount;

  Project copyWith({
    String? clientName,
    String? projectName,
    String? description,
    ProjectStatus? status,
    ProjectPriority? priority,
    List<Task>? tasks,
  }) {
    return Project(
      id: id,
      clientName: clientName ?? this.clientName,
      projectName: projectName ?? this.projectName,
      description: description ?? this.description,
      status: status ?? this.status,
      priority: priority ?? this.priority,
      tasks: tasks ?? this.tasks,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'clientName': clientName,
        'projectName': projectName,
        'description': description,
        'status': status.name,
        'priority': priority.name,
        'tasks': tasks.map((t) => t.toJson()).toList(),
      };

  factory Project.fromJson(Map<String, dynamic> json) => Project(
        id: json['id'] as String,
        clientName: json['clientName'] as String,
        projectName: json['projectName'] as String,
        description: json['description'] as String? ?? '',
        status: ProjectStatus.values.byName(json['status'] as String),
        priority: ProjectPriority.values.byName(json['priority'] as String),
        tasks: (json['tasks'] as List<dynamic>? ?? [])
            .map((t) => Task.fromJson(t as Map<String, dynamic>))
            .toList(),
      );
}
