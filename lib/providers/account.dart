//
// account.dart
// appflix
//
// Author: wess (me@wess.io)
// Created: 01/03/2022
//
// Copywrite (c) 2022 Wess.io
//

import 'dart:convert';

import 'package:appwrite/appwrite.dart' as appwrite;
import 'package:netflix_clone/api/client.dart';
import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:netflix_clone/data/store.dart';

class AccountProvider extends ChangeNotifier {
  Account? _current;
  Account? get current => _current;

  Session? _session;
  Session? get session => _session;

  Future<Session?> get _cachedSession async {
    final cached = await Store.get("session");

    if (cached == null) {
      return null;
    }

    return Session.fromMap(json.decode(cached));
  }

  Future<bool> isValid() async {
    if (session == null) {
      final cached = await _cachedSession;

      if (cached == null) {
        return false;
      }

      _session = cached;
    }

    return _session != null;
  }

  Future<void> register(String email, String password, String? name) async {
    try {
      final result = await ApiClient.account.create(
          userId: appwrite.ID.unique(), email: email, password: password, name: name);

      _current = result;

      notifyListeners();
    } catch (e) {
      throw Exception("Failed to register");
    }
  }

  Future<void> login(String email, String password) async {
    try {
      final result = await ApiClient.account.createEmailSession(
        email: email,
        password: password,
      );
      _session = result;

      Store.set("session", json.encode(result.toMap()));

      notifyListeners();
    } catch (e) {
      _session = null;
    }
  }
}
