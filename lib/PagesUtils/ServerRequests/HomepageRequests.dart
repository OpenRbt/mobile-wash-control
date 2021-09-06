import 'package:flutter/material.dart';
import 'package:mobile_wash_control/CommonElements.dart';
import 'package:mobile_wash_control/PagesUtils/PagesArgs.dart';
import 'package:mobile_wash_control/client/api.dart';

Future<List<ResponseStationButtonButtons>> GetStationButtons(PostMenuArgs postMenuArgs) async {
  List<ResponseStationButtonButtons> result;
  try {
    var args = ArgStationButton(
      stationID: postMenuArgs.postID,
    );
    var res = await postMenuArgs.sessionData.client.stationButton(args);
    result = res.buttons;
    var programs = await postMenuArgs.sessionData.client.programs(ArgPrograms());
  } catch (e) {
    print("Exception when calling DefaultApi->/station-button: $e\n");
    // showInfoSnackBar(_scaffoldKey, _isSnackBarActive,
    //   "Произошла ошибка при запросе к api", Colors.red);
  }
  return result;
}

class PostMenuInfo {
  final int incassBalance;
  final int balance;
  final int currentProgram;
  final List<bool> activePrograms;

  PostMenuInfo(this.incassBalance, this.balance, this.currentProgram, this.activePrograms);
}

Future<PostMenuInfo> GetPostInfo(PostMenuArgs postMenuArgs, List<ResponseStationButtonButtons> buttons) async {
  int incass = -1;
  int balance = -1;
  int currentProgram = -1;
  List<bool> activePrograms = List.filled(buttons.length, false);
  try {
    var resStatus = await postMenuArgs.sessionData.client.status();
    var status = resStatus.stations.firstWhere((element) => element.id == postMenuArgs.postID, orElse: () {
      return null;
    });

    currentProgram = status.currentProgram ?? -1;
    balance = status.currentBalance ?? 0;

    var args = ArgStationReportCurrentMoney(
      id: postMenuArgs.postID,
    );

    var res = await postMenuArgs.sessionData.client.stationReportCurrentMoney(args);

    incass = (res.moneyReport?.banknotes ?? 0) + (res.moneyReport?.coins ?? 0);

    var checkboxID = buttons.firstWhere((element) => element.programID == currentProgram, orElse: () {
          var tmp = ResponseStationButtonButtons();
          tmp.buttonID = 0;
          return tmp;
        }).buttonID -
        1;
    if (checkboxID >= 0) {
      activePrograms[checkboxID] = true;
    }
  } on ApiException catch (e) {
    if (e.code != 404) {
      print("Exception when calling DefaultApi->/station-report-current-money: $e\n");
    }
  } catch (e) {
    if (!(e is ApiException)) {
      print("Other Exception: $e\n");
    }
  }
  return PostMenuInfo(incass, balance, currentProgram, activePrograms);
}

class IncassationInfo {
  final List<CollectionReportWithUser> incassations;
  final int totalNal;
  final int totalBeznal;
  IncassationInfo(this.incassations, this.totalNal, this.totalBeznal);
}

Future<IncassationInfo> GetIncassation(PostMenuArgs postMenuArgs, DateTime _startDate, DateTime _endDate) async {
  List<CollectionReportWithUser> _incassations = [];
  int totalNal = 0;
  int totalBeznal = 0;

  print("FROM: $_startDate, TO: $_endDate");

  try {
    var args = ArgCollectionReportDates(stationID: postMenuArgs.postID, startDate: _startDate.millisecondsSinceEpoch ~/ 1000, endDate: _endDate.millisecondsSinceEpoch ~/ 1000);
    var res = await postMenuArgs.sessionData.client.stationCollectionReportDates(args);
    _incassations = res.collectionReports;

    totalNal = 0;
    totalBeznal = 0;
    for (int i = 0; i < _incassations.length; i++) {
      totalNal += (_incassations[i].banknotes ?? 0) + (_incassations[i].coins ?? 0);
      totalBeznal += _incassations[i].electronical ?? 0;
    }
  } on ApiException catch (e) {
    if (e.code != 404) {
      print("Exception when calling DefaultApi->/station-collection-report-dates: $e\n");
      //  showInfoSnackBar(_scaffoldKey, _isSnackBarActive,
      //      "Произошла ошибка при запросе к api", Colors.red);
    } else {}
  } catch (e) {
    if (!(e is ApiException)) {
      print("Other Exception: $e\n");
    }
  }
  return IncassationInfo(_incassations, totalNal, totalBeznal);
}

void AddServiceMoney(PostMenuArgs postMenuArgs) async {
  try {
    var args = ArgAddServiceAmount(
      hash: postMenuArgs.hash,
      amount: GlobalData.AddServiceValue,
    );
    var res = await postMenuArgs.sessionData.client.addServiceAmount(args);
  } catch (e) {
    print("Exception when calling DefaultApi->/add-service-amount: $e\n");
    //showInfoSnackBar(_scaffoldKey, _isSnackBarActive,
    //    "Произошла ошибка при запросе к api", Colors.red);
  }
}
