import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'state/db_constructor_state.dart';
import 'widgets/types_panel.dart';
import 'widgets/tables_panel.dart';
import 'widgets/table_editor_panel.dart';

class ConstructorPage extends StatelessWidget {
  const ConstructorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DbConstructorState.mock(),
      child: const _ConstructorView(),
    );
  }
}

class _ConstructorView extends StatelessWidget {
  const _ConstructorView();

  @override
  Widget build(BuildContext context) {
    final state = context.watch<DbConstructorState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Database Constructor'),
      ),
      body: Row(
        children: [
          SizedBox(
            width: 220,
            child: TypesPanel(
              types: state.types,
              selected: state.selectedType,
              onSelect: state.selectType,
            ),
          ),

          const VerticalDivider(width: 1),

          SizedBox(
            width: 240,
            child: TablesPanel(
              tables: state.selectedTables,
              selected: state.selectedTable,
              onSelect: state.selectTable,
            ),
          ),

          const VerticalDivider(width: 1),

          Expanded(
            child: state.selectedTable == null
                ? const Center(child: Text('Select table'))
                : TableEditorPanel(table: state.selectedTable!),
          ),
        ],
      ),
    );
  }
}
