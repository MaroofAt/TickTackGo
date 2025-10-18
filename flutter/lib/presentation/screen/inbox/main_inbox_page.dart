import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pr1/business_logic/inbox_cubit/inbox_cubit.dart';
import 'package:pr1/core/constance/colors.dart';
import 'package:pr1/core/constance/constance.dart';
import 'package:pr1/core/constance/strings.dart';
import 'package:pr1/core/functions/navigation_service.dart';
import 'package:pr1/presentation/screen/inbox/inbox_app_bar.dart';
import 'package:pr1/presentation/screen/inbox/inbox_body.dart';
import 'package:pr1/presentation/screen/inbox/inbox_bottom_navigation_bar.dart';
import 'package:pr1/presentation/widgets/alert_dialog.dart';
import 'package:pr1/presentation/widgets/icons.dart';
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
    _getInboxTasks();
  }

  _getInboxTasks() async {
    await BlocProvider.of<InboxCubit>(context).fetchInboxTask();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: InboxAppBar.inboxAppBar(context),
        bottomNavigationBar: SizedBox(
          height: height(context) * 0.08,
          child: PopScope(
            child: InboxBottomNavigationBar(
              'Add new task',
              false,
              icon: MyIcons.icon(Icons.add_circle_sharp, color: white),
            ),
          ),
        ),
        body: BlocConsumer<InboxCubit, InboxState>(
          listener: (context, state) {
            if (state is InboxFetchingTasksFailedState) {
              MyAlertDialog.showAlertDialog(
                context,
                content: state.errorMessage,
                firstButtonText: okText,
                firstButtonAction: () {
                  NavigationService().popScreen(context);
                  NavigationService().popScreen(context);
                },
                secondButtonText: '',
                secondButtonAction: () {},
              );
            }
          },
          builder: (context, state) {
            if (state is InboxFetchingTasksSucceededState) {
              return InboxBody(state.inboxTasksModelList);
            }
            return Center(
              child: LoadingIndicator.circularProgressIndicator(
                  color: Theme.of(context).secondaryHeaderColor),
            );
          },
        ),
      ),
    );
  }
}
