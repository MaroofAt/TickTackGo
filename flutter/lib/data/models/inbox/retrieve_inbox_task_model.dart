class RetrieveInboxTaskModel {
  int id;
  String title;
  String description;
  int user;
  String status;
  String priority;
  String errorMessage;

  RetrieveInboxTaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.user,
    required this.status,
    required this.priority,
    required this.errorMessage,
  });

  factory RetrieveInboxTaskModel.onSuccess(Map<String, dynamic> json) =>
      RetrieveInboxTaskModel(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        user: json["user"],
        status: json["status"],
        priority: json["priority"],
        errorMessage: '',
      );

  factory RetrieveInboxTaskModel.onError(Map<String, dynamic> json) =>
      RetrieveInboxTaskModel(
        id: json["id"] ?? 0,
        title: json["title"] ?? '',
        description: json["description"] ?? '',
        user: json["user"] ?? 0,
        status: json["status"] ?? '',
        priority: json["priority"] ?? '',
        errorMessage: json["detail"] ?? json["message"],
      );

  factory RetrieveInboxTaskModel.error(String errorMessage) =>
      RetrieveInboxTaskModel(
        id: 0,
        title: '',
        description: '',
        user: 0,
        status: '',
        priority: '',
        errorMessage: errorMessage,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "user": user,
        "status": status,
        "priority": priority,
      };
}
