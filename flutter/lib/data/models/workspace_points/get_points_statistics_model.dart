class GetPointsStatisticsModel {
  BestHardWorker? bestHardWorker;
  BestImportantMissionSolverRecord? bestImportantMissionSolverRecord;
  BestDisciplineMemberRecord? bestDisciplineMemberRecord;
  BestMemberRecord? bestMemberRecord;
  String errorMessage;

  GetPointsStatisticsModel({
    required this.bestHardWorker,
    required this.bestImportantMissionSolverRecord,
    required this.bestDisciplineMemberRecord,
    required this.bestMemberRecord,
    required this.errorMessage,
  });

  factory GetPointsStatisticsModel.onSuccess(Map<String, dynamic> json) =>
      GetPointsStatisticsModel(
        bestHardWorker: BestHardWorker.fromJson(json["best_hard_worker"]),
        bestImportantMissionSolverRecord:
            BestImportantMissionSolverRecord.fromJson(
                json["best_important_mission_solver_record"]),
        bestDisciplineMemberRecord: BestDisciplineMemberRecord.fromJson(
            json["best_discipline_member_record"]),
        bestMemberRecord: BestMemberRecord.fromJson(json["best_member_record"]),
        errorMessage: '',
      );

  factory GetPointsStatisticsModel.onError(Map<String, dynamic> json) =>
      GetPointsStatisticsModel(
        bestHardWorker: null,
        bestImportantMissionSolverRecord: null,
        bestDisciplineMemberRecord: null,
        bestMemberRecord: null,
        errorMessage: json["detail"] ?? json["message"],
      );

  factory GetPointsStatisticsModel.error(String errorMessage) =>
      GetPointsStatisticsModel(
        bestHardWorker: null,
        bestImportantMissionSolverRecord: null,
        bestDisciplineMemberRecord: null,
        bestMemberRecord: null,
        errorMessage: errorMessage,
      );
}

class BestDisciplineMemberRecord {
  int userId;
  String username;
  int disciplineMemberPoints;

  BestDisciplineMemberRecord({
    required this.userId,
    required this.username,
    required this.disciplineMemberPoints,
  });

  factory BestDisciplineMemberRecord.fromJson(Map<String, dynamic> json) =>
      BestDisciplineMemberRecord(
        userId: json["user_id"],
        username: json["username"],
        disciplineMemberPoints: json["discipline_member_points"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "username": username,
        "discipline_member_points": disciplineMemberPoints,
      };
}

class BestHardWorker {
  int userId;
  String username;
  int hardWorkerPoints;

  BestHardWorker({
    required this.userId,
    required this.username,
    required this.hardWorkerPoints,
  });

  factory BestHardWorker.fromJson(Map<String, dynamic> json) => BestHardWorker(
        userId: json["user_id"],
        username: json["username"],
        hardWorkerPoints: json["hard_worker_points"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "username": username,
        "hard_worker_points": hardWorkerPoints,
      };
}

class BestImportantMissionSolverRecord {
  int userId;
  String username;
  int importantMissionSolverPoints;

  BestImportantMissionSolverRecord({
    required this.userId,
    required this.username,
    required this.importantMissionSolverPoints,
  });

  factory BestImportantMissionSolverRecord.fromJson(
          Map<String, dynamic> json) =>
      BestImportantMissionSolverRecord(
        userId: json["user_id"],
        username: json["username"],
        importantMissionSolverPoints: json["important_mission_solver_points"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "username": username,
        "important_mission_solver_points": importantMissionSolverPoints,
      };
}

class BestMemberRecord {
  int userId;
  String username;
  int totalPoints;

  BestMemberRecord({
    required this.userId,
    required this.username,
    required this.totalPoints,
  });

  factory BestMemberRecord.fromJson(Map<String, dynamic> json) =>
      BestMemberRecord(
        userId: json["user_id"],
        username: json["username"],
        totalPoints: json["total_points"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "username": username,
        "total_points": totalPoints,
      };
}
