import 'package:flutter/material.dart';
import 'package:mobile_wash_control/entity/entity.dart';

abstract class Repository {
  //Update func handlers
  Future<void> updateStatus();
  Future<void> updatePrograms();
  Future<void> updateUsers();
  Future<void> updateDiscounts();

  Future<List<Station>?> getStations();
  Future<Station?> getStation(int id);
  Future<List<StationButton>?> getStationButtons(int id);
  Future<StationMoneyReport?> getStationMoneyReport(int id);

  Future<void> stationSaveCollection(int id);
  Future<void> stationOpenDoor(int id);

  Future<List<Program>?> getPrograms();
  Future<Program?> getProgram(int id);
  Future<void> saveProgram(Program program);
  Program? getCurrentProgram(int id);

  Future<void> addServiceMoney(int id, int amount);

  Future<List<User>?> getUsers();
  Future<User?> getCurrentUser();
  Future<void> createUser(User user, String pin);
  Future<void> updateUser(User user);
  Future<void> deleteUser(String login);

  Future<StationMoneyReport?> getStationMoneyReportsByDates(int id, DateTime startDate, DateTime endDate);
  Future<List<StationCollectionReport>?> getStationCollectionReports(int id, DateTime startDate, DateTime endDate);

  Future<List<StationStats>?> getStationsStatsByDates(int id, DateTime startDate, DateTime endDate);
  Future<List<StationStats>?> getStationsStatsCurrent(int id);
  Future<StationStats?> getStationStatsByDates(int id, DateTime startDate, DateTime endDate);
  Future<StationStats?> getStationStatsCurrent(int id);
  Future<void> resetStationStats(int id);

  Future<DiscountCampaign?> getDiscountCampaign(int id);

  ValueNotifier<List<Station>?> getStationsNotifier();
  ValueNotifier<KasseStatus?> getKasseStatusNotifier();
  ValueNotifier<String?> getLCWRepoNotifier();
  ValueNotifier<List<Program>?> getProgramsNotifier();
  ValueNotifier<List<User>?> getUsersNotifier();
  ValueNotifier<List<DiscountCampaign>?> getDiscountsNotifier();
  ValueNotifier<List<String>?> getHashesNotifier();

  Future<String?> getProgramNameFromCache(int id);

  Future<void> saveDiscountCampaign(DiscountCampaign campaign);

  Future<int?> getConfigVarInt(String name);
  Future<String?> getConfigVarString(String name);
  Future<bool?> getConfigVarBool(String name);
  Future<void> setConfigVarInt(String name, int value);
  Future<void> setConfigVarString(String name, String value);
  Future<void> setConfigVarBool(String name, bool value);

  Future<String?> getStationTemperature(int id);

  Future<StationConfig?> getStationConfig(int id);
  Future<void> saveStationConfig(StationConfig config);

  Future<StationCardReaderConfig?> getCardReaderConfig(int id);
  Future<void> saveCardReaderConfig(int id, StationCardReaderConfig config);

  Future<void> saveStationButtons(int id, List<StationButton> buttons);
  Future<void> deleteDiscountCampaign(int id);

  Future<KasseConfig?> getKasseConfig();
  Future<void> saveKasseConfig(KasseConfig config);

  void dispose();
}
