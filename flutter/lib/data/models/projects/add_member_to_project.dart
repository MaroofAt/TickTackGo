class AddMemberToProjectModel {
  int member;
  int project;
  String role;
  DateTime? createdAt;
  DateTime? updatedAt;
  String errorMessage;

  AddMemberToProjectModel({
    required this.member,
    required this.project,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
    required this.errorMessage,
  });

  factory AddMemberToProjectModel.onSuccess(Map<String, dynamic> json) =>
      AddMemberToProjectModel(
        member: json["member"],
        project: json["project"],
        role: json["role"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        errorMessage: '',
      );

  factory AddMemberToProjectModel.onError(Map<String, dynamic> json) =>
      AddMemberToProjectModel(
        member: json["member"] ?? 0,
        project: json["project"] ?? 0,
        role: json["role"] ?? '',
        createdAt: null,
        updatedAt: null,
        errorMessage: json["detail"] ?? json["message"],
      );

  factory AddMemberToProjectModel.error(String errorMessage) =>
      AddMemberToProjectModel(
        member: 0,
        project: 0,
        role: '',
        createdAt: null,
        updatedAt: null,
        errorMessage: errorMessage,
      );
}
