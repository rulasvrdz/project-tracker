import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/navigation/root_shell.dart';
import 'core/theme/app_theme.dart';
import 'features/projects/data/projects_repository.dart';
import 'features/projects/state/projects_provider.dart';

void main() {
  runApp(const RulasVrdzApp());
}

class RulasVrdzApp extends StatelessWidget {
  const RulasVrdzApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProjectsProvider(ProjectsRepository())..loadProjects(),
      child: MaterialApp(
        title: 'RulasVrdz Client Tracker',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.dark,
        home: const RootShell(),
      ),
    );
  }
}
