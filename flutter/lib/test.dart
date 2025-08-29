import 'package:flutter/material.dart';

void main () {
  final List<WorkspaceStats> ownedWorkspaces = [
    WorkspaceStats(
      workspaceName: 'Design Sprint Squad',
      bestHardWorker: BestHardWorker(userId: 2, hardWorkerPoints: 8),
      bestImportantMissionSolver: BestImportantMissionSolver(userId: 3, importantMissionSolverPoints: 12),
      bestDisciplineMember: BestDisciplineMember(userId: 4, disciplineMemberPoints: 10),
      bestMemberRecord: BestMemberRecord(userId: 3, totalPoints: 30),
    ),
    WorkspaceStats(
      workspaceName: 'Flutter Devs United',
      bestHardWorker: BestHardWorker(userId: 5, hardWorkerPoints: 10),
      bestImportantMissionSolver: BestImportantMissionSolver(userId: 6, importantMissionSolverPoints: 15),
      bestDisciplineMember: BestDisciplineMember(userId: 5, disciplineMemberPoints: 9),
      bestMemberRecord: BestMemberRecord(userId: 6, totalPoints: 34),
    ),
    WorkspaceStats(
      workspaceName: 'Productivity Ninjas',
      bestHardWorker: BestHardWorker(userId: 1, hardWorkerPoints: 5),
      bestImportantMissionSolver: BestImportantMissionSolver(userId: 1, importantMissionSolverPoints: 16),
      bestDisciplineMember: BestDisciplineMember(userId: 1, disciplineMemberPoints: 13),
      bestMemberRecord: BestMemberRecord(userId: 1, totalPoints: 34),
    ),
  ];

  runApp(MaterialApp(
    home: WorkspaceOverviewScreen(ownedWorkspaces: ownedWorkspaces),
  ));
}

class WorkspaceOverviewScreen extends StatelessWidget {
  final List<WorkspaceStats> ownedWorkspaces;

  const WorkspaceOverviewScreen({super.key, required this.ownedWorkspaces});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Your Workspaces')),
      body: ListView.builder(
        itemCount: ownedWorkspaces.length,
        itemBuilder: (context, index) {
          final stats = ownedWorkspaces[index];
          return Card(
            margin: const EdgeInsets.all(12),
            child: ListTile(
              title: Text(stats.workspaceName),
              subtitle: Text('Total Points: ${stats.bestMemberRecord.totalPoints}'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => WorkspaceStatsDetailScreen(stats: stats),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class WorkspaceStatsDetailScreen extends StatelessWidget {
  final WorkspaceStats stats;

  const WorkspaceStatsDetailScreen({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(stats.workspaceName)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            StatCard(
              title: '🏅 Hard Worker',
              userId: stats.bestHardWorker.userId,
              points: stats.bestHardWorker.hardWorkerPoints,
            ),
            StatCard(
              title: '🎯 Mission Solver',
              userId: stats.bestImportantMissionSolver.userId,
              points: stats.bestImportantMissionSolver.importantMissionSolverPoints,
            ),
            StatCard(
              title: '📋 Discipline Member',
              userId: stats.bestDisciplineMember.userId,
              points: stats.bestDisciplineMember.disciplineMemberPoints,
            ),
            StatCard(
              title: '👑 Best Member',
              userId: stats.bestMemberRecord.userId,
              points: stats.bestMemberRecord.totalPoints,
            ),
          ],
        ),
      ),
    );
  }
}


class StatCard extends StatelessWidget {
  final String title;
  final int userId;
  final int points;

  const StatCard({
    super.key,
    required this.title,
    required this.userId,
    required this.points,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: CircleAvatar(child: Text('$userId')), // Replace with avatar if available
        title: Text(title),
        subtitle: Text('Points: $points'),
      ),
    );
  }
}


class WorkspaceStats {
  final String workspaceName;
  final BestHardWorker bestHardWorker;
  final BestImportantMissionSolver bestImportantMissionSolver;
  final BestDisciplineMember bestDisciplineMember;
  final BestMemberRecord bestMemberRecord;

  WorkspaceStats({
    required this.workspaceName,
    required this.bestHardWorker,
    required this.bestImportantMissionSolver,
    required this.bestDisciplineMember,
    required this.bestMemberRecord,
  });
}

class BestHardWorker {
  final int userId;
  final int hardWorkerPoints;

  BestHardWorker({required this.userId, required this.hardWorkerPoints});
}

class BestImportantMissionSolver {
  final int userId;
  final int importantMissionSolverPoints;

  BestImportantMissionSolver({required this.userId, required this.importantMissionSolverPoints});
}

class BestDisciplineMember {
  final int userId;
  final int disciplineMemberPoints;

  BestDisciplineMember({required this.userId, required this.disciplineMemberPoints});
}

class BestMemberRecord {
  final int userId;
  final int totalPoints;

  BestMemberRecord({required this.userId, required this.totalPoints});
}


