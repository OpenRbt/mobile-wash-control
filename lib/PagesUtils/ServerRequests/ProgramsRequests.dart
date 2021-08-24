import 'package:flutter/material.dart';
import 'package:mobile_wash_control/CommonElements.dart';
import 'package:mobile_wash_control/client/api.dart';

Future<bool> saveProgram(
  SessionData sessionData, {
  int id = -1,
  int motorSpeed,
  int motorSpeedPreflight,
  bool preflightEnabled,
  bool isFinishingProgram,
  String programName,
  int price,
  List<int> relaysPercent,
  List<int> relaysPreflightPercent,
}) async {
  final int _relayCount = 17;
  final int _relayTime = 1000;
  try {
    if (id == -1) {
      var tmp = await sessionData.client.programs(ArgPrograms());
      int maxID = 1000;
      if (tmp != null && tmp.isNotEmpty) {
        tmp.sort(
          (a, b) => a.id.compareTo(b.id),
        );
        if (tmp.last.id >= 1000) {
          maxID = tmp.last.id + 1;
        }
      }
      id = maxID;
    }

    var args = Program();
    args.id = id;
    args.motorSpeedPercent = motorSpeed;
    args.name = programName;
    args.price = price;
    args.preflightEnabled = preflightEnabled;
    args.preflightMotorSpeedPercent = motorSpeedPreflight;
    args.isFinishingProgram = isFinishingProgram;

    List<RelayConfig> relays = List();
    List<RelayConfig> relaysPreflight = List();
    for (int i = 0; i < _relayCount; i++) {
      if (relaysPercent[i] != 0) {
        var tmp = RelayConfig();
        tmp.id = i + 1;
        tmp.timeon = (_relayTime * (relaysPercent[i] / 100)).round();
        tmp.timeoff = _relayTime - tmp.timeon;
        relays.add(tmp);
      }
      if (preflightEnabled && relaysPreflightPercent[i] != 0) {
        var tmp = RelayConfig();
        tmp.id = i + 1;
        tmp.timeon = (_relayTime * (relaysPreflightPercent[i] / 100)).round();
        tmp.timeoff = _relayTime - tmp.timeon;
        relaysPreflight.add(tmp);
      }
    }
    args.relays = relays;
    args.preflightRelays = relaysPreflight;

    print(args);
    var res = await sessionData.client.setProgram(args);
  } catch (e) {
    return false;
  }
  return true;
}

class ProgramData {
  String name;
  int price;
  bool preflightEnabled;
  bool isFinishingProgram;
  int motorSpeed;
  int motorSpeedPreflight;
  List<int> relays;
  List<int> relayPreflight;
}

Future<ProgramData> getProgram({SessionData sessionData, int programID}) async {
  final int _relayCount = 17;
  final int _relayTime = 1000;

  ProgramData program = ProgramData();
  program.name = "";
  program.price = 0;
  program.preflightEnabled = false;
  program.isFinishingProgram = false;
  program.motorSpeed = 0;
  program.motorSpeedPreflight = 0;
  program.relays = List.filled(_relayCount, 0);
  program.relayPreflight = List.filled(_relayCount, 0);

  try {
    var res = await sessionData.client.programs(ArgPrograms(
      programID: programID,
    ));

    if (res.length == 0) {
      return null;
    }
    Program resProgram = res[0];

    program.name = resProgram.name ?? "";
    program.price = resProgram.price ?? 0;
    program.motorSpeed = resProgram.motorSpeedPercent ?? 0;
    program.motorSpeedPreflight = resProgram.preflightMotorSpeedPercent ?? 0;
    program.preflightEnabled = resProgram.preflightEnabled ?? false;
    program.isFinishingProgram = resProgram.isFinishingProgram ?? false;

    for (int i = 0; i < resProgram.relays.length; i++) {
      int id = resProgram.relays[i].id - 1;
      int timeon = resProgram.relays[i].timeon ?? 0;
      int timeoff = resProgram.relays[i].timeoff ?? 0;
      int percent = (100 * timeon / (timeon + timeoff)).round();
      program.relays[id] = percent;
    }

    for (int i = 0; i < resProgram.preflightRelays.length; i++) {
      int id = resProgram.preflightRelays[i].id - 1;
      int timeon = resProgram.preflightRelays[i].timeon ?? 0;
      int timeoff = resProgram.preflightRelays[i].timeoff ?? 0;
      int percent = (100 * timeon / (timeon + timeoff)).round();
      program.relayPreflight[id] = percent;
    }
  } catch (e) {
    return null;
  }
  return program;
}
