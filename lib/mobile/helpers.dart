import 'package:mobile_wash_control/entity/entity.dart';

class Helpers {
  static List<StationPreset> getStationPresets() {
    return [
      StationPreset(
        name: "Wash",
        programs: [
          _getProgram(
            id: 1,
            name: "wsh-water",
            price: 25,
            preflightEnabled: false,
            motorSpeedPercent: 100,
            preflightMotorSpeedPercent: 100,
            relays: [
              RelayConfig(id: 1, percent: 100),
              RelayConfig(id: 6, percent: 100),
            ],
            relaysPreflight: [],
          ),
          _getProgram(
            id: 2,
            name: "wsh-foam",
            price: 25,
            preflightEnabled: false,
            motorSpeedPercent: 100,
            preflightMotorSpeedPercent: 100,
            relays: [
              RelayConfig(id: 1, percent: 100),
              RelayConfig(id: 2, percent: 28), //TODO: recheck with old value 0.3857 | 278 722
              RelayConfig(id: 6, percent: 100),
            ],
            relaysPreflight: [],
          ),
          _getProgram(
            id: 3,
            name: "wsh-foam-active",
            price: 25,
            preflightEnabled: false,
            motorSpeedPercent: 100,
            preflightMotorSpeedPercent: 100,
            relays: [
              RelayConfig(id: 1, percent: 100),
              RelayConfig(id: 2, percent: 50),
              RelayConfig(id: 6, percent: 100),
            ],
            relaysPreflight: [],
          ),
          _getProgram(
            id: 4,
            name: "wsh-wax",
            price: 25,
            preflightEnabled: false,
            motorSpeedPercent: 100,
            preflightMotorSpeedPercent: 100,
            relays: [
              RelayConfig(id: 1, percent: 100),
              RelayConfig(id: 4, percent: 28), //TODO: recheck with old value 0.3857 | 284 716
              RelayConfig(id: 6, percent: 100),
            ],
            relaysPreflight: [],
          ),
          _getProgram(
            id: 1,
            name: "wsh-osmosian",
            price: 25,
            preflightEnabled: false,
            motorSpeedPercent: 100,
            preflightMotorSpeedPercent: 100,
            relays: [
              RelayConfig(id: 5, percent: 100),
              RelayConfig(id: 6, percent: 100),
            ],
            relaysPreflight: [],
          ),
          _getProgram(
            id: 1,
            name: "wsh-pause",
            price: 25,
            preflightEnabled: false,
            motorSpeedPercent: 100,
            preflightMotorSpeedPercent: 100,
            relays: [
              RelayConfig(id: 6, percent: 100),
            ],
            relaysPreflight: [],
          ),
        ],
        stationButtons: [
          StationButton(buttonID: 1, programID: 1),
          StationButton(buttonID: 2, programID: 2),
          StationButton(buttonID: 3, programID: 3),
          StationButton(buttonID: 4, programID: 4),
          StationButton(buttonID: 5, programID: 5),
          StationButton(buttonID: 6, programID: 6),
        ],
      ),
      StationPreset(
        name: "Sensor Screen",
        programs: [
          _getProgram(
            id: 51,
            name: "qzr-foam",
            price: 25,
            preflightEnabled: false,
            motorSpeedPercent: 100,
            preflightMotorSpeedPercent: 100,
            relays: [
              RelayConfig(id: 1, percent: 100),
              RelayConfig(id: 6, percent: 100),
              RelayConfig(id: 12, percent: 100),
              RelayConfig(id: 14, percent: 100),
            ],
            relaysPreflight: [],
          ),
          _getProgram(
            id: 52,
            name: "qzr-shampoo",
            price: 25,
            preflightEnabled: false,
            motorSpeedPercent: 100,
            preflightMotorSpeedPercent: 100,
            relays: [
              RelayConfig(id: 1, percent: 100),
              RelayConfig(id: 5, percent: 66),
              RelayConfig(id: 12, percent: 100),
              RelayConfig(id: 14, percent: 100),
            ],
            relaysPreflight: [],
          ),
          _getProgram(
            id: 53,
            name: "qzr-water",
            price: 25,
            preflightEnabled: false,
            motorSpeedPercent: 100,
            preflightMotorSpeedPercent: 100,
            relays: [
              RelayConfig(id: 1, percent: 75),
              RelayConfig(id: 11, percent: 50),
              RelayConfig(id: 14, percent: 100),
            ],
            relaysPreflight: [],
          ),
          _getProgram(
            id: 54,
            name: "qzr-wax",
            price: 25,
            preflightEnabled: false,
            motorSpeedPercent: 100,
            preflightMotorSpeedPercent: 100,
            relays: [
              RelayConfig(id: 1, percent: 80),
              RelayConfig(id: 4, percent: 100),
              RelayConfig(id: 12, percent: 100),
              RelayConfig(id: 14, percent: 100),
            ],
            relaysPreflight: [],
          ),
          _getProgram(
            id: 55,
            name: "qzr-air",
            price: 25,
            preflightEnabled: false,
            motorSpeedPercent: 100,
            preflightMotorSpeedPercent: 100,
            relays: [
              RelayConfig(id: 14, percent: 100),
              RelayConfig(id: 16, percent: 100),
            ],
            relaysPreflight: [],
          ),
          _getProgram(
            id: 56,
            name: "qzr-pause",
            price: 25,
            preflightEnabled: false,
            motorSpeedPercent: 100,
            preflightMotorSpeedPercent: 100,
            relays: [
              RelayConfig(id: 6, percent: 100),
              RelayConfig(id: 14, percent: 100),
            ],
            relaysPreflight: [],
          ),
          _getProgram(
            id: 57,
            name: "qzr-openlid",
            price: 25,
            preflightEnabled: false,
            motorSpeedPercent: 100,
            preflightMotorSpeedPercent: 100,
            relays: [
              RelayConfig(id: 2, percent: 100),
              RelayConfig(id: 6, percent: 100),
              RelayConfig(id: 14, percent: 100),
            ],
            relaysPreflight: [],
          ),
        ],
        stationButtons: [
          StationButton(buttonID: 1, programID: 51),
          StationButton(buttonID: 2, programID: 52),
          StationButton(buttonID: 3, programID: 53),
          StationButton(buttonID: 4, programID: 54),
          StationButton(buttonID: 5, programID: 55),
          StationButton(buttonID: 6, programID: 56),
        ],
      ),
      StationPreset(
        name: "Moycar",
        programs: [
          _getProgram(
            id: 101,
            name: "robo-express",
            price: 25,
            preflightEnabled: false,
            motorSpeedPercent: 100,
            preflightMotorSpeedPercent: 100,
            relays: [
              RelayConfig(id: 1, percent: 100),
            ],
            relaysPreflight: [],
          ),
          _getProgram(
            id: 102,
            name: "robo-daily",
            price: 25,
            preflightEnabled: false,
            motorSpeedPercent: 100,
            preflightMotorSpeedPercent: 100,
            relays: [
              RelayConfig(id: 2, percent: 100),
            ],
            relaysPreflight: [],
          ),
          _getProgram(
            id: 103,
            name: "robo-premium",
            price: 25,
            preflightEnabled: false,
            motorSpeedPercent: 100,
            preflightMotorSpeedPercent: 100,
            relays: [
              RelayConfig(id: 3, percent: 100),
            ],
            relaysPreflight: [],
          ),
          _getProgram(
            id: 104,
            name: "robo-vacuum cleaner and mats",
            price: 25,
            preflightEnabled: false,
            motorSpeedPercent: 100,
            preflightMotorSpeedPercent: 100,
            relays: [
              RelayConfig(id: 11, percent: 100),
            ],
            relaysPreflight: [],
          ),
          _getProgram(
            id: 105,
            name: "robo-interior and wheels",
            price: 25,
            preflightEnabled: false,
            motorSpeedPercent: 100,
            preflightMotorSpeedPercent: 100,
            relays: [
              RelayConfig(id: 12, percent: 100),
            ],
            relaysPreflight: [],
          ),
          _getProgram(
            id: 106,
            name: "robo-tire",
            price: 25,
            preflightEnabled: false,
            motorSpeedPercent: 100,
            preflightMotorSpeedPercent: 100,
            relays: [
              RelayConfig(id: 13, percent: 100),
            ],
            relaysPreflight: [],
          ),
          _getProgram(
            id: 107,
            name: "robo-disks",
            price: 25,
            preflightEnabled: false,
            motorSpeedPercent: 100,
            preflightMotorSpeedPercent: 100,
            relays: [
              RelayConfig(id: 14, percent: 100),
            ],
            relaysPreflight: [],
          ),
          _getProgram(
            id: 108,
            name: "robo-drying",
            price: 25,
            preflightEnabled: false,
            motorSpeedPercent: 100,
            preflightMotorSpeedPercent: 100,
            relays: [
              RelayConfig(id: 15, percent: 100),
            ],
            relaysPreflight: [],
          ),
        ],
        stationButtons: [
          StationButton(buttonID: 1, programID: 101),
          StationButton(buttonID: 2, programID: 102),
          StationButton(buttonID: 3, programID: 103),
          StationButton(buttonID: 4, programID: 104),
          StationButton(buttonID: 5, programID: 105),
          StationButton(buttonID: 6, programID: 106),
          StationButton(buttonID: 7, programID: 107),
          StationButton(buttonID: 8, programID: 108),
        ],
      ),
      StationPreset(
        name: "Vacuum",
        programs: [
          _getProgram(
            id: 151,
            name: "vcm-vacuum",
            price: 25,
            preflightEnabled: false,
            motorSpeedPercent: 100,
            preflightMotorSpeedPercent: 100,
            relays: [
              RelayConfig(id: 1, percent: 100),
              RelayConfig(id: 2, percent: 100),
              RelayConfig(id: 3, percent: 100),
              RelayConfig(id: 4, percent: 100),
              RelayConfig(id: 5, percent: 100),
              RelayConfig(id: 6, percent: 100),
            ],
            relaysPreflight: [],
          ),
          _getProgram(
            id: 156,
            name: "vcm-pause",
            price: 25,
            preflightEnabled: false,
            motorSpeedPercent: 100,
            preflightMotorSpeedPercent: 100,
            relays: [
              RelayConfig(id: 6, percent: 100),
            ],
            relaysPreflight: [],
          ),
        ],
        stationButtons: [
          StationButton(buttonID: 1, programID: 151),
          StationButton(buttonID: 2, programID: 156),
        ],
      ),
    ];
  }

  static Program _getProgram({
    required int id,
    required String name,
    required int price,
    required bool preflightEnabled,
    required int motorSpeedPercent,
    required int preflightMotorSpeedPercent,
    required List<RelayConfig> relays,
    required List<RelayConfig> relaysPreflight,
  }) {
    var res = Program(id);
    res.name = name;
    res.price = price;
    res.preflightEnabled = preflightEnabled;
    res.motorSpeedPercent = motorSpeedPercent;
    res.preflightMotorSpeedPercent = preflightMotorSpeedPercent;
    res.relays = relays;
    res.relaysPreflight = relaysPreflight;

    return res;
  }
}
