import 'package:hkid_validator_web_demo/models/record/hkid_record.dart';

class GeneratedRecord extends HKID {
  final DateTime createdAt;
  GeneratedRecord({
    required this.createdAt,
    required super.id,
  });

  factory GeneratedRecord.fromJson(
    Map<String, dynamic> json,
  ) =>
      GeneratedRecord(
        createdAt: DateTime.parse(json['createdAt']),
        id: json['id'],
      );

  Map<String, Object?> toJson() => {
        'createdAt': createdAt.toIso8601String(),
        'id': id,
      };
}
