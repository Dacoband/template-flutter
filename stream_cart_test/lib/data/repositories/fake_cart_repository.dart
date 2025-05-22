import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stream_cart_test/domain/entities/cart_item.dart';
import 'package:stream_cart_test/domain/entities/live_stream.dart';
import 'package:stream_cart_test/domain/repositories/cart_repository.dart';
import 'dart:convert';
import 'package:uuid/uuid.dart';

class FakeCartRepository implements CartRepository {
  final _cartStreamController = StreamController<Cart>.broadcast();
  Cart _cart = const Cart(items: []);
  final _uuid = const Uuid();
  
  // Storage key for SharedPreferences
  static const String _storageKey = 'cart_data';
  
  FakeCartRepository() {
    _loadCart();
  }
  
  Stream<Cart> get cartStream => _cartStreamController.stream;

  Future<void> _loadCart() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cartJson = prefs.getString(_storageKey);
      
      if (cartJson != null) {
        final List<dynamic> decodedList = jsonDecode(cartJson);
        final items = decodedList.map((itemJson) {
          return CartItem(
            id: itemJson['id'],
            product: Product(
              id: itemJson['product']['id'],
              name: itemJson['product']['name'],
              description: itemJson['product']['description'] ?? '',
              price: (itemJson['product']['price'] as num).toDouble(),
              discountPrice: itemJson['product']['discountPrice'] != null 
                  ? (itemJson['product']['discountPrice'] as num).toDouble() 
                  : null,
              imageUrl: itemJson['product']['imageUrl'],
              stock: itemJson['product']['stock'] ?? 1000,
              categories: List<String>.from(itemJson['product']['categories'] ?? []),
              rating: (itemJson['product']['rating'] as num?)?.toDouble() ?? 5.0,
              soldCount: itemJson['product']['soldCount'] ?? 0,
            ),
            quantity: itemJson['quantity'],
            liveStreamId: itemJson['liveStreamId'],
            addedAt: DateTime.parse(itemJson['addedAt']),
          );
        }).toList().cast<CartItem>();
        
        _cart = Cart(items: items);
        _cartStreamController.add(_cart);
      }
    } catch (e) {
      // Fallback to empty cart in case of error
      _cart = const Cart(items: []);
      _cartStreamController.add(_cart);
      print('Error loading cart: $e');
    }
  }
  
  Future<void> _saveCart() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cartData = _cart.items.map((item) => {
        'id': item.id,
        'product': {
          'id': item.product.id,
          'name': item.product.name,
          'description': item.product.description,
          'price': item.product.price,
          'discountPrice': item.product.discountPrice,
          'imageUrl': item.product.imageUrl,
          'stock': item.product.stock,
          'categories': item.product.categories,
          'rating': item.product.rating,
          'soldCount': item.product.soldCount,
        },
        'quantity': item.quantity,
        'liveStreamId': item.liveStreamId,
        'addedAt': item.addedAt.toIso8601String(),
      }).toList();
      
      await prefs.setString(_storageKey, jsonEncode(cartData));
    } catch (e) {
      // Handle errors
      print('Error saving cart: $e');
    }
  }

  @override
  Future<Cart> getCart() async {
    return _cart;
  }

  @override
  Future<Cart> addToCart(Product product, {int quantity = 1, String? liveStreamId}) async {
    // Check if item already exists in cart
    final existingItemIndex = _cart.items.indexWhere(
      (item) => item.product.id == product.id && item.liveStreamId == liveStreamId
    );
    
    if (existingItemIndex >= 0) {
      // Update existing item
      final existingItem = _cart.items[existingItemIndex];
      final updatedItems = List<CartItem>.from(_cart.items);
      updatedItems[existingItemIndex] = existingItem.copyWith(
        quantity: existingItem.quantity + quantity,
      );
      
      _cart = Cart(items: updatedItems);
    } else {
      // Add new item
      final newItem = CartItem(
        id: _uuid.v4(),
        product: product,
        quantity: quantity,
        liveStreamId: liveStreamId,
        addedAt: DateTime.now(),
      );
      
      _cart = Cart(items: [..._cart.items, newItem]);
    }
    
    await _saveCart();
    _cartStreamController.add(_cart);
    return _cart;
  }

  @override
  Future<Cart> removeFromCart(String productId) async {
    final updatedItems = _cart.items.where((item) => item.product.id != productId).toList();
    _cart = Cart(items: updatedItems);
    
    await _saveCart();
    _cartStreamController.add(_cart);
    return _cart;
  }

  @override
  Future<Cart> updateQuantity(String productId, int quantity) async {
    if (quantity <= 0) {
      return removeFromCart(productId);
    }
    
    final updatedItems = _cart.items.map((item) {
      if (item.product.id == productId) {
        return item.copyWith(quantity: quantity);
      }
      return item;
    }).toList();
    
    _cart = Cart(items: updatedItems);
    
    await _saveCart();
    _cartStreamController.add(_cart);
    return _cart;
  }

  @override
  Future<void> clearCart() async {
    _cart = const Cart(items: []);
    
    await _saveCart();
    _cartStreamController.add(_cart);
  }
  
  @override
  Future<int> getCartItemCount() async {
    return _cart.totalItems;
  }
  
  void dispose() {
    _cartStreamController.close();
  }
}