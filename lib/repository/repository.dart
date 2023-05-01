import 'package:flutter/material.dart';
import 'package:mobile_wash_control/entity/entity.dart';

abstract class Repository {
  //Update func handlers
  Future<void> updateStatus({BuildContext? context});
  Future<void> updatePrograms({BuildContext? context});
  Future<void> updateUsers({BuildContext? context});
  Future<void> updateDiscounts({BuildContext? context});

  Future<List<Station>?> getStations();
  Future<Station?> getStation(int id);
  Future<List<StationButton>?> getStationButtons(int id, {BuildContext? context});
  Future<StationMoneyReport?> getStationMoneyReport(int id, {BuildContext? context});

  Future<void> stationSaveCollection(int id, {BuildContext? context});
  Future<void> stationOpenDoor(int id, {BuildContext? context});

  Future<List<Program>?> getPrograms();
  Future<Program?> getProgram(int id, {BuildContext? context});
  Future<void> saveProgram(Program program, {BuildContext? context});
  Program? getCurrentProgram(int id);

  Future<void> addServiceMoney(int id, int amount, {BuildContext? context});

  Future<List<User>?> getUsers();
  Future<User?> getCurrentUser({BuildContext? context});
  Future<void> createUser(User user, String pin, {BuildContext? context});
  Future<void> updateUser(User user, {BuildContext? context});
  Future<void> deleteUser(String login, {BuildContext? context});

  Future<StationMoneyReport?> getStationMoneyReportsByDates(int id, DateTime startDate, DateTime endDate, {BuildContext? context});
  Future<List<StationCollectionReport>?> getStationCollectionReports(int id, DateTime startDate, DateTime endDate);

  Future<List<StationStats>?> getStationsStatsByDates(int id, DateTime startDate, DateTime endDate);
  Future<List<StationStats>?> getStationsStatsCurrent(int id);
  Future<StationStats?> getStationStatsByDates(int id, DateTime startDate, DateTime endDate, {BuildContext? context});
  Future<StationStats?> getStationStatsCurrent(int id, {BuildContext? context});
  Future<void> resetStationStats(int id);

  Future<DiscountCampaign?> getDiscountCampaign(int id, {BuildContext? context});

  ValueNotifier<List<Station>?> getStationsNotifier();
  ValueNotifier<KasseStatus?> getKasseStatusNotifier();
  ValueNotifier<String?> getLCWRepoNotifier();
  ValueNotifier<List<Program>?> getProgramsNotifier();
  ValueNotifier<List<User>?> getUsersNotifier();
  ValueNotifier<List<DiscountCampaign>?> getDiscountsNotifier();
  ValueNotifier<List<String>?> getHashesNotifier();

  Future<String?> getProgramNameFromCache(int id);

  Future<void> saveDiscountCampaign(DiscountCampaign campaign, {BuildContext? context});

  Future<int?> getConfigVarInt(String name, {BuildContext? context});
  Future<String?> getConfigVarString(String name);
  Future<bool?> getConfigVarBool(String name);
  Future<void> setConfigVarInt(String name, int value, {BuildContext? context});
  Future<void> setConfigVarString(String name, String value);
  Future<void> setConfigVarBool(String name, bool value);

  Future<String?> getStationTemperature(int id);

  Future<StationConfig?> getStationConfig(int id, {BuildContext? context});
  Future<void> saveStationConfig(StationConfig config, {BuildContext? context});

  Future<StationCardReaderConfig?> getCardReaderConfig(int id, {BuildContext? context});
  Future<void> saveCardReaderConfig(int id, StationCardReaderConfig config, {BuildContext? context});

  Future<void> saveStationButtons(int id, List<StationButton> buttons, {BuildContext? context});
  Future<void> deleteDiscountCampaign(int id, {BuildContext? context});

  Future<KasseConfig?> getKasseConfig({BuildContext? context});
  Future<void> saveKasseConfig(KasseConfig config, {BuildContext? context});

  void dispose();
}
