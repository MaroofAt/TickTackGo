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
  int disciplineMemberPoints;

  BestDisciplineMemberRecord({
    required this.userId,
    required this.disciplineMemberPoints,
  });

  factory BestDisciplineMemberRecord.fromJson(Map<String, dynamic> json) =>
      BestDisciplineMemberRecord(
        userId: json["user_id"],
        disciplineMemberPoints: json["discipline_member_points"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "discipline_member_points": disciplineMemberPoints,
      };
}

class BestHardWorker {
  int userId;
  int hardWorkerPoints;

  BestHardWorker({
    required this.userId,
    required this.hardWorkerPoints,
  });

  factory BestHardWorker.fromJson(Map<String, dynamic> json) => BestHardWorker(
        userId: json["user_id"],
        hardWorkerPoints: json["hard_worker_points"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "hard_worker_points": hardWorkerPoints,
      };
}

class BestImportantMissionSolverRecord {
  int userId;
  int importantMissionSolverPoints;

  BestImportantMissionSolverRecord({
    required this.userId,
    required this.importantMissionSolverPoints,
  });

  factory BestImportantMissionSolverRecord.fromJson(
          Map<String, dynamic> json) =>
      BestImportantMissionSolverRecord(
        userId: json["user_id"],
        importantMissionSolverPoints: json["important_mission_solver_points"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "important_mission_solver_points": importantMissionSolverPoints,
      };
}

class BestMemberRecord {
  int userId;
  int totalPoints;

  BestMemberRecord({
    required this.userId,
    required this.totalPoints,
  });

  factory BestMemberRecord.fromJson(Map<String, dynamic> json) =>
      BestMemberRecord(
        userId: json["user_id"],
        totalPoints: json["total_points"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "total_points": totalPoints,
      };
}
