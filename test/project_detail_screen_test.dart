import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:client_tracker/core/theme/app_theme.dart';
import 'package:client_tracker/features/projects/data/projects_repository.dart';
import 'package:client_tracker/features/projects/models/enums.dart';
import 'package:client_tracker/features/projects/screens/project_detail_screen.dart';
import 'package:client_tracker/features/projects/state/projects_provider.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets('agrega, completa y elimina una tarea', (WidgetTester tester) async {
    final provider = ProjectsProvider(ProjectsRepository());
    await provider.loadProjects();
    await provider.addProject(
      clientName: 'Cliente Test',
      projectName: 'Proyecto Test',
      description: 'desc',
      status: ProjectStatus.inProgress,
      priority: ProjectPriority.medium,
    );
    final projectId = provider.projects.last.id;

    await tester.pumpWidget(
      ChangeNotifierProvider.value(
        value: provider,
        child: MaterialApp(
          theme: AppTheme.dark,
          home: ProjectDetailScreen(projectId: projectId),
        ),
      ),
    );
    await tester.pumpAndSettle();

    // Agregar tarea
    await tester.enterText(find.byType(TextField), 'Nueva tarea de prueba');
    await tester.tap(find.byIcon(Icons.add_rounded));
    await tester.pumpAndSettle();

    expect(find.text('Nueva tarea de prueba'), findsOneWidget);
    expect(provider.getById(projectId)!.tasks.length, 1);

    // Completar tarea
    await tester.tap(find.byType(Checkbox));
    await tester.pumpAndSettle();
    expect(provider.getById(projectId)!.tasks.first.isCompleted, true);

    // Eliminar tarea
    await tester.tap(find.byIcon(Icons.delete_outline_rounded));
    await tester.pumpAndSettle();
    expect(provider.getById(projectId)!.tasks, isEmpty);
  });
}
