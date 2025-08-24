class CancelInviteModel {
  String errorMessage;

  CancelInviteModel({required this.errorMessage});

  factory CancelInviteModel.onSuccess() => CancelInviteModel(errorMessage: '');

  factory CancelInviteModel.onError(Map<String, dynamic> json) =>
      CancelInviteModel(errorMessage: json["detail"] ?? json["message"]);

  factory CancelInviteModel.error(String errorMessage) =>
      CancelInviteModel(errorMessage: errorMessage);
}
