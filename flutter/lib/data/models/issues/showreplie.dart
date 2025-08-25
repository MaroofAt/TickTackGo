import 'package:pr1/data/models/comments/comment.dart';
import '../user/user.dart';

class ShowReplie {
  final int id;
  final String body;
  final int issue;
  final CommentUser user;

  ShowReplie({
    required this.id,
    required this.body,
    required this.issue,
    required this.user,
  });

  factory ShowReplie.fromJson(Map<String, dynamic> json) {
    return ShowReplie(
      id: json['id'] ?? 0,
      body: json['body'] ?? "",
      issue: json['issue'] ?? 0,
      user: CommentUser.fromJson(json['user'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'body': body,
      'issue': issue,
      'user': user.toJson(),
    };
  }
}
