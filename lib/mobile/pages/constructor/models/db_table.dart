import 'db_field.dart';

class DbTable {
  final String name;
  final List<DbField> fields;

  DbTable({required this.name, required this.fields});
}
