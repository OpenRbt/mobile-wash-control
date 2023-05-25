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

  Station({required this.id, this.name, this.hash, this.status, this.currentBalance, this.currentProgram, this.currentProgramName, this.ip});
}

class KasseStatus {
  String? status;
  String? info;

  KasseStatus({this.status, this.info});
}

class StationButton {
  int buttonID;
  int? programID;
  String? programName;

  StationButton({required this.buttonID, this.programID, this.programName});
}

class StationMoneyReport {
  int? coins;
  int? banknotes;
  int? electronical;
  int? service;
  int? carsTotal;
  StationMoneyReport({this.coins, this.banknotes, this.electronical, this.service, this.carsTotal});
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
  DateTime? ctime;
  String? user;

  StationCollectionReport({this.id, this.carsTotal, this.coins, this.banknotes, this.electronical, this.service, this.ctime, this.user});
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
        return "Понедельник";
      case WeekDay.tuesday:
        return "Вторник";
      case WeekDay.wednesday:
        return "Среда";
      case WeekDay.thursday:
        return "Четверг";
      case WeekDay.friday:
        return "Пятница";
      case WeekDay.saturday:
        return "Суббота";
      case WeekDay.sunday:
        return "Воскресенье";
      default:
        return "ОШИБКА";
    }
  }

  String labelShort() {
    switch (this) {
      case WeekDay.monday:
        return "Пн";
      case WeekDay.tuesday:
        return "Вт";
      case WeekDay.wednesday:
        return "Ср";
      case WeekDay.thursday:
        return "Чт";
      case WeekDay.friday:
        return "Пт";
      case WeekDay.saturday:
        return "Сб";
      case WeekDay.sunday:
        return "Вс";
      default:
        return "ОШИБКА";
    }
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
  danBoard;

  static RelayBoard? fromString(String str) {
    switch (str) {
      case "localGPIO":
        return RelayBoard.localGPIO;
      case "danBoard":
        return RelayBoard.danBoard;
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
      default:
        return "unknown";
    }
  }

  String label() {
    switch (this) {
      case RelayBoard.localGPIO:
        return "локально";
      case RelayBoard.danBoard:
        return "на сервере";
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
        return "не используется";
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
