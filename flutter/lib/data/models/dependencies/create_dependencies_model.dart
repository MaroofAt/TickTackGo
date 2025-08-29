
class CreateDependencyModel {
  int id;
  int conditionTask;
  int targetTask;
  String type;
  String errorMessage;

  CreateDependencyModel({
    required this.id,
    required this.conditionTask,
    required this.targetTask,
    required this.type,
    required this.errorMessage,
  });

  factory CreateDependencyModel.onSuccess(Map<String, dynamic> json) => CreateDependencyModel(
    id: json["id"],
    conditionTask: json["condition_task"],
    targetTask: json["target_task"],
    type: json["type"],
    errorMessage: ''
  );

  factory CreateDependencyModel.onError(Map<String, dynamic> json) => CreateDependencyModel(
      id: 0,
      conditionTask: 0,
      targetTask: 0,
      type: '',
      errorMessage: json["detail"]??json["message"],
  );

  factory CreateDependencyModel.error(String errorMessage) => CreateDependencyModel(
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
