import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:client_tracker/main.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets('Dashboard muestra las cards de resumen con datos',
      (WidgetTester tester) async {
    await tester.pumpWidget(const RulasVrdzApp());
    await tester.pumpAndSettle();

    // "Dashboard" aparece dos veces: título del AppBar y etiqueta del tab.
    expect(find.text('Dashboard'), findsNWidgets(2));
    expect(find.text('Proyectos totales'), findsOneWidget);
    expect(find.text('En progreso'), findsOneWidget);
    expect(find.text('Tareas pendientes'), findsOneWidget);
    expect(find.text('Tareas completadas'), findsOneWidget);
  });
}
