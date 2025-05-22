import 'package:stream_cart_test/domain/entities/cart_item.dart';
import 'package:stream_cart_test/domain/entities/live_stream.dart';

abstract class CartRepository {
  /// Get all items in the cart
  Future<Cart> getCart();
  
  /// Add a product to the cart
  Future<Cart> addToCart(Product product, {int quantity = 1, String? liveStreamId});
  
  /// Remove an item from the cart
  Future<Cart> removeFromCart(String productId);
  
  /// Update the quantity of an item in the cart
  Future<Cart> updateQuantity(String productId, int quantity);
  
  /// Clear the cart
  Future<void> clearCart();
  
  /// Get the total number of items in the cart
  Future<int> getCartItemCount();
}
