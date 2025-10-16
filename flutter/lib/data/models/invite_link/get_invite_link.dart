

class GetInviteLinkModel {
    String link;
    String errorMessage;

    GetInviteLinkModel({
        required this.link,
        required this.errorMessage,
    });

    factory GetInviteLinkModel.onSuccess(Map<String, dynamic> json) => GetInviteLinkModel(
        link: json["link"],
        errorMessage: '',
    );

    factory GetInviteLinkModel.onError(Map<String, dynamic> json) => GetInviteLinkModel(
        link: '',
        errorMessage: json['detail']??json['message'],
    );

    factory GetInviteLinkModel.error(String errorMessage) => GetInviteLinkModel(
        link: '',
        errorMessage: errorMessage,
    );

    Map<String, dynamic> toJson() => {
        "link": link,
    };
}
