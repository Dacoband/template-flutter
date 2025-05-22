import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:stream_cart_test/core/routing/app_router.dart';
import 'package:stream_cart_test/presentation/widgets/product_card.dart';
import 'package:stream_cart_test/presentation/widgets/cart_icon_with_badge.dart';
import 'package:stream_cart_test/data/models/product_model.dart';
import 'package:stream_cart_test/data/models/category_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  final List<String> _bannerImages = [
    'https://cf.shopee.vn/file/vn-50009109-f88805b5f6fb6c25391a7358fa45aa83_xxhdpi',
    'https://cf.shopee.vn/file/vn-50009109-36119037aac90a1218f342e33452cedc_xxhdpi',
    'https://cf.shopee.vn/file/vn-50009109-d4ce773a4631c00f1ce1c06cc9ed1363_xxhdpi',
  ];

  // Danh sách danh mục sản phẩm giả
  final List<CategoryModel> _categories = [
    CategoryModel(id: '1', name: 'Thời Trang', iconData: Icons.checkroom),
    CategoryModel(id: '2', name: 'Điện Tử', iconData: Icons.phone_android),
    CategoryModel(id: '3', name: 'Nhà Cửa', iconData: Icons.home),
    CategoryModel(id: '4', name: 'Làm Đẹp', iconData: Icons.face),
    CategoryModel(id: '5', name: 'Sức Khỏe', iconData: Icons.favorite),
    CategoryModel(id: '6', name: 'Thể Thao', iconData: Icons.sports_soccer),
    CategoryModel(id: '7', name: 'Sách', iconData: Icons.menu_book),
    CategoryModel(id: '8', name: 'Đồ Chơi', iconData: Icons.toys),
    CategoryModel(id: '9', name: 'Văn Phòng', iconData: Icons.business_center),
    CategoryModel(id: '10', name: 'LiveStream', iconData: Icons.live_tv),
    CategoryModel(id: '11', name: 'Xem Thêm', iconData: Icons.more_horiz),
  ];

  // Danh sách sản phẩm giả
  final List<ProductModel> _featuredProducts = [];
  final List<ProductModel> _flashSaleProducts = [];
  final List<ProductModel> _recommendedProducts = [];

  @override
  void initState() {
    super.initState();
    _loadFakeData();
  }

  void _loadFakeData() {
    // Data giả cho Flash Sale
    _flashSaleProducts.addAll([
      ProductModel(
        id: '1',
        name: 'Áo thun oversize unisex cổ tròn basic',
        price: 89000,
        originalPrice: 150000,
        imageUrl: 'https://down-vn.img.susercontent.com/file/vn-11134207-7qukw-lf6rk0xfvwl7d1',
        discount: 41,
        rating: 4.8,
        sold: 5240,
        isLiked: false,
      ),
      ProductModel(
        id: '2',
        name: 'Tai nghe Bluetooth không dây i12 TWS',
        price: 98000,
        originalPrice: 299000,
        imageUrl: 'https://down-vn.img.susercontent.com/file/a949f9708fd6811e64c27e47cfc3f2e7',
        discount: 67,
        rating: 4.5,
        sold: 12543,
        isLiked: false,
      ),
      ProductModel(
        id: '3',
        name: 'Sạc dự phòng 10000mAh sạc nhanh 22.5W',
        price: 219000,
        originalPrice: 400000,
        imageUrl: 'https://down-vn.img.susercontent.com/file/sg-11134201-22100-i6olnhbjwyiv6c',
        discount: 45,
        rating: 4.9,
        sold: 3280,
        isLiked: false,
      ),
      ProductModel(
        id: '4',
        name: 'Quần jean nam baggy ống rộng',
        price: 159000,
        originalPrice: 250000,
        imageUrl: 'https://down-vn.img.susercontent.com/file/vn-11134207-7qukw-lfr5pwnwuo2pe8',
        discount: 36,
        rating: 4.7,
        sold: 7825,
        isLiked: false,
      ),
      ProductModel(
        id: '5',
        name: 'Bộ skincare dưỡng ẩm trắng da',
        price: 245000,
        originalPrice: 500000,
        imageUrl: 'https://down-vn.img.susercontent.com/file/7869a8dad5b734fa93021fb96adcbc6d',
        discount: 51,
        rating: 4.6,
        sold: 2381,
        isLiked: false,
      ),
    ]);

    // Data giả cho Featured Products
    _featuredProducts.addAll([
      ProductModel(
        id: '6',
        name: 'Laptop Macbook Air M1 2020',
        price: 18990000,
        originalPrice: 22990000,
        imageUrl: 'https://down-vn.img.susercontent.com/file/vn-11134207-7qukw-lfr2j0r1u6zz30',
        discount: 17,
        rating: 4.9,
        sold: 852,
        isLiked: false,
      ),
      ProductModel(
        id: '7',
        name: 'Ghế gaming cao cấp có gác chân và massage',
        price: 1850000,
        originalPrice: 3200000,
        imageUrl: 'https://down-vn.img.susercontent.com/file/vn-11134207-7qukw-lfytjv3suoqv1d',
        discount: 42,
        rating: 4.7,
        sold: 1254,
        isLiked: false,
      ),
      ProductModel(
        id: '8',
        name: 'Tủ lạnh Samsung Inverter 236L',
        price: 5490000,
        originalPrice: 7490000,
        imageUrl: 'https://down-vn.img.susercontent.com/file/vn-11134207-7qukw-lfmbqzeuq9gx47',
        discount: 27,
        rating: 4.8,
        sold: 372,
        isLiked: false,
      ),
    ]);

    // Data giả cho Recommended Products
    _recommendedProducts.addAll([
      ProductModel(
        id: '9',
        name: 'Giày thể thao nam nữ học sinh',
        price: 135000,
        originalPrice: 250000,
        imageUrl: 'https://down-vn.img.susercontent.com/file/vn-11134207-7qukw-lfyt7kp9h0lxb3',
        discount: 46,
        rating: 4.6,
        sold: 9830,
        isLiked: false,
      ),
      ProductModel(
        id: '10',
        name: 'Đèn ngủ cảm ứng thông minh',
        price: 89000,
        originalPrice: 180000,
        imageUrl: 'https://down-vn.img.susercontent.com/file/cn-11134207-7qukw-lfb2xsjny45w61',
        discount: 51,
        rating: 4.7,
        sold: 5243,
        isLiked: false,
      ),
      ProductModel(
        id: '11',
        name: 'Balo laptop chống nước cao cấp',
        price: 219000,
        originalPrice: 320000,
        imageUrl: 'https://down-vn.img.susercontent.com/file/vn-11134207-7qukw-lfr4l7hpw3e7ee',
        discount: 32,
        rating: 4.8,
        sold: 3521,
        isLiked: false,
      ),
      ProductModel(
        id: '12',
        name: 'Kệ sách mini để bàn 3 tầng',
        price: 99000,
        originalPrice: 160000,
        imageUrl: 'https://down-vn.img.susercontent.com/file/vn-11134207-7qukw-lfrys6vqiddb3a',
        discount: 38,
        rating: 4.5,
        sold: 7852,
        isLiked: false,
      ),
      ProductModel(
        id: '13',
        name: 'Túi đựng mỹ phẩm du lịch',
        price: 65000,
        originalPrice: 120000,
        imageUrl: 'https://down-vn.img.susercontent.com/file/cn-11134207-7qukw-lfdg6ncuwysf7e',
        discount: 46,
        rating: 4.6,
        sold: 4521,
        isLiked: false,
      ),
      ProductModel(
        id: '14',
        name: 'Giá treo quần áo đa năng',
        price: 185000,
        originalPrice: 250000,
        imageUrl: 'https://down-vn.img.susercontent.com/file/b0ca2b2068b651dd6e9fc4b316a3a812',
        discount: 26,
        rating: 4.7,
        sold: 1235,
        isLiked: false,
      ),
    ]);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final isDarkMode = brightness == Brightness.dark;
    final statusBarHeight = MediaQuery.of(context).padding.top;
    
    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : const Color(0xFFF5F5F5),
      body: CustomScrollView(
        slivers: [
          // App Bar
          SliverAppBar(
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.light,
            ),
            expandedHeight: 110 + statusBarHeight,
            pinned: true,
            backgroundColor: const Color.fromARGB(255, 22, 22, 22),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                padding: EdgeInsets.only(
                  top: statusBarHeight + 8,
                  left: 16,
                  right: 16,
                  bottom: 8,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: TextField(
                              controller: _searchController,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                                hintText: 'Tìm kiếm sản phẩm',
                                hintStyle: const TextStyle(color: Colors.grey),
                                border: InputBorder.none,
                                prefixIcon: const Icon(
                                  Icons.search,
                                  color: Colors.grey,
                                ),
                                suffixIcon: IconButton(
                                  icon: const Icon(
                                    Icons.camera_alt_outlined,
                                    color: Colors.grey,
                                  ),
                                  onPressed: () {
                                    // Handle camera search
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),                        const SizedBox(width: 8),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, AppRouter.cart);
                          },
                          child: const CartIconWithBadge(),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.chat_outlined,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            // Navigate to chat
                            // Navigator.pushNamed(context, '/chat');
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    // Category tabs
                    SizedBox(
                      height: 36,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          _buildCategoryTab('Đề Xuất', isSelected: true),
                          _buildCategoryTab('Dành Cho Bạn'),
                          _buildCategoryTab('Flash Sale'),
                          _buildCategoryTab('Thời Trang Nam'),
                          _buildCategoryTab('Thời Trang Nữ'),
                          _buildCategoryTab('Điện Thoại'),
                          _buildCategoryTab('Điện Tử'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          // Content
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Banner slider
                FlutterCarousel(
                  options: CarouselOptions(
                    height: 180.0,
                    autoPlay: true,
                    enlargeCenterPage: true,
                    viewportFraction: 0.95,
                    showIndicator: false,
                    
                  ),
                  items: _bannerImages.map((url) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: DecorationImage(
                              image: NetworkImage(url),
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
                
                const SizedBox(height: 16),
                
                // Categories
                Container(
                  color: isDarkMode ? Colors.black : Colors.white,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Danh Mục',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 5,
                          childAspectRatio: 0.8,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                        ),
                        itemCount: _categories.length,
                        itemBuilder: (context, index) {
                          final category = _categories[index];
                          return GestureDetector(
                            onTap: () {
                              // Navigate based on category
                              if (category.id == '10') { // LiveStream category
                                Navigator.pushNamed(context, '/livestream-list');
                              }
                              // Handle other categories...
                            },
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: isDarkMode ? Colors.grey[900] : const Color(0xFFF5F5F5),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Icon(
                                    category.iconData,
                                    color: const Color.fromARGB(255, 0, 0, 0),
                                    size: 24,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  category.name,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: isDarkMode ? Colors.white70 : Colors.black87,
                                  ),
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 8),
                
                // Flash Sale
                Container(
                  color: isDarkMode ? Colors.black : Colors.white,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Text(
                                'FLASH SALE',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 3, 3, 3),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 0, 0, 0),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: const Text(
                                  '00:30:59',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          TextButton(
                            onPressed: () {
                              // Navigate to flash sale page
                            },
                            child: const Row(
                              children: [
                                Text(
                                  'Xem tất cả',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Icon(
                                  Icons.chevron_right,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  size: 16,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        height: 200,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _flashSaleProducts.length,
                          itemBuilder: (context, index) {
                            final product = _flashSaleProducts[index];
                            return SizedBox(
                              width: 120,
                              child: Card(
                                elevation: 0,
                                margin: const EdgeInsets.only(right: 8),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                clipBehavior: Clip.antiAlias,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Product image
                                    AspectRatio(
                                      aspectRatio: 1,
                                      child: Image.network(
                                        product.imageUrl,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    // Price
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '₫${product.price.toStringAsFixed(0)}',
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Color.fromARGB(255, 0, 0, 0),
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          // Discount badge
                                          Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                                            decoration: BoxDecoration(
                                              color: const Color(0xFFFEEFEF),
                                              borderRadius: BorderRadius.circular(2),
                                              border: Border.all(color: const Color.fromARGB(255, 0, 0, 0), width: 0.5),
                                            ),
                                            child: Text(
                                              '${product.discount}% GIẢM',
                                              style: const TextStyle(
                                                fontSize: 10,
                                                color: Color.fromARGB(255, 0, 0, 0),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 8),
                
                // Featured Products
                Container(
                  color: isDarkMode ? Colors.black : Colors.white,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'SẢN PHẨM NỔI BẬT',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              // Navigate to featured products page
                            },
                            child: const Row(
                              children: [
                                Text(
                                  'Xem thêm',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Icon(
                                  Icons.chevron_right,
                                  color: Color.fromARGB(255, 7, 7, 7),
                                  size: 16,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.7,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                        ),
                        itemCount: _featuredProducts.length,
                        itemBuilder: (context, index) {
                          final product = _featuredProducts[index];
                          return ProductCard(product: product);
                        },
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 8),
                
                // Recommended Products
                Container(
                  color: isDarkMode ? Colors.black : Colors.white,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'GỢI Ý HÔM NAY',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.7,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                        ),
                        itemCount: _recommendedProducts.length,
                        itemBuilder: (context, index) {
                          final product = _recommendedProducts[index];
                          return ProductCard(product: product);
                        },
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        type: BottomNavigationBarType.fixed,
        backgroundColor: isDarkMode ? Colors.black : Colors.white,
        selectedItemColor: const Color.fromARGB(255, 27, 27, 27),
        unselectedItemColor: isDarkMode ? Colors.white54 : Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Trang chủ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore_outlined),
            activeIcon: Icon(Icons.explore),
            label: 'Khám phá',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_mall_outlined),
            activeIcon: Icon(Icons.local_mall),
            label: 'Mall',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_outlined),
            activeIcon: Icon(Icons.notifications),
            label: 'Thông báo',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Tôi',
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryTab(String label, {bool isSelected = false}) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: TextButton(
        onPressed: () {},
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          backgroundColor: isSelected ? Colors.white : Colors.white.withOpacity(0.2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? const Color.fromARGB(255, 0, 0, 0) : Colors.white,
            fontSize: 12,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}