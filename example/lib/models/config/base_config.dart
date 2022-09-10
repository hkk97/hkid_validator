abstract class AppConfig {
  String get host;
  bool get enableHttps;

  bool isMatch(AppConfig value) =>
      (host == value.host && enableHttps == value.enableHttps);
}
