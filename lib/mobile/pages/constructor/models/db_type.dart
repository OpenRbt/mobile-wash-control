import 'db_table.dart';

class DbType {
  final String key;
  final List<DbTable> tables;

  DbType({required this.key, required this.tables});
}
