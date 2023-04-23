import 'dart:core';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_wash_control/application/Application.dart';
import 'package:mobile_wash_control/utils/common.dart';
import 'package:mobile_wash_control/openapi/wash-admin-client/api.dart';

final RouteObserver<PageRoute> routeObserver = new RouteObserver<PageRoute>();
void main() async {
  Common.washServersApi = WashServersApi(ApiClient(basePath: 'http://app.openwashing.com:8070', authentication: HttpBearerAuth()));

  Intl.defaultLocale = "ru_RU";
  runApp(
    Application(),
  );
}
