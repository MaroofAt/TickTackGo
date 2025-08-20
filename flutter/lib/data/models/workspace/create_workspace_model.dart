class CreateWorkspaceModel {
  int id;
  String title;
  String description;
  dynamic image;
  Owner? owner;
  List<dynamic> members;
  List<dynamic> projects;
  DateTime? createdAt;
  DateTime? updatedAt;
  String errorMessage;

  CreateWorkspaceModel({
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

  factory CreateWorkspaceModel.onSuccess(Map<String, dynamic> json) =>
      CreateWorkspaceModel(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        image: json["image"],
        owner: Owner.fromJson(json["owner"]),
        members: List<dynamic>.from(json["members"].map((x) => x)),
        projects: List<dynamic>.from(json["projects"].map((x) => x)),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        errorMessage: '',
      );

  factory CreateWorkspaceModel.onError(Map<String, dynamic> json) =>
      CreateWorkspaceModel(
        id: 0,
        title: '',
        description: '',
        image: '',
        owner: null,
        members: [],
        projects: [],
        createdAt: null,
        updatedAt: null,
        errorMessage: json["detail"] ?? json["message"],
      );

  factory CreateWorkspaceModel.error(String errorMessage) =>
      CreateWorkspaceModel(
        id: 0,
        title: '',
        description: '',
        image: '',
        owner: null,
        members: [],
        projects: [],
        createdAt: null,
        updatedAt: null,
        errorMessage: errorMessage,
      );
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
