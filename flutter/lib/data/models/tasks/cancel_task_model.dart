
class CancelTaskModel {
    String detail;
    String errorMessage;

    CancelTaskModel({
        required this.detail,
        required this.errorMessage,
    });

    factory CancelTaskModel.onSuccess(Map<String, dynamic> json) => CancelTaskModel(
        detail: json["detail"],
        errorMessage: '',
    );

    factory CancelTaskModel.onError(Map<String, dynamic> json) => CancelTaskModel(
        detail: '',
        errorMessage: json["detail"],
    );

    factory CancelTaskModel.error(String errorMessage) => CancelTaskModel(
        detail: '',
        errorMessage: errorMessage,
    );

    Map<String, dynamic> toJson() => {
        "detail": detail,
    };
}
