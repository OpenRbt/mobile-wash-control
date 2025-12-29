import 'package:pluto_grid/pluto_grid.dart';
import '../models/db_field.dart';

class PlutoMapper {
  static List<PlutoRow> fieldsToRows(List<DbField> fields) {
    return List.generate(fields.length, (index) {
      final f = fields[index];

      return PlutoRow(
        cells: {
          '_index': PlutoCell(value: index + 1),
          'name': PlutoCell(value: f.name),
          'type': PlutoCell(value: f.type),
          'optional': PlutoCell(value: f.optional.toString()),
          'unique': PlutoCell(value: f.unique.toString()),
        },
      );
    });
  }
}
