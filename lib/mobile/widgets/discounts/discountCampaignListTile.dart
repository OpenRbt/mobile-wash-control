import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_wash_control/entity/entity.dart';
import 'package:mobile_wash_control/mobile/widgets/discounts/programDiscountListTile.dart';
import 'package:mobile_wash_control/repository/repository.dart';
import 'package:easy_localization/easy_localization.dart';

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
        leading: Icon(Icons.discount_outlined),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
                child: Text(
                  campaign.name ?? "${context.tr('discount_program')} ${campaign.id!}",
                  overflow: TextOverflow.fade,
                ),
            ),
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
                  context.tr('discount_by_default'),
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
                  context.tr('dates_of_the_event'),
                  style: theme.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              Flexible(
                flex: 2,
                fit: FlexFit.tight,
                child: Wrap(
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("${context.tr('from')} ", style: theme.textTheme.titleMedium),
                        Text(
                          _dateFormatter.format(campaign.startDate) + " ",
                          style: theme.textTheme.titleLarge!.copyWith(color: theme.primaryColor),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("${context.tr('to')} ", style: theme.textTheme.titleMedium),
                        Text(
                          _dateFormatter.format(campaign.endDate),
                          style: theme.textTheme.titleLarge!.copyWith(color: theme.primaryColor),
                        ),
                      ],
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
                  context.tr('active_hours'),
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
                  context.tr('active_days_of_week'),
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
                            context.tr('not_defined'),
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
          ExpansionTile(title: Text("${context.tr('programs_discounts')} - ${campaign.discountPrograms?.length ?? 0}"), children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: campaign.discountPrograms?.length ?? 0,
              itemBuilder: (BuildContext context, int index) {
                return ProgramDiscountListTile(discount: campaign.discountPrograms!.elementAt(index), repository: repository);
              },
            ),
          ]),
          TextButton(
            onPressed: onPressed,
            child: Text("${context.tr('edit')}"),
          ),
        ],
      ),
    );
  }

  String _durationFormat(Duration d) {
    return "${d.inHours.toString().padLeft(2, "0")}:${d.inMinutes.remainder(60).toString().padLeft(2, "0")}";
  }
}
