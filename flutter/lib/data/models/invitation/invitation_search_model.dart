class InvitationSearchModel {
  int count;
  dynamic next;
  dynamic previous;
  List<Result> results;
  String errorMessage;

  InvitationSearchModel({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
    required this.errorMessage,
  });

  factory InvitationSearchModel.onSuccess(Map<String, dynamic> json) =>
      InvitationSearchModel(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
        errorMessage: '',
      );

  factory InvitationSearchModel.onError(Map<String, dynamic> json) =>
      InvitationSearchModel(
        count: json["count"] ?? '',
        next: json["next"] ?? '',
        previous: json["previous"] ?? '',
        results: json["results"] == null
            ? []
            : List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
        errorMessage: json["detail"],
      );

  factory InvitationSearchModel.error(String errorMessage) =>
      InvitationSearchModel(
        count: 0,
        next: '',
        previous: '',
        results:  [],
        errorMessage: errorMessage,
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class Result {
  int id;
  String username;
  String email;
  String image;
  DateTime createdAt;
  DateTime updatedAt;

  Result({
    required this.id,
    required this.username,
    required this.email,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        username: json["username"],
        email: json["email"],
        image: json["image"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "email": email,
        "image": image,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
