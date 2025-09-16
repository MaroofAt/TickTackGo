import '../comments/comment.dart';
import '../user/user.dart';

class ListIssuesModel {
  int id;
  String title;
  String description;
  CommentUser user;
  bool solved;
  Project project;

  ListIssuesModel({
    required this.id,
    required this.title,
    required this.description,
    required this.user,
    required this.solved,
    required this.project,
  });

  factory ListIssuesModel.fromJson(Map<String, dynamic> json) {
    return ListIssuesModel(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      user: CommentUser.fromJson(json['user']),
      solved: json['solved'] as bool,
      project: Project.fromJson(json['project']),
    );
  }
  ListIssuesModel copyWith({
    int? id,
    String? title,
    String? description,
    CommentUser? user,
    bool? solved,
    Project? project,
  }) {
    return ListIssuesModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      user: user ?? this.user,
      solved: solved ?? this.solved,
      project: project ?? this.project,
    );
  }
}

class Project {
  int id;
  String title;

  Project({
    required this.id,
    required this.title,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['id'] as int,
      title: json['title'] as String,
    );
  }

}
