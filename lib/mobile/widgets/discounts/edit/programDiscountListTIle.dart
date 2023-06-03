import 'package:flutter/material.dart';
import 'package:mobile_wash_control/entity/entity.dart';
import 'package:mobile_wash_control/repository/repository.dart';

class EditProgramDiscountListTile extends StatelessWidget {
  final int index;
  final ValueNotifier<DiscountCampaign> campaign;
  final DiscountProgram discount;
  final Repository repository;

  const EditProgramDiscountListTile({super.key, required this.campaign, required this.discount, required this.index, required this.repository});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Row(
          children: [
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Text(
                "Программа: ",
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
                    snapshot.data ?? "Программа ${discount.programID!}",
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
                "Скидка: ",
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              onPressed: () {
                final discounts = campaign.value.discountPrograms!;
                discounts.remove(discount);
                campaign.value = campaign.value.copyWith(discountPrograms: discounts);
              },
              child: Text("Удалить"),
            ),
          ],
        ),
      ],
    );
  }
}
