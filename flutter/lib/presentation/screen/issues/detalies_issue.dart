import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pr1/business_logic/replay/replay_cubit.dart'; // ✅ استورد الريلاي كيوبيت
import 'package:pr1/business_logic/replay/replay_state.dart'; // ✅ استورد الستيتات تبعو
import 'package:pr1/business_logic/issues/issues_cubit.dart';
import 'package:pr1/core/constance/colors.dart';
import '../../../core/constance/constance.dart';
import '../../widgets/creatTextFiled.dart';

class IssueDetails extends StatefulWidget {
  const IssueDetails({super.key});

  @override
  State<IssueDetails> createState() => _IssueDetailsState();
}

class _IssueDetailsState extends State<IssueDetails> {
  final TextEditingController commentController = TextEditingController();
  bool updated = false;
  int? issueId;
  int? projectId;

  @override
  void didChangeDependencies() {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final issueid = args["issueId"] as int;
    final projectid = args["projectId"] as int;
    super.didChangeDependencies();
    context.read<IssuesCubit>().fetchSingleIssue(
      issueId: issueId!,
      projectId: projectId!,
    );

    context.read<ReplyCubit>().fetchReplies(
      projectId: projectId!,
      issueId: issueId!,
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: true,
        onPopInvokedWithResult: (didPop, result) {
          if (didPop) {
            // Navigator.pop(context, updated);
          }
        },
        child: BlocBuilder<IssuesCubit, IssuesState>(
          builder: (context, state) {
            if (state is IssueLoadedSingle) {
              final issue = state.issue;
              return Scaffold(
                backgroundColor: primaryColor,
                appBar: AppBar(
                  backgroundColor: primaryColor,
                  title: Row(
                    children: [
                      Expanded(
                        child: Text(
                          issue.title,
                          style: const TextStyle(
                              color: white,
                              fontSize: 24,
                              fontFamily: 'PTSerif'),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                      const Spacer(),
                      const Icon(Icons.list, color: ampleOrange),
                    ],
                  ),
                  leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context, updated);
                    },
                    icon:
                        const Icon(Icons.arrow_back_sharp, color: ampleOrange),
                  ),
                ),
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const SizedBox(width: 20),
                        Expanded(
                          child: ListTile(
                            title: Text(
                              issue.description,
                              style: const TextStyle(
                                  color: white,
                                  fontSize: 20,
                                  fontFamily: 'PTSerif'),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 10),
                          padding: const EdgeInsets.all(10),
                          width: width(context) * 0.2,
                          height: height(context) * 0.1,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(40)),
                            color: ampleOrange,
                          ),
                          child: IconButton(
                            onPressed: () async {
                              await context.read<IssuesCubit>().marksolved(
                                  projectId: projectId!,
                                  context: context,
                                  issueID: issueId!);
                              setState(() {
                                updated = true;
                              });
                            },
                            icon: issue.solved
                                ? const Icon(Icons.check,
                                    color: Colors.white, size: 30)
                                : const Icon(Icons.close,
                                    color: Colors.white, size: 30),
                          ),
                        ),
                        const SizedBox(width: 10),
                      ],
                    ),
                    Container(
                      margin:
                          const EdgeInsets.only(left: 15, top: 10, bottom: 10),
                      child: CreateTextField(
                        iconsuf: IconButton(
                          onPressed: () {
                            if (commentController.text.isNotEmpty) {
                              context.read<ReplyCubit>().createReply(
                                    body: commentController.text,
                                    issueId: issueId!,
                                    projectId: projectId!,
                                  );
                              commentController.clear();
                            }
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Reply added successfully')),
                            );
                          },
                          icon: const Icon(Icons.send, color: parrotGreen),
                        ),
                        fillcolor: ampleOrange.withOpacity(0.2),
                        text: "Your reply",
                        icon: const Icon(Icons.comment, color: parrotGreen),
                        controller: commentController,
                      ),
                    ),
                    Expanded(
                      child: BlocBuilder<ReplyCubit, ReplyState>(
                        builder: (context, state) {
                          if (state is ReplyLoading) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (state is ReplyLoaded) {
                            final replies = state.replies;
                            if (replies.isEmpty) {
                              return const Center(
                                  child: Text("No replies yet"));
                            }
                            return ListView.builder(
                              itemCount: replies.length,
                              itemBuilder: (context, index) {
                                final reply = replies[index];
                                return Stack(
                                  children: [
                                    Card(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 18, vertical: 5),
                                      color: Colors.grey[800],
                                      child: ListTile(
                                        title: Text(
                                          reply.body,
                                          style: const TextStyle(color: white),
                                        ),
                                        subtitle: Text(
                                          "By ${reply.user.username}",
                                          style: const TextStyle(
                                              color: Colors.grey),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 10,
                                      top: 20,
                                      child: Container(
                                        width: 20,
                                        height: 40,
                                        decoration: const BoxDecoration(
                                          color: ampleOrange,
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(400),
                                            topLeft: Radius.circular(400),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          } else if (state is ReplyError) {
                            return Center(
                                child: Text("Error: ${state.message}"));
                          } else {
                            return const SizedBox.shrink();
                          }
                        },
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is IssueLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is IssueError) {
              return Center(child: Text("Error: ${state.message}"));
            } else {
              return const Center(child: Text("Loading..."));
            }
          },
        ));
  }
}
