import 'package:flutter/material.dart';
import '../models/db_table.dart';

class TablesPanel extends StatelessWidget {
  final List<DbTable> tables;
  final DbTable? selected;
  final ValueChanged<DbTable> onSelect;

  const TablesPanel({
    super.key,
    required this.tables,
    required this.selected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(12),
          child: Text(
            'Tables',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: tables.length,
            itemBuilder: (context, index) {
              final table = tables[index];
              final isSelected = table == selected;

              return ListTile(
                leading: const Icon(Icons.table_chart),
                title: Text(table.name),
                selected: isSelected,
                onTap: () => onSelect(table),
              );
            },
          ),
        ),
      ],
    );
  }
}
