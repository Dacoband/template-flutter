import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_cart_test/data/repositories/fake_live_stream_repository.dart';
import 'package:stream_cart_test/presentation/blocs/livestream/livestream_event.dart';
import 'package:stream_cart_test/presentation/blocs/livestream/livestream_state.dart';

class LiveStreamBloc extends Bloc<LiveStreamEvent, LiveStreamState> {
  final FakeLiveStreamRepository _liveStreamRepository;

  LiveStreamBloc(this._liveStreamRepository) : super(LiveStreamInitial()) {
    on<FetchActiveLiveStreamsEvent>(_onFetchActiveLiveStreams);
    on<FetchLiveStreamDetailsEvent>(_onFetchLiveStreamDetails);
    on<FetchProductsInLiveStreamEvent>(_onFetchProductsInLiveStream);
    on<JoinLiveStreamEvent>(_onJoinLiveStream);
    on<LeaveLiveStreamEvent>(_onLeaveLiveStream);
    on<LikeLiveStreamEvent>(_onLikeLiveStream);
    on<ShareLiveStreamEvent>(_onShareLiveStream);
  }

  Future<void> _onFetchActiveLiveStreams(
    FetchActiveLiveStreamsEvent event,
    Emitter<LiveStreamState> emit,
  ) async {
    emit(LiveStreamLoading());
    try {
      final liveStreams = await _liveStreamRepository.getActiveLiveStreams();
      emit(ActiveLiveStreamsLoaded(liveStreams));
    } catch (e) {
      emit(LiveStreamError(e.toString()));
    }
  }

  Future<void> _onFetchLiveStreamDetails(
    FetchLiveStreamDetailsEvent event,
    Emitter<LiveStreamState> emit,
  ) async {
    emit(LiveStreamLoading());
    try {
      final liveStream = await _liveStreamRepository.getLiveStreamById(event.liveStreamId);
      emit(LiveStreamDetailsLoaded(liveStream));
    } catch (e) {
      emit(LiveStreamError(e.toString()));
    }
  }

  Future<void> _onFetchProductsInLiveStream(
    FetchProductsInLiveStreamEvent event,
    Emitter<LiveStreamState> emit,
  ) async {
    try {
      final products = await _liveStreamRepository.getProductsInLiveStream(event.liveStreamId);
      emit(LiveStreamProductsLoaded(products: products, liveStreamId: event.liveStreamId));
    } catch (e) {
      emit(LiveStreamError(e.toString()));
    }
  }

  Future<void> _onJoinLiveStream(
    JoinLiveStreamEvent event,
    Emitter<LiveStreamState> emit,
  ) async {
    try {
      // Giả lập kết nối RTMP/WebRTC
      await Future.delayed(const Duration(seconds: 1));
      
      emit(LiveStreamJoined(
        liveStreamId: event.liveStreamId,
        userId: event.userId,
        joinTime: DateTime.now(),
      ));
      
      // Nạp chi tiết livestream sau khi tham gia
      add(FetchLiveStreamDetailsEvent(event.liveStreamId));
    } catch (e) {
      emit(LiveStreamError(e.toString()));
    }
  }

  Future<void> _onLeaveLiveStream(
    LeaveLiveStreamEvent event,
    Emitter<LiveStreamState> emit,
  ) async {
    try {
      // Giả lập ngắt kết nối RTMP/WebRTC
      await Future.delayed(const Duration(milliseconds: 500));
      
      emit(LiveStreamInitial());
    } catch (e) {
      emit(LiveStreamError(e.toString()));
    }
  }

  Future<void> _onLikeLiveStream(
    LikeLiveStreamEvent event,
    Emitter<LiveStreamState> emit,
  ) async {
    // Không cần triển khai logic thực tế vì đây là dữ liệu mẫu
    try {
      // Lấy thông tin livestream hiện tại
      final liveStream = await _liveStreamRepository.getLiveStreamById(event.liveStreamId);
      
      // Giả lập việc tăng lượt like
      final updatedLiveStream = liveStream.copyWith(
        likeCount: liveStream.likeCount + 1,
      );
      
      emit(LiveStreamDetailsLoaded(updatedLiveStream));
    } catch (e) {
      emit(LiveStreamError(e.toString()));
    }
  }

  Future<void> _onShareLiveStream(
    ShareLiveStreamEvent event,
    Emitter<LiveStreamState> emit,
  ) async {
    // Giả lập chia sẻ livestream
    try {
      await Future.delayed(const Duration(milliseconds: 300));
      
      // Có thể thực hiện các hành động khác sau khi chia sẻ
      // Ví dụ: cập nhật số lượt chia sẻ
      
      // Lấy thông tin livestream hiện tại
      final liveStream = await _liveStreamRepository.getLiveStreamById(event.liveStreamId);
      emit(LiveStreamDetailsLoaded(liveStream));
    } catch (e) {
      emit(LiveStreamError(e.toString()));
    }
  }
}
