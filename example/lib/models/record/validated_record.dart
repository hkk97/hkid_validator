import 'package:hkid_validator_web_demo/models/record/hkid_record.dart';

class ValidatedRecord extends HKID {
  final DateTime validatedAt;
  final bool isValid;
  ValidatedRecord({
    required this.validatedAt,
    required this.isValid,
    required super.id,
  });

  factory ValidatedRecord.fromJson(
    Map<String, dynamic> json,
  ) =>
      ValidatedRecord(
        validatedAt: DateTime.parse(json['validatedAt']),
        id: json['id'],
        isValid: json['isValid'],
      );

  Map<String, Object?> toJson() => {
        'validatedAt': validatedAt.toIso8601String(),
        'id': id,
        'isValid': isValid,
      };
}
