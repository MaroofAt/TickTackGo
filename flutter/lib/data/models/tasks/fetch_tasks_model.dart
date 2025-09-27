class FetchTasksModel {
  int id;
  String title;
  String description;
  DateTime? startDate;
  DateTime? dueDate;
  dynamic completeDate;
  int creator;
  int workspace;
  int project;
  String image;
  bool outDated;
  dynamic parentTask;
  List<String> assignees;
  String status;
  String priority;
  bool locked;
  dynamic reminder;
  List<SubTask> subTasks;
  String statusMessage;
  List<AttachmentsDisplayModel> attachments;
  String errorMessage;

  FetchTasksModel({
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
    required this.subTasks,
    required this.statusMessage,
    required this.attachments,
    required this.errorMessage,
  });

  factory FetchTasksModel.onSuccess(Map<String, dynamic> json) =>
      FetchTasksModel(
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
        assignees: List<String>.from(json["assignees_display"].map((x) => x)),
        status: json["status"],
        priority: json["priority"],
        locked: json["locked"],
        reminder: json["reminder"],
        subTasks: List<SubTask>.from(
            json["sub_tasks"].map((x) => SubTask.fromJson(x))),
        statusMessage: json["status_message"],
        attachments: List<AttachmentsDisplayModel>.from(
            json["attachments_display"]
                .map((x) => AttachmentsDisplayModel.fromJson(x))),
        errorMessage: '',
      );

  factory FetchTasksModel.onError(Map<String, dynamic> json) => FetchTasksModel(
        id: 0,
        title: '',
        description: '',
        startDate: null,
        dueDate: null,
        completeDate: null,
        creator: 0,
        workspace: 0,
        project: 0,
        image: '',
        outDated: false,
        parentTask: 0,
        assignees: [],
        status: '',
        priority: '',
        locked: false,
        reminder: 0,
        subTasks: [],
        statusMessage: '',
        attachments: [],
        errorMessage: json["detail"] ?? json["message"],
      );

  factory FetchTasksModel.error(String errorMessage) => FetchTasksModel(
        id: 0,
        title: '',
        description: '',
        startDate: null,
        dueDate: null,
        completeDate: null,
        creator: 0,
        workspace: 0,
        project: 0,
        image: '',
        outDated: false,
        parentTask: 0,
        assignees: [],
        status: '',
        priority: '',
        locked: false,
        reminder: 0,
        subTasks: [],
        statusMessage: '',
        attachments: [],
        errorMessage: errorMessage,
      );
}

class SubTask {
  int id;
  String title;
  String description;
  DateTime startDate;
  DateTime dueDate;
  dynamic completeDate;
  String status;
  String priority;
  bool locked;
  dynamic reminder;
  bool outDated;
  String image;

  SubTask({
    required this.id,
    required this.title,
    required this.description,
    required this.startDate,
    required this.dueDate,
    required this.completeDate,
    required this.status,
    required this.priority,
    required this.locked,
    required this.reminder,
    required this.outDated,
    required this.image,
  });

  factory SubTask.fromJson(Map<String, dynamic> json) => SubTask(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        startDate: DateTime.parse(json["start_date"]),
        dueDate: DateTime.parse(json["due_date"]),
        completeDate: json["complete_date"],
        status: json["status"],
        priority: json["priority"],
        locked: json["locked"],
        reminder: json["reminder"],
        outDated: json["out_dated"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "start_date":
            "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
        "due_date":
            "${dueDate.year.toString().padLeft(4, '0')}-${dueDate.month.toString().padLeft(2, '0')}-${dueDate.day.toString().padLeft(2, '0')}",
        "complete_date": completeDate,
        "status": status,
        "priority": priority,
        "locked": locked,
        "reminder": reminder,
        "out_dated": outDated,
        "image": image,
      };
}

class AttachmentsDisplayModel {
  int id;
  String file;
  DateTime createdAt;
  DateTime updatedAt;

  AttachmentsDisplayModel({
    required this.id,
    required this.file,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AttachmentsDisplayModel.fromJson(Map<String, dynamic> json) =>
      AttachmentsDisplayModel(
        id: json["id"],
        file: json["file"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "file": file,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
