class CreateTaskModel {
  Data? data;
  Result? result;
  String errorMessage;

  CreateTaskModel({
    required this.data,
    required this.result,
    required this.errorMessage,
  });

  factory CreateTaskModel.onSuccess(Map<String, dynamic> json) =>
      CreateTaskModel(
        data: Data.fromJson(json["data"]),
        result: null,
        errorMessage: '',
      );

  factory CreateTaskModel.onError(Map<String, dynamic> json) => CreateTaskModel(
        data: null,
        result: null,
        errorMessage: json["detail"] ?? json["message"],
      );

  factory CreateTaskModel.error(String errorMessage) => CreateTaskModel(
    data: null,
    result: null,
    errorMessage: errorMessage,
  );
}

class Data {
  int id;
  String title;
  String description;
  DateTime startDate;
  DateTime dueDate;
  dynamic completeDate;
  int creator;
  int workspace;
  int project;
  dynamic image;
  bool outDated;
  dynamic parentTask;
  List<dynamic> assignees;
  String status;
  String priority;
  bool locked;
  dynamic reminder;
  String statusMessage;

  Data({
    required this.id,
    required this.title,
    required this.description,
    required this.startDate,
    required this.dueDate,
    required this.completeDate,
    required this.creator,
    required this.workspace,
    required this.project,
    required this.image,
    required this.outDated,
    required this.parentTask,
    required this.assignees,
    required this.status,
    required this.priority,
    required this.locked,
    required this.reminder,
    required this.statusMessage,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        startDate: DateTime.parse(json["start_date"]),
        dueDate: DateTime.parse(json["due_date"]),
        completeDate: json["complete_date"],
        creator: json["creator"],
        workspace: json["workspace"],
        project: json["project"],
        image: json["image"],
        outDated: json["out_dated"],
        parentTask: json["parent_task"],
        assignees: List<dynamic>.from(json["assignees_display"].map((x) => x)),
        status: json["status"],
        priority: json["priority"],
        locked: json["locked"],
        reminder: json["reminder"],
        statusMessage: json["status_message"],
      );

}

class Result {
  bool success;
  String? error;
  String details;

  Result({
    required this.success,
    required this.error,
    required this.details,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        success: json["success"],
        error: json["error"],
        details: json["details"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "error": error,
        "details": details,
      };
}
