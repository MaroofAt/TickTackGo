// ignore_for_file: public_member_api_docs, sort_constructors_first
class JoinWorkspaceModel {
  String errorMessage;
  JoinWorkspaceModel({
    required this.errorMessage,
  });

  factory JoinWorkspaceModel.onSuccess() => JoinWorkspaceModel(
        errorMessage: '',
      );

  factory JoinWorkspaceModel.onError(Map<String, dynamic> json) => JoinWorkspaceModel(
        errorMessage: json['detail'] ?? json['message'],
      );

  factory JoinWorkspaceModel.error(String errorMessage) => JoinWorkspaceModel(
        errorMessage: errorMessage,
      );
}
