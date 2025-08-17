class DeleteWorkspaceModel {
  String errorMessage;

  DeleteWorkspaceModel({required this.errorMessage});

  factory DeleteWorkspaceModel.onSuccess() => DeleteWorkspaceModel(
        errorMessage: '',
      );

  factory DeleteWorkspaceModel.onError(Map<String, dynamic> json) =>
      DeleteWorkspaceModel(
        errorMessage: json["detail"],
      );

  factory DeleteWorkspaceModel.error(String errorMessage) =>
      DeleteWorkspaceModel(
        errorMessage: errorMessage,
      );
}
