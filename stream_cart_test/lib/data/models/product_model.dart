class ProductModel {
  final String id;
  final String name;
  final double price;
  final double originalPrice;
  final String imageUrl;
  final int discount;
  final double rating;
  final int sold;
  final bool isLiked;

  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.originalPrice,
    required this.imageUrl,
    required this.discount,
    required this.rating,
    required this.sold,
    required this.isLiked,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'].toString(),
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      originalPrice: (json['original_price'] as num).toDouble(),
      imageUrl: json['image_url'] as String,
      discount: json['discount'] as int,
      rating: (json['rating'] as num).toDouble(),
      sold: json['sold'] as int,
      isLiked: json['is_liked'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'original_price': originalPrice,
      'image_url': imageUrl,
      'discount': discount,
      'rating': rating,
      'sold': sold,
      'is_liked': isLiked,
    };
  }
}