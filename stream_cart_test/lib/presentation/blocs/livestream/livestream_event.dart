import 'package:equatable/equatable.dart';

abstract class LiveStreamEvent extends Equatable {
  const LiveStreamEvent();

  @override
  List<Object?> get props => [];
}

class FetchActiveLiveStreamsEvent extends LiveStreamEvent {}

class FetchLiveStreamDetailsEvent extends LiveStreamEvent {
  final String liveStreamId;

  const FetchLiveStreamDetailsEvent(this.liveStreamId);

  @override
  List<Object?> get props => [liveStreamId];
}

class FetchProductsInLiveStreamEvent extends LiveStreamEvent {
  final String liveStreamId;

  const FetchProductsInLiveStreamEvent(this.liveStreamId);

  @override
  List<Object?> get props => [liveStreamId];
}

class JoinLiveStreamEvent extends LiveStreamEvent {
  final String liveStreamId;
  final String userId;

  const JoinLiveStreamEvent({
    required this.liveStreamId,
    required this.userId,
  });

  @override
  List<Object?> get props => [liveStreamId, userId];
}

class LeaveLiveStreamEvent extends LiveStreamEvent {
  final String liveStreamId;
  final String userId;

  const LeaveLiveStreamEvent({
    required this.liveStreamId,
    required this.userId,
  });

  @override
  List<Object?> get props => [liveStreamId, userId];
}

class LikeLiveStreamEvent extends LiveStreamEvent {
  final String liveStreamId;
  final String userId;

  const LikeLiveStreamEvent({
    required this.liveStreamId,
    required this.userId,
  });

  @override
  List<Object?> get props => [liveStreamId, userId];
}

class ShareLiveStreamEvent extends LiveStreamEvent {
  final String liveStreamId;
  final String userId;

  const ShareLiveStreamEvent({
    required this.liveStreamId,
    required this.userId,
  });

  @override
  List<Object?> get props => [liveStreamId, userId];
}
