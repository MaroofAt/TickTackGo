class GetUserPointsModel {
  int id;
  int user;
  int workspace;
  int total;
  int importantMissionSolver;
  int hardWorker;
  int disciplineMember;
  DateTime? createdAt;
  DateTime? updatedAt;
  String errorMessage;

  GetUserPointsModel({
    required this.id,
    required this.user,
    required this.workspace,
    required this.total,
    required this.importantMissionSolver,
    required this.hardWorker,
    required this.disciplineMember,
    required this.createdAt,
    required this.updatedAt,
    required this.errorMessage,
  });

  factory GetUserPointsModel.onSuccess(Map<String, dynamic> json) =>
      GetUserPointsModel(
        id: json["id"],
        user: json["user"],
        workspace: json["workspace"],
        total: json["total"],
        importantMissionSolver: json["important_mission_solver"],
        hardWorker: json["hard_worker"],
        disciplineMember: json["discipline_member"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        errorMessage: '',
      );

  factory GetUserPointsModel.onError(Map<String, dynamic> json) =>
      GetUserPointsModel(
        id: 0,
        user: 0,
        workspace: 0,
        total: 0,
        importantMissionSolver: 0,
        hardWorker: 0,
        disciplineMember: 0,
        createdAt: null,
        updatedAt: null,
        errorMessage: json["detail"] ?? json["message"],
      );

  factory GetUserPointsModel.error(String errorMessage) =>
      GetUserPointsModel(
        id: 0,
        user: 0,
        workspace: 0,
        total: 0,
        importantMissionSolver: 0,
        hardWorker: 0,
        disciplineMember: 0,
        createdAt: null,
        updatedAt: null,
        errorMessage: errorMessage,
      );
}
