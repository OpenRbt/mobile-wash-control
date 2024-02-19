import 'package:flutter/material.dart';

class DropDownByID extends StatelessWidget {

  final List<dynamic> values;
  final dynamic currentValue;
  final Future<void>Function(dynamic value) onChanged;
  final bool canEdit;

  const DropDownByID({
    Key? key,
    required this.values,
    this.currentValue,
    required this.onChanged,
    required this.canEdit
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return DropdownButtonFormField(
      isExpanded: true,
      value: currentValue,
      items: List.generate(
        values.length,
            (index) => DropdownMenuItem(
          value: values[index],
          child: Text('${values[index].id}'),
        ),
      ),
      onChanged: canEdit ?
          (value) async {
        onChanged(value);
      }
          : null,
    );
  }
}
