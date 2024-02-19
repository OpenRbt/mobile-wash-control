import 'package:mobile_wash_control/openapi/lea-central-wash/api.dart' as lcw;

class Task {
  int id;
  int stationID;
  int? versionID;
  TaskType taskType;
  TaskStatus taskStatus;
  String? error;
  String createdAt;
  String? startedAt;
  String? stoppedAt;

  Task({
    required this.id,
    required this.stationID,
    this.versionID,
    required this.taskType,
    required this.taskStatus,
    this.error,
    required this.createdAt,
    this.startedAt,
    this.stoppedAt,
  });

  Task copyWith({
    int? id,
    int? stationID,
    int? versionID,
    TaskType? taskType,
    TaskStatus? taskStatus,
    String? error,
    String? createdAt,
    String? startedAt,
    String? stoppedAt,
  }) {
    return Task(
      id: id ?? this.id,
      stationID: stationID ?? this.stationID,
      versionID: versionID ?? this.versionID,
      taskType: taskType ?? this.taskType,
      taskStatus: taskStatus ?? this.taskStatus,
      error: error ?? this.error,
      createdAt: createdAt ?? this.createdAt,
      startedAt: startedAt ?? this.startedAt,
      stoppedAt: stoppedAt ?? this.stoppedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'stationID': this.stationID,
      'versionID': this.versionID,
      'taskType': this.taskType,
      'taskStatus': this.taskStatus,
      'error': this.error,
      'createdAt': this.createdAt,
      'startedAt': this.startedAt,
      'stoppedAt': this.stoppedAt,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {

    var taskTypeEnum = map['type'] as lcw.TaskType;
    var taskStatusEnum = map['status'] as lcw.TaskStatus;

    var taskType = convertTaskTypeEnum(taskTypeEnum);
    var taskStatus = convertTaskStatusEnum(taskStatusEnum);

    return Task(
      id: map['id'] as int,
      stationID: map['stationID'] as int,
      versionID: map['versionID'],
      taskType: taskType,
      taskStatus: taskStatus,
      error: map['error'] ?? "",
      createdAt: map['createdAt'] as String,
      startedAt: map['startedAt'] ?? "",
      stoppedAt: map['stoppedAt'] ?? "",
    );
  }

  @override
  String toString() {
    return 'Task{id: $id, stationID: $stationID, versionID: $versionID, taskType: $taskType, taskStatus: $taskStatus, error: $error, createdAt: $createdAt, startedAt: $startedAt, stoppedAt: $stoppedAt}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Task &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          stationID == other.stationID &&
          versionID == other.versionID &&
          taskType == other.taskType &&
          taskStatus == other.taskStatus &&
          error == other.error &&
          createdAt == other.createdAt &&
          startedAt == other.startedAt &&
          stoppedAt == other.stoppedAt;

  @override
  int get hashCode =>
      id.hashCode ^
      stationID.hashCode ^
      versionID.hashCode ^
      taskType.hashCode ^
      taskStatus.hashCode ^
      error.hashCode ^
      createdAt.hashCode ^
      startedAt.hashCode ^
      stoppedAt.hashCode;
}

class TasksPagination {
  List<Task> tasks;
  int page;
  int pageSize;
  int totalPages;
  int totalItems;

  TasksPagination({
    required this.tasks,
    required this.page,
    required this.pageSize,
    required this.totalPages,
    required this.totalItems,
  });

  TasksPagination copyWith({
    List<Task>? tasks,
    int? page,
    int? pageSize,
    int? totalPages,
    int? totalItems,
  }) {
    return TasksPagination(
      tasks: tasks ?? this.tasks,
      page: page ?? this.page,
      pageSize: pageSize ?? this.pageSize,
      totalPages: totalPages ?? this.totalPages,
      totalItems: totalItems ?? this.totalItems,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'tasks': this.tasks,
      'page': this.page,
      'pageSize': this.pageSize,
      'totalPages': this.totalPages,
      'totalItems': this.totalItems,
    };
  }

  factory TasksPagination.fromMap(Map<String, dynamic> map) {
    return TasksPagination(
      tasks: map['tasks'] ?? [],
      page: map['page'] as int,
      pageSize: map['pageSize'] as int,
      totalPages: map['totalPages'] as int,
      totalItems: map['totalItems'] as int,
    );
  }

  @override
  String toString() {
    return 'TasksPagination{tasks: $tasks, page: $page, pageSize: $pageSize, totalPages: $totalPages, totalItems: $totalItems}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TasksPagination &&
          runtimeType == other.runtimeType &&
          tasks == other.tasks &&
          page == other.page &&
          pageSize == other.pageSize &&
          totalPages == other.totalPages &&
          totalItems == other.totalItems;

  @override
  int get hashCode =>
      tasks.hashCode ^
      page.hashCode ^
      pageSize.hashCode ^
      totalPages.hashCode ^
      totalItems.hashCode;
}

class FirmwareVersion {

  int id;
  bool isCurrent;
  String? hashLua;
  String? hashEnv;
  String? hashBinar;
  String? builtAt;
  String? commitedAt;

  FirmwareVersion({
    required this.id,
    required this.isCurrent,
    this.hashLua,
    this.hashEnv,
    this.hashBinar,
    this.builtAt,
    this.commitedAt,
  });

  FirmwareVersion copyWith({
    int? id,
    bool? isCurrent,
    String? hashLua,
    String? hashEnv,
    String? hashBinar,
    String? builtAt,
    String? commitedAt,
  }) {
    return FirmwareVersion(
      id: id ?? this.id,
      isCurrent: isCurrent ?? this.isCurrent,
      hashLua: hashLua ?? this.hashLua,
      hashEnv: hashEnv ?? this.hashEnv,
      hashBinar: hashBinar ?? this.hashBinar,
      builtAt: builtAt ?? this.builtAt,
      commitedAt: commitedAt ?? this.commitedAt,
    );
  }

  @override
  String toString() {
    return 'FirmwareVersion{id: $id, isCurrent: $isCurrent, hashLua: $hashLua, hashEnv: $hashEnv, hashBinar: $hashBinar, builtAt: $builtAt, commitedAt: $commitedAt}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FirmwareVersion &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          isCurrent == other.isCurrent &&
          hashLua == other.hashLua &&
          hashEnv == other.hashEnv &&
          hashBinar == other.hashBinar &&
          builtAt == other.builtAt &&
          commitedAt == other.commitedAt;

  @override
  int get hashCode =>
      id.hashCode ^
      isCurrent.hashCode ^
      hashLua.hashCode ^
      hashEnv.hashCode ^
      hashBinar.hashCode ^
      builtAt.hashCode ^
      commitedAt.hashCode;

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'isCurrent': this.isCurrent,
      'hashLua': this.hashLua,
      'hashEnv': this.hashEnv,
      'hashBinar': this.hashBinar,
      'builtAt': this.builtAt,
      'commitedAt': this.commitedAt,
    };
  }

  factory FirmwareVersion.fromMap(Map<String, dynamic> map) {
    return FirmwareVersion(
      id: map['id'] as int,
      isCurrent: map['isCurrent'] as bool,
      hashLua: map['hashLua'] as String,
      hashEnv: map['hashEnv'] as String,
      hashBinar: map['hashBinar'] as String,
      builtAt: map['builtAt'] as String,
      commitedAt: map['commitedAt'] as String,
    );
  }
}

class Station {
  int id;
  String? name;
  String? hash;
  StationStatus? status;
  int? currentBalance;
  int? currentProgram;
  String? currentProgramName;
  String? ip;
  int? firmwareVersion;

  Station({
    required this.id,
    this.name,
    this.hash,
    this.status,
    this.currentBalance,
    this.currentProgram,
    this.currentProgramName,
    this.ip,
    this.firmwareVersion
  });

  Station copyWith({
    int? id,
    String? name,
    String? hash,
    StationStatus? status,
    int? currentBalance,
    int? currentProgram,
    String? currentProgramName,
    String? ip,
    int? firmwareVersion,
  }) {
    return Station(
      id: id ?? this.id,
      name: name ?? this.name,
      hash: hash ?? this.hash,
      status: status ?? this.status,
      currentBalance: currentBalance ?? this.currentBalance,
      currentProgram: currentProgram ?? this.currentProgram,
      currentProgramName: currentProgramName ?? this.currentProgramName,
      ip: ip ?? this.ip,
      firmwareVersion: firmwareVersion ?? this.firmwareVersion,
    );
  }

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
      status: convertStationStatusEnum(map['status']) ,
      currentBalance: map['currentBalance'],
      currentProgram: map['currentProgram'],
      currentProgramName: map['currentProgramName'],
      ip: map['ip'],
      firmwareVersion: map['firmwareVersion'],
    );
  }

  @override
  String toString() {
    return 'Station{id: $id, name: $name, hash: $hash, status: $status, currentBalance: $currentBalance, currentProgram: $currentProgram, currentProgramName: $currentProgramName, ip: $ip, firmwareVersion: $firmwareVersion}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Station &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          hash == other.hash &&
          status == other.status &&
          currentBalance == other.currentBalance &&
          currentProgram == other.currentProgram &&
          currentProgramName == other.currentProgramName &&
          ip == other.ip &&
          firmwareVersion == other.firmwareVersion;

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      hash.hashCode ^
      status.hashCode ^
      currentBalance.hashCode ^
      currentProgram.hashCode ^
      currentProgramName.hashCode ^
      ip.hashCode ^
      firmwareVersion.hashCode;
}

enum TaskType {
  build,
  update,
  reboot,
  getVersions,
  pullFirmware,
  setVersion
}

enum TaskStatus {
  queue,
  started,
  completed,
  error,
  canceled
}

enum StationStatus {
  offline,
  online,
}

TaskType taskTypeFromString(String taskType) {
  switch (taskType) {
    case 'build':
      return TaskType.build;
    case 'update':
      return TaskType.update;
    case 'reboot':
      return TaskType.reboot;
    case 'getVersions':
      return TaskType.getVersions;
    case 'pullFirmware':
      return TaskType.pullFirmware;
    case 'setVersion':
      return TaskType.setVersion;
    default:
      throw FormatException("Wrong task type in convertTaskTypeEnum");
  }
}

TaskStatus taskStatusFromString(String taskStatus) {
  switch (taskStatus) {
    case 'queue':
      return TaskStatus.queue;
    case 'started':
      return TaskStatus.started;
    case 'completed':
      return TaskStatus.completed;
    case 'error':
      return TaskStatus.error;
    case 'canceled':
      return TaskStatus.canceled;
    default:
      throw FormatException("Wrong task status in convertTaskStatusEnum");
  }
}

TaskType convertTaskTypeEnum(lcw.TaskType? taskType) {
  switch (taskType?.value) {
    case r'build':
      return TaskType.build;
    case r'update':
      return TaskType.update;
    case r'reboot':
      return TaskType.reboot;
    case r'getVersions':
      return TaskType.getVersions;
    case r'pullFirmware':
      return TaskType.pullFirmware;
    case r'setVersion':
      return TaskType.setVersion;
    default:
      throw FormatException("Wrong task type in convertTaskTypeEnum");
  }
}

TaskStatus convertTaskStatusEnum(lcw.TaskStatus? taskStatus) {
  switch (taskStatus?.value) {
    case r'queue':
      return TaskStatus.queue;
    case r'started':
      return TaskStatus.started;
    case r'completed':
      return TaskStatus.completed;
    case r'error':
      return TaskStatus.error;
    case r'canceled':
      return TaskStatus.canceled;
    default:
      throw FormatException("Wrong task status in convertTaskStatusEnum");
  }
}

StationStatus convertStationStatusEnum(lcw.Status? stationStatus) {
  switch (stationStatus?.value) {
    case r'online':
      return StationStatus.online;
    case r'offline':
      return StationStatus.offline;
    default:
      throw FormatException("Wrong task status in convertTaskStatusEnum");
  }
}