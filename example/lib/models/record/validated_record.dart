import 'package:hkid_validator_web_demo/models/record/hkid_record.dart';
import 'package:intl/intl.dart';

class ValidatedRecord extends HKID {
  final DateTime validatedAt;
  final bool isValid;
  ValidatedRecord({
    required this.validatedAt,
    required this.isValid,
    required super.id,
  });

  String date() => DateFormat("MMM dd H:mm").format(validatedAt);

  factory ValidatedRecord.fromJson(
    Map<String, dynamic> json,
  ) =>
      ValidatedRecord(
        validatedAt: DateTime.parse(json['validatedAt']),
        id: json['id'],
        isValid: json['isValid'],
      );
}
