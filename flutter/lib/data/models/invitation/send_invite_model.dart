class SendInviteModel {
  int id;
  int sender;
  int receiver;
  int workspace;
  String status;
  DateTime? expireDate;
  DateTime? createdAt;
  DateTime? updatedAt;
  String errorMessage;

  SendInviteModel({
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

  factory SendInviteModel.onSuccess(Map<String, dynamic> json) =>
      SendInviteModel(
        id: json["id"],
        sender: json["sender"],
        receiver: json["receiver"],
        workspace: json["workspace"],
        status: json["status"],
        expireDate: DateTime.parse(json["expire_date"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        errorMessage: '',
      );

  factory SendInviteModel.onError(Map<String, dynamic> json) => SendInviteModel(
        id: json["id"] ?? 0,
        sender: json["sender"] ?? 0,
        receiver: json["receiver"] ?? 0,
        workspace: json["workspace"] ?? 0,
        status: json["status"] ?? '',
        expireDate: DateTime.parse(json["expire_date"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        errorMessage: json["detail"] ?? json["message"],
      );

  factory SendInviteModel.error(String errorMessage) => SendInviteModel(
    id: 0,
    sender: 0,
    receiver: 0,
    workspace: 0,
    status: '',
    expireDate: null,
    createdAt: null,
    updatedAt: null,
    errorMessage: errorMessage,
  );

}
