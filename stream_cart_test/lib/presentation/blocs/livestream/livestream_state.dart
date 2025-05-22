import 'package:equatable/equatable.dart';
import 'package:stream_cart_test/domain/entities/live_stream.dart';

abstract class LiveStreamState extends Equatable {
  const LiveStreamState();

  @override
  List<Object?> get props => [];
}

class LiveStreamInitial extends LiveStreamState {}

class LiveStreamLoading extends LiveStreamState {}

class ActiveLiveStreamsLoaded extends LiveStreamState {
  final List<LiveStream> liveStreams;

  const ActiveLiveStreamsLoaded(this.liveStreams);

  @override
  List<Object?> get props => [liveStreams];
}

class LiveStreamDetailsLoaded extends LiveStreamState {
  final LiveStream liveStream;

  const LiveStreamDetailsLoaded(this.liveStream);

  @override
  List<Object?> get props => [liveStream];
}

class LiveStreamProductsLoaded extends LiveStreamState {
  final List<Product> products;
  final String liveStreamId;

  const LiveStreamProductsLoaded({
    required this.products,
    required this.liveStreamId,
  });

  @override
  List<Object?> get props => [products, liveStreamId];
}

class LiveStreamJoined extends LiveStreamState {
  final String liveStreamId;
  final String userId;
  final DateTime joinTime;

  const LiveStreamJoined({
    required this.liveStreamId,
    required this.userId,
    required this.joinTime,
  });

  @override
  List<Object?> get props => [liveStreamId, userId, joinTime];
}

class LiveStreamError extends LiveStreamState {
  final String message;

  const LiveStreamError(this.message);

  @override
  List<Object?> get props => [message];
}
