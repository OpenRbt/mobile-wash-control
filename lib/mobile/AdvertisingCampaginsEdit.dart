import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:mobile_wash_control/CommonElements.dart';
import 'package:mobile_wash_control/client/api.dart';

class AdvertisingCampaginsEditArgs{
  final SessionData sessionData;
  AdvertisingCampaign campaign;

  AdvertisingCampaginsEditArgs(this.sessionData, this.campaign);
}

class AdvertisingCampaginsEdit extends StatefulWidget {
  @override
  _AdvertisingCampaginsEditState createState() => _AdvertisingCampaginsEditState();
}

class _AdvertisingCampaginsEditState extends State<AdvertisingCampaginsEdit> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var _isSnackBarActive = ValueWrapper(false);

  bool _firstLoad = true;


  @override
  Widget build(BuildContext context) {
    final AdvertisingCampaginsEditArgs args = ModalRoute.of(context).settings.arguments;

    if (_firstLoad) {
      _firstLoad = false;
    }

    final AppBar appBar = AppBar(
      title: Text("Управление скидками"),
    );

    double screenH = MediaQuery.of(context).size.height - appBar.preferredSize.height - MediaQuery.of(context).padding.top;
    double screenW = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      appBar: appBar,
      body: Container(
        width: screenW,
        height: screenH,

      ),
    );
  }
}
