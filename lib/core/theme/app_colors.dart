import 'package:flutter/material.dart';

/// Paleta "premium dark editorial-tech" de RulasVrdz.
/// Fondo oscuro casi negro, acentos cobre/bronce y azul.
class AppColors {
  AppColors._();

  // Fondo y superficies
  static const background = Color(0xFF0D0D10);
  static const surface = Color(0xFF17171B);
  static const surfaceRaised = Color(0xFF1F1F25);
  static const border = Color(0xFF2A2A31);

  // Texto
  static const textPrimary = Color(0xFFF2EFEA);
  static const textSecondary = Color(0xFFA0A0AA);
  static const textMuted = Color(0xFF6C6C76);

  // Acentos de marca
  static const copper = Color(0xFFC1824A);
  static const copperLight = Color(0xFFDDA36E);
  static const steelBlue = Color(0xFF5B8DEF);
  static const steelBlueLight = Color(0xFF83A9F4);

  // Estados de proyecto
  static const statusIdea = Color(0xFF8B8B96);
  static const statusInProgress = steelBlue;
  static const statusInReview = Color(0xFFD9A441);
  static const statusDelivered = Color(0xFF4FB286);
  static const statusPaid = copper;

  // Prioridad
  static const priorityLow = Color(0xFF6E9BD1);
  static const priorityMedium = Color(0xFFD9A441);
  static const priorityHigh = Color(0xFFCF5C4C);

  // Feedback
  static const success = Color(0xFF4FB286);
  static const danger = Color(0xFFCF5C4C);
}
