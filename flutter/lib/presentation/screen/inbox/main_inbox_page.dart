import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pr1/business_logic/inbox_cubit/inbox_cubit.dart';
import 'package:pr1/presentation/screen/inbox/first_stack_child.dart';
import 'package:pr1/presentation/screen/inbox/inbox_appbar.dart';
import 'package:pr1/presentation/screen/inbox/inbox_body.dart';
import 'package:pr1/presentation/widgets/loading_indicator.dart';

class MainInboxPage extends StatefulWidget {
  const MainInboxPage({super.key});

  @override
  State<MainInboxPage> createState() => _MainInboxPageState();
}

class _MainInboxPageState extends State<MainInboxPage> {
  @override
  void initState() {
    super.initState();
    getInboxTasks();
  }

  getInboxTasks() {
    BlocProvider.of<InboxCubit>(context).fetchInboxTask();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: InboxAppbar.buildInboxAppBar(context),
          body: BlocBuilder<InboxCubit, InboxState>(
            builder: (context, state) {
              if (state is InboxFetchingTasksSucceededState) {
                return InboxBody(state.inboxTasksModelList);
              } else {
                return Center(
                  child: LoadingIndicator.circularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
