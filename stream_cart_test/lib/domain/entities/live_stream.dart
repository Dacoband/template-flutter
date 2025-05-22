import 'package:equatable/equatable.dart';

class LiveStream extends Equatable {
  final String id;
  final String title;
  final String description;
  final String thumbnailUrl;
  final String streamUrl;
  final String userId;
  final String userName;
  final String userAvatar;
  final DateTime startTime;
  final DateTime? endTime;
  final bool isActive;
  final int viewerCount;
  final int likeCount;
  final List<String> tags;
  final List<Product>? products;

  const LiveStream({
    required this.id,
    required this.title,
    required this.description,
    required this.thumbnailUrl,
    required this.streamUrl,
    required this.userId,
    required this.userName,
    required this.userAvatar,
    required this.startTime,
    this.endTime,
    required this.isActive,
    required this.viewerCount,
    required this.likeCount,
    required this.tags,
    this.products,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        thumbnailUrl,
        streamUrl,
        userId,
        userName,
        userAvatar,
        startTime,
        endTime,
        isActive,
        viewerCount,
        likeCount,
        tags,
        products,
      ];

  LiveStream copyWith({
    String? id,
    String? title,
    String? description,
    String? thumbnailUrl,
    String? streamUrl,
    String? userId,
    String? userName,
    String? userAvatar,
    DateTime? startTime,
    DateTime? endTime,
    bool? isActive,
    int? viewerCount,
    int? likeCount,
    List<String>? tags,
    List<Product>? products,
  }) {
    return LiveStream(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      streamUrl: streamUrl ?? this.streamUrl,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      userAvatar: userAvatar ?? this.userAvatar,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      isActive: isActive ?? this.isActive,
      viewerCount: viewerCount ?? this.viewerCount,
      likeCount: likeCount ?? this.likeCount,
      tags: tags ?? this.tags,
      products: products ?? this.products,
    );
  }
}

class Product extends Equatable {
  final String id;
  final String name;
  final String description;
  final double price;
  final double? discountPrice;
  final String imageUrl;
  final int stock;
  final List<String> categories;
  final double rating;
  final int soldCount;

  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    this.discountPrice,
    required this.imageUrl,
    required this.stock,
    required this.categories,
    required this.rating,
    required this.soldCount,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        price,
        discountPrice,
        imageUrl,
        stock,
        categories,
        rating,
        soldCount,
      ];

  double get finalPrice => discountPrice ?? price;
  
  int get discountPercentage {
    if (discountPrice == null) return 0;
    return ((price - discountPrice!) / price * 100).round();
  }
}
