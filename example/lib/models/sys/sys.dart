import 'package:hkid_validator_web_demo/const/const.dart';

class Sys {
  Section? sec;
  String? localeName;
  Sys({
    this.sec,
    this.localeName,
  });

  factory Sys.fromJson(Map<String, dynamic> json) => Sys(
        sec: json['sec'] == 'generate' ? Section.generate : Section.validate,
        localeName: json['localeName'],
      );

  bool isMatch(Sys newSys) =>
      newSys.sec == sec && newSys.localeName == localeName;

  @override
  String toString() => toJson().toString();

  Sys mergeWith(Sys sys) => Sys(
        sec: sys.sec != sec ? sys.sec : sec,
        localeName: sys.localeName != localeName ? sys.localeName : localeName,
      );

  Sys copyWith({
    Section? sec,
    String? localeName,
  }) =>
      Sys(
        sec: sec ?? this.sec,
        localeName: localeName ?? this.localeName,
      );

  Map<String, dynamic> toJson() => {
        'sec': sec == Section.generate ? 'generate' : 'validate',
        'localeName': localeName,
      };
}
