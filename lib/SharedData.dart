import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobile_wash_control/CommonElements.dart';
import 'package:mobile_wash_control/client/api.dart';

class HomePageData {
  late int id;
  late String name;
  late String ip;
  late String hash;
  late String status;
  late String info;
  late int currentBalance;
  late String currentProgramName = "";
  late int currentProgramID;

  HomePageData(this.id, this.name, this.ip, this.hash, this.status, this.info, this.currentBalance, this.currentProgramName, this.currentProgramID);
  HomePageData.fromStationStatus(StationStatus? status) {
    this.id = status?.id ?? 0;
    this.ip = status?.ip ?? "___.___.___.___";
    this.name = status?.name ?? "";
    this.hash = status?.hash ?? "";
    this.status = status?.status?.value ?? "";
    this.info = status?.info ?? "";
    this.currentBalance = status?.currentBalance ?? 0;
    this.currentProgramID = status?.currentProgram ?? 0;
    if (status?.currentProgramName != null) {
      var tmp = status?.currentProgramName?.indexOf('-') ?? 0;
      int len = status?.currentProgramName?.length ?? 0;
      if (tmp < len) {
        this.currentProgramName = (status!.currentProgramName?.substring(tmp + 1) ?? "");
      } else {
        this.currentProgramName = status!.currentProgramName ?? "";
      }
    }
  }
}

class SharedData {
  static late SessionData? sessionData;

  static ValueNotifier<String> StatuslcwInfo = ValueNotifier("");
  static ValueNotifier<String> StatusKasseInfo = ValueNotifier("");
  static ValueNotifier<String> StatusKasse = ValueNotifier("");

  static ValueNotifier<List<HomePageData>> StationsData = ValueNotifier([]);
  static ValueNotifier<List<Program>> Programs = ValueNotifier([]);

  static late Timer StatusTimer;

  static bool CanUpdateStatus = false;

  static bool _StatusInUpdate = false;

  static Future<bool> StartTimers() async {
    try {
      if (SharedData.StatusTimer != null && SharedData.StatusTimer.isActive) {
        SharedData.StatusTimer.cancel();
      }

      SharedData.StatusTimer = Timer.periodic(Duration(seconds: 1), (timer) {
        RefreshStatus();
      });
    } catch (Exception) {
      return false;
    }
    return true;
  }

  static Future<bool> StopTimers() async {
    try {
      if (SharedData.StatusTimer != null && SharedData.StatusTimer.isActive) {
        SharedData.StatusTimer.cancel();
      }

      SharedData.sessionData = null;

      SharedData.Programs.value = [];
      SharedData.StationsData.value = [];

      SharedData.StatuslcwInfo.value = "";
      SharedData.StatusKasse.value = "";
      SharedData.StatusKasseInfo.value = "";
    } catch (Exception) {
      return false;
    }
    return true;
  }

  static void RefreshStatus() async {
    try {
      if (SharedData.sessionData == null || !CanUpdateStatus || _StatusInUpdate) {
        return;
      }
      _StatusInUpdate = true;
      var statusRes = await SharedData.sessionData?.client.status();
      statusRes?.stations.sort((a, b) => a.id!.compareTo(b.id!));
      List<HomePageData> tmpStationsStatus = [];
      var length = statusRes?.stations.length ?? 0;
      for (int i = 0; i < length; i++) {
        if ((statusRes?.stations[i].hash ?? "").isNotEmpty) {
          tmpStationsStatus.add(HomePageData.fromStationStatus(statusRes?.stations[i]));
        }
      }
      SharedData.StationsData.value = tmpStationsStatus;
      SharedData.StatuslcwInfo.value = statusRes?.lcwInfo ?? "";
      SharedData.StatusKasse.value = statusRes?.kasseInfo ?? "";
      SharedData.StatusKasseInfo.value = statusRes?.kasseInfo ?? "";
    } catch (Exception) {
      print(Exception);
    }
    _StatusInUpdate = false;
  }

  static Future<void> RefreshPrograms() async {
    try {
      if (SharedData.sessionData == null) {
        return;
      }

      var ProgramsRes = await SharedData.sessionData?.client.programs(ArgPrograms());
      ProgramsRes?.sort((a, b) => a.id.compareTo(b.id));

      SharedData.Programs.value = ProgramsRes!;
    } catch (Exception) {
      print(Exception);
    }
  }
}
