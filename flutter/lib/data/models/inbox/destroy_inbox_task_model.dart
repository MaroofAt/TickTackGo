class DestroyInboxTaskModel {
  String detail;
  String errorMessage;

  DestroyInboxTaskModel({
    required this.detail,
    required this.errorMessage,
  });

  factory DestroyInboxTaskModel.onSuccess(Map<String, dynamic> json) =>
      DestroyInboxTaskModel(
        detail: json["detail"],
        errorMessage: '',
      );

  factory DestroyInboxTaskModel.onError(Map<String, dynamic> json) =>
      DestroyInboxTaskModel(
        detail: json["detail"],
        errorMessage: json["detail"] ?? json["message"],
      );

  factory DestroyInboxTaskModel.error(String errorMessage) =>
      DestroyInboxTaskModel(
        detail: '',
        errorMessage: errorMessage,
      );

  Map<String, dynamic> toJson() => {
        "detail": detail,
      };
}
