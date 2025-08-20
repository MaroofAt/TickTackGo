import '../comments/comment.dart';

class Issue {
final String id;
final String title;
final String description;
final String projectId;
final bool isResolved;
final String authorId;
final DateTime createdAt;
final DateTime updatedAt;
final List<Comment> comments;

Issue({
  required this.authorId,
  required this.id,
required this.title,
required this.description,
required this.projectId,
this.isResolved = false,
required this.createdAt,
required this.updatedAt,
List<Comment>? comments,
}) : comments = comments ?? [];

bool get isLinkedToProject => projectId != null;
bool get canAddComment => !isResolved;
}