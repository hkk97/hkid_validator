import 'package:intl/intl.dart';

class HKID {
  final String id;
  HKID({
    required this.id,
  });

  String date({required DateTime dateTime}) =>
      DateFormat("MMM dd H:mm").format(dateTime);
}
