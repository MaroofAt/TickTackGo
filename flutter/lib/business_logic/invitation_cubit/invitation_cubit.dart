import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pr1/core/API/invitation.dart';
import 'package:pr1/data/models/invitation/accept_invite_model.dart';
import 'package:pr1/data/models/invitation/invitation_search_model.dart';
import 'package:pr1/data/models/invitation/reject_invite_model.dart';
import 'package:pr1/data/models/invitation/user_invites_model.dart';

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
          await InvitationApi.invitationSearch(query);
      print(invitationSearchModel.errorMessage);

      if (invitationSearchModel.errorMessage.isEmpty) {
        emit(SearchSuccessState(invitationSearchModel));
      } else {
        emit(SearchFailedState(invitationSearchModel.errorMessage));
      }
    });
  }

  Future<void> fetchUserInvites() async {
    emit(GettingInvitesState());
    //TODO pass user token
    List<dynamic> userInvitesList = await InvitationApi.fetchUserInvites('');
    if (userInvitesList.isEmpty || userInvitesList[0].errorMessage.isNotEmpty) {
      emit(GetInvitesSucceededState(userInvitesList));
    } else {
      emit(GetInvitesFailedState(userInvitesList[0].errorMessage));
    }
  }

  Future<void> acceptInvite(int inviteId) async {
    emit(AcceptingInviteState());
    AcceptInviteModel acceptInviteModel =
        await InvitationApi.acceptInvite(inviteId, '');
    if (acceptInviteModel.errorMessage.isEmpty) {
      fetchUserInvites();
    } else {
      emit(RespondingToInviteFailedState(acceptInviteModel.errorMessage));
    }
  }

  Future<void> rejectInvite(int inviteId) async {
    emit(RejectingInviteState());
    RejectInviteModel rejectInviteModel =
    await InvitationApi.rejectInvite(inviteId, '');
    if (rejectInviteModel.errorMessage.isEmpty) {
      fetchUserInvites();
    } else {
      emit(RespondingToInviteFailedState(rejectInviteModel.errorMessage));
    }
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}
