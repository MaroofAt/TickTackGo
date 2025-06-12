class RejectInviteModel {
  String errorMessage;

  RejectInviteModel({required this.errorMessage});

  factory RejectInviteModel.onSuccess() =>
      RejectInviteModel(errorMessage: '');

  factory RejectInviteModel.onError(Map<String, dynamic> json) =>
      RejectInviteModel(errorMessage: json["message"]);

  factory RejectInviteModel.error(String errorMessage) =>
      RejectInviteModel(errorMessage: errorMessage);
}
