import 'package:flutter/material.dart';
import 'package:mobile_wash_control/CommonElements.dart';

class AccountsMenuArgs {}

class AccountsMenu extends StatefulWidget {
  @override
  _AccountsMenuState createState() => _AccountsMenuState();
}

class _AccountsMenuState extends State<AccountsMenu> {
  _AccountsMenuState() : super();

  @override
  Widget build(BuildContext context) {
    final AppBar appBar = AppBar(
      title: Text("Учетки"),
    );

    double screenH = MediaQuery.of(context).size.height;
    double screenW = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: appBar,
      drawer: prepareDrawer(context, Pages.Accounts),
      body: OrientationBuilder(
        builder: (context, orientation) {
          return new SizedBox(
            height: screenH - appBar.preferredSize.height,
            width: screenW,
            child: Text("EmptySpace"),
          );
        },
      ),
    );
  }
}
