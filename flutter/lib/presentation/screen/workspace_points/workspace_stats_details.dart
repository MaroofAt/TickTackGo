import 'package:flutter/material.dart';
import 'package:pr1/data/models/workspace_points/get_points_statistics_model.dart';
import 'package:pr1/presentation/screen/workspace_points/stat_card.dart';

class WorkspaceGetPointsStatisticsModelDetailScreen extends StatelessWidget {
  final String workspaceTitle;
  final GetPointsStatisticsModel getPointsStatisticsModel;

  const WorkspaceGetPointsStatisticsModelDetailScreen(
  this.getPointsStatisticsModel, this.workspaceTitle, {super.key,});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(workspaceTitle)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            StatCard(
              title: '🏅 Hard Worker',
              userId: getPointsStatisticsModel.bestHardWorker!.userId,
              points: getPointsStatisticsModel.bestHardWorker!.hardWorkerPoints,
            ),
            StatCard(
              title: '🎯 Mission Solver',
              userId:
                  getPointsStatisticsModel.bestImportantMissionSolverRecord!.userId,
              points: getPointsStatisticsModel
                  .bestImportantMissionSolverRecord!.importantMissionSolverPoints,
            ),
            StatCard(
              title: '📋 Discipline Member',
              userId: getPointsStatisticsModel.bestDisciplineMemberRecord!.userId,
              points: getPointsStatisticsModel
                  .bestDisciplineMemberRecord!.disciplineMemberPoints,
            ),
            StatCard(
              title: '👑 Best Member',
              userId: getPointsStatisticsModel.bestMemberRecord!.userId,
              points: getPointsStatisticsModel.bestMemberRecord!.totalPoints,
            ),
          ],
        ),
      ),
    );
  }
}
