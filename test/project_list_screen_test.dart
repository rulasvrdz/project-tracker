import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:client_tracker/core/theme/app_theme.dart';
import 'package:client_tracker/features/projects/data/projects_repository.dart';
import 'package:client_tracker/features/projects/screens/project_list_screen.dart';
import 'package:client_tracker/features/projects/state/projects_provider.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  Widget buildTestApp() {
    return ChangeNotifierProvider(
      create: (_) => ProjectsProvider(ProjectsRepository())..loadProjects(),
      child: MaterialApp(
        theme: AppTheme.dark,
        home: const ProjectListScreen(),
      ),
    );
  }

  testWidgets('muestra los proyectos sembrados y navega al detalle al tocar uno',
      (WidgetTester tester) async {
    await tester.pumpWidget(buildTestApp());
    await tester.pumpAndSettle();

    expect(find.text('Estudio Fénix'), findsOneWidget);
    expect(find.text('App Web de Reservas'), findsOneWidget);

    await tester.tap(find.text('App Web de Reservas'));
    await tester.pumpAndSettle();

    expect(find.text('Descripción'), findsOneWidget);
  });
}
