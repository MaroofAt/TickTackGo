class ChangeUserRoleModel {
  Member? member;
  int project;
  String role;
  DateTime? createdAt;
  DateTime? updatedAt;
  String errorMessage;

  ChangeUserRoleModel({
    required this.member,
    required this.project,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
    required this.errorMessage,
  });

  factory ChangeUserRoleModel.onSuccess(Map<String, dynamic> json) =>
      ChangeUserRoleModel(
        member: Member.fromJson(json["member"]),
        project: json["project"],
        role: json["role"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        errorMessage: '',
      );

  factory ChangeUserRoleModel.onError(Map<String, dynamic> json) =>
      ChangeUserRoleModel(
        member: null,
        project: 0,
        role: '',
        createdAt: null,
        updatedAt: null,
        errorMessage: json["detail"] ?? json["message"],
      );

  factory ChangeUserRoleModel.error(String errorMessage) => ChangeUserRoleModel(
        member: null,
        project: 0,
        role: '',
        createdAt: null,
        updatedAt: null,
        errorMessage: errorMessage,
      );
}

class Member {
  String username;
  String email;
  String image;
  String howToUseWebsite;
  String whatDoYouDo;
  String howDidYouGetHere;
  DateTime createdAt;
  DateTime updatedAt;

  Member({
    required this.username,
    required this.email,
    required this.image,
    required this.howToUseWebsite,
    required this.whatDoYouDo,
    required this.howDidYouGetHere,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Member.fromJson(Map<String, dynamic> json) => Member(
        username: json["username"],
        email: json["email"],
        image: json["image"],
        howToUseWebsite: json["how_to_use_website"],
        whatDoYouDo: json["what_do_you_do"],
        howDidYouGetHere: json["how_did_you_get_here"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "email": email,
        "image": image,
        "how_to_use_website": howToUseWebsite,
        "what_do_you_do": whatDoYouDo,
        "how_did_you_get_here": howDidYouGetHere,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
