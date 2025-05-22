import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_cart_test/domain/repositories/cart_repository.dart';
import 'package:stream_cart_test/presentation/blocs/cart/cart_event.dart';
import 'package:stream_cart_test/presentation/blocs/cart/cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepository cartRepository;

  CartBloc(this.cartRepository) : super(CartInitial()) {
    on<LoadCartEvent>(_onLoadCart);
    on<AddToCartEvent>(_onAddToCart);
    on<RemoveFromCartEvent>(_onRemoveFromCart);
    on<UpdateCartItemEvent>(_onUpdateCartItem);
    on<ClearCartEvent>(_onClearCart);  }

  Future<void> _onLoadCart(LoadCartEvent event, Emitter<CartState> emit) async {
    emit(CartLoading());
    try {
      final cart = await cartRepository.getCart();
      emit(CartLoaded(cart: cart));    } catch (e) {
      emit(CartError(message: e.toString()));
    }
  }

  Future<void> _onAddToCart(AddToCartEvent event, Emitter<CartState> emit) async {
    emit(CartLoading());
    try {
      final cart = await cartRepository.addToCart(
        event.product,
        quantity: event.quantity,
        liveStreamId: event.liveStreamId,
      );
      emit(CartLoaded(cart: cart));    } catch (e) {
      emit(CartError(message: e.toString()));
    }
  }

  Future<void> _onRemoveFromCart(RemoveFromCartEvent event, Emitter<CartState> emit) async {
    emit(CartLoading());
    try {
      final cart = await cartRepository.removeFromCart(event.productId);
      emit(CartLoaded(cart: cart));    } catch (e) {
      emit(CartError(message: e.toString()));
    }
  }

  Future<void> _onUpdateCartItem(UpdateCartItemEvent event, Emitter<CartState> emit) async {
    emit(CartLoading());
    try {
      final cart = await cartRepository.updateQuantity(event.productId, event.quantity);
      emit(CartLoaded(cart: cart));    } catch (e) {
      emit(CartError(message: e.toString()));
    }
  }

  Future<void> _onClearCart(ClearCartEvent event, Emitter<CartState> emit) async {
    emit(CartLoading());
    try {
      await cartRepository.clearCart();
      final cart = await cartRepository.getCart();
      emit(CartLoaded(cart: cart));
    } catch (e) {
      emit(CartError(message: e.toString()));
    }
  }
}
