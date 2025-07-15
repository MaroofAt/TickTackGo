import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pr1/business_logic/invitation_cubit/invitation_cubit.dart';
import 'package:pr1/core/constance/colors.dart';
import 'package:pr1/core/constance/constance.dart';
import 'package:pr1/core/constance/strings.dart';
import 'package:pr1/core/functions/navigation_functions.dart';
import 'package:pr1/data/models/invitation/invitation_search_model.dart';
import 'package:pr1/presentation/widgets/alert_dialog.dart';
import 'package:pr1/presentation/widgets/buttons.dart';
import 'package:pr1/presentation/widgets/gesture_detector.dart';
import 'package:pr1/presentation/widgets/loading_indicator.dart';
import 'package:pr1/presentation/widgets/text.dart';
import 'package:pr1/presentation/widgets/text_field.dart';

class InvitationSearch extends StatefulWidget {
  final int senderId;
  final int workspaceId;

  const InvitationSearch(
      {required this.senderId, required this.workspaceId, super.key});

  @override
  State<InvitationSearch> createState() => _InvitationSearchState();
}

class _InvitationSearchState extends State<InvitationSearch> {
  final List<String> _searchResults = [];

  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: MyTextField.textField(
                context,
                _controller,
                onChanged: (query) => BlocProvider.of<InvitationCubit>(context)
                    .invitationSearch(query),
                textColor: Colors.white,
                hint: "Search...",
                prefixIcon: const Icon(Icons.search, color: Colors.white),
              ),
            ),
            BlocConsumer<InvitationCubit, InvitationState>(
              listener: (context, state) {
                if (state is SendingInviteFailedState) {
                  MyAlertDialog.showAlertDialog(
                    context,
                    content: state.errorMessage,
                    firstButtonText: okText,
                    firstButtonAction: () {
                      popScreen(context);
                    },
                    secondButtonText: '',
                    secondButtonAction: () {},
                  );
                } else if (state is SearchFailedState) {
                  MyAlertDialog.showAlertDialog(
                    context,
                    content: state.errorMessage,
                    firstButtonText: okText,
                    firstButtonAction: () {
                      popScreen(context);
                      popScreen(context);
                    },
                    secondButtonText: '',
                    secondButtonAction: () {},
                  );
                } else if (state is SendingInviteSuccessfullyState) {
                  MyAlertDialog.showAlertDialog(
                    context,
                    content: 'Invite Sent Successfully',
                    firstButtonText: okText,
                    firstButtonAction: () {
                      popScreen(context);
                      popScreen(context);
                    },
                    secondButtonText: '',
                    secondButtonAction: () {},
                  );
                }
              },
              builder: (context, state) {
                if (state is SearchSuccessState) {
                  InvitationSearchModel invitationSearchModel = state.invitationSearchModel;
                  return Expanded(
                    child: ListView.builder(
                      itemCount: invitationSearchModel.results.length,
                      itemBuilder: (context, index) {
                        return Container(
                          width: width(context) * 0.9,
                          height: height(context) * 0.08,
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          margin: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            // border: Border.all(color: ampleOrange),
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: const [
                              BoxShadow(
                                color: darkGrey,
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: Offset(5, 5),
                              )
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MyText.text1(
                                    invitationSearchModel.results[index]
                                        .username,
                                    textColor: white,
                                    fontSize: 18,
                                  ),
                                  MyText.text1(
                                      invitationSearchModel.results[index]
                                          .email,
                                      textColor: Colors.grey[400]),
                                ],
                              ),
                              MyGestureDetector.gestureDetector(
                                onTap: () {
                                  BlocProvider.of<InvitationCubit>(context)
                                      .inviteUser(
                                    senderId: widget.senderId,
                                    workspaceId: widget.workspaceId,
                                    receiverId: invitationSearchModel.results[index].id,
                                  );
                                },
                                child: BlocBuilder<InvitationCubit,
                                    InvitationState>(
                                  builder: (context, state) {
                                    if (state is SendingInviteState) {
                                      return LoadingIndicator
                                          .circularProgressIndicator(
                                        color: Theme.of(context)
                                            .secondaryHeaderColor,
                                      );
                                    }
                                    return Container(
                                      height: height(context) * 0.04,
                                      width: width(context) * 0.25,
                                      decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .secondaryHeaderColor,
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: Center(
                                        child: MyText.text1(
                                          'invite',
                                          textColor: Theme.of(context)
                                              .scaffoldBackgroundColor,
                                          fontSize: 18,
                                          letterSpacing: 2,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                } else if (state is SearchLoadingState) {
                  return Center(
                    child: LoadingIndicator.circularProgressIndicator(),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
