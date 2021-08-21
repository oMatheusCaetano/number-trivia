abstract class ILocalStorage {
  Future<String?> getItem(String key);
  Future<bool> setItem(String key, Object value);
}
