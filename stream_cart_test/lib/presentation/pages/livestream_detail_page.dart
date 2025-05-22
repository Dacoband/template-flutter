import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:stream_cart_test/core/routing/app_router.dart';
import 'package:stream_cart_test/domain/entities/comment.dart';
import 'package:stream_cart_test/domain/entities/live_stream.dart';
import 'package:stream_cart_test/presentation/blocs/comment/comment_bloc.dart';
import 'package:stream_cart_test/presentation/blocs/comment/comment_event.dart';
import 'package:stream_cart_test/presentation/blocs/comment/comment_state.dart';
import 'package:stream_cart_test/presentation/blocs/livestream/livestream_bloc.dart';
import 'package:stream_cart_test/presentation/blocs/livestream/livestream_event.dart';
import 'package:stream_cart_test/presentation/blocs/livestream/livestream_state.dart';
import 'package:stream_cart_test/domain/entities/user.dart';
import 'package:stream_cart_test/presentation/blocs/cart/cart_bloc.dart';
import 'package:stream_cart_test/presentation/blocs/cart/cart_event.dart';

class LiveStreamDetailPage extends StatefulWidget {
  final String liveStreamId;
  
  const LiveStreamDetailPage({
    Key? key,
    required this.liveStreamId,
  }) : super(key: key);

  @override
  State<LiveStreamDetailPage> createState() => _LiveStreamDetailPageState();
}

class _LiveStreamDetailPageState extends State<LiveStreamDetailPage> {
  final LiveStreamBloc _liveStreamBloc = GetIt.instance<LiveStreamBloc>();
  final CommentBloc _commentBloc = GetIt.instance<CommentBloc>();
  final CartBloc _cartBloc = GetIt.instance<CartBloc>();
  final TextEditingController _commentController = TextEditingController();
  
  // Giả lập current user
  final User _currentUser = User(
    id: '1',
    name: 'Nguyễn Văn A',
    email: 'user@example.com',
    phone: '0987654321',
    avatar: 'https://i.pravatar.cc/150?img=1',
  );
  
  // Trạng thái của các features trong trang
  bool _isCommentsVisible = true;
  bool _isProductsVisible = true;
  
  @override
  void initState() {
    super.initState();
    _liveStreamBloc.add(FetchLiveStreamDetailsEvent(widget.liveStreamId));
    _liveStreamBloc.add(FetchProductsInLiveStreamEvent(widget.liveStreamId));
    _commentBloc.add(FetchCommentsEvent(widget.liveStreamId));
    
    // Join livestream
    _liveStreamBloc.add(JoinLiveStreamEvent(
      liveStreamId: widget.liveStreamId,
      userId: _currentUser.id,
    ));
  }
  
  @override
  void dispose() {
    _commentController.dispose();
    
    // Leave livestream
    _liveStreamBloc.add(LeaveLiveStreamEvent(
      liveStreamId: widget.liveStreamId,
      userId: _currentUser.id,
    ));
    
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final isDarkMode = brightness == Brightness.dark;
    final size = MediaQuery.of(context).size;
      return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => _liveStreamBloc),
        BlocProvider(create: (context) => _commentBloc),
        BlocProvider(create: (context) => _cartBloc),
      ],
      child: Scaffold(
        backgroundColor: isDarkMode ? Colors.black : Colors.grey[100],
        body: SafeArea(
          child: BlocBuilder<LiveStreamBloc, LiveStreamState>(
            builder: (context, state) {
              if (state is LiveStreamLoading) {
                return const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFEE4D2D)),
                  ),
                );
              } else if (state is LiveStreamDetailsLoaded) {
                return _buildStreamingUI(state.liveStream, isDarkMode, size);
              } else if (state is LiveStreamError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        color: Colors.red,
                        size: 60,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Không thể kết nối tới livestream',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        state.message,
                        style: TextStyle(
                          color: isDarkMode ? Colors.white70 : Colors.black54,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: () {
                          _liveStreamBloc.add(FetchLiveStreamDetailsEvent(widget.liveStreamId));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFEE4D2D),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text('Thử lại'),
                      ),
                    ],
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }

  Widget _buildStreamingUI(LiveStream liveStream, bool isDarkMode, Size size) {
    return Column(
      children: [
        // AppBar
        _buildAppBar(liveStream, isDarkMode),
        
        // Video stream
        Container(
          width: double.infinity,
          height: size.width * 9 / 16, // 16:9 aspect ratio
          color: Colors.black,
          child: Stack(
            children: [
              // Video player would be implemented here with RTMP/WebRTC
              // For now, we'll use a placeholder image
              Center(
                child: Image.network(
                  liveStream.thumbnailUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.black,
                      child: const Center(
                        child: Icon(
                          Icons.live_tv,
                          color: Colors.white,
                          size: 64,
                        ),
                      ),
                    );
                  },
                ),
              ),
              
              // Live indicator
              Positioned(
                top: 16,
                left: 16,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.fiber_manual_record,
                        color: Colors.white,
                        size: 12,
                      ),
                      SizedBox(width: 4),
                      Text(
                        'LIVE',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              // Viewer count
              Positioned(
                top: 16,
                right: 16,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.remove_red_eye,
                        color: Colors.white,
                        size: 14,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${liveStream.viewerCount}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              // Stream controls (like, share)
              Positioned(
                bottom: 16,
                right: 16,
                child: Column(
                  children: [
                    // Like button
                    _buildControlButton(
                      icon: Icons.favorite,
                      label: '${liveStream.likeCount}',
                      color: Colors.red,
                      onTap: () {
                        _liveStreamBloc.add(LikeLiveStreamEvent(
                          liveStreamId: liveStream.id,
                          userId: _currentUser.id,
                        ));
                      },
                    ),
                    const SizedBox(height: 16),
                    
                    // Share button
                    _buildControlButton(
                      icon: Icons.share,
                      label: 'Chia sẻ',
                      color: Colors.white,
                      onTap: () {
                        _liveStreamBloc.add(ShareLiveStreamEvent(
                          liveStreamId: liveStream.id,
                          userId: _currentUser.id,
                        ));
                        
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Đã sao chép đường dẫn livestream'),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        
        // Stream info (toggle between comments and products)
        _buildStreamInfo(liveStream, isDarkMode),
        
        // Comments and products section
        Expanded(
          child: _isCommentsVisible
              ? _buildCommentsSection(isDarkMode)
              : _buildProductsSection(liveStream, isDarkMode),
        ),
        
        // Comment input field
        if (_isCommentsVisible) _buildCommentInput(isDarkMode),
      ],
    );
  }

  Widget _buildAppBar(LiveStream liveStream, bool isDarkMode) {
    return AppBar(
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: isDarkMode ? Colors.white : Colors.black,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Row(
        children: [
          CircleAvatar(
            radius: 16,
            backgroundImage: NetworkImage(liveStream.userAvatar),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              liveStream.userName,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
      actions: [
        // Follow button
        TextButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Đã theo dõi streamer'),
                behavior: SnackBarBehavior.floating,
              ),
            );
          },
          style: TextButton.styleFrom(
            backgroundColor: const Color(0xFFEE4D2D),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12),
          ),
          child: const Text('Theo dõi'),
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  Widget _buildControlButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.6),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: color,
              size: 24,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStreamInfo(LiveStream liveStream, bool isDarkMode) {
    return Container(
      color: isDarkMode ? Colors.black : Colors.white,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Stream title
          Text(
            liveStream.title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          const SizedBox(height: 8),
          
          // Stream description
          Text(
            liveStream.description,
            style: TextStyle(
              fontSize: 14,
              color: isDarkMode ? Colors.white70 : Colors.black54,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 16),
          
          // Toggle buttons
          Row(
            children: [
              Expanded(
                child: _buildToggleButton(
                  label: 'Bình luận',
                  isSelected: _isCommentsVisible,
                  onTap: () {
                    setState(() {
                      _isCommentsVisible = true;
                      _isProductsVisible = false;
                    });
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildToggleButton(
                  label: 'Sản phẩm',
                  isSelected: _isProductsVisible && !_isCommentsVisible,
                  onTap: () {
                    setState(() {
                      _isCommentsVisible = false;
                      _isProductsVisible = true;
                    });
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildToggleButton({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isSelected ? const Color(0xFFEE4D2D) : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            color: isSelected ? const Color(0xFFEE4D2D) : Colors.grey,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildCommentsSection(bool isDarkMode) {
    return BlocBuilder<CommentBloc, CommentState>(
      builder: (context, state) {
        if (state is CommentLoading) {
          return const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFEE4D2D)),
            ),
          );
        } else if (state is CommentsLoaded) {
          return _buildCommentsList(state.comments, isDarkMode);
        } else if (state is CommentError) {
          return Center(
            child: Text(
              'Không thể tải bình luận: ${state.message}',
              style: TextStyle(
                color: isDarkMode ? Colors.white70 : Colors.black54,
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildCommentsList(List<Comment> comments, bool isDarkMode) {
    if (comments.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.chat_bubble_outline,
              color: Colors.grey,
              size: 48,
            ),
            const SizedBox(height: 16),
            Text(
              'Chưa có bình luận nào',
              style: TextStyle(
                fontSize: 16,
                color: isDarkMode ? Colors.white70 : Colors.black54,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Hãy là người đầu tiên bình luận!',
              style: TextStyle(
                fontSize: 14,
                color: isDarkMode ? Colors.white54 : Colors.black45,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: comments.length,
      reverse: true,
      itemBuilder: (context, index) {
        final comment = comments[comments.length - 1 - index];
        final isStreamerComment = comment.userId == '3'; // Streamer's ID
        
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // User avatar
              CircleAvatar(
                radius: 16,
                backgroundImage: NetworkImage(comment.userAvatar),
              ),
              const SizedBox(width: 12),
              
              // Comment content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Username
                    Row(
                      children: [
                        Text(
                          comment.userName,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: isStreamerComment
                                ? const Color(0xFFEE4D2D)
                                : (isDarkMode ? Colors.white : Colors.black),
                          ),
                        ),
                        if (isStreamerComment) ...[
                          const SizedBox(width: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                            decoration: BoxDecoration(
                              color: const Color(0xFFEE4D2D),
                              borderRadius: BorderRadius.circular(2),
                            ),
                            child: const Text(
                              'Streamer',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 4),
                    
                    // Comment content
                    Text(
                      comment.content,
                      style: TextStyle(
                        fontSize: 14,
                        color: isDarkMode ? Colors.white : Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    
                    // Comment info (time, reactions)
                    Row(
                      children: [
                        Text(
                          _getTimeAgo(comment.timestamp),
                          style: TextStyle(
                            fontSize: 12,
                            color: isDarkMode ? Colors.white54 : Colors.black45,
                          ),
                        ),
                        const SizedBox(width: 16),
                        
                        // Reactions
                        if (comment.reactions.isNotEmpty) ...[
                          GestureDetector(
                            onTap: () {
                              // Show all reactions
                            },
                            child: Row(
                              children: [
                                for (final reaction in comment.reactions.take(3))
                                  Padding(
                                    padding: const EdgeInsets.only(right: 2),
                                    child: Text(
                                      reaction.type.emoji,
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                  ),
                                if (comment.reactions.length > 3)
                                  Text(
                                    '+${comment.reactions.length - 3}',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: isDarkMode ? Colors.white54 : Colors.black45,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
              
              // Reaction button
              IconButton(
                icon: const Icon(Icons.favorite_border, size: 18),
                color: isDarkMode ? Colors.white70 : Colors.black54,
                onPressed: () {
                  _commentBloc.add(AddReactionEvent(
                    commentId: comment.id,
                    userId: _currentUser.id,
                    userName: _currentUser.name,
                    reactionType: ReactionType.heart,
                  ));
                },
                constraints: const BoxConstraints(),
                padding: const EdgeInsets.all(8),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildProductsSection(LiveStream liveStream, bool isDarkMode) {
    final products = liveStream.products ?? [];
    
    if (products.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.shopping_bag_outlined,
              color: Colors.grey,
              size: 48,
            ),
            const SizedBox(height: 16),
            Text(
              'Không có sản phẩm nào',
              style: TextStyle(
                fontSize: 16,
                color: isDarkMode ? Colors.white70 : Colors.black54,
              ),
            ),
          ],
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product image with discount badge
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Image.network(
                        product.imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  if (product.discountPercentage > 0)
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
                          '-${product.discountPercentage}%',
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
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product name
                    Text(
                      product.name,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    
                    // Price
                    Row(
                      children: [
                        Text(
                          '₫${product.finalPrice.toStringAsFixed(0)}',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFEE4D2D),
                          ),
                        ),
                        if (product.discountPrice != null) ...[
                          const SizedBox(width: 4),
                          Text(
                            '₫${product.price.toStringAsFixed(0)}',
                            style: TextStyle(
                              fontSize: 12,
                              decoration: TextDecoration.lineThrough,
                              color: isDarkMode ? Colors.white60 : Colors.black45,
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 8),                    // Add to cart button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(                        onPressed: () {
                          // Add to cart using CartBloc from context
                          context.read<CartBloc>().add(AddToCartEvent(
                            product: product,
                            quantity: 1,
                            liveStreamId: liveStream.id,
                          ));
                          
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Đã thêm ${product.name} vào giỏ hàng'),
                              behavior: SnackBarBehavior.floating,
                              action: SnackBarAction(
                                label: 'Xem giỏ hàng',
                                onPressed: () {
                                  Navigator.of(context).pushNamed(AppRouter.cart);
                                },
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFEE4D2D),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          textStyle: const TextStyle(fontSize: 12),
                          elevation: 0,
                        ),
                        child: const Text('Thêm vào giỏ'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCommentInput(bool isDarkMode) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: isDarkMode ? Colors.grey[900] : Colors.white,
      child: Row(
        children: [
          // Comment input field
          Expanded(
            child: TextField(
              controller: _commentController,
              decoration: InputDecoration(
                hintText: 'Nhập bình luận...',
                hintStyle: TextStyle(
                  color: isDarkMode ? Colors.white54 : Colors.black45,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: isDarkMode ? Colors.grey[800] : Colors.grey[200],
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              ),
              style: TextStyle(
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
          ),
          const SizedBox(width: 16),
          
          // Send button
          InkWell(
            onTap: () {
              if (_commentController.text.trim().isNotEmpty) {
                _commentBloc.add(AddCommentEvent(
                  liveStreamId: widget.liveStreamId,
                  userId: _currentUser.id,
                  userName: _currentUser.name,
                  userAvatar: _currentUser.avatar ?? '',
                  content: _commentController.text.trim(),
                ));
                _commentController.clear();
              }
            },
            borderRadius: BorderRadius.circular(24),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFEE4D2D),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.send,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);
    
    if (difference.inDays > 0) {
      return '${difference.inDays} ngày trước';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} giờ trước';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} phút trước';
    } else {
      return 'Vừa xong';
    }
  }
}
