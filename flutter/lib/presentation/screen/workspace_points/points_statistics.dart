import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pr1/business_logic/points_cubit/points_cubit.dart';
import 'package:pr1/presentation/screen/workspace_points/points_statistics_app_bar.dart';
import 'package:pr1/presentation/screen/workspace_points/workspace_stats_details.dart';
import 'package:pr1/presentation/widgets/loading_indicator.dart';

class PointsStatistics extends StatefulWidget {
  final int workspaceId;
  final String workspaceName;

  const PointsStatistics(this.workspaceId, this.workspaceName, {super.key});

  @override
  State<PointsStatistics> createState() => _PointsStatisticsState();
}

class _PointsStatisticsState extends State<PointsStatistics> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<PointsCubit>(context)
        .getPointsStatistics(widget.workspaceId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PointsStatisticsAppBar.pointsStatisticsDependenciesAppBar(
          context, widget.workspaceName),
      body: BlocBuilder<PointsCubit, PointsState>(
        builder: (context, state) {
          if (state is GettingPointsStatisticsSucceededState) {
            return WorkspaceGetPointsStatisticsModelDetailScreen(state.getPointsStatisticsModel,);
          }
          return Center(
            child: LoadingIndicator.circularProgressIndicator(),
          );
        },
      ),
    );
  }
}
