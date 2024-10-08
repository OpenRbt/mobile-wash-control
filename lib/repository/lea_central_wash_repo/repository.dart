import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobile_wash_control/entity/entity.dart' as entity;
import 'package:mobile_wash_control/mobile/widgets/common/snackBars.dart';
import 'package:mobile_wash_control/openapi/lea-central-wash/api.dart';
import 'package:mobile_wash_control/repository/lea_central_wash_repo/helpers.dart';
import 'package:mobile_wash_control/repository/repository.dart';

class LeaCentralRepository extends Repository {
  final DefaultApi api;
  entity.User? _currentUser;

  Future? refresh;
  final refreshDelay = Duration(seconds: 1, milliseconds: 500);

  ValueNotifier<List<entity.Station>?> _stations = ValueNotifier(null);
  ValueNotifier<List<entity.Organization>?> _organizations = ValueNotifier(null);
  ValueNotifier<entity.KasseStatus?> _kasseStatus = ValueNotifier(null);
  ValueNotifier<entity.ServiceStatus?> _bonusStatus = ValueNotifier(null);
  ValueNotifier<entity.ServiceStatus?> _sbpStatus = ValueNotifier(null);
  ValueNotifier<String?> _lcwRepo = ValueNotifier(null);
  ValueNotifier<List<entity.Program>?> _programs = ValueNotifier(null);
  ValueNotifier<List<entity.User>?> _users = ValueNotifier(null);
  ValueNotifier<List<entity.DiscountCampaign>?> _discount = ValueNotifier(null);
  ValueNotifier<List<String>?> _hashes = ValueNotifier(null);

  LeaCentralRepository(this.api) {
    _prepareStatusRefresh();
  }

  void _prepareStatusRefresh() {
    refresh = Future.delayed(refreshDelay, () async {
      await updateStatus();
      _prepareStatusRefresh();
    });
  }

  @override
  void dispose() {
    _stations.dispose();
    _organizations.dispose();
    _kasseStatus.dispose();
    _bonusStatus.dispose();
    _sbpStatus.dispose();
    _lcwRepo.dispose();
    _programs.dispose();
    _users.dispose();
  }

  @override
  ValueNotifier<List<entity.Station>?> getStationsNotifier() => _stations;

  @override
  ValueNotifier<List<entity.Organization>?> getOrganizationsNotifier() => _organizations;

  @override
  ValueNotifier<entity.KasseStatus?> getKasseStatusNotifier() => _kasseStatus;

  @override
  ValueNotifier<entity.ServiceStatus?> getBonusStatusNotifier() => _bonusStatus;

  @override
  ValueNotifier<entity.ServiceStatus?> getSbpStatusNotifier() => _sbpStatus;

  @override
  ValueNotifier<String?> getLCWRepoNotifier() => _lcwRepo;

  @override
  ValueNotifier<List<entity.Program>?> getProgramsNotifier() => _programs;

  @override
  ValueNotifier<List<entity.User>?> getUsersNotifier() => _users;

  @override
  ValueNotifier<List<entity.DiscountCampaign>?> getDiscountsNotifier() => _discount;

  @override
  ValueNotifier<List<String>?> getHashesNotifier() => _hashes;

  @override
  Future<List<entity.Station>?> getStations() async {
    print("get Stations");
    final stations = _stations.value;
    if (stations == null) {
      await updateStatus();
    }

    return _stations.value;
  }

  @override
  Future<void> updateStatus({BuildContext? context}) async {
    try {
      final res = await api.status();

      var stations = <entity.Station>[];
      res?.stations.where((element) => element.id != null).forEach((element) {
        stations.add(entity.Station(
          id: element.id!,
          name: element.name,
          hash: element.hash,
          status: element.status?.value,
          currentBalance: element.currentBalance,
          currentProgramName: element.currentProgramName,
          currentProgram: element.currentProgram,
          ip: element.ip,
          firmwareVersion: element.version?.id
        ));
      });

      stations.sort((a, b) => a.id.compareTo(b.id));
      if (!listEquals(_stations.value, stations)) {
        _stations.value = stations;
      }
      if (_lcwRepo.value != res?.lcwInfo) {
        _lcwRepo.value = res?.lcwInfo;
      }

      var hashes = <String>[""];
      res?.stations.where((element) => element.hash != null).forEach((element) {
        hashes.add(element.hash!);
      });
      if (_hashes.value != hashes) {
        _hashes.value = hashes;
      }

      //bonus_status
      //sbp_status
      //res?.bonusStatus?;
      var kasseStatus = entity.KasseStatus(status: res?.kasseStatus?.value, info: res?.kasseInfo);
      if (_kasseStatus.value != kasseStatus) {
        _kasseStatus.value = kasseStatus;
      }

      var bonusStatus = entity.ServiceStatus(
          available: res?.bonusStatus?.available,
          disabledOnServer: res?.bonusStatus?.disabledOnServer,
          isConnected: res?.bonusStatus?.isConnected,
          lastErr: res?.bonusStatus?.lastErr,
          dateLastErrUTC: res?.bonusStatus?.dateLastErrUTC,
          unpaidStations: res?.bonusStatus?.unpaidStations
      );
      if (_bonusStatus.value != bonusStatus) {
        _bonusStatus.value = bonusStatus;
      }

      var sbpStatus = entity.ServiceStatus(
          available: res?.sbpStatus?.available,
          disabledOnServer: res?.sbpStatus?.disabledOnServer,
          isConnected: res?.sbpStatus?.isConnected,
          lastErr: res?.sbpStatus?.lastErr,
          dateLastErrUTC: res?.sbpStatus?.dateLastErrUTC,
          unpaidStations: res?.sbpStatus?.unpaidStations
      );
      if (_sbpStatus.value != sbpStatus) {
        _sbpStatus.value = sbpStatus;
      }

    } on ApiException catch (e) {
      switch (e.code) {
        default:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('failed')} ${context.tr('to_update_status')}, ${context.tr('error')}: ${e.code}"));
          }
          break;
      }
    } catch (e) {
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('an_unknown_error_has_occurred')}: $e"));
      }
    }
  }

  @override
  Future<void> updateOrganizations({BuildContext? context}) async {
    try {
      //final res = await api.organizations();

      var organizations = <entity.Organization>[];
      for(int i = 0; i < 12; i++){
        organizations.add(entity.Organization(
          id: i.toString(),
          name: "Organization$i",
          description: "${context?.tr('description')} $i",
        ));
      }

      organizations.sort((a, b) => a.id!.compareTo(b.id!));
      if (!listEquals(_organizations.value, organizations)) {
        _organizations.value = organizations;
      }
      /*
      if (_lcwRepo.value != res?.lcwInfo) {
        _lcwRepo.value = res?.lcwInfo;
      }
      */

    } on ApiException catch (e) {
      switch (e.code) {
        default:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('failed')} ${context.tr('to_update_status')}, ${context.tr('error')}: ${e.code}"));
          }
          break;
      }
    } catch (e) {
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('an_unknown_error_has_occurred')}: $e"));
      }
    }
  }

  @override
  Future<List<entity.Program>?> getPrograms() async {
    final programs = _programs.value;
    if (programs == null) {
      await updatePrograms();
    }

    return _programs.value;
  }

  @override
  Future<void> updatePrograms({BuildContext? context}) async {
    try {
      final res = await api.programs(ArgPrograms());

      var programs = <entity.Program>[];
      res?.forEach((element) {
        programs.add(Helpers.programFromApi(element));
      });

      _programs.value = programs;
    } on ApiException catch (e) {
      switch (e.code) {
        default:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('failed')} ${context.tr('to_get')} ${context.tr('programs_list')}, ${context.tr('error')}: ${e.code}"));
          }
          break;
      }
    } catch (e) {
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('an_unknown_error_has_occurred')}: $e"));
      }
    }
  }

  @override
  Future<entity.Program?> getProgram(int id, {BuildContext? context}) async {
    try {
      var programs = await api.programs(ArgPrograms(programID: id));

      return Helpers.programFromApi(programs!.single);
    } on ApiException catch (e) {
      switch (e.code) {
        default:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('failed')} ${context.tr('to_load_program')}, ${context.tr('error')}: ${e.code}"));
          }
          break;
      }
    } catch (e) {
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('an_unknown_error_has_occurred')}: $e"));
      }
    }

    return null;
  }

  @override
  Future<entity.Station?> getStation(int id) async {
    print("GetStations");
    var stations = _stations.value;
    if (stations == null) {
      await updateStatus();
      stations = _stations.value;
    }

    var stationsFiltered = stations!.where((element) => element.id == id);
    if (stationsFiltered.length == 0) {
      return null;
    }

    return stationsFiltered.first;
  }

  @override
  Future<List<entity.StationButton>?> getStationButtons(int id, {BuildContext? context}) async {
    try {
      final programs = await getPrograms();

      var args = ArgStationButton(stationID: id);
      var response = await api.stationButton(args);

      var res = <entity.StationButton>[];

      response?.buttons.forEach((element) {
        var programsFiltered = programs?.where((program) => program.id == element.programID);

        res.add(entity.StationButton(
          buttonID: element.buttonID!,
          programID: element.programID,
          programName: (programsFiltered != null && programsFiltered.isNotEmpty) ? programsFiltered.first.name : null,
        ));
      });

      res.sort((a, b) => a.buttonID.compareTo(b.buttonID));

      return res;
    } on ApiException catch (e) {
      switch (e.code) {
        case HttpStatus.notFound:
          break;
        default:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('post')} $id, ${context.tr('error')}: ${e.code}"));
          }
          break;
      }
    } catch (e) {
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('an_unknown_error_has_occurred')}: $e"));
      }
    }

    return null;
  }

  @override
  Future<void> addServiceMoney(int id, int amount, {BuildContext? context}) async {
    try {
      final station = await getStation(id);
      if (station?.hash == null || station!.hash!.isEmpty) {
        return;
      }

      final args = ArgAddServiceAmount(amount: amount, hash: station.hash!);
      final response = await api.addServiceAmount(args);
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBars.getSuccessSnackBar(message: "${context.tr('credited')} $amount  ${context.tr('to_post')} $id"));
      }
    } on ApiException catch (e) {
      switch (e.code) {
        default:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('post')} $id, ${context.tr('error')}: ${e.code}"));
          }
          break;
      }
    } catch (e) {
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('an_unknown_error_has_occurred')}: $e"));
      }
    }
  }

  @override
  Future<entity.StationMoneyReport?> getStationMoneyReport(int id, {BuildContext? context}) async {
    final args = ArgStationReportCurrentMoney(id: id);

    try {
      final response = await api.stationReportCurrentMoney(args);
      return Helpers.stationMoneyReportFromAPI(response!.moneyReport!, id);
    } on ApiException catch (e) {
      switch (e.code) {
        case HttpStatus.notFound:
          break;
        default:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('post')} $id, ${context.tr('error')}: ${e.code}"));
          }
          break;
      }
    } catch (e) {
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('an_unknown_error_has_occurred')}: $e"));
      }
    }

    return null;
  }

  @override
  Future<void> stationOpenDoor(int id, {BuildContext? context}) async {
    try {
      final args = ArgOpenStation(stationID: id);
      final response = await api.openStation(args);
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBars.getSuccessSnackBar(message: "${context.tr('the_lid_has_been_opened_on_post')} $id"));
      }
    } on ApiException catch (e) {
      switch (e.code) {
        case HttpStatus.notFound:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getWarningSnackBar(message: "${context.tr('post_not_found')} $id"));
          }
          break;
        default:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('post')} $id, ${context.tr('error')}: ${e.code}"));
          }
          break;
      }
    } catch (e) {
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('an_unknown_error_has_occurred')}: $e"));
      }
    }
  }

  @override
  Future<void> stationSaveCollection(int id, {BuildContext? context}) async {
    try {
      final args = StationRequest(id: id);
      final response = await api.saveCollection(args);
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBars.getSuccessSnackBar(message: "${context.tr('post')} $id ${context.tr('collected')}"));
      }
    } on ApiException catch (e) {
      switch (e.code) {
        case HttpStatus.notFound:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getWarningSnackBar(message: "${context.tr('post_not_found')} $id"));
          }
          break;
        case HttpStatus.unauthorized:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('wrong')} PIN"));
          }
          break;
        case HttpStatus.forbidden:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('access_denied')}"));
          }
          break;
        default:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('post')} $id, ${context.tr('error')}: ${e.code}"));
          }
          break;
      }
    } catch (e) {
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('an_unknown_error_has_occurred')}: $e"));
      }
    }
  }

  @override
  entity.Program? getCurrentProgram(int id) {
    final stations = _stations.value;
    final programs = _programs.value;
    if (stations == null || programs == null) return null;

    var stationsFiltered = stations.where((element) => element.id == id);
    if (stationsFiltered.length == 0) {
      return null;
    }

    var station = stationsFiltered.first;

    var programsFiltered = programs.where((program) => program.id == station.currentProgram);
    return programsFiltered.isNotEmpty ? programsFiltered.first : null;
  }

  @override
  Future<void> saveProgram(entity.Program program, {BuildContext? context}) async {
    try {
      int id;
      if (program.id == null) {
        final programs = await getPrograms();
        var maxId = programs?.reduce((a, b) => a.id! > b.id! ? a : b);
        id = (maxId?.id ?? 1000) + 1;
      } else {
        id = program.id!;
      }

      var args = Program(
        id: id,
        name: program.name,
        price: program.price,
        isFinishingProgram: program.isFinishingProgram,
        motorSpeedPercent: program.motorSpeedPercent,
        preflightMotorSpeedPercent: program.preflightMotorSpeedPercent,
        preflightEnabled: program.preflightEnabled,
        relays: program.relays.where((element) => element.timeOn > 0).map((e) => RelayConfig(id: e.id, timeon: e.timeOn, timeoff: e.timeOff)).toList(),
        preflightRelays: program.relaysPreflight.where((element) => element.timeOn > 0).map((e) => RelayConfig(id: e.id, timeon: e.timeOn, timeoff: e.timeOff)).toList(),
      );

      await api.setProgram(args);

      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBars.getSuccessSnackBar(message: context.tr('program_saved_successfully')));
      }
    } on ApiException catch (e) {
      switch (e.code) {
        default:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('failed')} ${context.tr('to_save_program')}, ${context.tr('error')}: ${e.code}"));
          }
          break;
      }
    } catch (e) {
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('an_unknown_error_has_occurred')}: $e"));
      }
    }
  }

  @override
  Future<List<entity.User>?> getUsers() async {
    final users = _users.value;
    if (users == null) {
      await updateUsers();
    }

    return _users.value;
  }

  @override
  Future<void> updateUsers({BuildContext? context}) async {
    try {
      final response = await api.getUsers();

      final users = List.generate(response?.users.length ?? 0, (index) => Helpers.userFromApi(response!.users[index]));
      users.sort((a, b) => a.login.compareTo(b.login));

      _users.value = users;
    } on ApiException catch (e) {
      switch (e.code) {
        case HttpStatus.unauthorized:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('wrong')} PIN"));
          }
          break;
        case HttpStatus.forbidden:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('access_denied')}"));
          }
          break;
        default:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('failed')} ${context.tr('to_get')} ${context.tr('users_list')}, ${context.tr('error')}: ${e.code}"));
          }
          break;
      }
    } catch (e) {
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('an_unknown_error_has_occurred')}: $e"));
      }
    }
  }

  @override
  Future<void> updateUser(entity.User user, {BuildContext? context}) async {
    try {
      final args = ArgUserUpdate(
        login: user.login,
        firstName: ((user.firstName?.length ?? 0) > 0 ? user.firstName : null),
        lastName: ((user.lastName?.length ?? 0) > 0 ? user.lastName : null),
        middleName: ((user.middleName?.length ?? 0) > 0 ? user.middleName : null),
        isAdmin: user.isAdmin,
        isOperator: user.isOperator,
        isEngineer: user.isEngineer,
      );
      final response = api.updateUser(args);

      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBars.getSuccessSnackBar(message: "${context.tr('user')} ${user.login} ${context.tr('updated_successfully')}"));
      }
    } on ApiException catch (e) {
      switch (e.code) {
        case HttpStatus.unauthorized:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('wrong')} PIN"));
          }
          break;
        case HttpStatus.forbidden:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('access_denied')}"));
          }
          break;
        case HttpStatus.notFound:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('user')} ${context.tr('not_found_with_this_login')}"));
          }
          break;

        case HttpStatus.forbidden:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('access_denied')}"));
          }
          break;
        default:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('error')}: ${e.code}"));
          }
          break;
      }
    } catch (e) {
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('an_unknown_error_has_occurred')}: $e"));
      }
    }
  }

  @override
  Future<void> updateUserPassword(entity.User user, entity.User currentUser, String oldPassword, String newPassword, {BuildContext? context}) async {
    try {
      final args = ArgUserPassword(
        login: user.login,
        oldPassword: oldPassword,
        newPassword: newPassword,
      );
      final response = await api.updateUserPassword(args);
      if(user.login == currentUser.login){
        api.apiClient.addDefaultHeader("Pin", newPassword);
      }

      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBars.getSuccessSnackBar(message: "${context.tr('users_password')} ${user.login} ${context.tr('updated_successfully')}"));
      }
    } on ApiException catch (e) {
      switch (e.code) {
        case HttpStatus.unauthorized:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('wrong')} PIN"));
          }
          break;
        case HttpStatus.forbidden:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('wrong')} PIN"));
          }
          break;
        case HttpStatus.notFound:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('wrong')} PIN"));
          }
          break;

        case HttpStatus.forbidden:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('access_denied')}"));
          }
          break;
        default:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('error')}: ${e.code}"));
          }
          break;
      }
    } catch (e) {
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('an_unknown_error_has_occurred')}: $e"));
      }
    }
  }

  @override
  Future<void> createUser(entity.User user, String pin, {BuildContext? context}) async {
    try {
      final args = ArgUserCreate(
        login: user.login,
        password: pin,
        firstName: ((user.firstName?.length ?? 0) > 0 ? user.firstName : null),
        lastName: ((user.lastName?.length ?? 0) > 0 ? user.lastName : null),
        middleName: ((user.middleName?.length ?? 0) > 0 ? user.middleName : null),
        isAdmin: user.isAdmin,
        isOperator: user.isOperator,
        isEngineer: user.isEngineer,
      );
      final response = await api.createUser(args);

      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBars.getSuccessSnackBar(message: "${context.tr('user')} ${user.login} ${context.tr('added_successfully')}"));
      }
    } on ApiException catch (e) {
      switch (e.code) {
        case HttpStatus.unauthorized:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('wrong')} PIN"));
          }
          break;
        case HttpStatus.forbidden:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('access_denied')}"));
          }
          break;
        case HttpStatus.conflict:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('user')} ${context.tr('with_this_login_already_exists')}"));
          }
          break;

        case HttpStatus.forbidden:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('access_denied')}"));
          }
          break;
        default:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('error')}: ${e.code}"));
          }
          break;
      }
    } catch (e) {
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('an_unknown_error_has_occurred')}: $e"));
      }
    }
  }

  @override
  entity.User? currentUser() {
    return _currentUser;
  }

  @override
  Future<String?> getServerInfo({BuildContext? context}) async {
    try {
      final response = await api.getServerInfo();
      return response?.bonusServiceURL;
    }
    on ApiException catch (e){
      switch (e.code) {
        case HttpStatus.unauthorized:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('wrong')} PIN"));
          }
          break;
        case HttpStatus.forbidden:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('access_denied')}"));
          }
          break;
        default:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('failed')} ${context.tr('to_get')} ${context.tr('link_to_bonus_server')}, ${context.tr('error')}: ${e.code}"));
          }
          break;
      }
    }
    catch (e) {

    }
  }

  @override
  Future<entity.User?> getCurrentUser({BuildContext? context}) async {
    if (_currentUser != null) {
      return _currentUser;
    }
    try {
      final response = await api.getUser();

      if (response != null) {
        _currentUser = Helpers.userFromApi(response);
        return _currentUser;
      }
    } on ApiException catch (e) {
      switch (e.code) {
        case HttpStatus.unauthorized:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('wrong')} PIN"));
          }
          break;
        case HttpStatus.forbidden:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('access_denied')}"));
          }
          break;
        default:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('error')}: ${e.code}"));
          }
          break;
      }
    } catch (e) {
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('an_unknown_error_has_occurred')}: $e"));
      }
    }
    return null;
  }

  @override
  Future<void> deleteUser(String login, {BuildContext? context}) async {
    try {
      final args = ArgUserDelete(login: login);
      final response = await api.deleteUser(args);

      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBars.getSuccessSnackBar(message: "${context.tr('user')} $login ${context.tr('deleted_successfully')}"));
      }
    } on ApiException catch (e) {
      switch (e.code) {
        case HttpStatus.unauthorized:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('wrong')} PIN"));
          }
          break;
        case HttpStatus.forbidden:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('access_denied')}"));
          }
          break;
        default:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('error')}: ${e.code}"));
          }
          break;
      }
    } catch (e) {
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('an_unknown_error_has_occurred')}: $e"));
      }
    }
  }

  @override
  Future<entity.StationMoneyReport?> getStationMoneyReportByDates(int id, DateTime startDate, DateTime endDate, {BuildContext? context}) async {
    final args = ArgStationReportDates(id: id, startDate: startDate.toUtc().millisecondsSinceEpoch ~/ 1000, endDate: endDate.toUtc().millisecondsSinceEpoch ~/ 1000);

    try {
      print(args.toJson().toString());
      final response = await api.stationReportDates(args);

      return Helpers.stationMoneyReportFromAPI(response!.moneyReport!, id);
    } on ApiException catch (e) {
      switch (e.code) {
        case HttpStatus.notFound:
          break;
        default:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('post')} $id, ${context.tr('error')}: ${e.code}"));
          }
          break;
      }
    } catch (e) {
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('an_unknown_error_has_occurred')}: $e"));
      }
    }

    return null;
  }

  @override
  Future<List<entity.StationCollectionReport>?> getStationCollectionReports(int id, DateTime startDate, DateTime endDate) async {
    final args = ArgCollectionReportDates(stationID: id, startDate: startDate.toUtc().millisecondsSinceEpoch ~/ 1000, endDate: endDate.toUtc().millisecondsSinceEpoch ~/ 1000);
    final response = await api.stationCollectionReportDates(args);

    if (response?.collectionReports != null) {
      return List.generate(response!.collectionReports.length, (index) => Helpers.stationCollectionReportFromAPI(response!.collectionReports[index]));
    }

    return null;
  }

  @override
  Future<List<entity.StationStats>?> getStationsStatsByDates(int id, DateTime startDate, DateTime endDate, {BuildContext? context}) async {
    final args = ArgStationStatDates(stationID: id, startDate: startDate.toUtc().millisecondsSinceEpoch ~/ 1000, endDate: endDate.toUtc().millisecondsSinceEpoch ~/ 1000);
    try {
      final response = await api.stationStatDates(args: args);

      if (response != null) {
        return List.generate(response.length, (index) => Helpers.stationStatsFromAPI(response[index]));
      }
    } on ApiException catch (e) {
      switch (e.code) {
        case HttpStatus.notFound:
          break;
        case HttpStatus.unauthorized:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('wrong')} PIN"));
          }
          break;
        case HttpStatus.forbidden:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('access_denied')}"));
          }
          break;
        default:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('post')} $id, ${context.tr('error')}: ${e.code}"));
          }
          break;
      }
    } catch (e) {
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('an_unknown_error_has_occurred')}: $e"));
      }
    }

    return null;
  }

  @override
  Future<List<entity.StationStats>?> getStationsStatsCurrent(int id, {BuildContext? context}) async {
    final args = ArgStationStat(stationID: id);
    try {
      final response = await api.stationStatCurrent(args: args);

      if (response != null) {
        return List.generate(response.length, (index) => Helpers.stationStatsFromAPI(response[index]));
      }
    } on ApiException catch (e) {
      switch (e.code) {
        case HttpStatus.notFound:
          break;
        case HttpStatus.unauthorized:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('wrong')} PIN"));
          }
          break;
        case HttpStatus.forbidden:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('access_denied')}"));
          }
          break;
        default:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('post')} $id, ${context.tr('error')}: ${e.code}"));
          }
          break;
      }
    } catch (e) {
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('an_unknown_error_has_occurred')}: $e"));
      }
    }
    final response = await api.stationStatCurrent(args: args);

    if (response != null) {
      return List.generate(response.length, (index) => Helpers.stationStatsFromAPI(response[index]));
    }

    return null;
  }

  @override
  Future<entity.StationStats?> getStationStatsByDates(int id, DateTime startDate, DateTime endDate, {BuildContext? context}) async {
    try {
      final args = ArgStationStatDates(stationID: id, startDate: startDate.toUtc().millisecondsSinceEpoch ~/ 1000, endDate: endDate.toUtc().millisecondsSinceEpoch ~/ 1000);
      final response = await api.stationStatDates(args: args);

      if (response != null && response.length > 0) {
        return Helpers.stationStatsFromAPI(response.single);
      }
    } on ApiException catch (e) {
      switch (e.code) {
        case HttpStatus.notFound:
          break;
        case HttpStatus.unauthorized:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('wrong')} PIN"));
          }
          break;
        case HttpStatus.forbidden:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('access_denied')}"));
          }
          break;
        default:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('post')} $id, ${context.tr('error')}: ${e.code}"));
          }
          break;
      }
    } catch (e) {
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('an_unknown_error_has_occurred')}: $e"));
      }
    }

    return null;
  }

  @override
  Future<entity.StationStats?> getStationStatsCurrent(int id, {BuildContext? context}) async {
    try {
      final args = ArgStationStat(stationID: id);
      final response = await api.stationStatCurrent(args: args);

      if (response != null && response.length > 0) {
        return Helpers.stationStatsFromAPI(response.single);
      }
    } on ApiException catch (e) {
      switch (e.code) {
        case HttpStatus.notFound:
          break;
        case HttpStatus.unauthorized:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('wrong')} PIN"));
          }
          break;
        case HttpStatus.forbidden:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('access_denied')}"));
          }
          break;
        default:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('post')} $id, ${context.tr('error')}: ${e.code}"));
          }
          break;
      }
    } catch (e) {
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('an_unknown_error_has_occurred')}: $e"));
      }
    }

    return null;
  }

  @override
  Future<List<entity.StationStats>> getAllStationStatsByDates(DateTime startDate, DateTime endDate, {BuildContext? context}) async {
    try {
      final args = ArgStationStatDates(startDate: startDate.toUtc().millisecondsSinceEpoch ~/ 1000, endDate: endDate.toUtc().millisecondsSinceEpoch ~/ 1000);
      final response = await api.stationStatDates(args: args);

      if (response != null && response.length > 0) {
        final res = response.map((e) => Helpers.stationStatsFromAPI(e)).toList();

        res.sort((a, b) => a.id!.compareTo(b.id!));

        return res;
      }
    } on ApiException catch (e) {
      switch (e.code) {
        case HttpStatus.notFound:
          break;
        case HttpStatus.unauthorized:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('wrong')} PIN"));
          }
          break;
        case HttpStatus.forbidden:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('access_denied')}"));
          }
          break;
        default:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('error')}: ${e.code}"));
          }
          break;
      }
    } catch (e) {
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('an_unknown_error_has_occurred')}: $e"));
      }
    }

    return [];
  }

  @override
  Future<List<entity.StationStats>> getAllStationStatsCurrent({BuildContext? context}) async {
    try {
      final args = ArgStationStat();
      final response = await api.stationStatCurrent(args: args);

      if (response != null && response.length > 0) {
        final res = response.map((e) => Helpers.stationStatsFromAPI(e)).toList();

        res.sort((a, b) => a.id!.compareTo(b.id!));

        return res;
      }
    } on ApiException catch (e) {
      switch (e.code) {
        case HttpStatus.notFound:
          break;
        case HttpStatus.unauthorized:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('wrong')} PIN"));
          }
          break;
        case HttpStatus.forbidden:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('access_denied')}"));
          }
          break;
        default:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('error')}: ${e.code}"));
          }
          break;
      }
    } catch (e) {
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('an_unknown_error_has_occurred')}: $e"));
      }
    }

    return [];
  }

  @override
  Future<void> resetStationStats(int id, {BuildContext? context}) async {
    try {
      final args = ArgResetStationStat(stationID: id);
      final res = await api.resetStationStat(args: args);
    } on ApiException catch (e) {
      switch (e.code) {
        default:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('failed')} ${context.tr('to_reset_posts_statistics')} - $id, ${context.tr('error')}: ${e.code}"));
          }
          break;
      }
    } catch (e) {
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('an_unknown_error_has_occurred')}: $e"));
      }
    }
  }

  @override
  Future<void> updateDiscounts({BuildContext? context}) async {
    try {
      final args = ArgAdvertisingCampagin();
      final response = await api.advertisingCampaign(args: args);
      _discount.value = List.generate(response?.length ?? 0, (index) => Helpers.discountCampaignFromApi(response![index]));
    } on ApiException catch (e) {
      switch (e.code) {
        case HttpStatus.unauthorized:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('wrong')} PIN"));
          }
          break;
        case HttpStatus.forbidden:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('access_denied')}"));
          }
          break;
        default:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('error')}: ${e.code}"));
          }
          break;
      }
    } catch (e) {
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('an_unknown_error_has_occurred')}: $e"));
      }
    }
  }

  @override
  Future<entity.DiscountCampaign?> getDiscountCampaign(int id, {BuildContext? context}) async {
    try {
      final args = ArgAdvertisingCampaignByID(id: id);
      final response = await api.advertisingCampaignByID(args);

      if (response != null) {
        return Helpers.discountCampaignFromApi(response);
      }
    } on ApiException catch (e) {
      switch (e.code) {
        case HttpStatus.notFound:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getWarningSnackBar(message: "${context.tr('discount_program_not_found')} - $id"));
          }
          break;
        case HttpStatus.unauthorized:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('wrong')} PIN"));
          }
          break;
        case HttpStatus.forbidden:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('access_denied')}"));
          }
          break;
        default:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('error')}: ${e.code}"));
          }
          break;
      }
    } catch (e) {
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('an_unknown_error_has_occurred')}: $e"));
      }
    }

    return null;
  }

  @override
  Future<String?> getProgramNameFromCache(int id) async {
    if (_programs.value == null) {
      await updatePrograms();
    }
    final programs = _programs.value ?? [];

    final filteredProgram = programs.where((element) => element.id == id);
    return filteredProgram.length > 0 ? filteredProgram.first.name : null;
  }

  @override
  Future<void> saveDiscountCampaign(entity.DiscountCampaign campaign, {BuildContext? context}) async {
    try {
      final args = Helpers.discountCampaignToApi(campaign);
      if (campaign.id != null) {
        await api.editAdvertisingCampaign(args);
        if (context != null) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBars.getSuccessSnackBar(message: "${context.tr('changes_have_been_saved')}"));
        }
      } else {
        await api.addAdvertisingCampaign(args);
        if (context != null) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBars.getSuccessSnackBar(message: context.tr('discount_program_has_been_added')));
        }
      }
    } on ApiException catch (e) {
      switch (e.code) {
        case HttpStatus.unauthorized:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('wrong')} PIN"));
          }
          break;
        case HttpStatus.forbidden:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('access_denied')}"));
          }
          break;
        default:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('error')}: ${e.code}"));
          }
          break;
      }
    } catch (e) {
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('an_unknown_error_has_occurred')}: $e"));
      }
    }
  }

  @override
  Future<int?> getConfigVarInt(String name, {BuildContext? context}) async {
    try {
      var args = ArgGetConfigVar(name: name);
      final response = await api.getConfigVarInt(args);
      return response?.value;
    } on ApiException catch (e) {
      switch (e.code) {
        case HttpStatus.notFound:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getWarningSnackBar(message: "${context.tr('config_settings_not_found')} - $name"));
          }
          break;

        default:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('failed')} ${context.tr('to_get')} ${context.tr('config_settings')} - $name, ${context.tr('error')}: ${e.code}"));
          }
          break;
      }
    } catch (e) {
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('an_unknown_error_has_occurred')}: $e"));
      }
    }

    return null;
  }

  @override
  Future<String?> getConfigVarString(String name) async {
    var args = ArgGetConfigVar(name: name);
    final response = await api.getConfigVarString(args);
    return response?.value ?? "";
  }

  @override
  Future<bool?> getConfigVarBool(String name) async {
    var args = ArgGetConfigVar(name: name);
    final response = await api.getConfigVarBool(args);
    return response?.value;
  }

  @override
  Future<String?> getStationTemperature(int id, {BuildContext? context}) async {
    try {
      if (_stations.value == null) {
        await updateStatus();
      }
      final stations = _stations.value;

      final stationFiltered = stations?.where((element) => element.id == id);
      if ((stationFiltered?.length ?? 0) > 0) {
        final station = stationFiltered!.single;
        if (station.hash != null) {
          final args = ArgLoad(hash: station.hash!, key: "curr_temp");
          final response = api.load(args);
          return response;
        }
      }
    } on ApiException catch (e) {
      switch (e.code) {
        default:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('failed')} ${context.tr('to_get_temperature')}, ${context.tr('error')}: ${e.code}"));
          }
          break;
      }
    } catch (e) {
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('an_unknown_error_has_occurred')}: $e"));
      }
    }

    return null;
  }

  @override
  Future<void> setConfigVarBool(String name, bool value) async {
    var args = ConfigVarBool(name: name, value: value);
    final response = await api.setConfigVarBool(args);
  }

  @override
  Future<void> setConfigVarInt(String name, int value, {BuildContext? context}) async {
    try {
      var args = ConfigVarInt(name: name, value: value);
      final response = await api.setConfigVarInt(args);
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBars.getSuccessSnackBar(message: "${context.tr('config_settings')} $name ${context.tr('set_successfully')}"));
      }
    } on ApiException catch (e) {
      switch (e.code) {
        default:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('failed')} ${context.tr('to_set_config_settings')} - $name, ${context.tr('error')}: ${e.code}"));
          }
          break;
      }
    } catch (e) {
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('an_unknown_error_has_occurred')}: $e"));
      }
    }
  }

  @override
  Future<void> setConfigVarString(String name, String value) async {
    var args = ConfigVarString(name: name, value: value);
    final response = await api.setConfigVarString(args);
  }

  @override
  Future<void> deleteConfigVarString(String name, String value) async {

  }

  @override
  Future<entity.StationConfig?> getStationConfig(int id, {BuildContext? context}) async {
    try {
      final args = StationRequest(id: id);
      final response = await api.station(args);

      if (response != null) {
        return Helpers.stationConfigFromAPI(response);
      }
    } on ApiException catch (e) {
      switch (e.code) {
        case HttpStatus.unauthorized:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('wrong')} PIN"));
          }
          break;
        case HttpStatus.forbidden:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('access_denied')}"));
          }
          break;
        case HttpStatus.notFound:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('post_configuration_not_found')} $id"));
          }
          break;
        default:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('error')}: ${e.code}"));
          }
          break;
      }
    } catch (e) {
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('an_unknown_error_has_occurred')}: $e"));
      }
    }

    return null;
  }

  @override
  Future<void> saveStationConfig(entity.StationConfig config, {BuildContext? context}) async {
    try {
      final args = Helpers.stationConfigToAPI(config);
      final response = await api.setStation(args);

      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBars.getSuccessSnackBar(message: "${context.tr('post_configuration')} ${config.id} ${context.tr('saved_successfully')}"));
      }
    } on ApiException catch (e) {
      switch (e.code) {
        case HttpStatus.unauthorized:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('wrong')} PIN"));
          }
          break;
        case HttpStatus.forbidden:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('access_denied')}"));
          }
          break;
        case HttpStatus.notFound:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('post_configuration_not_found')} ${config.id}"));
          }
          break;
        case HttpStatus.unprocessableEntity:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('configuration_has_failed_the_test')}"));
          }
          break;
        default:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('error')}: ${e.code}"));
          }
          break;
      }
    } catch (e) {
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('an_unknown_error_has_occurred')}: $e"));
      }
    }
  }

  @override
  Future<entity.StationCardReaderConfig?> getCardReaderConfig(int id, {BuildContext? context}) async {
    try {
      var args = ArgCardReaderConfig(stationID: id);
      final response = await api.cardReaderConfig(args);

      if (response != null) {
        return Helpers.cardReaderConfigFromAPI(response);
      }
    } on ApiException catch (e) {
      switch (e.code) {
        case HttpStatus.notFound:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('no_card_reader_configuration_found_for_the_post')} $id"));
          }
          break;
        default:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('error')}: ${e.code}"));
          }
          break;
      }
    } catch (e) {
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('an_unknown_error_has_occurred')}: $e"));
      }
    }

    return null;
  }

  @override
  Future<void> saveCardReaderConfig(int id, entity.StationCardReaderConfig config, {BuildContext? context}) async {
    try {
      final args = Helpers.cardReaderConfigToAPI(id, config);
      final response = await api.setCardReaderConfig(args);

      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBars.getSuccessSnackBar(message: "${context.tr('card_reader_configuration_for_post')} $id ${context.tr('saved_successfully')}"));
      }
    } on ApiException catch (e) {
      switch (e.code) {
        case HttpStatus.unauthorized:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('wrong')} PIN"));
          }
          break;
        case HttpStatus.forbidden:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('access_denied')}"));
          }
          break;
        case HttpStatus.notFound:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('no_card_reader_configuration_found_for_the_post')} $id"));
          }
          break;
        case HttpStatus.unprocessableEntity:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: context.tr('configuration_has_failed_the_test')));
          }
          break;
        default:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('error')}: ${e.code}"));
          }
          break;
      }
    } catch (e) {
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('an_unknown_error_has_occurred')}: $e"));
      }
    }
  }

  @override
  Future<void> saveStationButtons(int id, List<entity.StationButton> buttons, {BuildContext? context}) async {
    try {
      final buttonsToSave = buttons.where((element) => (element.programID ?? -1) > 0);
      if (buttonsToSave.length == 0) {
        return null;
      }

      final args = ArgSetStationButton(
        stationID: id,
        buttons: List.generate(
          buttonsToSave.length,
          (index) => ResponseStationButtonButtonsInner(buttonID: buttonsToSave.elementAt(index).buttonID, programID: buttonsToSave.elementAt(index).programID),
        ),
      );

      final response = await api.setStationButton(args);
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBars.getSuccessSnackBar(message: "${context.tr('buttons_configuration_for_post')} $id ${context.tr('saved_successfully')}"));
      }
    } on ApiException catch (e) {
      switch (e.code) {
        case HttpStatus.unprocessableEntity:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('unacceptable_buttons_configuration')}"));
          }
          break;
        default:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('error')}: ${e.code}"));
          }
          break;
      }
    } catch (e) {
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('an_unknown_error_has_occurred')}: $e"));
      }
    }
  }

  @override
  Future<void> deleteDiscountCampaign(int id, {BuildContext? context}) async {
    try {
      final args = ArgDelAdvertisingCampagin(id: id);
      final response = await api.delAdvertisingCampaign(args);

      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBars.getSuccessSnackBar(message: "${context.tr('discount_program')} $id ${context.tr('deleted_successfully')}"));
      }
    } on ApiException catch (e) {
      switch (e.code) {
        case HttpStatus.notFound:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getWarningSnackBar(message: "${context.tr('discount_program_not_found')} - $id"));
          }
          break;
        case HttpStatus.unauthorized:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('wrong')} PIN"));
          }
          break;
        case HttpStatus.forbidden:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('access_denied')}"));
          }
          break;
        default:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('error')}: ${e.code}"));
          }
          break;
      }
    } catch (e) {
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('an_unknown_error_has_occurred')}: $e"));
      }
    }
  }

  @override
  Future<entity.KasseConfig?> getKasseConfig({BuildContext? context}) async {
    try {
      var response = await api.kasse();
      if (response != null) {
        return Helpers.kasseConfigFromAPI(response);
      }
    } on ApiException catch (e) {
      switch (e.code) {
        case HttpStatus.notFound:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getWarningSnackBar(message: "${context.tr('cash_desk_configuration_not_found')}"));
          }
          break;
        default:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('error')}: ${e.code}"));
          }
          break;
      }
    } catch (e) {
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('an_unknown_error_has_occurred')}: $e"));
      }
    }

    return null;
  }

  @override
  Future<void> saveKasseConfig(entity.KasseConfig config, {BuildContext? context}) async {
    try {
      final args = Helpers.kasseConfigToAPI(config);
      final response = await api.setKasse(args);
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBars.getSuccessSnackBar(message: "${context.tr('cash_desk_configuration')} ${context.tr('saved_successfully')}"));
      }
    } on ApiException catch (e) {
      switch (e.code) {
        default:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('error')}: ${e.code}"));
          }
          break;
      }
    } catch (e) {
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('an_unknown_error_has_occurred')}: $e"));
      }
    }
  }

  @override
  Future<List<entity.FirmwareVersion>?> getPostVersions(int id, {BuildContext? context}) async {
    try {

      final response = await api.getStationFirmwareVersions(id);
      List<entity.FirmwareVersion> firmwareVersions = [];

      for(int i = 0; i < response!.length; i++) {

        firmwareVersions.add(
            entity.FirmwareVersion(
              id: response[i].id,
              hashLua: response[i].hashLua,
              hashEnv: response[i].hashEnv,
              hashBinar: response[i].hashBinar,
              builtAt: response[i].builtAt,
              commitedAt:response[i].commitedAt,
              isCurrent: response[i].isCurrent
            )
        );
      }



      return firmwareVersions;

    } on ApiException catch (e) {
      switch (e.code) {
        case HttpStatus.notFound:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('failed')} ${context.tr('to_execute_program')}, ${context.tr('error')}: ${e.message ?? "${context.tr('one_of_the_parameters_of_the_passed_config_was_not_found')}"}"));
          }
          break;
        default:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('error')}: ${e.code}"));
          }
          break;
      }
    } catch (e) {
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('an_unknown_error_has_occurred')}: $e"));
      }
    }
    return null;
  }

  @override
  Future<void> getServerVersions({BuildContext? context}) async {

  }

  @override
  Future<void> getApplicationVersions({BuildContext? context}) async {

  }

  @override
  Future<entity.BuildScript?> getCurrentBuildScript(int id, {BuildContext? context}) async {
    try{
      final response = await api.getBuildScript(id);

      entity.BuildScript buildScript = entity.BuildScript(
        id: (response?.id ?? 0),
        stationID: (response?.stationID ?? 0),
        name: (response?.name ?? ''),
        commands: (response?.commangs ?? []),
      );

      return buildScript;

    }  on ApiException catch (e) {

      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('failed')} ${context.tr('to_get')} ${context.tr('script')}. ${e.message}"));
      }
    } catch (e) {
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('an_unknown_error_has_occurred')}: $e"));
      }
    }
    return null;
  }

  @override
  Future<void> setCurrentBuildScript(int id, {BuildContext? context, required String name, required List<String> commands, int? copyFrom}) async {
    try{
      await api.setBuildScript(
          SetBuildScript(
            copyFromStationID: copyFrom,
            stationID: id,
            name: name,
            commangs: commands
          )
      );

      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBars.getSuccessSnackBar(message: "${context.tr('script')} ${context.tr('saved_successfully')}"));
      }
    }  on ApiException catch (e) {

      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('failed')} ${context.tr('save')} ${context.tr('script')}. ${e.message}"));
      }
    } catch (e) {
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('an_unknown_error_has_occurred')}: $e"));
      }
    }
  }

  @override
  Future<void> runProgram(entity.RunProgramConfig cfg, {BuildContext? context}) async {
    try {
      final args = Helpers.RunProgramConfigToAPI(cfg);
      final response = await api.runProgram(args);

      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBars.getSuccessSnackBar(message: "${context.tr('the_program_is_running')}"));
      }
    } on ApiException catch (e) {
      switch (e.code) {
        case HttpStatus.notFound:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('failed')} ${context.tr('to_execute_program')}, ${context.tr('error')}: ${e.message ?? "${context.tr('one_of_the_parameters_of_the_passed_config_was_not_found')}"}"));
          }
          break;
        default:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('error')}: ${e.code}"));
          }
          break;
      }
    } catch (e) {
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('an_unknown_error_has_occurred')}: $e"));
      }
    }
  }

  @override
  Future<List<entity.StationMoneyReport>> lastCollectionReportsStats({BuildContext? context}) async {
    List<entity.StationMoneyReport> res = [];
    try {
      final response = await api.statusCollection();

      response?.stations?.forEach(
        (element) {
          DateTime? tmpCtime;
          if (element.ctime != null) {
            tmpCtime = DateTime.fromMillisecondsSinceEpoch(element.ctime! * 1000, isUtc: true).toLocal();
          }
          final tmpResReport = entity.StationMoneyReport(
            carsTotal: element.carsTotal,
            coins: element.coins,
            banknotes: element.banknotes,
            electronical: element.electronical,
            service: element.service,
            bonuses: element.bonuses,
            qrMoney: element.qrMoney,
            post: element.id,
            dateTime: tmpCtime,
          );
          if (tmpResReport.notEmpty()) {
            res.add(tmpResReport);
          }
        },
      );
      res.sort((a, b) => a.post!.compareTo(b.post!));

      return res;
    } on ApiException catch (e) {
      switch (e.code) {
        default:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('error')}: ${e.code}"));
          }
          break;
      }
    } catch (e) {
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('an_unknown_error_has_occurred')}: $e"));
      }
    }
    return res;
  }
}
