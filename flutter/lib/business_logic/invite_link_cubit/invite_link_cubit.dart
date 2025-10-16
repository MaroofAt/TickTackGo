import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:pr1/core/API/invite_link.dart';
import 'package:pr1/core/variables/global_var.dart';
import 'package:pr1/data/models/invite_link/create_invite_link.dart';
import 'package:pr1/data/models/invite_link/get_invite_link.dart';

part 'invite_link_state.dart';

class InviteLinkCubit extends Cubit<InviteLinkState> {
  InviteLinkCubit() : super(InviteLinkInitial());

  Future<void> getInviteLink(workspaceId) async {
    emit(GettingInviteLinkState());

    GetInviteLinkModel getInviteLinkModel = await InviteLink.getInviteLInk(workspaceId, token);

    if(getInviteLinkModel.errorMessage.isEmpty) {
      emit(GettingInviteLinkSucceededState(getInviteLinkModel));
    } else {
      emit(GettingInviteLinkFailedState(getInviteLinkModel.errorMessage));
    }
  }

  Future<void> createInviteLink(workspaceId) async {
    emit(InviteLinkCreatingState());

    CreateInviteLinkModel createInviteLinkModel = await InviteLink.createInviteLink(workspaceId, token);

    if(createInviteLinkModel.errorMessage.isEmpty) {
      emit(InviteLinkCreatingSucceededState(createInviteLinkModel));
    } else {
      emit(InviteLinkCreatingFailedState(createInviteLinkModel.errorMessage));
    }
  }
}
