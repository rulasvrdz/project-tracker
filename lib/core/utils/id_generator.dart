int _counter = 0;

/// Genera un id simple y único, suficiente para una app local de un solo
/// usuario (no hay escrituras concurrentes que resolver, a diferencia de
/// un backend con múltiples clientes).
String generateId() {
  _counter++;
  return '${DateTime.now().microsecondsSinceEpoch}-$_counter';
}
