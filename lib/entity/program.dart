part of 'entity.dart';

class Program {
  static final int relayCount = 17;
  static final int maxPercent = 100;
  static final int maxMotor = 100;

  final int? id;

  String name = "";
  int price = 10;
  bool preflightEnabled = false;
  bool ifFinishingProgram = false;
  int motorSpeedPercent = 100;
  int preflightMotorSpeedPercent = 100;

  List<RelayConfig> relays = List.generate(relayCount, (index) => RelayConfig(id: index + 1));
  List<RelayConfig> relaysPreflight = List.generate(relayCount, (index) => RelayConfig(id: index + 1));

  Program(this.id);
}
