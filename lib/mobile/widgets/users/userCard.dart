import 'package:flutter/material.dart';
import 'package:mobile_wash_control/entity/entity.dart';
import 'package:easy_localization/easy_localization.dart';

class UserCard extends StatelessWidget {
  final Function()? onPress;
  final User user;

  const UserCard({super.key, this.onPress, required this.user});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: ExpansionTile(
        title: Text(
          "${user.login} - ${user.firstName ?? ""} ${user.lastName ?? ""}",
          style: theme.textTheme.titleLarge,
          overflow: TextOverflow.ellipsis,
        ),
        childrenPadding: EdgeInsets.all(8),
        children: [
          Row(
            children: [
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Text(
                  context.tr('access_rights'),
                  style: theme.textTheme.titleLarge,
                ),
              ),
              Flexible(
                flex: 2,
                fit: FlexFit.tight,
                child: Text(
                  context.tr('user_data'),
                  style: theme.textTheme.titleLarge,
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${context.tr('operator')}: ",
                          style: theme.textTheme.bodyLarge,
                        ),
                        Checkbox(
                          value: user.isOperator ?? false,
                          onChanged: null,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${context.tr('engineer')}: ",
                          style: theme.textTheme.bodyLarge,
                        ),
                        Checkbox(
                          value: user.isEngineer ?? false,
                          onChanged: null,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${context.tr('admin')}: ",
                          style: theme.textTheme.bodyLarge,
                        ),
                        Checkbox(
                          value: user.isAdmin ?? false,
                          onChanged: null,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Flexible(
                flex: 2,
                fit: FlexFit.tight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 48,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${context.tr('lastname')}: ",
                            style: theme.textTheme.bodyLarge,
                          ),
                          Text(user.lastName ?? ""),
                        ],
                      ),
                    ),
                    Container(
                      height: 48,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${context.tr('firstname')}: ",
                            style: theme.textTheme.bodyLarge,
                          ),
                          Text(user.firstName ?? ""),
                        ],
                      ),
                    ),
                    Container(
                      height: 48,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${context.tr('middlename')}: ",
                            style: theme.textTheme.bodyLarge,
                          ),
                          Text(user.middleName ?? ""),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: onPress,
            child: Text("${context.tr('edit')}"),
          ),
        ],
      ),
    );
  }
}
