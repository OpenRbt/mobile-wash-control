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
            typeFilter: [],
            statusFilter: [],
            stationFilter: [],
            sorted: false
          )
      )
  ) {
    _initialize();
  }

  Future<void> _initialize() async {

    final tasksPagination = await LcwTransport.getTasksPage(state.tasksPageEntity);
    final tasksPageEntity = state.tasksPageEntity.copyWith(tasksPagination: tasksPagination);
    final newState = state.copyWith(tasksPageEntity: tasksPageEntity);

    emit(newState);
  }

}