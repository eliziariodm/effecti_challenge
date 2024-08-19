import 'package:effecti_challenge/app/data/local_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesStorage implements LocalStorage {
  late final Future<SharedPreferences> _prefs;

  SharedPreferencesStorage() {
    _prefs = SharedPreferences.getInstance();
  }

  @override
  Future<T?> get<T>(String key) async {
    final value = (await _prefs).get(key);

    if (value == null) return null;

    return value as T;
  }

  @override
  Future<List<String>?> getList(String key) async {
    final list = (await _prefs).getStringList(key);

    if (list == null) return null;

    return list;
  }

  @override
  Future<void> set<T>(String key, T value) async {
    if (value is bool) {
      (await _prefs).setBool(key, value);
    } else if (value is String) {
      (await _prefs).setString(key, value);
    } else if (value is int) {
      (await _prefs).setInt(key, value);
    } else if (value is double) {
      (await _prefs).setDouble(key, value);
    } else if (value is List<String>) {
      (await _prefs).setStringList(key, value);
    }
  }

  @override
  Future<void> delete(String key) async {
    (await _prefs).remove(key);
  }
}
