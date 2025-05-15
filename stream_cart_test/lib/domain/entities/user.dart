class User {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String role;
  final String status;
  final String? token;
  final String? refreshToken;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.role,
    required this.status,
    this.token,
    this.refreshToken,
  });
}