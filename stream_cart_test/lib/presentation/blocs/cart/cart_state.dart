// filepath: d:\My Project\template-flutter\stream_cart_test\lib\presentation\blocs\cart\cart_state.dart
import 'package:equatable/equatable.dart';
import 'package:stream_cart_test/domain/entities/cart_item.dart';

abstract class CartState extends Equatable {
  const CartState();
  
  @override
  List<Object> get props => [];
}

class CartInitial extends CartState {
  const CartInitial();
}

class CartLoading extends CartState {
  const CartLoading();
}

class CartLoaded extends CartState {
  final Cart cart;
  
  const CartLoaded({required this.cart});
  
  @override
  List<Object> get props => [cart];
}

class CartError extends CartState {
  final String message;
  
  const CartError({required this.message});
  
  @override
  List<Object> get props => [message];
}
