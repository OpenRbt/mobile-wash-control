import 'package:bloc/bloc.dart';
import 'package:mobile_wash_control/domain/entities/lcw_enteties.dart';
import 'package:mobile_wash_control/domain/entities/pages_entities.dart';

import '../data_providers/lcw_transport.dart';

class TasksPageState {
  TasksPageEntity tasksPageEntity;

  TasksPageState({
    required this.tasksPageEntity,
  });

  TasksPageState copyWith({
    TasksPageEntity? tasksPageEntity,
  }) {
    return TasksPageState(
      tasksPageEntity: tasksPageEntity ?? this.tasksPageEntity,
    );
  }

  @override
  String toString() {
    return 'TasksPageState{tasksPageEntity: $tasksPageEntity}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TasksPageState &&
          runtimeType == other.runtimeType &&
          tasksPageEntity == other.tasksPageEntity;

  @override
  int get hashCode => tasksPageEntity.hashCode;
}

class TasksPageCubit extends Cubit<TasksPageState> {

  TasksPageCubit() : super(
      TasksPageState(
          tasksPageEntity: TasksPageEntity(
            tasksPagination: TasksPagination(
              tasks: [],
              page: 1,
              pageSize: 10,
              totalPages: 0,
              totalItems: 0,
            ),
            typeFilter: {
              TaskType.build: false,
              TaskType.update: false,
              TaskType.reboot: false,
              TaskType.getVersions: false,
              TaskType.pullFirmware: false,
              TaskType.setVersion: false,
            },
            statusFilter: {
              TaskStatus.queue: false,
              TaskStatus.started: false,
              TaskStatus.completed: false,
              TaskStatus.error: false,
              TaskStatus.canceled: false,
            },
            stationFilter: [],
            sorted: false
          )
      )
  ) {
    _initialize();
  }

  Future<void> _initialize() async {
    await getTasks();
  }

  Future<void> goToPage(int page) async {
    final tasksPagination = await LcwTransport.getTasksPage(
        state.tasksPageEntity.copyWith(
            tasksPagination: state.tasksPageEntity.tasksPagination.copyWith(page: page)
        )
    );

    final tasksPageEntity = state.tasksPageEntity.copyWith(tasksPagination: tasksPagination);
    final newState = state.copyWith(tasksPageEntity: tasksPageEntity);

    emit(newState);
  }

  void changeTypeFilter (TaskType key, bool value) {
    final filter = state.tasksPageEntity.typeFilter;
    filter[key] = value;

    Map<TaskType, bool> newFilterState = Map();
    newFilterState.addAll(filter);

    final tasksPageEntity = state.tasksPageEntity.copyWith(typeFilter: newFilterState);
    final newState = state.copyWith(tasksPageEntity: tasksPageEntity);

    emit(newState);
  }

  void changeStatusFilter (TaskStatus key, bool value) {
    final filter = state.tasksPageEntity.statusFilter;
    filter[key] = value;

    Map<TaskStatus, bool> newFilterState = Map();
    newFilterState.addAll(filter);

    final tasksPageEntity = state.tasksPageEntity.copyWith(statusFilter: newFilterState);
    final newState = state.copyWith(tasksPageEntity: tasksPageEntity);

    emit(newState);
  }

  Future<void> changeSort() async {
    final sorted = !state.tasksPageEntity.sorted;
    final tasksPageEntity = state.tasksPageEntity.copyWith(sorted: sorted);
    final newState = state.copyWith(tasksPageEntity: tasksPageEntity);
    emit(newState);

    await getTasks();

  }

  Future<void> getTasks() async {
    final tasksPagination = await LcwTransport.getTasksPage(state.tasksPageEntity);
    final tasksPageEntity = state.tasksPageEntity.copyWith(tasksPagination: tasksPagination);
    final newState = state.copyWith(tasksPageEntity: tasksPageEntity);

    emit(newState);
  }

}