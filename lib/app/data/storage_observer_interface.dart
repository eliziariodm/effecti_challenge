abstract class IStorageObserver {
  List<String> listeningTo = [];
  void onUpdate(String key, dynamic value);
}
