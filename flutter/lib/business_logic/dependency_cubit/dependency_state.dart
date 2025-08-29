part of 'dependency_cubit.dart';

@immutable
sealed class DependencyState {}

final class DependencyInitial extends DependencyState {}

class CreatingDependencyState extends DependencyState {}

class CreatingDependencySucceededState extends DependencyState {
  CreateDependencyModel createDependencyModel;

  CreatingDependencySucceededState(this.createDependencyModel);
}

class CreatingDependencyFailedState extends DependencyState {
  String errorMessage;

  CreatingDependencyFailedState(this.errorMessage);
}

class DeletingDependencyState extends DependencyState {}

class DeletingDependencySucceededState extends DependencyState {
  DeleteDependencyModel deleteDependencyModel;

  DeletingDependencySucceededState(this.deleteDependencyModel);
}

class DeletingDependencyFailedState extends DependencyState {
  String errorMessage;

  DeletingDependencyFailedState(this.errorMessage);
}

