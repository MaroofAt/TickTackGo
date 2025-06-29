class DeleteProjectModel {
  String errorMessage;

  DeleteProjectModel({
    required this.errorMessage,
  });

  factory DeleteProjectModel.onSuccess() => DeleteProjectModel(
        errorMessage: '',
      );

  factory DeleteProjectModel.onError(Map<String, dynamic> json) =>
      DeleteProjectModel(
        errorMessage: json["detail"],
      );

  factory DeleteProjectModel.error(String errorMessage) => DeleteProjectModel(
        errorMessage: errorMessage,
      );
}
