enum AnimatedStatus {
  idle,
  animating,
  animated,
}

enum Section {
  generate,
  validate,
}

enum CopyStatus {
  idle,
  copied,
}

enum ThemeType {
  generated,
  validated,
}

enum HomeScreenPlatform {
  android,
  ios,
  chrome,
}

Map<String, dynamic> nameToHomeScreenPlatform = {
  'Android': HomeScreenPlatform.android,
  'iOS': HomeScreenPlatform.ios,
  'Chrome': HomeScreenPlatform.chrome,
};
