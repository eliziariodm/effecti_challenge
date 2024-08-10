import 'package:effecti_challenge/app/data/local_storage.dart';
import 'package:effecti_challenge/app/data/storage_observer_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesStorage implements LocalStorage {
  late final Future<SharedPreferences> _prefs;
  final List<IStorageObserver> _observers = [];

  SharedPreferencesStorage() {
    _prefs = SharedPreferences.getInstance();
  }

  @override
  void addObserver(IStorageObserver observer) {
    _observers.add(observer);
  }

  @override
  void removeObserver(IStorageObserver observer) {
    _observers.remove(observer);
  }

  void _notifyObservers(String key, dynamic value) {
    for (var observer in _observers) {
      if (observer.listeningTo.contains(key)) {
        observer.onUpdate(key, value);
      }
    }
  }

  @override
  Future<T?> get<T>(String key) async {
    final value = (await _prefs).get(key);

    if (value == null) return null;

    return value as T;
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

    _notifyObservers(key, value);
  }

  @override
  Future<void> delete(String key) async {
    (await _prefs).remove(key);
  }

  @override
  Future<List<String>?> getList(String key) async {
    final list = (await _prefs).getStringList(key);

    if (list == null) return null;

    return list;
  }

  @override
  Future<void> setList(String key, List<String> value) async {
    (await _prefs).setStringList(key, value);

    _notifyObservers(key, value);
  }
}
