import 'package:effecti_challenge/app/data/storage_observer_interface.dart';

abstract class LocalStorage {
  Future<T?> get<T>(String key);
  Future<void> set<T>(String key, T value);
  Future<void> delete(String key);
  Future<List<String>?> getList(String key);
  Future<void> setList(String key, List<String> value);
  void addObserver(IStorageObserver observer);
  void removeObserver(IStorageObserver observer);
}
