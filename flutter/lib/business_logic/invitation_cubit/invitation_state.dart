part of 'invitation_cubit.dart';

@immutable
sealed class InvitationState {}

final class InvitationInitial extends InvitationState {}

class SearchLoadingState extends InvitationState {}

class SearchSuccessState extends InvitationState {
  InvitationSearchModel invitationSearchModel;

  SearchSuccessState(this.invitationSearchModel);
}

class SearchFailedState extends InvitationState {
  String errorMessage;

  SearchFailedState(this.errorMessage);
}

class GettingInvitesState extends InvitationState {}

class GetInvitesSucceededState extends InvitationState {
  List<dynamic> userInvitesList;

  GetInvitesSucceededState(this.userInvitesList);
}

class GetInvitesFailedState extends InvitationState {
  String errorMessage;

  GetInvitesFailedState(this.errorMessage);
}

class AcceptingInviteState extends InvitationState {}

class RejectingInviteState extends InvitationState {}

class RespondingToInviteFailedState extends InvitationState {
  String errorMessage;

  RespondingToInviteFailedState(this.errorMessage);
}
