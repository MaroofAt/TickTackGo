import '../../data/models/comments/comment.dart';
import '../../data/models/issues/issue_model.dart';

String all="All";
String number_of_issues_notsolved="$notSolvedIssuesCount";
String number_of_all_solvedornot="${sampleIssues.length}";
String number_of_related="$notSolvedIssuesCount";
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
final List<Issue> sampleIssues = [
  Issue(
    id: '1',
    authorId:'1',
    title: 'Login Issue',
    description: 'Users cannot login after latest app update',
    projectId: 'project_123',
    isResolved: false,
    createdAt: DateTime(2023, 5, 10),
    updatedAt: DateTime(2023, 5, 15),
    comments: [
      Comment(
        id: 'c1',
        content: 'Have you tried resetting password?',
        authorName: 'Ahmed',
        createdAt: DateTime(2023, 5, 11),
      ),
    ],
  ),
  Issue(
    id: '2',
    authorId:'1',
    title: 'UI Design Improvement',
    description: 'Homepage needs better visual hierarchy',
    projectId: 'project_456',
    isResolved: true,
    createdAt: DateTime(2023, 4, 20),
    updatedAt: DateTime(2023, 5, 1),
    comments: [
      Comment(
        id: 'c2',
        content: 'New design mockups completed',
        authorName: 'Sarah',
        createdAt: DateTime(2023, 4, 25),
      ),
    ],
  ),
  Issue(
    id: '3',
    title: 'Calculation Error',
    authorId:'1',

    description: 'Numbers not adding correctly in reports',
    isResolved: false,
    createdAt: DateTime(2023, 5, 5),
    updatedAt: DateTime(2023, 5, 5), projectId: 'project_123',
  ),
  Issue(
    id: '4',
    authorId:'1',

    title: 'Performance Issue',
    description: 'Dashboard takes too long to load',
    projectId: 'project_789',
    isResolved: false,

    createdAt: DateTime(2023, 5, 12),
    updatedAt: DateTime(2023, 5, 14),
    comments: [
      Comment(
        id: 'c3',
        content: 'This appears to be a server-side issue',
        authorName: 'Ali',
        createdAt: DateTime(2023, 5, 13),
      ),
      Comment(
        id: 'c4',
        content: 'We are working on a fix',
        authorName: 'Support Team',
        createdAt: DateTime(2023, 5, 14),
      ),
    ],
  ),
];
final int notSolvedIssuesCount = sampleIssues.where((issue) => !issue.isResolved).length;
final List<Issue> unsolvedIssues = sampleIssues.where((issue) => !issue.isResolved).toList();