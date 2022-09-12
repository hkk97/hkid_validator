import 'package:sembast/sembast.dart';

class DBSer {
  final String name;
  final DatabaseFactory dbFactory;
  final StoreRef<int, Map<String, Object?>> dbstore;

  DBSer({
    required this.name,
    required this.dbFactory,
    required this.dbstore,
  });
}
