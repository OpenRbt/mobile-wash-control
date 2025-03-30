import 'package:android_intent_plus/android_intent.dart';
//import 'package:open_file/open_file.dart';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:mobile_wash_control/domain/entities/lcw_entities.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../presentation/widgets/dialogs/permission_dialog.dart';
import '../../repository/repository.dart';
import '../../utils/utils.dart';
import '../data_providers/external_transport.dart';
import '../data_providers/lcw_transport.dart';
import '../entities/pages_entities.dart';

class UpdatesPageState {
  final UpdatesPageEntity updatesPageEntity;

  const UpdatesPageState({
    required this.updatesPageEntity,
  });

  UpdatesPageState copyWith({
    UpdatesPageEntity? updatesPageEntity,
  }) {
    return UpdatesPageState(
      updatesPageEntity: updatesPageEntity ?? this.updatesPageEntity,
    );
  }

  @override
  String toString() {
    return 'UpdatesPageState{updatesPageEntity: $updatesPageEntity}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UpdatesPageState &&
          runtimeType == other.runtimeType &&
          updatesPageEntity == other.updatesPageEntity;

  @override
  int get hashCode => updatesPageEntity.hashCode;
}

class UpdatesPageCubit extends Cubit<UpdatesPageState> {

  UpdatesPageCubit(Repository repository) : super(
      UpdatesPageState(
          updatesPageEntity: UpdatesPageEntity(
              stations: [],
              currentApplicationVersion: '',
              availableApplicationVersion: '',
              downloadUrl: '',
              isDownloadBlocked: true,
            isDownloading: false
          )
      )
  ) {
    _initialize(repository);
  }

  Future<void> _initialize(Repository repository) async {

    final stations = await LcwTransport.getStations();
    List<Station> filteredStations = stations.where((station) => (station.hash?.isNotEmpty ?? false) && (station.ip?.isNotEmpty ?? false)).toList();

    final updateData = await checkLatestRelease(Platform.isAndroid);

    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String currentVersion = packageInfo.version;

    bool isDownloadBlocked = !versionIsGreater(
        version1: updateData['latestVersion'] ?? '',
        version2: currentVersion
    );

    String downloadUrl = updateData['downloadUrl'] ?? '';

    emit(
      state.copyWith(
        updatesPageEntity: state.updatesPageEntity.copyWith(
            stations: filteredStations,
            isDownloadBlocked: isDownloadBlocked,
            availableApplicationVersion: updateData['latestVersion'],
            downloadUrl: downloadUrl,
            currentApplicationVersion: currentVersion
        )
      )
    );
  }

  Future<void> getStations() async {
    final stations = await LcwTransport.getStations();
    List<Station> filteredStations = stations.where((station) => (station.hash?.isNotEmpty ?? false) && (station.ip?.isNotEmpty ?? false)).toList();

    emit(
        state.copyWith(
            updatesPageEntity: state.updatesPageEntity.copyWith(
                stations: filteredStations,
            )
        )
    );
  }

  Future<void> updateMobileApplication(BuildContext context) async {

    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String packageName = packageInfo.packageName;

    final status = await Permission.requestInstallPackages.status;

    if(status == PermissionStatus.denied) {

      permissionDialog(
          context: context,
          givePermission: () async {
            AndroidIntent permissionIntent = AndroidIntent(
              action: 'android.settings.MANAGE_UNKNOWN_APP_SOURCES',
              data: 'package:$packageName',
            );
            await permissionIntent.launch();
          }
      );

    } else if (status == PermissionStatus.granted) {

      emit(
          state.copyWith(
              updatesPageEntity: state.updatesPageEntity.copyWith(
                isDownloading: true
              )
          )
      );

      String fileName = 'update.apk';
      final downloadUrl = state.updatesPageEntity.downloadUrl;
      await downloadFile(downloadUrl, fileName);

      String dir = (await getExternalStorageDirectory())?.path ?? '';
      File file = File('$dir/$fileName');
      //OpenFile.open(file.path, type: "application/vnd.android.package-archive");
    }

    emit(
        state.copyWith(
            updatesPageEntity: state.updatesPageEntity.copyWith(
                isDownloading: false
            )
        )
    );

  }

  Future<void> updateDesktopApplication() async {
    final downloadUrl = state.updatesPageEntity.downloadUrl;
    await launchUrl(Uri.parse(downloadUrl));
  }

}