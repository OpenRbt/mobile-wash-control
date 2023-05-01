import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobile_wash_control/entity/entity.dart' as entity;
import 'package:mobile_wash_control/mobile/widgets/common/snackBars.dart';
import 'package:mobile_wash_control/openapi/lea-central-wash/api.dart';
import 'package:mobile_wash_control/repository/lea_central_wash_repo/helpers.dart';
import 'package:mobile_wash_control/repository/repository.dart';

class LeaCentralRepository extends Repository {
  final DefaultApi api;

  Timer? refresh;

  ValueNotifier<List<entity.Station>?> _stations = ValueNotifier(null);
  ValueNotifier<entity.KasseStatus?> _kasseStatus = ValueNotifier(null);
  ValueNotifier<String?> _lcwRepo = ValueNotifier(null);
  ValueNotifier<List<entity.Program>?> _programs = ValueNotifier(null);
  ValueNotifier<List<entity.User>?> _users = ValueNotifier(null);
  ValueNotifier<List<entity.DiscountCampaign>?> _discount = ValueNotifier(null);
  ValueNotifier<List<String>?> _hashes = ValueNotifier(null);

  LeaCentralRepository(this.api) {
    refresh = Timer.periodic(Duration(seconds: 3), (timer) async {
      await updateStatus();
    });
  }

  @override
  void dispose() {
    refresh?.cancel();
    refresh = null;

    _stations.dispose();
    _kasseStatus.dispose();
    _lcwRepo.dispose();
    _programs.dispose();
    _users.dispose();
  }

  @override
  ValueNotifier<List<entity.Station>?> getStationsNotifier() => _stations;

  @override
  ValueNotifier<entity.KasseStatus?> getKasseStatusNotifier() => _kasseStatus;

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
        ));
      });

      stations.sort((a, b) => a.id.compareTo(b.id));
      if (!listEquals(_stations.value, stations)) {
        _stations.value = stations;
      }
      if (_lcwRepo.value != res?.lcwInfo) {
        _lcwRepo.value = res?.lcwInfo;
      }

      var hashes = <String>["-"];
      res?.stations.where((element) => element.hash != null).forEach((element) {
        hashes.add(element.hash!);
      });
      if (_hashes.value != hashes) {
        _hashes.value = hashes;
      }

      var kasseStatus = entity.KasseStatus(status: res?.kasseStatus?.value, info: res?.kasseInfo);
      if (_kasseStatus.value != kasseStatus) {
        _kasseStatus.value = kasseStatus;
      }
    } on ApiException catch (e) {
      switch (e.code) {
        default:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "Не удалось обновить статус, Ошибка: ${e.code}"));
          }
          break;
      }
    } catch (e) {
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "Произошла неизвестная ошибка: $e"));
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
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "Не удалось получить список программ, Ошибка: ${e.code}"));
          }
          break;
      }
    } catch (e) {
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "Произошла неизвестная ошибка: $e"));
      }
    }
  }

  @override
  Future<entity.Program?> getProgram(int id, {BuildContext? context}) async {
    try {
      var programs = _programs.value;
      if (programs == null) {
        await updatePrograms();
        programs = _programs.value;
      }

      var programsFiltered = programs!.where((program) => program.id == id);
      return programsFiltered.isNotEmpty ? programsFiltered.first : null;
    } on ApiException catch (e) {
      switch (e.code) {
        default:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "Не удалось загрузить программу, Ошибка: ${e.code}"));
          }
          break;
      }
    } catch (e) {
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "Произошла неизвестная ошибка: $e"));
      }
    }

    return null;
  }

  @override
  Future<entity.Station?> getStation(int id) async {
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
      return res;
    } on ApiException catch (e) {
      switch (e.code) {
        case HttpStatus.notFound:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getWarningSnackBar(message: "Не найдено статистики для поста $id"));
          }
          break;
        default:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "Пост $id, Ошибка: ${e.code}"));
          }
          break;
      }
    } catch (e) {
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "Произошла неизвестная ошибка: $e"));
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
        ScaffoldMessenger.of(context).showSnackBar(SnackBars.getSuccessSnackBar(message: "Зачислено $amount  на пост $id"));
      }
    } on ApiException catch (e) {
      switch (e.code) {
        default:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "Пост $id, Ошибка: ${e.code}"));
          }
          break;
      }
    } catch (e) {
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "Произошла неизвестная ошибка: $e"));
      }
    }
  }

  @override
  Future<entity.StationMoneyReport?> getStationMoneyReport(int id, {BuildContext? context}) async {
    final args = ArgStationReportCurrentMoney(id: id);

    try {
      final response = await api.stationReportCurrentMoney(args);
      return Helpers.stationMoneyReportFromAPI(response!.moneyReport!);
    } on ApiException catch (e) {
      switch (e.code) {
        case HttpStatus.notFound:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getWarningSnackBar(message: "Не найдено статистики для поста $id"));
          }
          break;
        default:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "Пост $id, Ошибка: ${e.code}"));
          }
          break;
      }
    } catch (e) {
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "Произошла неизвестная ошибка: $e"));
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
        ScaffoldMessenger.of(context).showSnackBar(SnackBars.getSuccessSnackBar(message: "Выполнена открытие двери нв посту $id"));
      }
    } on ApiException catch (e) {
      switch (e.code) {
        case HttpStatus.notFound:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getWarningSnackBar(message: "Не найден пост $id"));
          }
          break;
        default:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "Пост $id, Ошибка: ${e.code}"));
          }
          break;
      }
    } catch (e) {
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "Произошла неизвестная ошибка: $e"));
      }
    }
  }

  @override
  Future<void> stationSaveCollection(int id, {BuildContext? context}) async {
    try {
      final args = StationRequest(id: id);
      final response = await api.saveCollection(args);
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBars.getSuccessSnackBar(message: "Пост $id проинкассирован"));
      }
    } on ApiException catch (e) {
      switch (e.code) {
        case HttpStatus.notFound:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getWarningSnackBar(message: "Не найден пост $id"));
          }
          break;
        case HttpStatus.unauthorized:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "Неверный PIN"));
          }
          break;
        default:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "Пост $id, Ошибка: ${e.code}"));
          }
          break;
      }
    } catch (e) {
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "Произошла неизвестная ошибка: $e"));
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
        isFinishingProgram: program.ifFinishingProgram,
        motorSpeedPercent: program.motorSpeedPercent,
        preflightMotorSpeedPercent: program.preflightMotorSpeedPercent,
        preflightEnabled: program.preflightEnabled,
        relays: List.generate(
          program.relays.length,
          (index) => RelayConfig(
            id: program.relays[index].id,
            timeon: program.relays[index].timeOn,
            timeoff: program.relays[index].timeOff,
          ),
        ),
        preflightRelays: List.generate(
          program.relaysPreflight.length,
          (index) => RelayConfig(
            id: program.relaysPreflight[index].id,
            timeon: program.relaysPreflight[index].timeOn,
            timeoff: program.relaysPreflight[index].timeOff,
          ),
        ),
      );

      await api.setProgram(args);

      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBars.getSuccessSnackBar(message: "Программа успешно сохранена"));
      }
    } on ApiException catch (e) {
      switch (e.code) {
        default:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "Не удалось сохранить программу, Ошибка: ${e.code}"));
          }
          break;
      }
    } catch (e) {
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "Произошла неизвестная ошибка: $e"));
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
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "Неверный PIN"));
          }
          break;
        case HttpStatus.forbidden:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "Доступ запрещен"));
          }
          break;
        default:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "Не удалось получить список пользователей, Ошибка: ${e.code}"));
          }
          break;
      }
    } catch (e) {
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "Произошла неизвестная ошибка: $e"));
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
        ScaffoldMessenger.of(context).showSnackBar(SnackBars.getSuccessSnackBar(message: "Пользователь ${user.login} успешно обновлен"));
      }
    } on ApiException catch (e) {
      switch (e.code) {
        case HttpStatus.unauthorized:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "Неверный PIN"));
          }
          break;
        case HttpStatus.notFound:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "Пользователь с данным логином не найден"));
          }
          break;

        case HttpStatus.forbidden:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "Доступ запрещен"));
          }
          break;
        default:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "Ошибка: ${e.code}"));
          }
          break;
      }
    } catch (e) {
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "Произошла неизвестная ошибка: $e"));
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
        ScaffoldMessenger.of(context).showSnackBar(SnackBars.getSuccessSnackBar(message: "Пользователь ${user.login} успешно добавлен"));
      }
    } on ApiException catch (e) {
      switch (e.code) {
        case HttpStatus.unauthorized:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "Неверный PIN"));
          }
          break;
        case HttpStatus.conflict:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "Пользователь с данным логином уже существует"));
          }
          break;

        case HttpStatus.forbidden:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "Доступ запрещен"));
          }
          break;
        default:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "Ошибка: ${e.code}"));
          }
          break;
      }
    } catch (e) {
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "Произошла неизвестная ошибка: $e"));
      }
    }
  }

  @override
  Future<entity.User?> getCurrentUser({BuildContext? context}) async {
    try {
      final response = await api.getUser();

      if (response != null) {
        return Helpers.userFromApi(response);
      }
    } on ApiException catch (e) {
      switch (e.code) {
        case HttpStatus.unauthorized:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "Неверный PIN"));
          }
          break;
        default:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "Ошибка: ${e.code}"));
          }
          break;
      }
    } catch (e) {
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "Произошла неизвестная ошибка: $e"));
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
        ScaffoldMessenger.of(context).showSnackBar(SnackBars.getSuccessSnackBar(message: "Пользователь $login успешно удален"));
      }
    } on ApiException catch (e) {
      switch (e.code) {
        case HttpStatus.unauthorized:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "Неверный PIN"));
          }
          break;
        case HttpStatus.forbidden:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "Доступ запрещен"));
          }
          break;
        default:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "Ошибка: ${e.code}"));
          }
          break;
      }
    } catch (e) {
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "Произошла неизвестная ошибка: $e"));
      }
    }
  }

  @override
  Future<entity.StationMoneyReport?> getStationMoneyReportsByDates(int id, DateTime startDate, DateTime endDate, {BuildContext? context}) async {
    final args = ArgStationReportDates(id: id, startDate: startDate.millisecondsSinceEpoch ~/ 1000, endDate: endDate.millisecondsSinceEpoch ~/ 1000);

    try {
      final response = await api.stationReportDates(args);

      return Helpers.stationMoneyReportFromAPI(response!.moneyReport!);
    } on ApiException catch (e) {
      switch (e.code) {
        case HttpStatus.notFound:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getWarningSnackBar(message: "Не найдено статистики для поста $id"));
          }
          break;
        default:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "Пост $id, Ошибка: ${e.code}"));
          }
          break;
      }
    } catch (e) {
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "Произошла неизвестная ошибка: $e"));
      }
    }

    return null;
  }

  @override
  Future<List<entity.StationCollectionReport>?> getStationCollectionReports(int id, DateTime startDate, DateTime endDate) async {
    final args = ArgCollectionReportDates(stationID: id, startDate: startDate.millisecondsSinceEpoch ~/ 1000, endDate: endDate.millisecondsSinceEpoch ~/ 1000);
    final response = await api.stationCollectionReportDates(args);

    if (response?.collectionReports != null) {
      return List.generate(response!.collectionReports.length, (index) => Helpers.stationCollectionReportFromAPI(response!.collectionReports[index]));
    }

    return null;
  }

  @override
  Future<List<entity.StationStats>?> getStationsStatsByDates(int id, DateTime startDate, DateTime endDate, {BuildContext? context}) async {
    final args = ArgStationStatDates(stationID: id, startDate: startDate.millisecondsSinceEpoch ~/ 1000, endDate: endDate.millisecondsSinceEpoch ~/ 1000);
    try {
      final response = await api.stationStatDates(args: args);

      if (response != null) {
        return List.generate(response.length, (index) => Helpers.stationStatsFromAPI(response[index]));
      }
    } on ApiException catch (e) {
      switch (e.code) {
        case HttpStatus.notFound:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getWarningSnackBar(message: "Не найдено статистики моторесурса для поста $id"));
          }
          break;
        case HttpStatus.unauthorized:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "Неверный PIN"));
          }
          break;
        case HttpStatus.forbidden:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "Доступ запрещен"));
          }
          break;
        default:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "Пост $id, Ошибка: ${e.code}"));
          }
          break;
      }
    } catch (e) {
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "Произошла неизвестная ошибка: $e"));
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
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getWarningSnackBar(message: "Не найдено статистики моторесурса  для поста $id"));
          }
          break;
        case HttpStatus.unauthorized:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "Неверный PIN"));
          }
          break;
        case HttpStatus.forbidden:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "Доступ запрещен"));
          }
          break;
        default:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "Пост $id, Ошибка: ${e.code}"));
          }
          break;
      }
    } catch (e) {
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "Произошла неизвестная ошибка: $e"));
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
      final args = ArgStationStatDates(stationID: id, startDate: startDate.millisecondsSinceEpoch ~/ 1000, endDate: endDate.millisecondsSinceEpoch ~/ 1000);
      final response = await api.stationStatDates(args: args);

      if (response != null && response.length > 0) {
        return Helpers.stationStatsFromAPI(response.single);
      }
    } on ApiException catch (e) {
      switch (e.code) {
        case HttpStatus.notFound:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getWarningSnackBar(message: "Не найдено статистики моторесурса для поста $id"));
          }
          break;
        case HttpStatus.unauthorized:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "Неверный PIN"));
          }
          break;
        case HttpStatus.forbidden:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "Доступ запрещен"));
          }
          break;
        default:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "Пост $id, Ошибка: ${e.code}"));
          }
          break;
      }
    } catch (e) {
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "Произошла неизвестная ошибка: $e"));
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
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getWarningSnackBar(message: "Не найдено статистики моторесурса для поста $id"));
          }
          break;
        case HttpStatus.unauthorized:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "Неверный PIN"));
          }
          break;
        case HttpStatus.forbidden:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "Доступ запрещен"));
          }
          break;
        default:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "Пост $id, Ошибка: ${e.code}"));
          }
          break;
      }
    } catch (e) {
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "Произошла неизвестная ошибка: $e"));
      }
    }

    return null;
  }

  @override
  Future<void> resetStationStats(int id) async {
    final args = ArgResetStationStat(stationID: id);
    final res = await api.resetStationStat(args: args);
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
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "Неверный PIN"));
          }
          break;
        case HttpStatus.forbidden:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "Доступ запрещен"));
          }
          break;
        default:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "Ошибка: ${e.code}"));
          }
          break;
      }
    } catch (e) {
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "Произошла неизвестная ошибка: $e"));
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
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getWarningSnackBar(message: "Не найдено скидочной программы - $id"));
          }
          break;
        case HttpStatus.unauthorized:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "Неверный PIN"));
          }
          break;
        case HttpStatus.forbidden:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "Доступ запрещен"));
          }
          break;
        default:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "Ошибка: ${e.code}"));
          }
          break;
      }
    } catch (e) {
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "Произошла неизвестная ошибка: $e"));
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
          ScaffoldMessenger.of(context).showSnackBar(SnackBars.getSuccessSnackBar(message: "Изменения сохранены"));
        }
      } else {
        await api.addAdvertisingCampaign(args);
        if (context != null) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBars.getSuccessSnackBar(message: "Скидочная программа добавлена"));
        }
      }
    } on ApiException catch (e) {
      switch (e.code) {
        case HttpStatus.unauthorized:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "Неверный PIN"));
          }
          break;
        case HttpStatus.forbidden:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "Доступ запрещен"));
          }
          break;
        default:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "Ошибка: ${e.code}"));
          }
          break;
      }
    } catch (e) {
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "Произошла неизвестная ошибка: $e"));
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
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getWarningSnackBar(message: "Не найден параметр конфига - $name"));
          }
          break;

        default:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "Не удалось получить параметр конфига - $name, Ошибка: ${e.code}"));
          }
          break;
      }
    } catch (e) {
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "Произошла неизвестная ошибка: $e"));
      }
    }

    return null;
  }

  @override
  Future<String?> getConfigVarString(String name) async {
    var args = ArgGetConfigVar(name: name);
    final response = await api.getConfigVarString(args);
    return response?.value;
  }

  @override
  Future<bool?> getConfigVarBool(String name) async {
    var args = ArgGetConfigVar(name: name);
    final response = await api.getConfigVarBool(args);
    return response?.value;
  }

  @override
  Future<String?> getStationTemperature(int id) async {
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
        ScaffoldMessenger.of(context).showSnackBar(SnackBars.getSuccessSnackBar(message: "Параметр конфига $name успешно установлен"));
      }
    } on ApiException catch (e) {
      switch (e.code) {
        default:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "Не удалось установить параметр конфига - $name, Ошибка: ${e.code}"));
          }
          break;
      }
    } catch (e) {
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "Произошла неизвестная ошибка: $e"));
      }
    }
  }

  @override
  Future<void> setConfigVarString(String name, String value) async {
    var args = ConfigVarString(name: name, value: value);
    final response = await api.setConfigVarString(args);
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
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "Неверный PIN"));
          }
          break;
        case HttpStatus.notFound:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "Не найдена конфигурация поста $id"));
          }
          break;
        default:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "Ошибка: ${e.code}"));
          }
          break;
      }
    } catch (e) {
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "Произошла неизвестная ошибка: $e"));
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
        ScaffoldMessenger.of(context).showSnackBar(SnackBars.getSuccessSnackBar(message: "Конфигурация поста ${config.id} успешно сохранена"));
      }
    } on ApiException catch (e) {
      switch (e.code) {
        case HttpStatus.unauthorized:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "Неверный PIN"));
          }
          break;
        case HttpStatus.notFound:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "Не найдена конфигурация поста ${config.id}"));
          }
          break;
        case HttpStatus.unprocessableEntity:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "Конфигурация не прошла проверку"));
          }
          break;
        default:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "Ошибка: ${e.code}"));
          }
          break;
      }
    } catch (e) {
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "Произошла неизвестная ошибка: $e"));
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
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "Не найдена конфигурация кардридера для поста $id"));
          }
          break;
        default:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "Ошибка: ${e.code}"));
          }
          break;
      }
    } catch (e) {
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "Произошла неизвестная ошибка: $e"));
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
        ScaffoldMessenger.of(context).showSnackBar(SnackBars.getSuccessSnackBar(message: "Конфигурация кардридера поста $id успешно сохранена"));
      }
    } on ApiException catch (e) {
      switch (e.code) {
        case HttpStatus.unauthorized:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "Неверный PIN"));
          }
          break;
        case HttpStatus.notFound:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "Не найдена конфигурация кардридера поста $id"));
          }
          break;
        case HttpStatus.unprocessableEntity:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "Конфигурация не прошла проверку"));
          }
          break;
        default:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "Ошибка: ${e.code}"));
          }
          break;
      }
    } catch (e) {
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "Произошла неизвестная ошибка: $e"));
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
        ScaffoldMessenger.of(context).showSnackBar(SnackBars.getSuccessSnackBar(message: "Конфигурация кнопок поста $id сохранена"));
      }
    } on ApiException catch (e) {
      switch (e.code) {
        case HttpStatus.unprocessableEntity:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "Неприемдимая конфигурация кнопок"));
          }
          break;
        default:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "Ошибка: ${e.code}"));
          }
          break;
      }
    } catch (e) {
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "Произошла неизвестная ошибка: $e"));
      }
    }
  }

  @override
  Future<void> deleteDiscountCampaign(int id, {BuildContext? context}) async {
    try {
      final args = ArgDelAdvertisingCampagin(id: id);
      final response = await api.delAdvertisingCampaign(args);

      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBars.getSuccessSnackBar(message: "Скидочная программа $id удалена"));
      }
    } on ApiException catch (e) {
      switch (e.code) {
        case HttpStatus.notFound:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getWarningSnackBar(message: "Не найдено скидочной программы - $id"));
          }
          break;
        case HttpStatus.unauthorized:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "Неверный PIN"));
          }
          break;
        case HttpStatus.forbidden:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "Доступ запрещен"));
          }
          break;
        default:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "Ошибка: ${e.code}"));
          }
          break;
      }
    } catch (e) {
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "Произошла неизвестная ошибка: $e"));
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
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getWarningSnackBar(message: "Не найдено конфигурации кассы"));
          }
          break;
        default:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "Ошибка: ${e.code}"));
          }
          break;
      }
    } catch (e) {
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "Произошла неизвестная ошибка: $e"));
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
        ScaffoldMessenger.of(context).showSnackBar(SnackBars.getSuccessSnackBar(message: "Конфигурация кассы сохранена"));
      }
    } on ApiException catch (e) {
      switch (e.code) {
        default:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "Ошибка: ${e.code}"));
          }
          break;
      }
    } catch (e) {
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "Произошла неизвестная ошибка: $e"));
      }
    }
  }
}
