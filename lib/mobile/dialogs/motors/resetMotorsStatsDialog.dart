import 'package:flutter/material.dart';
import 'package:mobile_wash_control/mobile/widgets/common/ProgressTextButton.dart';
import 'package:mobile_wash_control/repository/repository.dart';

class ResetMotorsStatsDialog extends StatelessWidget {
  final Repository repository;

  ResetMotorsStatsDialog({super.key, required this.repository});

  Map<int, bool> _posts = Map.fromIterable(List.generate(12, (index) => index + 1), value: (index) => false);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    var appBarPadding = AppBar().preferredSize.height + MediaQuery.of(context).padding.top;

    return Align(
      alignment: Alignment.bottomCenter,
      child: Card(
        child: Container(
          height: MediaQuery.of(context).size.height - appBarPadding,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(0),
          child: Column(
            children: [
              Text(
                "Сброс статистики моторесурса",
                style: theme.textTheme.titleLarge,
              ),
              Expanded(
                child: StatefulBuilder(
                  builder: (context, setState) {
                    return ListView.builder(
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: _posts.length,
                      itemBuilder: (BuildContext context, int index) {
                        return CheckboxListTile(
                          value: _posts[index + 1],
                          onChanged: (value) {
                            _posts[index + 1] = value ?? false;
                            setState(() {});
                          },
                          title: Text("Пост ${index + 1}"),
                        );
                      },
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Вы уверены?"),
                            actions: [
                              ProgressTextButton(
                                onPressed: () async {
                                  _posts.forEach((key, value) async {
                                    if (value) {
                                      await repository.resetStationStats(key, context: context);
                                    }
                                  });
                                  Navigator.pop(context);
                                  Navigator.of(context).pop();
                                },
                                child: Text("Да"),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text("Нет"),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Text("Сбросить"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Отмена"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
