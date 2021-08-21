abstract class IHttp {
  Future<dynamic> get(String url, Map<String, String>? headers);
}
