import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:client_tracker/core/theme/app_theme.dart';
import 'package:client_tracker/features/projects/data/projects_repository.dart';
import 'package:client_tracker/features/projects/screens/project_form_screen.dart';
import 'package:client_tracker/features/projects/state/projects_provider.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets('guardar el formulario agrega un proyecto y cierra la pantalla',
      (WidgetTester tester) async {
    final provider = ProjectsProvider(ProjectsRepository());
    await provider.loadProjects();
    final before = provider.totalProjects;

    await tester.pumpWidget(
      ChangeNotifierProvider.value(
        value: provider,
        child: MaterialApp(
          theme: AppTheme.dark,
          home: Navigator(
            onGenerateRoute: (_) => MaterialPageRoute(
              builder: (_) => const ProjectFormScreen(),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.enterText(find.widgetWithText(TextFormField, 'Cliente'), 'Cliente Nuevo');
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Nombre del proyecto'),
      'Proyecto Nuevo',
    );

    await tester.tap(find.text('Guardar proyecto'));
    await tester.pumpAndSettle();

    expect(provider.totalProjects, before + 1);
    expect(provider.projects.last.projectName, 'Proyecto Nuevo');
    expect(find.byType(ProjectFormScreen), findsNothing);
  });

  testWidgets('no guarda si los campos obligatorios están vacíos',
      (WidgetTester tester) async {
    final provider = ProjectsProvider(ProjectsRepository());
    await provider.loadProjects();
    final before = provider.totalProjects;

    await tester.pumpWidget(
      ChangeNotifierProvider.value(
        value: provider,
        child: MaterialApp(
          theme: AppTheme.dark,
          home: const ProjectFormScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Guardar proyecto'));
    await tester.pumpAndSettle();

    expect(provider.totalProjects, before);
    expect(find.text('Este campo es obligatorio'), findsWidgets);
  });
}
