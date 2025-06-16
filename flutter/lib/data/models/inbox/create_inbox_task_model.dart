class CreateInboxTaskModel {
  int id;
  String title;
  String description;
  int user;
  String status;
  String priority;
  String errorMessage;

  CreateInboxTaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.user,
    required this.status,
    required this.priority,
    required this.errorMessage,
  });

  factory CreateInboxTaskModel.onSuccess(Map<String, dynamic> json) =>
      CreateInboxTaskModel(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        user: json["user"],
        status: json["status"],
        priority: json["priority"],
        errorMessage: '',
      );

  factory CreateInboxTaskModel.onError(Map<String, dynamic> json) =>
      CreateInboxTaskModel(
        id: json["id"] ?? 0,
        title: json["title"] ?? '',
        description: json["description"] ?? '',
        user: json["user"] ?? 0,
        status: json["status"] ?? '',
        priority: json["priority"] ?? '',
        errorMessage: json["detail"] ?? json["message"],
      );

  factory CreateInboxTaskModel.error(String errorMessage) =>
      CreateInboxTaskModel(
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
