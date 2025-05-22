import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_cart_test/data/repositories/fake_live_stream_repository.dart';
import 'package:stream_cart_test/presentation/blocs/comment/comment_event.dart';
import 'package:stream_cart_test/presentation/blocs/comment/comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final FakeLiveStreamRepository _liveStreamRepository;

  CommentBloc(this._liveStreamRepository) : super(CommentInitial()) {
    on<FetchCommentsEvent>(_onFetchComments);
    on<AddCommentEvent>(_onAddComment);
    on<AddReactionEvent>(_onAddReaction);
    on<ReceiveNewCommentEvent>(_onReceiveNewComment);
  }

  Future<void> _onFetchComments(
    FetchCommentsEvent event,
    Emitter<CommentState> emit,
  ) async {
    emit(CommentLoading());
    try {
      final comments = await _liveStreamRepository.getCommentsInLiveStream(event.liveStreamId);
      emit(CommentsLoaded(comments: comments, liveStreamId: event.liveStreamId));
    } catch (e) {
      emit(CommentError(e.toString()));
    }
  }

  Future<void> _onAddComment(
    AddCommentEvent event,
    Emitter<CommentState> emit,
  ) async {
    try {
      final comment = await _liveStreamRepository.addComment(
        event.liveStreamId,
        event.userId,
        event.userName,
        event.userAvatar,
        event.content,
        productId: event.productId,
      );
      
      emit(CommentAdded(comment));
      
      // Sau khi thêm comment, lấy lại toàn bộ danh sách
      add(FetchCommentsEvent(event.liveStreamId));
    } catch (e) {
      emit(CommentError(e.toString()));
    }
  }

  Future<void> _onAddReaction(
    AddReactionEvent event,
    Emitter<CommentState> emit,
  ) async {
    try {
      final updatedComment = await _liveStreamRepository.addReactionToComment(
        event.commentId,
        event.userId,
        event.userName,
        event.reactionType,
      );
      
      emit(ReactionAdded(updatedComment));
      
      // Cập nhật lại danh sách comments
      // Lấy liveStreamId từ comment đã cập nhật
      add(FetchCommentsEvent(updatedComment.liveStreamId));
    } catch (e) {
      emit(CommentError(e.toString()));
    }
  }

  void _onReceiveNewComment(
    ReceiveNewCommentEvent event,
    Emitter<CommentState> emit,
  ) {
    // Khi nhận được comment mới từ WebSocket hoặc từ nguồn khác
    emit(CommentAdded(event.comment));
    
    // Cập nhật lại danh sách comments
    add(FetchCommentsEvent(event.comment.liveStreamId));
  }
}
