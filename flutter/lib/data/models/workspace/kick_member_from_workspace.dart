class KickMemberFromWorkspaceModel {
  String errorMessage;

  KickMemberFromWorkspaceModel({
    required this.errorMessage,
  });

  factory KickMemberFromWorkspaceModel.onSuccess() =>
      KickMemberFromWorkspaceModel(errorMessage: '');

  factory KickMemberFromWorkspaceModel.onError(Map<String, dynamic> json) =>
      KickMemberFromWorkspaceModel(errorMessage: json["detail"]);

  factory KickMemberFromWorkspaceModel.error(String errorMessage) =>
      KickMemberFromWorkspaceModel(errorMessage: errorMessage);
}
