import '../../data/models/issues/list_issues_model.dart';

String all="All";
// String number_of_issues_notsolved="$notSolvedIssuesCount";
// String number_of_all_solvedornot="${sampleIssuesreally.length}";
// String number_of_related="$notSolvedIssuesCount";
String related="NotSolved";
final List<String> allIssues = [
  'Issue 1: Button not working',
  'Issue 2: Page loading slow',
  'Issue 3: UI alignment problem',
  'Issue 4: Database connection error',
];

final List<String> relatedIssues = [
  'Related Issue 1: Similar to your last report',
  'Related Issue 2: Reported by your team',
  'Related Issue 3: In your department',
];
final List<String> allcomment = [
  'comment 1: Button not working',
  'comment 2: Page loading slow',

];
// final List<Issue> sampleIssues = [
//   Issue(
//     id: '1',
//     authorId: '1',
//     title: 'Login Issue',
//     description: 'Users cannot login after latest app update',
//     projectId: 'project_123',
//     isResolved: false,
//     createdAt: DateTime(2023, 5, 10),
//     updatedAt: DateTime(2023, 5, 15),
//     comments: [
//       Comment(
//         id: 11,
//         task: 1,
//         user: CommentUser(id: 101, username: 'ali'),
//         body: 'Have you tried resetting password?',
//         createdAt: DateTime(2023, 5, 11),
//         updatedAt: DateTime(2023, 5, 11),
//       ),
//     ],
//   ),
//   Issue(
//     id: '2',
//     authorId: '1',
//     title: 'UI Design Improvement',
//     description: 'Homepage needs better visual hierarchy',
//     projectId: 'project_456',
//     isResolved: true,
//     createdAt: DateTime(2023, 4, 20),
//     updatedAt: DateTime(2023, 5, 1),
//     comments: [
//       Comment(
//         id: 22,
//         task: 2,
//         user: CommentUser(id: 102, username: 'layla'),
//         body: 'New design mockups completed',
//         createdAt: DateTime(2023, 4, 25),
//         updatedAt: DateTime(2023, 4, 25),
//       ),
//     ],
//   ),
//   Issue(
//     id: '3',
//     authorId: '1',
//     title: 'Calculation Error',
//     description: 'Numbers not adding correctly in reports',
//     projectId: 'project_123',
//     isResolved: false,
//     createdAt: DateTime(2023, 5, 5),
//     updatedAt: DateTime(2023, 5, 5),
//     comments: [],
//   ),
//   Issue(
//     id: '4',
//     authorId: '1',
//     title: 'Performance Issue',
//     description: 'Dashboard takes too long to load',
//     projectId: 'project_789',
//     isResolved: false,
//     createdAt: DateTime(2023, 5, 12),
//     updatedAt: DateTime(2023, 5, 14),
//     comments: [
//       Comment(
//         id: 41,
//         task: 4,
//         user: CommentUser(id: 103, username: 'omar'),
//         body: 'This appears to be a server-side issue',
//         createdAt: DateTime(2023, 5, 13),
//         updatedAt: DateTime(2023, 5, 13),
//       ),
//       Comment(
//         id: 42,
//         task: 4,
//         user: CommentUser(id: 104, username: 'sara'),
//         body: 'We are working on a fix',
//         createdAt: DateTime(2023, 5, 14),
//         updatedAt: DateTime(2023, 5, 14),
//       ),
//     ],
//   ),
// ];
late final List<ListIssuesModel> sampleIssuesreally;
// = [
//   ListIssuesModel(
//     id: 1,
//     title: 'Login Issue',
//     description: 'Users cannot login after latest app update',
//     user: CommentUser(id: 1, username: 'author1'),
//     solved: false,
//     project: Project(id: 123, title: 'Project 123'),
//   ),
//   ListIssuesModel(
//     id: 2,
//     title: 'UI Design Improvement',
//     description: 'Homepage needs better visual hierarchy',
//     user: CommentUser(id: 1, username: 'author1'),
//     solved: true,
//     project: Project(id: 456, title: 'Project 456'),
//   ),
//   ListIssuesModel(
//     id: 3,
//     title: 'Calculation Error',
//     description: 'Numbers not adding correctly in reports',
//     user: CommentUser(id: 1, username: 'author1'),
//     solved: false,
//     project: Project(id: 123, title: 'Project 123'),
//   ),
//   ListIssuesModel(
//     id: 4,
//     title: 'Performance Issue',
//     description: 'Dashboard takes too long to load',
//     user: CommentUser(id: 1, username: 'author1'),
//     solved: false,
//     project: Project(id: 789, title: 'Project 789'),
//   ),
// ];


// final int notSolvedIssuesCount = sampleIssuesreally.where((issue) => !issue.solved).length;
// final List<Issue> unsolvedIssues = sampleIssues.where((issue) => !issue.isResolved).toList();