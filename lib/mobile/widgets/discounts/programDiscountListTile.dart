import 'package:flutter/material.dart';
import 'package:mobile_wash_control/entity/entity.dart';
import 'package:mobile_wash_control/repository/repository.dart';
import 'package:easy_localization/easy_localization.dart';

class ProgramDiscountListTile extends StatelessWidget {
  final DiscountProgram discount;
  final Repository repository;

  const ProgramDiscountListTile({super.key, required this.discount, required this.repository});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Text(
                  "${context.tr('program')}: ",
                  style: theme.textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: FutureBuilder(
                  future: repository.getProgramNameFromCache(discount.programID!),
                  builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
                    return Text(
                      snapshot.data ?? "${context.tr('program')} ${discount.programID!}",
                      style: theme.textTheme.titleMedium,
                    );
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Text(
                  "${context.tr('discount')}: ",
                  style: theme.textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Text(
                  "${discount.discount ?? 0} %",
                  style: theme.textTheme.titleMedium,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
