import 'package:equatable/equatable.dart';

class Comment extends Equatable {
  final String id;
  final String userId;
  final String userName;
  final String userAvatar;
  final String content;
  final DateTime timestamp;
  final String? productId; // Nếu comment liên quan đến sản phẩm
  final String liveStreamId;
  final List<CommentReaction> reactions;

  const Comment({
    required this.id,
    required this.userId,
    required this.userName,
    required this.userAvatar,
    required this.content,
    required this.timestamp,
    this.productId,
    required this.liveStreamId,
    this.reactions = const [],
  });

  @override
  List<Object?> get props => [
        id,
        userId,
        userName,
        userAvatar,
        content,
        timestamp,
        productId,
        liveStreamId,
        reactions,
      ];

  Comment copyWith({
    String? id,
    String? userId,
    String? userName,
    String? userAvatar,
    String? content,
    DateTime? timestamp,
    String? productId,
    String? liveStreamId,
    List<CommentReaction>? reactions,
  }) {
    return Comment(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      userAvatar: userAvatar ?? this.userAvatar,
      content: content ?? this.content,
      timestamp: timestamp ?? this.timestamp,
      productId: productId ?? this.productId,
      liveStreamId: liveStreamId ?? this.liveStreamId,
      reactions: reactions ?? this.reactions,
    );
  }
}

class CommentReaction extends Equatable {
  final String userId;
  final String userName;
  final ReactionType type;

  const CommentReaction({
    required this.userId,
    required this.userName,
    required this.type,
  });

  @override
  List<Object> get props => [userId, userName, type];
}

enum ReactionType {
  like,
  heart,
  laugh,
  wow,
  sad,
  angry,
}

extension ReactionTypeExtension on ReactionType {
  String get emoji {
    switch (this) {
      case ReactionType.like:
        return '👍';
      case ReactionType.heart:
        return '❤️';
      case ReactionType.laugh:
        return '😂';
      case ReactionType.wow:
        return '😮';
      case ReactionType.sad:
        return '😢';
      case ReactionType.angry:
        return '😡';
    }
  }
}
