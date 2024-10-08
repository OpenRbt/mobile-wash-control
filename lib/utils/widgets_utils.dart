import 'package:easy_localization/easy_localization.dart';

String getTypeName(String type) {
  switch (type) {
    case 'build':
      return 'build_noun'.tr();
    case 'update':
      return 'update_noun'.tr();
    case 'reboot':
      return 'reboot_noun'.tr();
    case 'getVersions':
      return 'get_versions_noun'.tr();
    case 'pullFirmware':
      return 'server_uploading'.tr();
    case 'setVersion':
      return 'set_version_noun'.tr();
    default:
      return '';
  }
}

String getStatusName(String status) {
  switch (status) {
    case 'queue':
      return 'in_queue'.tr();
    case 'started':
      return 'started'.tr();
    case 'completed':
      return 'completed'.tr();
    case 'error':
      return 'error'.tr();
    case 'canceled':
      return 'canceled'.tr();
    default:
      return '';
  }
}