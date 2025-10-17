// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'invite_link_cubit.dart';

@immutable
sealed class InviteLinkState {}

final class InviteLinkInitial extends InviteLinkState {}

class InviteLinkCreatingState extends InviteLinkState {}

class InviteLinkCreatingSucceededState extends InviteLinkState {
  CreateInviteLinkModel createInviteLinkModel;
  InviteLinkCreatingSucceededState(this.createInviteLinkModel);
}

class InviteLinkCreatingFailedState extends InviteLinkState {
  String errorMessage;
  InviteLinkCreatingFailedState(this.errorMessage);
}

class GettingInviteLinkState extends InviteLinkState {}

class GettingInviteLinkSucceededState extends InviteLinkState {
  GetInviteLinkModel getInviteLinkModel;
  GettingInviteLinkSucceededState(this.getInviteLinkModel);
}

class GettingInviteLinkFailedState extends InviteLinkState {
    String errorMessage;
    GettingInviteLinkFailedState(this.errorMessage);
}

class InviteLinkAcceptingState extends InviteLinkState {}

class InviteLinkAcceptedState extends InviteLinkState {}

class InviteLinkAcceptingFailedState extends InviteLinkState {
  String errorMessage;
  InviteLinkAcceptingFailedState(this.errorMessage);
}
