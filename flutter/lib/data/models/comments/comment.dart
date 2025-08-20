
class Comment {
  final int id;
  final int task;
  final CommentUser user;
  final String body;
  final DateTime createdAt;
  final DateTime updatedAt;

  Comment({
    required this.id,
    required this.task,
    required this.user,
    required this.body,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'] ?? 0,
      task: json['task'] ?? 0,
      user: CommentUser.fromJson(json['user'] ?? {}),
      body: json['body'] ?? '',
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updated_at'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'task': task,
      'user': user.toJson(),
      'body': body,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
class CommentUser {
  final int id;
  final String username;

  CommentUser({
    required this.id,
    required this.username,
  });

  factory CommentUser.fromJson(Map<String, dynamic> json) {
    return CommentUser(
      id: json['id'] ?? 0,
      username: json['username'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
    };
  }
}
