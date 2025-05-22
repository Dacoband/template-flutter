import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_cart_test/core/routing/app_router.dart';
import 'package:stream_cart_test/presentation/blocs/cart/cart_bloc.dart';
import 'package:stream_cart_test/presentation/blocs/cart/cart_state.dart';

class CartIconWithBadge extends StatelessWidget {
  final Color? iconColor;
  final VoidCallback? onPressed;

  const CartIconWithBadge({
    Key? key,
    this.iconColor,
    this.onPressed,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        int itemCount = 0;
        
        if (state is CartLoaded) {
          itemCount = state.cart.totalItems;
        }
        
        return Stack(
          children: [
            IconButton(
              icon: Icon(
                Icons.shopping_cart_outlined,
                color: iconColor ?? Colors.white,
              ),
              onPressed: onPressed ?? () {
                Navigator.pushNamed(context, AppRouter.cart);
              },
            ),
            if (itemCount > 0)
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 16,
                    minHeight: 16,
                  ),
                  child: Text(
                    itemCount > 9 ? '9+' : itemCount.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
