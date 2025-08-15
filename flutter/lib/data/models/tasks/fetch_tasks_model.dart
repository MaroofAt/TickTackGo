class FetchTasksModel {
  int id;
  String title;
  String description;
  DateTime? startDate;
  DateTime? dueDate;
  DateTime? completeDate;
  int creator;
  int workspace;
  int project;
  String image;
  bool outDated;
  int? parentTask;
  List<dynamic> assignees;
  String status;
  String priority;
  bool locked;
  DateTime? reminder;
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
    required this.errorMessage,
  });

  factory FetchTasksModel.onSuccess(Map<String, dynamic> json) =>
      FetchTasksModel(
        id: json["id"] ?? 0,
        title: json["title"] ?? '',
        description: json["description"] ?? '',
        startDate: json["start_date"] != null ? DateTime.parse(json["start_date"]) : null,
        dueDate: json["due_date"] != null ? DateTime.parse(json["due_date"]) : null,
        completeDate: json["complete_date"] != null ? DateTime.parse(json["complete_date"]) : null,
        creator: json["creator"] ?? 0,
        workspace: json["workspace"] ?? 0,
        project: json["project"] ?? 0,
        image: json["image"] ?? '',
        outDated: json["out_dated"] ?? false,
        parentTask: json["parent_task"],
        assignees: json["assignees"] != null
            ? List<dynamic>.from(json["assignees"].map((x) => x))
            : [],
        status: json["status"] ?? '',
        priority: json["priority"] ?? '',
        locked: json["locked"] ?? false,
        reminder: json["reminder"] != null ? DateTime.parse(json["reminder"]) : null,
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
        reminder: null,
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
        reminder: null,
        errorMessage: errorMessage,
      );
}
