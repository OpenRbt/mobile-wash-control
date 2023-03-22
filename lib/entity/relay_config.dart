part of 'entity.dart';

class RelayConfig {
  static final int RelayTime = 1000;

  int id;
  late int timeOn;
  late int timeOff;

  int percent() {
    return (100 * timeOn / (timeOn + timeOff)).round();
  }

  RelayConfig({required this.id, int percent = 0}) {
    timeOn = (RelayTime * percent / 100).round();
    timeOff = (RelayTime * percent / 100).round();
  }

  static RelayConfig FromApi(int id, int timeOn, int timeOff) {
    var res = RelayConfig(id: id);
    res.timeOn = timeOn;
    res.timeOff = timeOff;
    return res;
  }
}
