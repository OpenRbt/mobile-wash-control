import 'package:mobile_wash_control/entity/entity.dart' as entity;
import 'package:mobile_wash_control/openapi/lea-central-wash/api.dart';

class Helpers {
  static entity.Program programFromApi(Program program) {
    var res = entity.Program(program.id);
    res.name = program.name ?? "";
    res.price = program.price ?? 0;
    res.motorSpeedPercent = program.motorSpeedPercent ?? 100;
    res.preflightMotorSpeedPercent = program.preflightMotorSpeedPercent ?? 100;
    res.preflightEnabled = program.preflightEnabled ?? false;
    res.isFinishingProgram = program.isFinishingProgram ?? false;

    program.relays.forEach((element) {
      if ((element.timeon ?? 0) + (element.timeoff ?? 0) > 0) {
        res.relays[element.id! - 1] = entity.RelayConfig.FromApi(element.id!, element.timeon ?? 0, element.timeoff ?? 0);
      }
    });
    program.preflightRelays.forEach((element) {
      if ((element.timeon ?? 0) + (element.timeoff ?? 0) > 0) {
        res.relaysPreflight[element.id! - 1] = entity.RelayConfig.FromApi(element.id!, element.timeon ?? 0, element.timeoff ?? 0);
      }
    });
    return res;
  }

  static entity.User userFromApi(UserConfig u) {
    return entity.User(
      login: u.login,
      firstName: u.firstName,
      lastName: u.lastName,
      middleName: u.middleName,
      isAdmin: u.isAdmin,
      isEngineer: u.isEngineer,
      isOperator: u.isOperator,
    );
  }

  static entity.StationMoneyReport stationMoneyReportFromAPI(MoneyReport report) {
    return entity.StationMoneyReport(
      coins: report.coins,
      banknotes: report.banknotes,
      electronical: report.electronical,
      service: report.service,
      carsTotal: report.carsTotal,
    );
  }

  static entity.StationCollectionReport stationCollectionReportFromAPI(CollectionReportWithUser report) {
    DateTime? dateTime;
    if (report.ctime != null) {
      dateTime = DateTime.fromMillisecondsSinceEpoch(report.ctime! * 1000);
    }

    return entity.StationCollectionReport(
      id: report.id,
      coins: report.coins,
      banknotes: report.banknotes,
      electronical: report.electronical,
      service: report.service,
      carsTotal: report.carsTotal,
      ctime: dateTime,
      user: report.user,
    );
  }

  static entity.StationStats stationStatsFromAPI(StationStat stats) {
    return entity.StationStats(
      id: stats.stationID,
      relayStats: List.generate(stats.relayStats.length, (index) => relayStatsFromApi(stats.relayStats[index])),
      programStats: List.generate(stats.programStats.length, (index) => programStatsFromApi(stats.programStats[index])),
      pumpTimeOn: stats.pumpTimeOn,
    );
  }

  static entity.RelayStats relayStatsFromApi(RelayStat stat) {
    return entity.RelayStats(
      relayID: stat.relayID,
      switchedCount: stat.switchedCount,
      totalTimeOn: stat.totalTimeOn,
    );
  }

  static entity.ProgramStats programStatsFromApi(ProgramStat stat) {
    return entity.ProgramStats(
      programID: stat.programID,
      programName: stat.programName,
      timeOn: stat.timeOn,
    );
  }

  static entity.DiscountCampaign discountCampaignFromApi(AdvertisingCampaign campaign) {
    Set<entity.WeekDay> weekDays = Set();

    campaign.weekday.forEach((element) {
      weekDays.add(entity.WeekDay.fromString(element.toString()));
    });

    return entity.DiscountCampaign(
      id: campaign.id,
      startDate: DateTime.fromMillisecondsSinceEpoch(campaign.startDate * 1000),
      endDate: DateTime.fromMillisecondsSinceEpoch(campaign.endDate * 1000),
      enabled: campaign.enabled,
      startMinute: campaign.startMinute,
      endMinute: campaign.endMinute,
      defaultDiscount: campaign.defaultDiscount,
      discountPrograms: Set.from(
        List.generate(
          campaign.discountPrograms.length ?? 0,
          (index) => entity.DiscountProgram(programID: campaign.discountPrograms[index].programID, discount: campaign.discountPrograms[index].discount),
        ),
      ),
      weekDays: weekDays,
      name: campaign.name,
    );
  }

  static AdvertisingCampaign discountCampaignToApi(entity.DiscountCampaign campaign) {
    List<AdvertisingCampaignWeekdayEnum> weekdays = [];

    campaign.weekDays?.forEach(
      (element) {
        switch (element) {
          case entity.WeekDay.monday:
            weekdays.add(AdvertisingCampaignWeekdayEnum.monday);
            break;
          case entity.WeekDay.tuesday:
            weekdays.add(AdvertisingCampaignWeekdayEnum.tuesday);
            break;
          case entity.WeekDay.wednesday:
            weekdays.add(AdvertisingCampaignWeekdayEnum.wednesday);
            break;
          case entity.WeekDay.thursday:
            weekdays.add(AdvertisingCampaignWeekdayEnum.thursday);
            break;
          case entity.WeekDay.friday:
            weekdays.add(AdvertisingCampaignWeekdayEnum.friday);
            break;
          case entity.WeekDay.saturday:
            weekdays.add(AdvertisingCampaignWeekdayEnum.saturday);
            break;
          case entity.WeekDay.sunday:
            weekdays.add(AdvertisingCampaignWeekdayEnum.sunday);
            break;
          case entity.WeekDay.unknown:
            break;
        }
      },
    );

    var discountPrograms = <DiscountProgram>[];
    campaign.discountPrograms?.forEach((element) {
      discountPrograms.add(DiscountProgram(programID: element.programID, discount: element.discount));
    });

    return AdvertisingCampaign(
      id: campaign.id,
      startDate: campaign.startDate.millisecondsSinceEpoch ~/ 1000,
      endDate: campaign.endDate.millisecondsSinceEpoch ~/ 1000,
      enabled: campaign.enabled,
      startMinute: campaign.startMinute,
      endMinute: campaign.endMinute,
      defaultDiscount: campaign.defaultDiscount,
      discountPrograms: discountPrograms,
      weekday: weekdays,
      name: campaign.name,
    );
  }

  static entity.StationConfig stationConfigFromAPI(StationConfig config) {
    return entity.StationConfig(
      id: config.id,
      name: config.name,
      hash: config.hash,
      preflightSec: config.preflightSec,
      relayBoard: entity.RelayBoard.fromString(config.relayBoard?.toString() ?? "") ?? entity.RelayBoard.localGPIO,
    );
  }

  static StationConfig stationConfigToAPI(entity.StationConfig config) {
    RelayBoard? relayBoard;

    switch (config.relayBoard) {
      case entity.RelayBoard.localGPIO:
        relayBoard = RelayBoard.localGPIO;
        break;
      case entity.RelayBoard.danBoard:
        relayBoard = RelayBoard.danBoard;
        break;
    }

    return StationConfig(
      id: config.id,
      name: config.name,
      hash: config.hash,
      relayBoard: relayBoard,
      preflightSec: config.preflightSec,
    );
  }

  static entity.StationCardReaderConfig cardReaderConfigFromAPI(CardReaderConfig config) {
    return entity.StationCardReaderConfig(host: config.host, port: config.port, cardReader: entity.CardReader.fromString(config.cardReaderType?.toString() ?? ""));
  }

  static CardReaderConfig cardReaderConfigToAPI(int id, entity.StationCardReaderConfig config) {
    CardReaderConfigCardReaderTypeEnum? cardReader;

    switch (config.cardReader) {
      case entity.CardReader.vendotek:
        cardReader = CardReaderConfigCardReaderTypeEnum.VENDOTEK;
        break;
      case entity.CardReader.paymentWorld:
        cardReader = CardReaderConfigCardReaderTypeEnum.PAYMENT_WORLD;
        break;
      case entity.CardReader.not_used:
        cardReader = CardReaderConfigCardReaderTypeEnum.NOT_USED;
        break;
    }

    return CardReaderConfig(
      stationID: id,
      host: config.host,
      port: config.port,
      cardReaderType: cardReader,
    );
  }

  static entity.KasseConfig kasseConfigFromAPI(KasseConfig config) {
    return entity.KasseConfig(
      taxType: entity.TaxType.fromString(config.tax?.value ?? ""),
      receiptItemName: config.receiptItemName,
      cashier: config.cashier,
      cashierINN: config.cashierINN,
    );
  }

  static KasseConfig kasseConfigToAPI(entity.KasseConfig config) {
    KasseConfigTaxEnum? taxType;
    switch (config.taxType) {
      case entity.TaxType.vAT110:
        taxType = KasseConfigTaxEnum.vAT110;
        break;
      case entity.TaxType.vAT0:
        taxType = KasseConfigTaxEnum.vAT0;
        break;
      case entity.TaxType.no:
        taxType = KasseConfigTaxEnum.NO;
        break;
      case entity.TaxType.vat120:
        taxType = KasseConfigTaxEnum.vAT120;
        break;
    }

    return KasseConfig(
      tax: taxType,
      receiptItemName: config.receiptItemName,
      cashier: config.cashier,
      cashierINN: config.cashierINN,
    );
  }
}
