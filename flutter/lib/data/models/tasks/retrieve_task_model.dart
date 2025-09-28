class RetrieveTaskModel {
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

  RetrieveTaskModel({
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

  factory RetrieveTaskModel.onSuccess(Map<String, dynamic> json) =>
      RetrieveTaskModel(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        startDate: DateTime.parse(json["start_date"]),
        dueDate: DateTime.parse(json["due_date"]),
        completeDate: json["complete_date"] == null
            ? null
            : DateTime(json["complete_date"]),
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
        errorMessage: '',
      );

  factory RetrieveTaskModel.onError(Map<String, dynamic> json) =>
      RetrieveTaskModel(
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

  factory RetrieveTaskModel.error(String errorMessage) => RetrieveTaskModel(
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
