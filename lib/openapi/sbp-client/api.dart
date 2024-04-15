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

part 'api/groups_api.dart';
part 'api/notifications_api.dart';
part 'api/payments_api.dart';
part 'api/standard_api.dart';
part 'api/transactions_api.dart';
part 'api/washes_api.dart';

part 'model/error.dart';
part 'model/group.dart';
part 'model/healthcheck200_response.dart';
part 'model/notification.dart';
part 'model/organization.dart';
part 'model/payment.dart';
part 'model/payment_cancellation.dart';
part 'model/payment_response.dart';
part 'model/simple_wash.dart';
part 'model/transaction.dart';
part 'model/transaction_page.dart';
part 'model/transaction_status.dart';
part 'model/user.dart';
part 'model/user_organization.dart';
part 'model/user_role.dart';
part 'model/wash.dart';
part 'model/wash_creation.dart';
part 'model/wash_update.dart';


const _delimiters = {'csv': ',', 'ssv': ' ', 'tsv': '\t', 'pipes': '|'};
const _dateEpochMarker = 'epoch';
final _dateFormatter = DateFormat('yyyy-MM-dd');
final _regList = RegExp(r'^List<(.*)>$');
final _regSet = RegExp(r'^Set<(.*)>$');
final _regMap = RegExp(r'^Map<String,(.*)>$');

ApiClient defaultApiClient = ApiClient();
