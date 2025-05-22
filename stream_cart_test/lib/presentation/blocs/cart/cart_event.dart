import 'package:equatable/equatable.dart';
import 'package:stream_cart_test/domain/entities/live_stream.dart';

abstract class CartEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

// Load cart event
class LoadCartEvent extends CartEvent {}

// Add item to cart
class AddToCartEvent extends CartEvent {
  final Product product;
  final int quantity;
  final String? liveStreamId;
  
  AddToCartEvent({
    required this.product, 
    this.quantity = 1,
    this.liveStreamId,
  });
  
  @override
  List<Object?> get props => [product, quantity, liveStreamId];
}

// Remove item from cart
class RemoveFromCartEvent extends CartEvent {
  final String productId;
  
  RemoveFromCartEvent({required this.productId});
  
  @override
  List<Object?> get props => [productId];
}

// Update item quantity
class UpdateCartItemEvent extends CartEvent {
  final String productId;
  final int quantity;
  
  UpdateCartItemEvent({
    required this.productId,
    required this.quantity,
  });
    @override
  List<Object?> get props => [productId, quantity];
}

// Clear cart
class ClearCartEvent extends CartEvent {}
