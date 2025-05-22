import 'package:equatable/equatable.dart';
import 'package:stream_cart_test/domain/entities/live_stream.dart';

class CartItem extends Equatable {
  final String id;
  final Product product;
  final int quantity;
  final String? liveStreamId;
  final DateTime addedAt;

  const CartItem({
    required this.id,
    required this.product,
    required this.quantity,
    this.liveStreamId,
    required this.addedAt,
  });

  double get totalPrice => product.finalPrice * quantity;

  @override
  List<Object?> get props => [id, product, quantity, liveStreamId, addedAt];
  
  CartItem copyWith({
    String? id,
    Product? product,
    int? quantity,
    String? liveStreamId,
    DateTime? addedAt,
  }) {
    return CartItem(
      id: id ?? this.id,
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
      liveStreamId: liveStreamId ?? this.liveStreamId,
      addedAt: addedAt ?? this.addedAt,
    );
  }
}

class Cart extends Equatable {
  final List<CartItem> items;
  
  const Cart({required this.items});
    @override
  List<Object?> get props => [items];
  
  double get totalAmount => items.fold(0, (total, item) => total + item.totalPrice);
  
  int get totalItems => items.fold(0, (total, item) => total + item.quantity);
    bool get isEmpty => items.isEmpty;
  
  bool get isNotEmpty => items.isNotEmpty;
  
  CartItem? findById(String productId) {
    try {
      return items.firstWhere((item) => item.product.id == productId);
    } catch (e) {
      return null;
    }
  }
  
  Cart copyWith({
    List<CartItem>? items,
  }) {
    return Cart(
      items: items ?? this.items,
    );
  }
}
