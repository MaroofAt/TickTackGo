import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../data/models/comments/comment.dart';
import '../core/API/comments.dart';

part 'comment_state.dart';

class CommentCubit extends Cubit<CommentState> {
  final CommentApi _commentApi;

  CommentCubit(this._commentApi) : super(CommentInitial());

  Future<void> fetchComments(int taskId) async {
    emit(CommentLoading());
    try {
      final comments = await _commentApi.getCommentsForTask(taskId);
      emit(CommentLoaded(comments));
    } catch (e) {
      emit(CommentError(e.toString()));
    }
  }

  Future<void> addComment(int taskId, String body) async {
    emit(CommentSending());
    try {
      await _commentApi.createComment(taskId: taskId, body: body);
      final comments = await _commentApi.getCommentsForTask(taskId);
      emit(CommentLoaded(comments));
    } catch (e) {
      emit(CommentError(e.toString()));
    }
  }
}
