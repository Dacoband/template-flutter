import 'package:equatable/equatable.dart';
import 'package:stream_cart_test/domain/entities/comment.dart';

abstract class CommentEvent extends Equatable {
  const CommentEvent();

  @override
  List<Object?> get props => [];
}

class FetchCommentsEvent extends CommentEvent {
  final String liveStreamId;

  const FetchCommentsEvent(this.liveStreamId);

  @override
  List<Object?> get props => [liveStreamId];
}

class AddCommentEvent extends CommentEvent {
  final String liveStreamId;
  final String userId;
  final String userName;
  final String userAvatar;
  final String content;
  final String? productId;

  const AddCommentEvent({
    required this.liveStreamId,
    required this.userId,
    required this.userName,
    required this.userAvatar,
    required this.content,
    this.productId,
  });

  @override
  List<Object?> get props => [liveStreamId, userId, userName, userAvatar, content, productId];
}

class AddReactionEvent extends CommentEvent {
  final String commentId;
  final String userId;
  final String userName;
  final ReactionType reactionType;

  const AddReactionEvent({
    required this.commentId,
    required this.userId,
    required this.userName,
    required this.reactionType,
  });

  @override
  List<Object?> get props => [commentId, userId, userName, reactionType];
}

class ReceiveNewCommentEvent extends CommentEvent {
  final Comment comment;

  const ReceiveNewCommentEvent(this.comment);

  @override
  List<Object?> get props => [comment];
}
