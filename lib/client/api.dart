library swagger.api;

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';

part 'api_client.dart';
part 'api_helper.dart';
part 'api_exception.dart';
part 'auth/authentication.dart';
part 'auth/api_key_auth.dart';
part 'auth/oauth.dart';
part 'auth/http_basic_auth.dart';

part 'api/default_api.dart';

part 'model/args.dart';
part 'model/args1.dart';
part 'model/args10.dart';
part 'model/args11.dart';
part 'model/args12.dart';
part 'model/args13.dart';
part 'model/args14.dart';
part 'model/args15.dart';
part 'model/args16.dart';
part 'model/args17.dart';
part 'model/args18.dart';
part 'model/args19.dart';
part 'model/args2.dart';
part 'model/args3.dart';
part 'model/args4.dart';
part 'model/args5.dart';
part 'model/args6.dart';
part 'model/args7.dart';
part 'model/args8.dart';
part 'model/args9.dart';
part 'model/card_reader_config.dart';
part 'model/collection_report.dart';
part 'model/hash.dart';
part 'model/inline_response200.dart';
part 'model/inline_response2001.dart';
part 'model/kasse_config.dart';
part 'model/key_pair.dart';
part 'model/money_report.dart';
part 'model/program_info.dart';
part 'model/relay_config.dart';
part 'model/relay_report.dart';
part 'model/relay_stat.dart';
part 'model/station_report.dart';
part 'model/station_status.dart';
part 'model/stations_variables.dart';
part 'model/status.dart';
part 'model/status_collection_report.dart';
part 'model/status_report.dart';


ApiClient defaultApiClient = new ApiClient();
