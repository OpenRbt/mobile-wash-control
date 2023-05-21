part of 'entity.dart';

class Program {
  static final int relayCount = 17;
  static final int maxPercent = 100;
  static final int maxMotor = 100;

  final int? id;

  String name = "";
  int price = 10;
  bool preflightEnabled = false;
  bool isFinishingProgram = false;
  int motorSpeedPercent = 100;
  int preflightMotorSpeedPercent = 100;

  List<RelayConfig> relays = List.generate(relayCount, (index) => RelayConfig(id: index + 1));
  List<RelayConfig> relaysPreflight = List.generate(relayCount, (index) => RelayConfig(id: index + 1));

  Program(this.id);

  Program copyWith({
    int? id,
    String? name,
    int? price,
    bool? preflightEnabled,
    bool? isFinishingProgram,
    int? motorSpeedPercent,
    int? preflightMotorSpeedPercent,
    List<RelayConfig>? relays,
    List<RelayConfig>? relaysPreflight,
  }) {
    return Program(id ?? this.id)
      ..name = name ?? this.name
      ..price = price ?? this.price
      ..preflightEnabled = preflightEnabled ?? this.preflightEnabled
      ..isFinishingProgram = isFinishingProgram ?? this.isFinishingProgram
      ..motorSpeedPercent = motorSpeedPercent ?? this.motorSpeedPercent
      ..preflightMotorSpeedPercent = preflightMotorSpeedPercent ?? this.preflightMotorSpeedPercent
      ..relays = relays ?? this.relays
      ..relaysPreflight = relaysPreflight ?? this.relaysPreflight;
  }
}
