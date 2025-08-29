import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pr1/core/API/dependencies.dart';
import 'package:pr1/core/variables/global_var.dart';
import 'package:pr1/data/models/dependencies/create_dependencies_model.dart';
import 'package:pr1/presentation/screen/dependencies/create_dependency.dart';
import 'package:pr1/presentation/screen/dependencies/delete_dependency_model.dart';

part 'dependency_state.dart';

class DependencyCubit extends Cubit<DependencyState> {
  DependencyCubit() : super(DependencyInitial());

  Future<void> createDependency(
      int conditionTaskId, int targetTaskId, String type) async {
    emit(CreatingDependencyState());

    CreateDependencyModel createDependencyModel =
        await DependenciesApi.createDependency(
      conditionTaskId,
      targetTaskId,
      type,
      token,
    );

    if (createDependencyModel.errorMessage.isEmpty) {
      emit(CreatingDependencySucceededState(createDependencyModel));
    } else {
      emit(CreatingDependencyFailedState(createDependencyModel.errorMessage));
    }
  }

  Future<void> deleteDependency(int dependencyId) async {
    emit(DeletingDependencyState());

    DeleteDependencyModel deleteDependencyModel =
    await DependenciesApi.deleteDependency(
      dependencyId,
      token,
    );

    if (deleteDependencyModel.errorMessage.isEmpty) {
      emit(DeletingDependencySucceededState(deleteDependencyModel));
    } else {
      emit(DeletingDependencyFailedState(deleteDependencyModel.errorMessage));
    }
  }

}
