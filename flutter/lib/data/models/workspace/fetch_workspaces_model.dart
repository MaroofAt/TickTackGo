class FetchWorkspacesModel {
  int id;
  String title;
  String description;
  dynamic image;
  Owner? owner;
  List<Member> members;
  List<Project> projects;
  DateTime? createdAt;
  DateTime? updatedAt;
  String errorMessage;

  FetchWorkspacesModel({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.owner,
    required this.members,
    required this.projects,
    required this.createdAt,
    required this.updatedAt,
    required this.errorMessage,
  });

  factory FetchWorkspacesModel.onSuccess(Map<String, dynamic> json) =>
      FetchWorkspacesModel(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        image: json["image"],
        owner: Owner.fromJson(json["owner"]),
        members:
        List<Member>.from(json["members"].map((x) => Member.fromJson(x))),
        projects: List<Project>.from(
            json["projects"].map((x) => Project.fromJson(x))),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        errorMessage: '',
      );

  factory FetchWorkspacesModel.onError(Map<String, dynamic> json) =>
      FetchWorkspacesModel(
        id: json["id"]??0,
        title: json["title"]??'',
        description: json["description"]??'',
        image: json["image"] ?? '',
        owner: null,
        members: [],
        projects: [],
        createdAt: null,
        updatedAt: null,
        errorMessage: json["detail"] ?? json["message"],
      );

  factory FetchWorkspacesModel.error(String errorMessage) =>
      FetchWorkspacesModel(
        id: 0,
        title: '',
        description: '',
        image:  '',
        owner: null,
        members: [],
        projects: [],
        createdAt: null,
        updatedAt: null,
        errorMessage: errorMessage,
      );

}

class Member {
  Owner member;
  String role;
  DateTime createdAt;
  DateTime updatedAt;

  Member({
    required this.member,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Member.fromJson(Map<String, dynamic> json) => Member(
    member: Owner.fromJson(json["member"]),
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

class Owner {
  String username;
  String email;
  String image;
  String howToUseWebsite;
  String whatDoYouDo;
  String howDidYouGetHere;
  DateTime createdAt;
  DateTime updatedAt;

  Owner({
    required this.username,
    required this.email,
    required this.image,
    required this.howToUseWebsite,
    required this.whatDoYouDo,
    required this.howDidYouGetHere,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Owner.fromJson(Map<String, dynamic> json) => Owner(
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

class Project {
  int id;
  String title;
  String color;
  bool ended;
  List<Project> subProjects;

  Project({
    required this.id,
    required this.title,
    required this.color,
    required this.ended,
    required this.subProjects,
  });

  factory Project.fromJson(Map<String, dynamic> json) => Project(
    id: json["id"],
    title: json["title"],
    color: json["color"],
    ended: json["ended"],
    subProjects: List<Project>.from(
        json["sub_projects"].map((x) => Project.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "color": color,
    "ended": ended,
    "sub_projects": List<dynamic>.from(subProjects.map((x) => x.toJson())),
  };
}
