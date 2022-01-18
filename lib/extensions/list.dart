//
// list.dart
// Bastion
// 
// Author: Wess Cope (wess@frenzylabs.com)
// Created: 03/25/2021
// 
// Copywrite (c) 2021 FrenzyLabs, LLC.
//

extension ListExt<T> on List<T> {
  T? find(bool Function(T index) predicate) {
    try {
      return firstWhere(predicate);
    } on StateError {
      return null;
    }
  }
}

