import 'package:flutter/material.dart';
import '../models/db_type.dart';

class TypesPanel extends StatelessWidget {
  final List<DbType> types;
  final DbType? selected;
  final ValueChanged<DbType> onSelect;

  const TypesPanel({
    super.key,
    required this.types,
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
            'Types',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: types.length,
            itemBuilder: (context, index) {
              final type = types[index];
              final isSelected = type == selected;

              return ListTile(
                title: Text(type.key),
                selected: isSelected,
                onTap: () => onSelect(type),
              );
            },
          ),
        ),
      ],
    );
  }
}
