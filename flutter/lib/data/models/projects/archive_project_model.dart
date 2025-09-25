class ArchiveProjectModel {
  int id;
  String title;
  String color;
  bool ended;
  int workspace;
  dynamic parentProject;
  List<MemberElement> members;
  DateTime? createdAt;
  DateTime? updatedAt;
  String errorMessage;

  ArchiveProjectModel({
    required this.id,
    required this.title,
    required this.color,
    required this.ended,
    required this.workspace,
    required this.parentProject,
    required this.members,
    required this.createdAt,
    required this.updatedAt,
    required this.errorMessage,
  });

  factory ArchiveProjectModel.onSuccess(Map<String, dynamic> json) =>
      ArchiveProjectModel(
        id: json["id"],
        title: json["title"],
        color: json["color"],
        ended: json["ended"],
        workspace: json["workspace"],
        parentProject: json["parent_project"],
        members: List<MemberElement>.from(
            json["members"].map((x) => MemberElement.fromJson(x))),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        errorMessage: '',
      );

  factory ArchiveProjectModel.onError(Map<String, dynamic> json) =>
      ArchiveProjectModel(
        id: 0,
        title: '',
        color: '',
        ended: false,
        workspace: 0,
        parentProject: 0,
        members: [],
        createdAt: null,
        updatedAt: null,
        errorMessage: json["detail"] ?? json["message"],
      );

  factory ArchiveProjectModel.error(String errorMessage) =>
      ArchiveProjectModel(
        id: 0,
        title: '',
        color: '',
        ended: false,
        workspace: 0,
        parentProject: 0,
        members: [],
        createdAt: null,
        updatedAt: null,
        errorMessage: errorMessage,
      );
}

class MemberElement {
  MemberMember member;
  String role;
  DateTime createdAt;
  DateTime updatedAt;

  MemberElement({
    required this.member,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MemberElement.fromJson(Map<String, dynamic> json) => MemberElement(
        member: MemberMember.fromJson(json["member"]),
        role: json["role"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "member": member.toJson(),
        "role": role,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class MemberMember {
  int id;
  String username;
  String email;
  String image;
  String howToUseWebsite;
  String whatDoYouDo;
  String howDidYouGetHere;
  DateTime createdAt;
  DateTime updatedAt;

  MemberMember({
    required this.id,
    required this.username,
    required this.email,
    required this.image,
    required this.howToUseWebsite,
    required this.whatDoYouDo,
    required this.howDidYouGetHere,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MemberMember.fromJson(Map<String, dynamic> json) => MemberMember(
        id: json["id"],
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
        "id": id,
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
