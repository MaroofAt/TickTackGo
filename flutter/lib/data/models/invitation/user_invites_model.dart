class UserInvitesModel {
  int id;
  Sender? sender;
  int receiver;
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
        sender: Sender.fromJson(json["sender"]),
        receiver: json["receiver"] ?? 0,
        workspace: Workspace.fromJson(json["workspace"]),
        status: json["status"] ?? '',
        expireDate: DateTime.parse(json["expire_date"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        errorMessage: '',
      );

  factory UserInvitesModel.onError(Map<String, dynamic> json) =>
      UserInvitesModel(
        id: json["id"] ?? 0,
        sender: Sender.fromJson(json["sender"]),
        receiver: json["receiver"],
        workspace: Workspace.fromJson(json["workspace"]),
        status: json["status"],
        expireDate: DateTime.parse(json["expire_date"] ?? ''),
        createdAt: DateTime.parse(json["created_at"] ?? ''),
        updatedAt: DateTime.parse(json["updated_at"] ?? ''),
        errorMessage: json["detail"],
      );

  factory UserInvitesModel.error(String errorMessage) => UserInvitesModel(
        id: 0,
        sender: null,
        receiver: 0,
        workspace: null,
        status: '',
        expireDate: null,
        createdAt: null,
        updatedAt: null,
        errorMessage: errorMessage,
      );
}

class Sender {
  int? id;
  String? username;

  Sender({
    required this.id,
    required this.username,
  });

  factory Sender.fromJson(Map<String, dynamic> json) => Sender(
        id: json["id"],
        username: json["username"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
      };
}

class Workspace {
  int? id;
  String? title;

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
