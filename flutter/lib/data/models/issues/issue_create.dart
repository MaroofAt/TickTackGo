class Issue {
  int id;
  String title;
  String description;
  User user;
  bool solved;
  Project project;

  Issue({
    required this.id,
    required this.title,
    required this.description,
    required this.user,
    required this.solved,
    required this.project,
  });

}

class Project {
  int id;
  String title;

  Project({
    required this.id,
    required this.title,
  });

}

class User {
  int id;
  String username;

  User({
    required this.id,
    required this.username,
  });

}
