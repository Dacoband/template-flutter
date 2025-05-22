class User {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String? role;
  final String? status;
  final String? token;
  final String? refreshToken;
  final String? avatar;
  final bool isAdmin;
  final bool isStreamer;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.role,
    this.status,
    this.token,
    this.refreshToken,
    this.avatar,
    this.isAdmin = false,
    this.isStreamer = false,
  });
}