import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// Barra de progreso con porcentaje. [value] va de 0.0 a 1.0.
class AppProgressBar extends StatelessWidget {
  const AppProgressBar({super.key, required this.value, this.showLabel = true});

  final double value;
  final bool showLabel;

  @override
  Widget build(BuildContext context) {
    final clamped = value.clamp(0.0, 1.0);
    final percent = (clamped * 100).round();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: clamped,
            minHeight: 8,
            backgroundColor: AppColors.surfaceRaised,
            valueColor: const AlwaysStoppedAnimation(AppColors.copper),
          ),
        ),
        if (showLabel) ...[
          const SizedBox(height: 6),
          Text(
            '$percent% completado',
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 12,
            ),
          ),
        ],
      ],
    );
  }
}
