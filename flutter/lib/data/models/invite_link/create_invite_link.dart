

class CreateInviteLinkModel {
    String link;
    String errorMessage;

    CreateInviteLinkModel({
        required this.link,
        required this.errorMessage,
    });

    factory CreateInviteLinkModel.onSuccess(Map<String, dynamic> json) => CreateInviteLinkModel(
        link: json["link"],
        errorMessage: '',
    );

    factory CreateInviteLinkModel.onError(Map<String, dynamic> json) => CreateInviteLinkModel(
        link: '',
        errorMessage: json['detail']??json['message'],
    );

    factory CreateInviteLinkModel.error(String errorMessage) => CreateInviteLinkModel(
        link: '',
        errorMessage: errorMessage,
    );

    Map<String, dynamic> toJson() => {
        "link": link,
    };
}
