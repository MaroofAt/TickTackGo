class DeleteDependencyModel {
  String errorMessage;

  DeleteDependencyModel({required this.errorMessage});

  factory DeleteDependencyModel.onSuccess() => DeleteDependencyModel(
        errorMessage: '',
      );

  factory DeleteDependencyModel.onError(Map<String, dynamic> json) => DeleteDependencyModel(
    errorMessage: json["detail"],
  );

  factory DeleteDependencyModel.error(String errorMessage) => DeleteDependencyModel(
    errorMessage: errorMessage,
  );
}
