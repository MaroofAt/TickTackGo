class RefreshTokenModel {
  String access;
  String errorMessage;

  RefreshTokenModel({
    required this.access,
    required this.errorMessage,
  });

  factory RefreshTokenModel.onSuccess(Map<String, dynamic> json) =>
      RefreshTokenModel(
        access: json["access"],
        errorMessage: '',
      );

  factory RefreshTokenModel.onError(Map<String, dynamic> json) =>
      RefreshTokenModel(
          access: json["access"] ?? '',
          errorMessage: json["detail"] ?? json["message"],
      );

  factory RefreshTokenModel.error(String errorMessage) =>
      RefreshTokenModel(
        access: '',
        errorMessage: errorMessage,
      );

  Map<String, dynamic> toJson() =>
      {
        "access": access,
      };
}
