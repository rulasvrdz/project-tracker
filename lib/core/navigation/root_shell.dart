import 'package:flutter/material.dart';

import '../../features/projects/screens/dashboard_screen.dart';
import '../../features/projects/screens/project_list_screen.dart';

/// Navegación raíz de la app: barra inferior con Dashboard y Proyectos.
/// Detalle y Formulario se apilan encima con Navigator.push desde cada tab.
class RootShell extends StatefulWidget {
  const RootShell({super.key});

  @override
  State<RootShell> createState() => _RootShellState();
}

class _RootShellState extends State<RootShell> {
  int _index = 0;

  static const _screens = [DashboardScreen(), ProjectListScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _index, children: _screens),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (index) => setState(() => _index = index),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.dashboard_rounded),
            label: 'Dashboard',
          ),
          NavigationDestination(
            icon: Icon(Icons.folder_rounded),
            label: 'Proyectos',
          ),
        ],
      ),
    );
  }
}
