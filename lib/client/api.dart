//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

library openapi.api;

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

part 'api_client.dart';
part 'api_helper.dart';
part 'api_exception.dart';
part 'auth/authentication.dart';
part 'auth/api_key_auth.dart';
part 'auth/oauth.dart';
part 'auth/http_basic_auth.dart';
part 'auth/http_bearer_auth.dart';

part 'api/default_api.dart';

part 'model/advertising_campaign.dart';
part 'model/arg_add_service_amount.dart';
part 'model/arg_advertising_campagin.dart';
part 'model/arg_advertising_campaign_by_id.dart';
part 'model/arg_card_reader_config.dart';
part 'model/arg_card_reader_config_by_cash.dart';
part 'model/arg_collection_report_dates.dart';
part 'model/arg_del_advertising_campagin.dart';
part 'model/arg_del_station.dart';
part 'model/arg_get_config_var.dart';
part 'model/arg_get_level.dart';
part 'model/arg_get_station_config_var.dart';
part 'model/arg_get_station_config_var1.dart';
part 'model/arg_get_station_discounts.dart';
part 'model/arg_load.dart';
part 'model/arg_load_from_station.dart';
part 'model/arg_load_money.dart';
part 'model/arg_measure_volume_milliliters.dart';
part 'model/arg_open_station.dart';
part 'model/arg_ping.dart';
part 'model/arg_press_button.dart';
part 'model/arg_programs.dart';
part 'model/arg_reset_station_stat.dart';
part 'model/arg_run2_program.dart';
part 'model/arg_run_program.dart';
part 'model/arg_save.dart';
part 'model/arg_save_if_not_exists.dart';
part 'model/arg_set_station_button.dart';
part 'model/arg_station_button.dart';
part 'model/arg_station_by_hash.dart';
part 'model/arg_station_program_by_hash.dart';
part 'model/arg_station_report_current_money.dart';
part 'model/arg_station_report_dates.dart';
part 'model/arg_station_stat.dart';
part 'model/arg_station_stat_dates.dart';
part 'model/arg_user_create.dart';
part 'model/arg_user_delete.dart';
part 'model/arg_user_password.dart';
part 'model/arg_user_update.dart';
part 'model/button_discount.dart';
part 'model/card_reader_config.dart';
part 'model/collection_report.dart';
part 'model/collection_report_with_user.dart';
part 'model/config_var_bool.dart';
part 'model/config_var_int.dart';
part 'model/config_var_string.dart';
part 'model/delete_user409_response.dart';
part 'model/discount_program.dart';
part 'model/kasse_config.dart';
part 'model/key_pair.dart';
part 'model/load_relay_request.dart';
part 'model/money_report.dart';
part 'model/program.dart';
part 'model/program_stat.dart';
part 'model/relay_board.dart';
part 'model/relay_config.dart';
part 'model/relay_report.dart';
part 'model/relay_stat.dart';
part 'model/response_get_level.dart';
part 'model/response_ping.dart';
part 'model/response_station_button.dart';
part 'model/response_station_button_buttons_inner.dart';
part 'model/response_station_collection_report_dates.dart';
part 'model/response_user_create.dart';
part 'model/response_user_create_conflict.dart';
part 'model/response_user_password.dart';
part 'model/response_user_update.dart';
part 'model/response_volume_dispenser.dart';
part 'model/station_config.dart';
part 'model/station_config_var_bool.dart';
part 'model/station_config_var_int.dart';
part 'model/station_config_var_string.dart';
part 'model/station_programs.dart';
part 'model/station_programs_programs_inner.dart';
part 'model/station_report.dart';
part 'model/station_request.dart';
part 'model/station_stat.dart';
part 'model/station_status.dart';
part 'model/stations_variables.dart';
part 'model/status.dart';
part 'model/status_collection_report.dart';
part 'model/status_report.dart';
part 'model/user_config.dart';
part 'model/users_report.dart';
part 'model/volume_dispenser.dart';


const _delimiters = {'csv': ',', 'ssv': ' ', 'tsv': '\t', 'pipes': '|'};
const _dateEpochMarker = 'epoch';
final _dateFormatter = DateFormat('yyyy-MM-dd');
final _regList = RegExp(r'^List<(.*)>$');
final _regSet = RegExp(r'^Set<(.*)>$');
final _regMap = RegExp(r'^Map<String,(.*)>$');

ApiClient defaultApiClient = ApiClient();
