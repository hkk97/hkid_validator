import 'package:hkid_validator_web_demo/model/record/hkid_record.dart';
import 'package:intl/intl.dart';

class GeneratedRecord extends HKID {
  final DateTime createdAt;
  GeneratedRecord({
    required this.createdAt,
    required super.id,
  });

  String date() => DateFormat("MMM dd H:mm").format(createdAt);

  factory GeneratedRecord.fromJson(
    Map<String, dynamic> json,
  ) =>
      GeneratedRecord(
        createdAt: DateTime.parse(json['createdAt']),
        id: json['id'],
      );
}
