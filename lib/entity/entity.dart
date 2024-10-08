import 'package:easy_localization/easy_localization.dart';

part 'program.dart';
part 'relay_config.dart';
part 'wash_server.dart';

class Station {
  int id;
  String? name;
  String? hash;
  String? status;
  int? currentBalance;
  int? currentProgram;
  String? currentProgramName;
  String? ip;
  int? firmwareVersion;

  Station({required this.id, this.name, this.hash, this.status, this.currentBalance, this.currentProgram, this.currentProgramName, this.ip, this.firmwareVersion});

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'hash': this.hash,
      'status': this.status,
      'currentBalance': this.currentBalance,
      'currentProgram': this.currentProgram,
      'currentProgramName': this.currentProgramName,
      'ip': this.ip,
      'firmwareVersion': this.firmwareVersion,
    };
  }

  factory Station.fromMap(Map<String, dynamic> map) {
    return Station(
      id: map['id'] as int,
      name: map['name'],
      hash: map['hash'],
      status: map['status'],
      currentBalance: map['currentBalance'],
      currentProgram: map['currentProgram'],
      currentProgramName: map['currentProgramName'],
      ip: map['ip'],
      firmwareVersion: map['firmwareVersion'],
    );
  }
}

class Organization {
  String? id;
  String? name;
  String? description;
  bool? isDefault;

  Organization({this.id, this.name, this.description, this.isDefault});

  Organization copyWith({String? id, String? name, String? description, bool? isDefault}) {
    return Organization(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        isDefault: isDefault ?? this.isDefault,
    );
  }
}

class ServerGroup {
  String? id;
  String? name;
  String? description;
  String? organizationId;

  ServerGroup({this.id, this.name, this.description, this.organizationId});

  ServerGroup copyWith({String? id, String? name, String? description, String? organizationId}) {
    return ServerGroup(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      organizationId: organizationId ?? this.organizationId,
    );
  }
}

class FirebaseUser {
  String? id;
  String? name;
  String? email;

  FirebaseUser({this.id, this.name, this.email});
}

class KasseStatus {
  String? status;
  String? info;

  KasseStatus({this.status, this.info});
}

class ServiceStatus {
  bool? available;
  bool? disabledOnServer;
  bool? isConnected;
  String? lastErr;
  int? dateLastErrUTC;
  List<int>? unpaidStations;

  ServiceStatus({this.available, this.disabledOnServer, this.isConnected, this.lastErr, this.dateLastErrUTC, this.unpaidStations});
}

class StationButton {
  int buttonID;
  int? programID;
  String? programName;

  StationButton({required this.buttonID, this.programID, this.programName});
}

class StationMoneyReport {
  int? post;
  int? coins;
  int? banknotes;
  int? electronical;
  int? qrMoney;
  int? service;
  int? bonuses;
  int? carsTotal;
  DateTime? dateTime;

  StationMoneyReport({this.coins, this.banknotes, this.electronical, this.service, this.carsTotal, this.qrMoney, this.bonuses, this.post, this.dateTime});

  double Average() {
    if ((carsTotal ?? 0) == 0) {
      return 0;
    }

    return ((coins ?? 0) + (banknotes ?? 0) + (electronical ?? 0) + (qrMoney ?? 0)) / carsTotal!;
  }

  bool notEmpty() {
    return (coins ?? 0) != 0 || (banknotes ?? 0) != 0 || (electronical ?? 0) != 0 || (qrMoney ?? 0) != 0 || (service ?? 0) != 0 || (bonuses ?? 0) != 0 || (carsTotal ?? 0) != 0;
  }
}

class User {
  String login;

  String? firstName;
  String? middleName;
  String? lastName;
  bool? isAdmin;
  bool? isOperator;
  bool? isEngineer;

  User({required this.login, this.firstName, this.middleName, this.lastName, this.isAdmin, this.isOperator, this.isEngineer});

  @override
  bool operator ==(covariant User other) {
    return this.login == other.login &&
        this.firstName == other.firstName &&
        this.lastName == other.lastName &&
        this.middleName == other.middleName &&
        this.isOperator == other.isOperator &&
        this.isEngineer == other.isEngineer &&
        this.isAdmin == other.isAdmin;
  }

  User copyWith({
    String? login,
    String? firstName,
    String? middleName,
    String? lastName,
    bool? isAdmin,
    bool? isOperator,
    bool? isEngineer,
  }) {
    return User(login: login ?? this.login)
      ..firstName = firstName ?? this.firstName
      ..middleName = middleName ?? this.middleName
      ..lastName = lastName ?? this.lastName
      ..isAdmin = isAdmin ?? this.isAdmin
      ..isOperator = isOperator ?? this.isOperator
      ..isEngineer = isEngineer ?? this.isEngineer;
  }
}

class StationCollectionReport {
  int? id;
  int? carsTotal;
  int? coins;
  int? banknotes;
  int? electronical;
  int? service;
  int? bonuses;
  int? qrMoney;
  DateTime? ctime;
  String? user;

  StationCollectionReport({this.id, this.carsTotal, this.coins, this.banknotes, this.electronical, this.service, this.bonuses, this.qrMoney, this.ctime, this.user});
}

class StationStats {
  int? id;
  int? pumpTimeOn;
  List<RelayStats>? relayStats;
  List<ProgramStats>? programStats;

  StationStats({this.id, this.pumpTimeOn, this.relayStats, this.programStats});
}

class RelayStats {
  int? relayID;
  int? switchedCount;
  int? totalTimeOn;

  RelayStats({this.relayID, this.switchedCount, this.totalTimeOn});
}

class ProgramStats {
  int? programID;
  String? programName;
  int? timeOn;

  ProgramStats({this.programID, this.programName, this.timeOn});
}

enum WeekDay {
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday,
  sunday,
  unknown;

  static WeekDay fromInt(int val) {
    var index = val - 1;
    return WeekDay.values.length < index ? WeekDay.values[index] : WeekDay.unknown;
  }

  static WeekDay fromString(String val) {
    switch (val) {
      case "sunday":
        return WeekDay.sunday;
      case "monday":
        return WeekDay.monday;
      case "tuesday":
        return WeekDay.tuesday;
      case "wednesday":
        return WeekDay.wednesday;
      case "thursday":
        return WeekDay.thursday;
      case "friday":
        return WeekDay.friday;
      case "saturday":
        return WeekDay.saturday;
      default:
        return WeekDay.unknown;
    }
  }

  String label() {
    switch (this) {
      case WeekDay.monday:
        return 'monday'.tr();
      case WeekDay.tuesday:
        return 'tuesday'.tr();
      case WeekDay.wednesday:
        return 'wednesday'.tr();
      case WeekDay.thursday:
        return 'thursday'.tr();
      case WeekDay.friday:
        return 'friday'.tr();
      case WeekDay.saturday:
        return 'saturday'.tr();
      case WeekDay.sunday:
        return 'sunday'.tr();
      default:
        return 'ERROR'.tr();
    }
  }

  String labelShort() {
    switch (this) {
      case WeekDay.monday:
        return 'mo"'.tr();
      case WeekDay.tuesday:
        return 'tu'.tr();
      case WeekDay.wednesday:
        return 'we'.tr();
      case WeekDay.thursday:
        return 'th'.tr();
      case WeekDay.friday:
        return 'fr'.tr();
      case WeekDay.saturday:
        return 'sa'.tr();
      case WeekDay.sunday:
        return 'su'.tr();
      default:
        return 'ERROR'.tr();
    }
  }
}

extension WeekDaySorting on WeekDay {
  static Set<WeekDay> sortDays(Set<WeekDay> days) {
    List<WeekDay> sortedList = days.toList()
      ..sort((a, b) => a.index.compareTo(b.index));
    return sortedList.toSet();
  }
}

enum TaskStatus {
  queue,
  started,
  completed,
  error;

  static TaskStatus fromString(String val) {

    for(int i = 0; i < TaskStatus.values.length; i++){
      if(TaskStatus.values[i].name == val) {
        return TaskStatus.values[i];
      }
    }

    return error;
  }
}

enum TaskType {
  build,
  update;

  static TaskType fromString(String val) {

    for(int i = 0; i < TaskType.values.length; i++){
      if(TaskType.values[i].name == val) {
        return TaskType.values[i];
      }
    }

    return update;
  }

}

class DiscountCampaign {
  int? id;
  String? name;
  DateTime startDate;
  DateTime endDate;
  bool? enabled;
  int? startMinute;
  int? endMinute;
  int? defaultDiscount;
  Set<DiscountProgram>? discountPrograms;
  Set<WeekDay>? weekDays;

  DiscountCampaign({this.id, this.name, required this.startDate, required this.endDate, this.enabled, this.startMinute, this.endMinute, this.defaultDiscount, this.discountPrograms, this.weekDays});

  DiscountCampaign copyWith({
    int? id,
    String? name,
    DateTime? startDate,
    DateTime? endDate,
    bool? enabled,
    int? startMinute,
    int? endMinute,
    int? defaultDiscount,
    Set<DiscountProgram>? discountPrograms,
    Set<WeekDay>? weekDays,
  }) {
    return DiscountCampaign(startDate: startDate ?? this.startDate, endDate: endDate ?? this.endDate)
      ..id = id ?? this.id
      ..name = name ?? this.name
      ..enabled = enabled ?? this.enabled
      ..startMinute = startMinute ?? this.startMinute
      ..endMinute = endMinute ?? this.endMinute
      ..defaultDiscount = defaultDiscount ?? this.defaultDiscount
      ..discountPrograms = discountPrograms ?? this.discountPrograms
      ..weekDays = weekDays ?? this.weekDays;
  }
}

class DiscountProgram {
  int? programID;
  int? discount;
  String? programName;

  DiscountProgram({this.programID, this.discount, this.programName});

  DiscountProgram copyWith({
    int? programID,
    int? discount,
    String? programName,
  }) {
    return DiscountProgram()
      ..programID = programID ?? this.programID
      ..discount = discount ?? this.discount
      ..programName = programName ?? this.programName;
  }

  @override
  int get hashCode => this.programID ?? 0;

  @override
  bool operator ==(covariant DiscountProgram other) {
    return this.programID == other.programID;
  }
}

class LeaCentralConfig {
  int? timeZone;

  LeaCentralConfig({this.timeZone});

  LeaCentralConfig copyWith({
    int? timeZone,
  }) {
    return LeaCentralConfig()..timeZone = timeZone ?? this.timeZone;
  }
}

enum RelayBoard {
  localGPIO,
  danBoard,
  all;

  static RelayBoard? fromString(String str) {
    switch (str) {
      case "localGPIO":
        return RelayBoard.localGPIO;
      case "danBoard":
        return RelayBoard.danBoard;
      case "all":
        return RelayBoard.all;
      default:
        return null;
    }
  }

  String toString() {
    switch (this) {
      case RelayBoard.localGPIO:
        return "localGPIO";
      case RelayBoard.danBoard:
        return "danBoard";
      case RelayBoard.all:
        return "all";
      default:
        return "unknown";
    }
  }

  String label() {
    switch (this) {
      case RelayBoard.localGPIO:
        return 'local'.tr();
      case RelayBoard.danBoard:
        return 'on_server'.tr();
      case RelayBoard.all:
        return 'everywhere'.tr();
      default:
        return "unknown";
    }
  }
}

class StationConfig {
  int id;
  int? preflightSec;
  String? name;
  String? hash;
  RelayBoard relayBoard;

  StationConfig({required this.id, this.preflightSec, this.name, this.hash, required this.relayBoard});

  StationConfig copyWith({
    int? id,
    int? preflightSec,
    String? name,
    String? hash,
    RelayBoard? relayBoard,
  }) {
    return StationConfig(id: id ?? this.id, relayBoard: relayBoard ?? this.relayBoard)
      ..preflightSec = preflightSec ?? this.preflightSec
      ..name = name ?? this.name
      ..hash = hash ?? this.hash;
  }
}

enum CardReader {
  vendotek,
  paymentWorld,
  not_used;

  static CardReader fromString(String str) {
    switch (str) {
      case "PAYMENT_WORLD":
        return CardReader.paymentWorld;
      case "VENDOTEK":
        return CardReader.vendotek;
      default:
        return CardReader.not_used;
    }
  }

  String label() {
    switch (this) {
      case CardReader.vendotek:
        return "VENDOTEK";
      case CardReader.paymentWorld:
        return "PAYMENT WORLD";
      case CardReader.not_used:
        return 'not_used'.tr();;
    }
  }
}

class StationCardReaderConfig {
  CardReader cardReader;
  String? host;
  String? port;

  StationCardReaderConfig({required this.cardReader, this.host, this.port});

  StationCardReaderConfig copyWith({
    CardReader? cardReader,
    String? host,
    String? port,
  }) {
    return StationCardReaderConfig(cardReader: cardReader ?? this.cardReader)
      ..host = host ?? this.host
      ..port = port ?? this.port;
  }
}

enum TaxType {
  vAT110,
  vAT0,
  no,
  vat120;

  static TaxType fromString(String value) {
    switch (value) {
      case "TAX_VAT110":
        return TaxType.vAT110;
      case "TAX_VAT0":
        return TaxType.vAT0;
      case "TAX_VAT120":
        return TaxType.vat120;
      default:
        return TaxType.no;
    }
  }

  String label() {
    switch (this) {
      case TaxType.vAT110:
        return "TAX_VAT110";
      case TaxType.vAT0:
        return "TAX_VAT0";
        break;
      case TaxType.no:
        return "TAX_NO";
      case TaxType.vat120:
        return "TAX_VAT120";
    }
  }
}

class KasseConfig {
  TaxType taxType;
  String? receiptItemName;
  String? cashier;
  String? cashierINN;

  KasseConfig({required this.taxType, this.receiptItemName, this.cashier, this.cashierINN});

  KasseConfig copyWith({
    TaxType? taxType,
    String? receiptItemName,
    String? cashier,
    String? cashierINN,
  }) {
    return KasseConfig(taxType: taxType ?? this.taxType)
      ..receiptItemName = receiptItemName ?? this.receiptItemName
      ..cashier = cashier ?? this.cashier
      ..cashierINN = cashierINN ?? this.cashierINN;
  }
}

class StationPreset {
  String name;
  List<Program> programs;
  List<StationButton> stationButtons;

  StationPreset({required this.programs, required this.stationButtons, required this.name});
}

class RunProgramConfig {
  String stationHash;
  int? stationID;
  int programID;
  String? programName;
  //UNUSED
  bool Prefligth = false;

  RunProgramConfig({required this.stationHash, required this.programID, this.Prefligth = false, this.programName, this.stationID});
}

class FirmwareVersion {
  int id;
  String? hashLua;
  String? hashEnv;
  String? hashBinar;
  DateTime? builtAt;
  DateTime? commitedAt;
  bool? isCurrent;

  FirmwareVersion({
    required this.id,
    required this.hashLua,
    required this.hashEnv,
    required this.hashBinar,
    required this.builtAt,
    required this.commitedAt,
    required this.isCurrent,
  });
}

class Task {
  Task({
    required this.id,
    required this.stationID,
    required this.type,
    required this.status,
    this.error,
    required this.createdAt,
    this.startedAt,
    this.stoppedAt,
  });

  int id;
  int stationID;
  TaskType type;
  TaskStatus status;
  String? error;
  DateTime createdAt;
  DateTime? startedAt;
  DateTime? stoppedAt;
}

class BuildScript {
  BuildScript({
    required this.id,
    required this.stationID,
    required this.name,
    required this.commands,
  });

  int id;
  int stationID;
  String name;
  List<String> commands;
}