
class FetchDependenciesModel {
  int id;
  int conditionTask;
  int targetTask;
  String type;
  String errorMessage;

  FetchDependenciesModel({
    required this.id,
    required this.conditionTask,
    required this.targetTask,
    required this.type,
    required this.errorMessage,
  });


  factory FetchDependenciesModel.onSuccess(Map<String, dynamic> json) => FetchDependenciesModel(
    id: json["id"],
    conditionTask: json["condition_task"],
    targetTask: json["target_task"],
    type: json["type"],
    errorMessage: '',
  );

  factory FetchDependenciesModel.onError(Map<String, dynamic> json) => FetchDependenciesModel(
    id: 0,
    conditionTask: 0,
    targetTask: 0,
    type: '',
    errorMessage: json["detail"]??json["message"],
  );

  factory FetchDependenciesModel.error(String errorMessage) => FetchDependenciesModel(
    id: 0,
    conditionTask: 0,
    targetTask: 0,
    type: '',
    errorMessage: errorMessage,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "condition_task": conditionTask,
    "target_task": targetTask,
    "type": type,
  };
}
