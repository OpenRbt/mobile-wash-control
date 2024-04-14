String getTypeName(String type) {
  switch (type) {
    case 'build':
      return 'сборка';
    case 'update':
      return 'обновление';
    case 'reboot':
      return 'перезагрузка';
    case 'getVersions':
      return 'получение версий';
    case 'pullFirmware':
      return 'выгрузка на сервер';
    case 'setVersion':
      return 'смена версии';
    default:
      return '';
  }
}

String getStatusName(String status) {
  switch (status) {
    case 'queue':
      return 'в очереди';
    case 'started':
      return 'начата';
    case 'completed':
      return 'завершена';
    case 'error':
      return 'ошибка';
    case 'canceled':
      return 'отменена';
    default:
      return '';
  }
}