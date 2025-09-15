import 'package:flutter/material.dart';
import 'package:pr1/data/models/workspace_points/get_points_statistics_model.dart';
import 'package:pr1/presentation/screen/workspace_points/stat_card.dart';

class WorkspaceGetPointsStatisticsModelDetailScreen extends StatelessWidget {
  final GetPointsStatisticsModel getPointsStatisticsModel;

  const WorkspaceGetPointsStatisticsModelDetailScreen(
  this.getPointsStatisticsModel, {super.key,});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          StatCard(
            title: '🏅 Hard Worker',
            userId: getPointsStatisticsModel.bestHardWorker!.userId,
            userName: getPointsStatisticsModel.bestHardWorker!.username,
            points: getPointsStatisticsModel.bestHardWorker!.hardWorkerPoints,
          ),
          StatCard(
            title: '🎯 Mission Solver',
            userId:
            getPointsStatisticsModel.bestImportantMissionSolverRecord!.userId,
            userName: getPointsStatisticsModel.bestImportantMissionSolverRecord!.username,
            points: getPointsStatisticsModel
                .bestImportantMissionSolverRecord!.importantMissionSolverPoints,
          ),
          StatCard(
            title: '📋 Discipline Member',
            userId: getPointsStatisticsModel.bestDisciplineMemberRecord!.userId,
            userName: getPointsStatisticsModel.bestDisciplineMemberRecord!.username,
            points: getPointsStatisticsModel
                .bestDisciplineMemberRecord!.disciplineMemberPoints,
          ),
          StatCard(
            title: '👑 Best Member',
            userId: getPointsStatisticsModel.bestMemberRecord!.userId,
            userName: getPointsStatisticsModel.bestMemberRecord!.username,
            points: getPointsStatisticsModel.bestMemberRecord!.totalPoints,
          ),
        ],
      ),
    );
  }
}
