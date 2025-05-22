import 'package:equatable/equatable.dart';
import 'package:stream_cart_test/domain/entities/comment.dart';

abstract class CommentState extends Equatable {
  const CommentState();

  @override
  List<Object?> get props => [];
}

class CommentInitial extends CommentState {}

class CommentLoading extends CommentState {}

class CommentsLoaded extends CommentState {
  final List<Comment> comments;
  final String liveStreamId;

  const CommentsLoaded({
    required this.comments,
    required this.liveStreamId,
  });

  @override
  List<Object?> get props => [comments, liveStreamId];
}

class CommentAdded extends CommentState {
  final Comment comment;

  const CommentAdded(this.comment);

  @override
  List<Object?> get props => [comment];
}

class ReactionAdded extends CommentState {
  final Comment comment;

  const ReactionAdded(this.comment);

  @override
  List<Object?> get props => [comment];
}

class CommentError extends CommentState {
  final String message;

  const CommentError(this.message);

  @override
  List<Object?> get props => [message];
}
