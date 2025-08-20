class UserInvitesModel {
  int id;
  Receiver? sender;
  Receiver? receiver;
  Workspace? workspace;
  String status;
  DateTime? expireDate;
  DateTime? createdAt;
  DateTime? updatedAt;
  String errorMessage;

  UserInvitesModel({
    required this.id,
    required this.sender,
    required this.receiver,
    required this.workspace,
    required this.status,
    required this.expireDate,
    required this.createdAt,
    required this.updatedAt,
    required this.errorMessage,
  });

  factory UserInvitesModel.onSuccess(Map<String, dynamic> json) =>
      UserInvitesModel(
        id: json["id"],
        sender: Receiver.fromJson(json["sender"]),
        receiver: Receiver.fromJson(json["receiver"]),
        workspace: Workspace.fromJson(json["workspace"]),
        status: json["status"],
        expireDate: DateTime.parse(json["expire_date"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        errorMessage: '',
      );

  factory UserInvitesModel.onError(Map<String, dynamic> json) =>
      UserInvitesModel(
        id: 0,
        sender: null,
        receiver: null,
        workspace: null,
        status: '',
        expireDate: null,
        createdAt: null,
        updatedAt: null,
        errorMessage: json["detail"] ?? json["message"],
      );

  factory UserInvitesModel.error(String errorMessage) =>
      UserInvitesModel(
        id: 0,
        sender: null,
        receiver: null,
        workspace: null,
        status: '',
        expireDate: null,
        createdAt: null,
        updatedAt: null,
        errorMessage: errorMessage,
      );
}

class Receiver {
  int id;
  String username;

  Receiver({
    required this.id,
    required this.username,
  });

  factory Receiver.fromJson(Map<String, dynamic> json) => Receiver(
        id: json["id"],
        username: json["username"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
      };
}

class Workspace {
  int id;
  String title;

  Workspace({
    required this.id,
    required this.title,
  });

  factory Workspace.fromJson(Map<String, dynamic> json) => Workspace(
        id: json["id"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
      };
}
