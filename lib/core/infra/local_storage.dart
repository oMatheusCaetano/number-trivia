import 'dart:convert';

import 'package:number_trivia/core/infra/contracts/ilocal_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage implements ILocalStorage {
  final SharedPreferences sharedPreferences;

  LocalStorage({required this.sharedPreferences});

  Future<String?> getItem(String key) {
    return Future.value(this.sharedPreferences.getString(key));
  }

  Future<bool> setItem(String key, Object value) {
    return this.sharedPreferences.setString(key, json.encode(value));
  }
}
