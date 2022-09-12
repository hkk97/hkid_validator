import 'dart:async';
import 'package:sembast/sembast.dart';

class DBSerClient {
  DBSer? dbSer;
  DBSerClient({this.dbSer});

  Future<void> init() async {}
  void setSer(DBSer ser) => dbSer = ser;
}

class DBSer {
  final String name;
  final int dbVersion;
  final Database db;
  final DatabaseFactory dbFactory;
  final StoreRef<int, Map<String, Object?>> dbstore;

  DBSer.client(
      this.name, this.dbVersion, this.db, this.dbFactory, this.dbstore);

  Future<void> dispose() async => db.close();
}
