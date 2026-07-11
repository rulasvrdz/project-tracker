import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/project.dart';

/// Guarda y carga la lista completa de proyectos como un solo JSON
/// dentro de shared_preferences. Equivalente a usar AsyncStorage con
/// JSON.stringify/parse en React Native.
class ProjectsRepository {
  static const _storageKey = 'projects';

  Future<List<Project>> loadProjects() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_storageKey);
    if (raw == null || raw.isEmpty) return [];

    final decoded = jsonDecode(raw) as List<dynamic>;
    return decoded
        .map((item) => Project.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<void> saveProjects(List<Project> projects) async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = jsonEncode(projects.map((p) => p.toJson()).toList());
    await prefs.setString(_storageKey, encoded);
  }
}
