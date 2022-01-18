//
// num.dart
// Bastion
// 
// Author: Wess Cope (wess@frenzylabs.com)
// Created: 03/25/2021
// 
// Copywrite (c) 2021 FrenzyLabs, LLC.
//

import 'dart:math' as math;

extension NumExt on num {
  double root(num exp) => (math.pow(this, 1 / exp) * 1E+9).round() / 1E+9;
  double sqrt() => math.sqrt(this);
  double cbrt() => root(3);

  double pow(int exp) => math.pow(this, exp).toDouble();
  double squared() => pow(2);
  double cubed() => pow(3);
}