class AppLocale {
  final String name;
  final String localeName;

  AppLocale._({
    required this.name,
    required this.localeName,
  });

  static final _en = AppLocale._(name: 'EN', localeName: 'en');

  static final _hk = AppLocale._(name: '繁', localeName: 'hk');

  static final _ch = AppLocale._(name: '简', localeName: 'ch');

  static final List<AppLocale> locales = [_en, _hk, _ch];

  static AppLocale en() => _en;
  static AppLocale hk() => _hk;
  static AppLocale ch() => _ch;

  static AppLocale appLocale(String name) {
    switch (name) {
      case 'ch':
        return _ch;
      case 'hk':
        return _hk;
      case 'en':
      default:
        return _en;
    }
  }
}
