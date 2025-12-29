import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:provider/provider.dart';

import '../models/db_table.dart';
import '../models/db_field.dart';
import '../state/db_constructor_state.dart';
import '../utils/pluto_mapper.dart';

class TableEditorPanel extends StatefulWidget {
  final DbTable table;

  const TableEditorPanel({super.key, required this.table});

  @override
  State<TableEditorPanel> createState() => _TableEditorPanelState();
}

class _TableEditorPanelState extends State<TableEditorPanel> {
  PlutoGridStateManager? stateManager;

  @override
  Widget build(BuildContext context) {
    final state = context.watch<DbConstructorState>();
    final table = widget.table;

    final columns = [
      PlutoColumn(
        title: '#',
        field: '_index',
        type: PlutoColumnType.number(),
        width: 60,
        enableEditingMode: false,
        backgroundColor: Colors.grey.shade100,
        textAlign: PlutoColumnTextAlign.center,
      ),
      PlutoColumn(title: 'Name', field: 'name', type: PlutoColumnType.text()),
      PlutoColumn(title: 'Type', field: 'type', type: PlutoColumnType.text()),
      PlutoColumn(
        title: 'Optional',
        field: 'optional',
        type: PlutoColumnType.select(['true', 'false']),
      ),
      PlutoColumn(
        title: 'Unique',
        field: 'unique',
        type: PlutoColumnType.select(['true', 'false']),
      ),
    ];

    final rows = PlutoMapper.fieldsToRows(table.fields);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Text(
                'Table: ${table.name}',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const Spacer(),

              ElevatedButton.icon(
                onPressed: () {
                  state.addField(
                    table,
                    DbField(
                      name: 'new_field_${table.fields.length + 1}',
                      type: 'string',
                      optional: true,
                      unique: false,
                    ),
                  );
                },
                icon: const Icon(Icons.add),
                label: const Text('Add field'),
              ),

              const SizedBox(width: 8),

              OutlinedButton.icon(
                onPressed:
                    stateManager?.currentRow == null
                        ? null
                        : () {
                          final index = stateManager!.currentRowIdx;
                          if (index == null) return;

                          state.deleteField(table, index);
                        },
                icon: const Icon(Icons.delete),
                label: const Text('Delete field'),
              ),
            ],
          ),
        ),

        Expanded(
          child: PlutoGrid(
            key: ValueKey(table.fields.length),
            columns: columns,
            rows: rows,
            onLoaded: (event) {
              stateManager = event.stateManager;
              stateManager!.setSelectingMode(PlutoGridSelectingMode.row);
            },
            configuration: PlutoGridConfiguration(
              style: PlutoGridStyleConfig(
                rowHeight: 48,
                columnHeight: 48,
                gridBorderColor: Colors.grey.shade300,
                activatedBorderColor: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
