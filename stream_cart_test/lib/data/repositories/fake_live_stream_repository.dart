import 'package:stream_cart_test/domain/entities/comment.dart';
import 'package:stream_cart_test/domain/entities/live_stream.dart';

class FakeLiveStreamRepository {
  // Danh sách sản phẩm giả lập
  final List<Product> _products = [
    Product(
      id: '1',
      name: 'Áo thun oversize unisex cổ tròn basic',
      description: 'Áo thun oversize unisex cổ tròn basic chất liệu cotton cao cấp, thoáng mát, thấm hút mồ hôi tốt.',
      price: 150000,
      discountPrice: 89000,
      imageUrl: 'https://down-vn.img.susercontent.com/file/vn-11134207-7qukw-lf6rk0xfvwl7d1',
      stock: 100,
      categories: ['Áo thun', 'Thời trang nam', 'Thời trang nữ'],
      rating: 4.8,
      soldCount: 5240,
    ),
    Product(
      id: '2',
      name: 'Tai nghe Bluetooth không dây i12 TWS',
      description: 'Tai nghe Bluetooth không dây i12 TWS kết nối nhanh, âm thanh chất lượng, pin trâu.',
      price: 299000,
      discountPrice: 98000,
      imageUrl: 'https://down-vn.img.susercontent.com/file/a949f9708fd6811e64c27e47cfc3f2e7',
      stock: 50,
      categories: ['Phụ kiện điện tử', 'Tai nghe'],
      rating: 4.5,
      soldCount: 12543,
    ),
    Product(
      id: '3',
      name: 'Sạc dự phòng 10000mAh sạc nhanh 22.5W',
      description: 'Sạc dự phòng dung lượng 10000mAh, hỗ trợ sạc nhanh 22.5W, nhỏ gọn dễ mang theo.',
      price: 400000,
      discountPrice: 219000,
      imageUrl: 'https://down-vn.img.susercontent.com/file/sg-11134201-22100-i6olnhbjwyiv6c',
      stock: 30,
      categories: ['Phụ kiện điện tử', 'Sạc dự phòng'],
      rating: 4.9,
      soldCount: 3280,
    ),
    Product(
      id: '4',
      name: 'Quần jean nam baggy ống rộng',
      description: 'Quần jean nam baggy ống rộng phong cách Hàn Quốc, chất vải denim cao cấp.',
      price: 250000,
      discountPrice: 159000,
      imageUrl: 'https://down-vn.img.susercontent.com/file/vn-11134207-7qukw-lfr5pwnwuo2pe8',
      stock: 80,
      categories: ['Quần jean', 'Thời trang nam'],
      rating: 4.7,
      soldCount: 7825,
    ),
    Product(
      id: '5',
      name: 'Bộ skincare dưỡng ẩm trắng da',
      description: 'Bộ skincare dưỡng ẩm trắng da gồm sữa rửa mặt, toner, serum và kem dưỡng.',
      price: 500000,
      discountPrice: 245000,
      imageUrl: 'https://down-vn.img.susercontent.com/file/7869a8dad5b734fa93021fb96adcbc6d',
      stock: 20,
      categories: ['Mỹ phẩm', 'Chăm sóc da'],
      rating: 4.6,
      soldCount: 2381,
    ),
  ];

  // Danh sách livestream giả lập
  final List<LiveStream> _liveStreams = [
    LiveStream(
      id: '1',
      title: 'Sale sốc cuối tuần - Giảm đến 70%',
      description: 'Livestream sale sốc cuối tuần với nhiều ưu đãi hấp dẫn, giảm giá lên đến 70% cho các sản phẩm thời trang, mỹ phẩm và phụ kiện điện tử.',
      thumbnailUrl: 'https://cf.shopee.vn/file/sg-11134004-23020-t2h7xnnq4inv9b',
      streamUrl: 'rtmp://example.com/live/stream1',
      userId: '3', // ID của streamer
      userName: 'Streamer',
      userAvatar: 'https://i.pravatar.cc/150?img=3',
      startTime: DateTime.now().subtract(const Duration(minutes: 45)),
      isActive: true,
      viewerCount: 1256,
      likeCount: 845,
      tags: ['Sale', 'Thời trang', 'Mỹ phẩm', 'Điện tử'],
      products: [
        Product(
          id: '1',
          name: 'Áo thun oversize unisex cổ tròn basic',
          description: 'Áo thun oversize unisex cổ tròn basic chất liệu cotton cao cấp, thoáng mát, thấm hút mồ hôi tốt.',
          price: 150000,
          discountPrice: 89000,
          imageUrl: 'https://down-vn.img.susercontent.com/file/vn-11134207-7qukw-lf6rk0xfvwl7d1',
          stock: 100,
          categories: ['Áo thun', 'Thời trang nam', 'Thời trang nữ'],
          rating: 4.8,
          soldCount: 5240,
        ),
        Product(
          id: '2',
          name: 'Tai nghe Bluetooth không dây i12 TWS',
          description: 'Tai nghe Bluetooth không dây i12 TWS kết nối nhanh, âm thanh chất lượng, pin trâu.',
          price: 299000,
          discountPrice: 98000,
          imageUrl: 'https://down-vn.img.susercontent.com/file/a949f9708fd6811e64c27e47cfc3f2e7',
          stock: 50,
          categories: ['Phụ kiện điện tử', 'Tai nghe'],
          rating: 4.5,
          soldCount: 12543,
        ),
        Product(
          id: '3',
          name: 'Sạc dự phòng 10000mAh sạc nhanh 22.5W',
          description: 'Sạc dự phòng dung lượng 10000mAh, hỗ trợ sạc nhanh 22.5W, nhỏ gọn dễ mang theo.',
          price: 400000,
          discountPrice: 219000,
          imageUrl: 'https://down-vn.img.susercontent.com/file/sg-11134201-22100-i6olnhbjwyiv6c',
          stock: 30,
          categories: ['Phụ kiện điện tử', 'Sạc dự phòng'],
          rating: 4.9,
          soldCount: 3280,
        ),
      ],
    ),
    LiveStream(
      id: '2',
      title: 'Review mỹ phẩm mới nhất tháng 5',
      description: 'Cùng review các sản phẩm mỹ phẩm mới ra mắt trong tháng 5, có cả demo và so sánh với các sản phẩm cùng loại.',
      thumbnailUrl: 'https://down-vn.img.susercontent.com/file/vn-11134207-7r98o-lpg0z7vcxnux20',
      streamUrl: 'rtmp://example.com/live/stream2',
      userId: '3', // ID của streamer
      userName: 'Streamer',
      userAvatar: 'https://i.pravatar.cc/150?img=3',
      startTime: DateTime.now().subtract(const Duration(hours: 2)),
      isActive: true,
      viewerCount: 789,
      likeCount: 456,
      tags: ['Mỹ phẩm', 'Review', 'Làm đẹp'],
      products: [
        Product(
          id: '5',
          name: 'Bộ skincare dưỡng ẩm trắng da',
          description: 'Bộ skincare dưỡng ẩm trắng da gồm sữa rửa mặt, toner, serum và kem dưỡng.',
          price: 500000,
          discountPrice: 245000,
          imageUrl: 'https://down-vn.img.susercontent.com/file/7869a8dad5b734fa93021fb96adcbc6d',
          stock: 20,
          categories: ['Mỹ phẩm', 'Chăm sóc da'],
          rating: 4.6,
          soldCount: 2381,
        ),
      ],
    ),
  ];

  // Danh sách comment giả lập
  final List<Comment> _comments = [
    Comment(
      id: '1',
      userId: '1',
      userName: 'Nguyễn Văn A',
      userAvatar: 'https://i.pravatar.cc/150?img=1',
      content: 'Áo đẹp quá shop ơi, có size XL không ạ?',
      timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
      productId: '1',
      liveStreamId: '1',
      reactions: [
        CommentReaction(
          userId: '3',
          userName: 'Streamer',
          type: ReactionType.like,
        ),
      ],
    ),
    Comment(
      id: '2',
      userId: '2',
      userName: 'Admin User',
      userAvatar: 'https://i.pravatar.cc/150?img=2',
      content: 'Chất lượng sản phẩm thế nào shop?',
      timestamp: DateTime.now().subtract(const Duration(minutes: 3)),
      liveStreamId: '1',
      reactions: [],
    ),
    Comment(
      id: '3',
      userId: '3',
      userName: 'Streamer',
      userAvatar: 'https://i.pravatar.cc/150?img=3',
      content: '@Nguyễn Văn A: Shop có đủ size từ S đến XXL bạn nhé, bạn mặc XL thì shop khuyên nên lấy size XXL vì form oversize sẽ đẹp hơn ạ.',
      timestamp: DateTime.now().subtract(const Duration(minutes: 2)),
      productId: '1',
      liveStreamId: '1',
      reactions: [
        CommentReaction(
          userId: '1',
          userName: 'Nguyễn Văn A',
          type: ReactionType.like,
        ),
      ],
    ),
    Comment(
      id: '4',
      userId: '3',
      userName: 'Streamer',
      userAvatar: 'https://i.pravatar.cc/150?img=3',
      content: '@Admin User: Chất lượng sản phẩm rất tốt bạn nhé, mình dùng mấy tháng rồi vẫn như mới.',
      timestamp: DateTime.now().subtract(const Duration(minutes: 1)),
      liveStreamId: '1',
      reactions: [],
    ),
    Comment(
      id: '5',
      userId: '1',
      userName: 'Nguyễn Văn A',
      userAvatar: 'https://i.pravatar.cc/150?img=1',
      content: 'Cảm ơn shop, cho mình đặt 1 cái XXL màu đen nha.',
      timestamp: DateTime.now(),
      productId: '1',
      liveStreamId: '1',
      reactions: [
        CommentReaction(
          userId: '3',
          userName: 'Streamer',
          type: ReactionType.heart,
        ),
      ],
    ),
  ];

  // Lấy danh sách livestream đang hoạt động
  Future<List<LiveStream>> getActiveLiveStreams() async {
    await Future.delayed(const Duration(seconds: 1));
    return _liveStreams.where((stream) => stream.isActive).toList();
  }

  // Lấy thông tin livestream theo ID
  Future<LiveStream> getLiveStreamById(String id) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final liveStream = _liveStreams.firstWhere(
      (stream) => stream.id == id,
      orElse: () => throw Exception('Không tìm thấy livestream'),
    );
    return liveStream;
  }

  // Lấy danh sách sản phẩm trong livestream
  Future<List<Product>> getProductsInLiveStream(String liveStreamId) async {
    await Future.delayed(const Duration(milliseconds: 800));
    final liveStream = _liveStreams.firstWhere(
      (stream) => stream.id == liveStreamId,
      orElse: () => throw Exception('Không tìm thấy livestream'),
    );
    return liveStream.products ?? [];
  }

  // Lấy danh sách comments trong livestream
  Future<List<Comment>> getCommentsInLiveStream(String liveStreamId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _comments.where((comment) => comment.liveStreamId == liveStreamId).toList();
  }

  // Thêm comment mới vào livestream
  Future<Comment> addComment(String liveStreamId, String userId, String userName, String userAvatar, String content, {String? productId}) async {
    await Future.delayed(const Duration(milliseconds: 200));
    
    final newComment = Comment(
      id: (_comments.length + 1).toString(),
      userId: userId,
      userName: userName,
      userAvatar: userAvatar,
      content: content,
      timestamp: DateTime.now(),
      productId: productId,
      liveStreamId: liveStreamId,
    );
    
    _comments.add(newComment);
    return newComment;
  }

  // Thêm reaction vào comment
  Future<Comment> addReactionToComment(String commentId, String userId, String userName, ReactionType type) async {
    await Future.delayed(const Duration(milliseconds: 200));
    
    final commentIndex = _comments.indexWhere((comment) => comment.id == commentId);
    if (commentIndex == -1) {
      throw Exception('Không tìm thấy comment');
    }
    
    final comment = _comments[commentIndex];
    
    // Kiểm tra xem user đã reaction chưa
    final existingReactionIndex = comment.reactions.indexWhere((reaction) => reaction.userId == userId);
    
    List<CommentReaction> updatedReactions;
    if (existingReactionIndex != -1) {
      // Cập nhật reaction hiện có
      updatedReactions = List.from(comment.reactions);
      updatedReactions[existingReactionIndex] = CommentReaction(
        userId: userId,
        userName: userName,
        type: type,
      );
    } else {
      // Thêm reaction mới
      updatedReactions = List.from(comment.reactions)
        ..add(CommentReaction(
          userId: userId,
          userName: userName,
          type: type,
        ));
    }
    
    final updatedComment = comment.copyWith(reactions: updatedReactions);
    _comments[commentIndex] = updatedComment;
    
    return updatedComment;
  }
}
