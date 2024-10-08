import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobile_wash_control/domain/entities/lcw_entities.dart';
import 'package:mobile_wash_control/domain/entities/pages_entities.dart';

import '../../mobile/widgets/common/snackBars.dart';
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

  TasksPageCubit({required BuildContext context}) : super(
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
    _initialize(context);
  }

  Future<void> _initialize(BuildContext context) async {
    try {
      await getTasks();
    } on FormatException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${'error_has_occurred'.tr()} $e"));
      rethrow;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${'unknown_error_has_occurred'.tr()} $e"));
      rethrow;
    }
  }

  Future<void> goToPage(int page) async {
    try {
      final tasksPagination = await LcwTransport.getTasksPage(
          state.tasksPageEntity.copyWith(
              tasksPagination: state.tasksPageEntity.tasksPagination.copyWith(page: page)
          )
      );

      final tasksPageEntity = state.tasksPageEntity.copyWith(tasksPagination: tasksPagination);
      final newState = state.copyWith(tasksPageEntity: tasksPageEntity);

      emit(newState);
    } on FormatException catch (e) {
      rethrow;
    } catch (e) {
      rethrow;
    }
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
    try {
      final sorted = !state.tasksPageEntity.sorted;
      final tasksPageEntity = state.tasksPageEntity.copyWith(sorted: sorted);
      final newState = state.copyWith(tasksPageEntity: tasksPageEntity);
      emit(newState);

      await getTasks();
    } on FormatException catch (e) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> getTasks() async {
    try {
      final tasksPagination = await LcwTransport.getTasksPage(state.tasksPageEntity);
      final tasksPageEntity = state.tasksPageEntity.copyWith(tasksPagination: tasksPagination);
      final newState = state.copyWith(tasksPageEntity: tasksPageEntity);

      emit(newState);
    } on FormatException catch (e) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

}