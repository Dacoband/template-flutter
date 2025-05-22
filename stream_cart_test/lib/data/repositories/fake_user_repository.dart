import 'package:stream_cart_test/domain/entities/user.dart';

// Mock repository để cung cấp fake data user khi API đã đóng
class FakeUserRepository {
  // Danh sách người dùng giả lập
  final List<User> _users = [
    User(
      id: '1',
      name: 'Nguyễn Văn A',
      email: 'user@example.com',
      phone: '0987654321',
      avatar: 'https://i.pravatar.cc/150?img=1',
      token: 'fake_token_user_1',
      role: 'user',
      status: 'active',
      isAdmin: false,
    ),
    User(
      id: '2',
      name: 'Admin User',
      email: 'admin@example.com',
      phone: '0123456789',
      avatar: 'https://i.pravatar.cc/150?img=2',
      token: 'fake_token_admin_1',
      role: 'admin',
      status: 'active',
      isAdmin: true,
    ),
    User(
      id: '3',
      name: 'Streamer',
      email: 'streamer@example.com',
      phone: '0909090909',
      avatar: 'https://i.pravatar.cc/150?img=3',
      token: 'fake_token_streamer_1',
      role: 'streamer',
      status: 'active',
      isStreamer: true,
    ),
  ];

  // Phương thức đăng nhập giả lập
  Future<User> login(String email, String password) async {
    // Giả lập độ trễ khi gọi API
    await Future.delayed(const Duration(seconds: 1));
    
    // Tìm user theo email (mật khẩu bỏ qua vì đây là môi trường giả lập)
    final user = _users.firstWhere(
      (user) => user.email == email,
      orElse: () => throw Exception('Tài khoản không tồn tại'),
    );
    
    return user;
  }

  // Phương thức đăng ký giả lập
  Future<User> register(String name, String email, String password, String phone) async {
    // Giả lập độ trễ khi gọi API
    await Future.delayed(const Duration(seconds: 1));
    
    // Kiểm tra email đã tồn tại chưa
    final existingUser = _users.any((user) => user.email == email);
    if (existingUser) {
      throw Exception('Email đã được sử dụng');
    }
    
    // Tạo user mới
    final newUser = User(
      id: (_users.length + 1).toString(),
      name: name,
      email: email,
      phone: phone,
      avatar: 'https://i.pravatar.cc/150?img=${_users.length + 10}',
      token: 'fake_token_${_users.length + 1}',
      role: 'user',
      status: 'active',
      isAdmin: false,
    );
    
    // Thêm vào danh sách
    _users.add(newUser);
    
    return newUser;
  }
  
  // Lấy thông tin user theo token
  Future<User> getUserByToken(String token) async {
    await Future.delayed(const Duration(milliseconds: 500));
    
    final user = _users.firstWhere(
      (user) => user.token == token,
      orElse: () => throw Exception('Token không hợp lệ'),
    );
    
    return user;
  }
}
