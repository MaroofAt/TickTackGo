class CreateWorkspaceModel {
  int id;
  String title;
  String description;
  dynamic image;
  Owner? owner;
  List<dynamic> members;
  String code;
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
    required this.code,
    required this.createdAt,
    required this.updatedAt,
    required this.errorMessage,
  });

  factory CreateWorkspaceModel.onSuccess(Map<String, dynamic> json) =>
      CreateWorkspaceModel(
        id: json["id"]??0,
        title: json["title"]??'',
        description: json["description"]??'',
        image: json["image"]??'',
        owner: Owner.fromJson(json["owner"]),
        members: List<dynamic>.from(json["members"].map((x) => x)),
        code: json["code"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        errorMessage: '',
      );

  factory CreateWorkspaceModel.onError(Map<String, dynamic> json) =>
      CreateWorkspaceModel(
        id: json["id"]??'',
        title: json["title"]??'',
        description: json["description"]??'',
        image: json["image"]??'',
        owner: Owner.fromJson(json["owner"]),
        members: List<dynamic>.from(json["members"].map((x) => x)),
        code: json["code"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        errorMessage: json["detail"],
      );

  factory CreateWorkspaceModel.error(String message) =>
      CreateWorkspaceModel(
        id: 0,
        title: '',
        description: '',
        image: '',
        owner: null,
        members: [],
        code: '',
        createdAt: null,
        updatedAt: null,
        errorMessage: message,
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
}
