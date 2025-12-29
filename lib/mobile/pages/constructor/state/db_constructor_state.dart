import 'package:flutter/material.dart';
import 'package:mobile_wash_control/mobile/pages/constructor/models/db_field.dart';

import '../models/db_type.dart';
import '../models/db_table.dart';

class DbConstructorState extends ChangeNotifier {
  final List<DbType> types;

  DbType? selectedType;
  DbTable? selectedTable;

  DbConstructorState(this.types);

  List<DbTable> get selectedTables => selectedType?.tables ?? [];

  void selectType(DbType type) {
    selectedType = type;
    selectedTable = null;
    notifyListeners();
  }

  void selectTable(DbTable table) {
    selectedTable = table;
    notifyListeners();
  }

  void addField(DbTable table, DbField field) {
    table.fields.add(field);
    notifyListeners();
  }

  void updateField(DbTable table, int index, DbField field) {
    table.fields[index] = field;
    notifyListeners();
  }

  void deleteField(DbTable table, int index) {
    table.fields.removeAt(index);
    notifyListeners();
  }

  factory DbConstructorState.mock() {
    final stationsTable = DbTable(
      name: 'stations',
      fields: [
        DbField(name: 'id', type: 'uuid', optional: false, unique: true),
        DbField(name: 'name', type: 'string', optional: false, unique: false),
        DbField(name: 'status', type: 'enum', optional: false, unique: false),
        DbField(
          name: 'created_at',
          type: 'timestamp',
          optional: false,
          unique: false,
        ),
      ],
    );

    final programsTable = DbTable(
      name: 'programs',
      fields: [
        DbField(name: 'id', type: 'uuid', optional: false, unique: true),
        DbField(name: 'title', type: 'string', optional: false, unique: false),
        DbField(name: 'price', type: 'decimal', optional: false, unique: false),
      ],
    );

    final usersTable = DbTable(
      name: 'users',
      fields: [
        DbField(name: 'id', type: 'uuid', optional: false, unique: true),
        DbField(name: 'email', type: 'string', optional: false, unique: true),
        DbField(name: 'phone', type: 'string', optional: true, unique: true),
      ],
    );

    return DbConstructorState([
      DbType(
        key: 'default',
        tables: [stationsTable, programsTable, usersTable],
      ),
    ]);
  }
}
