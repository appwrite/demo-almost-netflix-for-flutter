//
// meta.dart
// appflix
// 
// Author: wess (me@wess.io)
// Created: 01/03/2022
// 
// Copywrite (c) 2022 Wess.io
//

import 'dart:convert';

class Meta {
  Map<String, dynamic> _backing;

  dynamic get(String key) => _backing[key];
  
  void insert(Map<String, dynamic> data) => _backing = {..._backing, ...data};
  Meta set(String key, dynamic value) {
    _backing[key] = value;

    return this;
  }

  void clear() => _backing = {};

  String toJson() => json.encode(_backing);

  Meta(): _backing = {};

  factory Meta.fromJson(String str) {
    final meta = Meta();
    meta.insert(
      json.decode(str)
    );

    return meta;
  }

  operator [](String key) => _backing[key];
  operator []=(String key, dynamic value) => _backing[key] = value;
}