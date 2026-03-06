import 'package:flutter/material.dart';
import 'package:mobile_wash_control/entity/entity.dart';

abstract class Repository {
  //Update func handlers
  Future<void> updateStatus({BuildContext? context});
  Future<void> updateOrganizations({BuildContext? context});
  Future<void> updatePrograms({BuildContext? context});
  Future<void> updateUsers({BuildContext? context});
  Future<void> updateDiscounts({BuildContext? context});

  Future<List<Station>?> getStations();
  Future<Station?> getStation(int id);
  Future<List<StationButton>?> getStationButtons(
    int id, {
    BuildContext? context,
  });
  Future<StationMoneyReport?> getStationMoneyReport(
    int id, {
    BuildContext? context,
  });

  Future<void> stationSaveCollection(int id, {BuildContext? context});
  Future<void> stationOpenDoor(int id, {BuildContext? context});

  Future<List<Program>?> getPrograms();
  Future<Program?> getProgram(int id, {BuildContext? context});
  Future<void> saveProgram(Program program, {BuildContext? context});
  Program? getCurrentProgram(int id);

  Future<bool> addServiceMoney(int id, int amount, {BuildContext? context, bool showMessage});
  Future<String?> getCommonTemperature({BuildContext? context});
  Future<List<User>?> getUsers();
  Future<String?> getServerInfo({BuildContext? context});
  Future<User?> getCurrentUser({BuildContext? context});
  Future<void> createUser(User user, String pin, {BuildContext? context});
  Future<void> updateUser(User user, {BuildContext? context});
  Future<void> updateUserPassword(
    User user,
    User currentUser,
    String oldPassword,
    String newPassword, {
    BuildContext? context,
  });
  Future<void> deleteUser(String login, {BuildContext? context});

  Future<StationMoneyReport?> getStationMoneyReportByDates(
    int id,
    DateTime startDate,
    DateTime endDate, {
    BuildContext? context,
  });
  Future<List<StationCollectionReport>?> getStationCollectionReports(
    int id,
    DateTime startDate,
    DateTime endDate,
  );

  Future<List<StationStats>?> getStationsStatsByDates(
    int id,
    DateTime startDate,
    DateTime endDate,
  );
  Future<List<StationStats>?> getStationsStatsCurrent(int id);

  Future<StationStats?> getStationStatsByDates(
    int id,
    DateTime startDate,
    DateTime endDate, {
    BuildContext? context,
  });
  Future<StationStats?> getStationStatsCurrent(int id, {BuildContext? context});

  Future<List<StationStats>> getAllStationStatsByDates(
    DateTime startDate,
    DateTime endDate, {
    BuildContext? context,
  });
  Future<List<StationStats>> getAllStationStatsCurrent({BuildContext? context});

  Future<void> resetStationStats(int id, {BuildContext? context});

  Future<DiscountCampaign?> getDiscountCampaign(
    int id, {
    BuildContext? context,
  });

  ValueNotifier<List<Station>?> getStationsNotifier();
  ValueNotifier<List<Organization>?> getOrganizationsNotifier();
  ValueNotifier<KasseStatus?> getKasseStatusNotifier();
  ValueNotifier<ServiceStatus?> getBonusStatusNotifier();
  ValueNotifier<ServiceStatus?> getSbpStatusNotifier();
  ValueNotifier<String?> getLCWRepoNotifier();
  ValueNotifier<List<Program>?> getProgramsNotifier();
  ValueNotifier<List<User>?> getUsersNotifier();
  ValueNotifier<List<DiscountCampaign>?> getDiscountsNotifier();
  ValueNotifier<List<String>?> getHashesNotifier();

  Future<String?> getProgramNameFromCache(int id);

  Future<void> saveDiscountCampaign(
    DiscountCampaign campaign, {
    BuildContext? context,
  });

  Future<int?> getConfigVarInt(String name, {BuildContext? context});
  Future<String?> getConfigVarString(String name);
  Future<bool?> getConfigVarBool(String name);
  Future<void> setConfigVarInt(String name, int value, {BuildContext? context});
  Future<void> setConfigVarString(String name, String value);
  Future<void> deleteConfigVarString(String name, String value);
  Future<void> setConfigVarBool(String name, bool value);

  Future<int?> getStationConfigVarInt(int stationID, String name, {BuildContext? context});
  Future<void> setStationConfigVarInt(int stationID, String name, int value, {BuildContext? context});
  Future<Map<String, String>?> listStationConfigVarInt(int stationID, {BuildContext? context});

  Future<bool?> getStationConfigVarBool(int stationID, String name, {BuildContext? context});
  Future<void> setStationConfigVarBool(int stationID, String name, bool value, {BuildContext? context});
  Future<Map<String, bool>?> listStationConfigVarBool(int stationID, {BuildContext? context});

  Future<String?> getStationConfigVarString(int stationID, String name, {BuildContext? context});
  Future<void> setStationConfigVarString(int stationID, String name, String value, {BuildContext? context});
  Future<Map<String, String>?> listStationConfigVarString(int stationID, {BuildContext? context});

  Future<String?> getStationTemperature(int id, {BuildContext? context});

  Future<StationConfig?> getStationConfig(int id, {BuildContext? context});
  Future<void> saveStationConfig(StationConfig config, {BuildContext? context});

  Future<StationCardReaderConfig?> getCardReaderConfig(
    int id, {
    BuildContext? context,
  });
  Future<void> saveCardReaderConfig(
    int id,
    StationCardReaderConfig config, {
    BuildContext? context,
  });

  Future<void> saveStationButtons(
    int id,
    List<StationButton> buttons, {
    BuildContext? context,
  });
  Future<void> deleteDiscountCampaign(int id, {BuildContext? context});

  Future<KasseConfig?> getKasseConfig({BuildContext? context});
  Future<void> saveKasseConfig(KasseConfig config, {BuildContext? context});

  Future<List<FirmwareVersion>?> getPostVersions(
    int id, {
    BuildContext? context,
  });
  Future<void> getServerVersions({BuildContext? context});
  Future<void> getApplicationVersions({BuildContext? context});

  Future<BuildScript?> getCurrentBuildScript(int id, {BuildContext? context});
  Future<void> setCurrentBuildScript(
    int id, {
    BuildContext? context,
    required String name,
    required List<String> commands,
    int? copyFrom,
  });

  User? currentUser();

  void dispose();

  Future<void> runProgram(RunProgramConfig cfg, {BuildContext? context});

  Future<List<StationMoneyReport>> lastCollectionReportsStats({
    BuildContext? context,
  });

  // Skins
  Future<List<SkinInfo>> listSkins({BuildContext? context});
  Future<void> uploadSkin(String name, List<int> zipBytes, {BuildContext? context});
  Future<void> deleteSkin(String name, {BuildContext? context});
  Future<List<int>> downloadSkin(String name, {BuildContext? context});

  // Skin editor
  Future<List<SkinFileInfo>> getSkinManifest(String name, {BuildContext? context});
  Future<List<int>> getSkinFile(String name, String path, {BuildContext? context});
  Future<void> uploadSkinFile(String name, String path, List<int> bytes, {BuildContext? context});
}
