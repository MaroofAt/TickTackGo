class CompleteTaskModel {
  String errorMessage;

  CompleteTaskModel({required this.errorMessage});

  factory CompleteTaskModel.onSuccess() => CompleteTaskModel(errorMessage: '');

  factory CompleteTaskModel.onError(Map<String, dynamic> json) =>
      CompleteTaskModel(errorMessage: json["detail"]??json["message"]);

  factory CompleteTaskModel.error(String errorMessage) =>
      CompleteTaskModel(errorMessage: errorMessage);


}
