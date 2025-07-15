import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pr1/core/API/invitation.dart';
import 'package:pr1/core/variables/global_var.dart';
import 'package:pr1/data/models/invitation/accept_invite_model.dart';
import 'package:pr1/data/models/invitation/invitation_search_model.dart';
import 'package:pr1/data/models/invitation/reject_invite_model.dart';
import 'package:pr1/data/models/invitation/send_invite_model.dart';

part 'invitation_state.dart';

class InvitationCubit extends Cubit<InvitationState> {
  InvitationCubit() : super(InvitationInitial());
  Timer? _debounce;

  Future<void> invitationSearch(String query) async {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () async {
      if (query.isEmpty) {
        emit(InvitationInitial());
        return;
      }

      emit(SearchLoadingState());

      InvitationSearchModel invitationSearchModel =
          await InvitationApi.invitationSearch(query, token);

      if (invitationSearchModel.errorMessage.isEmpty) {
        //TODO
        // invitationSearchModel.results.removeWhere((element) => element.id == user.id,);
        emit(SearchSuccessState(invitationSearchModel));
      } else {
        emit(SearchFailedState(invitationSearchModel.errorMessage));
      }
    });
  }

  Future<void> fetchUserInvites() async {
    emit(GettingInvitesState());
    List<dynamic> userInvitesList = await InvitationApi.fetchUserInvites(token);
    if (userInvitesList.isEmpty || userInvitesList[0].errorMessage.isEmpty) {
      emit(GetInvitesSucceededState(userInvitesList));
    } else {
      emit(GetInvitesFailedState(userInvitesList[0].errorMessage));
    }
  }

  Future<void> acceptInvite(int inviteId) async {
    emit(AcceptingInviteState());
    AcceptInviteModel acceptInviteModel =
        await InvitationApi.acceptInvite(inviteId, token);
    if (acceptInviteModel.errorMessage.isEmpty) {
      fetchUserInvites();
    } else {
      emit(RespondingToInviteFailedState(acceptInviteModel.errorMessage));
    }
  }

  Future<void> rejectInvite(int inviteId) async {
    emit(RejectingInviteState());
    RejectInviteModel rejectInviteModel =
        await InvitationApi.rejectInvite(inviteId, token);
    if (rejectInviteModel.errorMessage.isEmpty) {
      fetchUserInvites();
    } else {
      emit(RespondingToInviteFailedState(rejectInviteModel.errorMessage));
    }
  }

  Future<void> inviteUser(
      {required int senderId,
      required int receiverId,
      required int workspaceId}) async {

    emit(SendingInviteState());
    SendInviteModel sendInviteModel =
        await InvitationApi.sendInvite(senderId, receiverId, workspaceId, token);
    if (sendInviteModel.errorMessage.isEmpty) {
      emit(SendingInviteSuccessfullyState(sendInviteModel));
    } else {
      emit(SendingInviteFailedState(sendInviteModel.errorMessage));
    }
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}
