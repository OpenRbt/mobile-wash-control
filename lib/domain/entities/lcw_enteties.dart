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