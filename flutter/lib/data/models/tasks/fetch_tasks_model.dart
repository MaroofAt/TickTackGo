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
  String statusMessage;
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
    required this.statusMessage,
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
        assignees: List<String>.from(json["assignees"].map((x) => x)),
        status: json["status"],
        priority: json["priority"],
        locked: json["locked"],
        reminder: json["reminder"],
        statusMessage: json["status_message"],
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
        statusMessage: '',
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
        statusMessage: '',
        errorMessage: errorMessage,
      );
}
