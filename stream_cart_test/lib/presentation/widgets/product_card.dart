import 'package:flutter/material.dart';
import 'package:stream_cart_test/data/models/product_model.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;
  final VoidCallback? onTap;

  const ProductCard({
    super.key,
    required this.product,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final isDarkMode = brightness == Brightness.dark;
    
    return GestureDetector(
      onTap: onTap ?? () {
        // Navigate to product detail
        // Navigator.pushNamed(context, '/product', arguments: product);
      },
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product image with discount badge
            Stack(
              children: [
                AspectRatio(
                  aspectRatio: 1,
                  child: Image.network(
                    product.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
                if (product.discount > 0)
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEE4D2D),
                        borderRadius: BorderRadius.circular(2),
                      ),
                      child: Text(
                        '-${product.discount}%',
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            // Product details
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product name
                  Text(
                    product.name,
                    style: TextStyle(
                      fontSize: 12,
                      color: isDarkMode ? Colors.white : Colors.black87,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  // Price
                  Row(
                    children: [
                      Text(
                        '₫${product.price.toStringAsFixed(0)}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFEE4D2D),
                        ),
                      ),
                      if (product.originalPrice > 0 && product.originalPrice != product.price)
                        Padding(
                          padding: const EdgeInsets.only(left: 4),
                          child: Text(
                            '₫${product.originalPrice.toStringAsFixed(0)}',
                            style: TextStyle(
                              fontSize: 11,
                              decoration: TextDecoration.lineThrough,
                              color: isDarkMode ? Colors.white60 : Colors.black54,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  // Rating and sold
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Color(0xFFEE4D2D),
                        size: 12,
                      ),
                      Text(
                        ' ${product.rating}',
                        style: TextStyle(
                          fontSize: 11,
                          color: isDarkMode ? Colors.white60 : Colors.black54,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'Đã bán ${product.sold}',
                        style: TextStyle(
                          fontSize: 11,
                          color: isDarkMode ? Colors.white60 : Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}