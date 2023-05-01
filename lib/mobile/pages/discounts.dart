import 'package:flutter/material.dart';
import 'package:mobile_wash_control/entity/entity.dart';
import 'package:mobile_wash_control/entity/vo/page_args_codes.dart';
import 'package:mobile_wash_control/mobile/widgets/common/washNavigationDrawer.dart';
import 'package:mobile_wash_control/mobile/widgets/discounts/discountCampaignListTile.dart';
import 'package:mobile_wash_control/repository/repository.dart';

class DiscountsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DiscountsPageState();
}

class _DiscountsPageState extends State<DiscountsPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    var args = ModalRoute.of(context)?.settings.arguments as Map<PageArgCode, dynamic>;
    final Repository repository = args[PageArgCode.repository];

    return Scaffold(
      drawer: WashNavigationDrawer(
        selected: SelectedPage.Discounts,
        repository: repository,
      ),
      appBar: AppBar(
        title: Text("Управление скидками"),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: repository.updateDiscounts(context: context),
              builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
                return ValueListenableBuilder(
                  valueListenable: repository.getDiscountsNotifier(),
                  builder: (BuildContext context, List<DiscountCampaign>? campaigns, Widget? child) {
                    return RefreshIndicator(
                      onRefresh: () async {
                        await repository.updateDiscounts(context: context);
                      },
                      child: ListView.builder(
                        itemCount: campaigns?.length ?? 0,
                        itemBuilder: (BuildContext context, int index) {
                          return DiscountCampaignListTile(
                            campaign: campaigns![index],
                            repository: repository,
                            onPressed: () {
                              var args = Map<PageArgCode, dynamic>();
                              args[PageArgCode.repository] = repository;
                              args[PageArgCode.discountID] = campaigns![index].id;

                              Navigator.pushNamed(context, "/mobile/discounts/edit", arguments: args).then((value) => repository.updateDiscounts(context: context));
                            },
                          );
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              var args = Map<PageArgCode, dynamic>();
              args[PageArgCode.repository] = repository;
              args[PageArgCode.discountID] = null;

              Navigator.pushNamed(context, "/mobile/discounts/edit", arguments: args).then((value) => repository.updateDiscounts(context: context));
            },
            child: Text("Добавить скидочную программу"),
          ),
        ],
      ),
    );
  }
}
