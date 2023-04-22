import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_wash_control/entity/entity.dart';
import 'package:mobile_wash_control/mobile/widgets/discounts/programDiscountListTile.dart';
import 'package:mobile_wash_control/repository/repository.dart';

class DiscountCampaignListTile extends StatelessWidget {
  final DiscountCampaign campaign;
  final Repository repository;
  final Function()? onPressed;

  final _dateFormatter = DateFormat('dd.MM.yyyy');

  DiscountCampaignListTile({super.key, required this.campaign, required this.repository, this.onPressed});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: ExpansionTile(
        leading: IconButton(
          icon: Icon(Icons.edit_outlined),
          onPressed: onPressed,
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(campaign.name ?? "Скидочная кампания ${campaign.id!}"),
            Icon(
              Icons.circle,
              color: (campaign.enabled ?? false) ? Colors.green : Colors.red,
            )
          ],
        ),
        childrenPadding: EdgeInsets.all(8),
        children: [
          Row(
            children: [
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Text(
                  "Скидка по умолчанию",
                  style: theme.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              Flexible(
                flex: 2,
                fit: FlexFit.tight,
                child: Text(
                  "${campaign.defaultDiscount ?? 0} %",
                  style: theme.textTheme.titleLarge,
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
                  "Даты проведения",
                  style: theme.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              Flexible(
                flex: 2,
                fit: FlexFit.tight,
                child: Row(
                  children: [
                    Text("С ", style: theme.textTheme.titleMedium),
                    Text(
                      _dateFormatter.format(campaign.startDate),
                      style: theme.textTheme.titleLarge!.copyWith(color: theme.primaryColor),
                    ),
                    Text(" по ", style: theme.textTheme.titleMedium),
                    Text(
                      _dateFormatter.format(campaign.endDate),
                      style: theme.textTheme.titleLarge!.copyWith(color: theme.primaryColor),
                    ),
                  ],
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
                  "Часы проведения",
                  style: theme.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              Flexible(
                flex: 2,
                fit: FlexFit.tight,
                child: Row(
                  children: [
                    Text(
                      "${_durationFormat(Duration(minutes: campaign.startMinute ?? 0))}-${_durationFormat(Duration(minutes: campaign.endMinute ?? 0))}",
                      style: theme.textTheme.titleLarge!.copyWith(color: theme.primaryColor),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              children: [
                Text(
                  "Дни действия",
                  style: theme.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: (campaign.weekDays?.length ?? 0) > 0
                      ? List.generate(
                          campaign.weekDays!.length,
                          (index) => Text(
                            campaign.weekDays!.elementAt(index).labelShort(),
                            style: theme.textTheme.titleMedium,
                          ),
                        )
                      : [
                          Text(
                            "Не определены",
                            style: theme.textTheme.titleMedium!.copyWith(
                              color: theme.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                ),
              ],
            ),
          ),
          ExpansionTile(title: Text("Скидки по программам - ${campaign.discountPrograms?.length ?? 0} шт"), children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: campaign.discountPrograms?.length ?? 0,
              itemBuilder: (BuildContext context, int index) {
                return ProgramDiscountListTile(discount: campaign.discountPrograms!.elementAt(index), repository: repository);
              },
            ),
          ])
        ],
      ),
    );
  }

  String _durationFormat(Duration d) {
    return "${d.inHours.toString().padLeft(2, "0")}:${d.inMinutes.remainder(60).toString().padLeft(2, "0")}";
  }
}
