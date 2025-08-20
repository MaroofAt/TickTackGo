import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pr1/business_logic/invitation_cubit/invitation_cubit.dart';
import 'package:pr1/core/constance/colors.dart';
import 'package:pr1/core/constance/constance.dart';
import 'package:pr1/presentation/widgets/gesture_detector.dart';
import 'package:pr1/presentation/widgets/images.dart';
import 'package:pr1/presentation/widgets/loading_indicator.dart';
import 'package:pr1/presentation/widgets/text.dart';

class InvitesList extends StatelessWidget {
  List<dynamic> userInvitesList;
  int clickedItemId = 0;

  InvitesList(this.userInvitesList, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: userInvitesList.length,
      itemBuilder: (context, index) {
        return Container(
          width: width(context) * 0.9,
          height: height(context) * 0.16,
          margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          decoration: BoxDecoration(
            color: Theme
                .of(context)
                .scaffoldBackgroundColor,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: height(context) * 0.06,
                width: height(context) * 0.06,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: MyImages.decorationImage(
                    isAssetImage: true,
                    image: 'assets/images/workspace_images/img.png',
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText.text1(
                    '${userInvitesList[index].sender
                        .username} invites you to join\n${userInvitesList[index]
                        .workspace.title}',
                    textColor: white,
                    fontSize: 18,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MyGestureDetector.gestureDetector(
                        onTap: () {
                          clickedItemId = userInvitesList[index].id;
                          BlocProvider.of<InvitationCubit>(context).acceptInvite(clickedItemId);
                        },
                        child: BlocBuilder<InvitationCubit, InvitationState>(
                          builder: (context, state) {
                            if (state is AcceptingInviteState &&
                                clickedItemId == userInvitesList[index].id) {
                              return Center(
                                child:
                                LoadingIndicator.circularProgressIndicator(
                                  color: Theme
                                      .of(context)
                                      .secondaryHeaderColor,
                                ),
                              );
                            }
                            return buildAcceptRejectButton(
                              context,
                              'Join',
                              Theme
                                  .of(context)
                                  .primaryColor,
                            );
                          },
                        ),
                      ),
                      SizedBox(width: width(context) * 0.15),
                      MyGestureDetector.gestureDetector(
                        onTap: () {
                          clickedItemId = userInvitesList[index].id;
                          BlocProvider.of<InvitationCubit>(context).rejectInvite(clickedItemId);
                        },
                        child: BlocBuilder<InvitationCubit, InvitationState>(
                          builder: (context, state) {
                            if (state is RejectingInviteState &&
                                clickedItemId == userInvitesList[index].id) {
                              return Center(
                                child: LoadingIndicator
                                    .circularProgressIndicator(color: Theme
                                    .of(context)
                                    .secondaryHeaderColor,),
                              );
                            }
                            return buildAcceptRejectButton(
                              context,
                              'Reject',
                              darkGrey,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  Container buildAcceptRejectButton(BuildContext context, String text,
      Color color) {
    return Container(
      height: width(context) * 0.08,
      width: width(context) * 0.3,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(
          width(context) * 0.02,
        ),
      ),
      child: Center(
        child: MyText.text1(text, textColor: white),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pr1/business_logic/invitation_cubit/invitation_cubit.dart';
import 'package:pr1/core/constance/colors.dart';
import 'package:pr1/core/constance/constance.dart';
import 'package:pr1/presentation/widgets/gesture_detector.dart';
import 'package:pr1/presentation/widgets/images.dart';
import 'package:pr1/presentation/widgets/loading_indicator.dart';
import 'package:pr1/presentation/widgets/text.dart';

class InvitesList extends StatelessWidget {
  List<dynamic> userInvitesList;
  int clickedItemId = 0;

  InvitesList(this.userInvitesList, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: userInvitesList.length,
      itemBuilder: (context, index) {
        return Container(
          width: width(context) * 0.9,
          height: height(context) * 0.16,
          margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          decoration: BoxDecoration(
            color: Theme
                .of(context)
                .scaffoldBackgroundColor,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: height(context) * 0.06,
                width: height(context) * 0.06,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: MyImages.decorationImage(
                    isAssetImage: false,
                    //TODO display workspace image
                    image: 'assets/images/workspace_images/img.png',
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText.text1(
                    '${userInvitesList[index].sender
                        .username} invites you to join\n${userInvitesList[index]
                        .workspace.title}',
                    textColor: white,
                    fontSize: 18,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MyGestureDetector.gestureDetector(
                        onTap: () {
                          clickedItemId = userInvitesList[index].id;
                          BlocProvider.of<InvitationCubit>(context).acceptInvite(clickedItemId);
                        },
                        child: BlocBuilder<InvitationCubit, InvitationState>(
                          builder: (context, state) {
                            if (state is AcceptingInviteState &&
                                clickedItemId == userInvitesList[index].id) {
                              return Center(
                                child:
                                LoadingIndicator.circularProgressIndicator(
                                  color: Theme
                                      .of(context)
                                      .secondaryHeaderColor,
                                ),
                              );
                            }
                            return buildAcceptRejectButton(
                              context,
                              'Join',
                              Theme
                                  .of(context)
                                  .primaryColor,
                            );
                          },
                        ),
                      ),
                      SizedBox(width: width(context) * 0.15),
                      MyGestureDetector.gestureDetector(
                        onTap: () {
                          clickedItemId = userInvitesList[index].id;
                          BlocProvider.of<InvitationCubit>(context).rejectInvite(clickedItemId);
                        },
                        child: BlocBuilder<InvitationCubit, InvitationState>(
                          builder: (context, state) {
                            if (state is RejectingInviteState &&
                                clickedItemId == userInvitesList[index].id) {
                              return Center(
                                child: LoadingIndicator
                                    .circularProgressIndicator(color: Theme
                                    .of(context)
                                    .secondaryHeaderColor,),
                              );
                            }
                            return buildAcceptRejectButton(
                              context,
                              'Reject',
                              darkGrey,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  Container buildAcceptRejectButton(BuildContext context, String text,
      Color color) {
    return Container(
      height: width(context) * 0.08,
      width: width(context) * 0.3,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(
          width(context) * 0.02,
        ),
      ),
      child: Center(
        child: MyText.text1(text, textColor: white),
      ),
    );
  }
}
