part of 'entity.dart';

class RelayConfig {
  static final int relayTime = 1000;

  int id;
  int timeOn = 0;
  int timeOff = 0;

  int percent() {
    return (timeOn / relayTime * 100).round();
  }

  RelayConfig({required this.id, int percent = 0}) {
    timeOn = (relayTime * percent / 100).round();
    timeOff = (relayTime * percent / 100).round();
  }

  void SetPercent(int percent) {
    timeOn = (relayTime / 100 * percent).round();
    timeOff = relayTime - timeOn;
  }

  static RelayConfig FromApi(int id, int timeOn, int timeOff) {
    var res = RelayConfig(id: id);
    res.timeOn = timeOn;
    res.timeOff = timeOff;

    return res;
  }
}
