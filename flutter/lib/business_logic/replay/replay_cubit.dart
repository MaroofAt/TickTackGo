import 'package:bloc/bloc.dart';
import 'package:pr1/business_logic/replay/replay_state.dart';
import '../../core/API/issues.dart';

class ReplyCubit extends Cubit<ReplyState> {
  final IssueApi _issueApi;

  ReplyCubit(this._issueApi) : super(ReplyInitial());

  Future<void> fetchReplies({
    required int projectId,
    required int issueId,
  }) async {
    emit(ReplyLoading());
    try {
      final replies = await _issueApi.get_Replie(
        projectId: projectId,
        issueID: issueId,
      );
      emit(ReplyLoaded(replies));
    } catch (e) {
      emit(ReplyError(e.toString()));
    }
  }

  Future<void> createReply({
    required String body,
    required int issueId,
    required int projectId,
  }) async {
    emit(ReplyCreating());
    try {
      await _issueApi.createReplie(
        body: body,
        issueID: issueId,
      );

      final replies = await _issueApi.get_Replie(
        projectId: projectId,
        issueID: issueId,
      );

      emit(ReplyLoaded(replies));
    } catch (e) {
      emit(ReplyError(e.toString()));
    }
  }
}