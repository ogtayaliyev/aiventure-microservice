import 'package:flutter/material.dart';

/// Système de border radius cohérent pour AIVenture
class AppRadius {
  // Radius prédéfinis
  static const double sm = 8.0;
  static const double md = 12.0;
  static const double lg = 16.0;
  static const double xl = 24.0;
  static const double full = 999.0;

  // BorderRadius prédéfinis
  static BorderRadius get borderSm => BorderRadius.circular(sm);
  static BorderRadius get borderMd => BorderRadius.circular(md);
  static BorderRadius get borderLg => BorderRadius.circular(lg);
  static BorderRadius get borderXl => BorderRadius.circular(xl);
  static BorderRadius get borderFull => BorderRadius.circular(full);

  // Radius spécifiques
  static const double button = md;
  static const double card = lg;
  static const double input = md;
  static const double dialog = xl;
}
