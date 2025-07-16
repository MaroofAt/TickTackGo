import 'package:pr1/data/models/user/user.dart';

class AllUser {
  final int count;
  final String? next;
  final String? previous;
  final List<User> results;

  AllUser({
    required this.count,
    this.next,
    this.previous,
    required this.results,
  });

  factory AllUser.fromJson(Map<String, dynamic> json) {
    return AllUser(
      count: json['count'],
      next: json['next'],
      previous: json['previous'],
      results: (json['results'] as List)
          .map((user) => User.fromJson(user))
          .toList(),
    );
  }
}