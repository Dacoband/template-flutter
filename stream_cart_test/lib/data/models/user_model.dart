import 'package:json_annotation/json_annotation.dart';
import 'package:stream_cart_test/domain/entities/user.dart';


// part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends User {
  @JsonKey(name: '_id')
  final String id;
  final String name;
  final String email;
  final String phone;
  final String role;
  final String status;
  final String? accessToken;
  final String? refreshToken;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.role,
    required this.status,
    this.accessToken,
    this.refreshToken,
  }) : super(
          id: id,
          name: name,
          email: email,
          phone: phone,
          role: role,
          status: status,
          token: accessToken,
          refreshToken: refreshToken,
        );
  factory UserModel.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('isValid')) {
      // Login response format
      var accessToken = '';
      var refreshToken = '';

      if (json.containsKey('token')) {
        var tokenData = json['token'];
        if (tokenData is Map<String, dynamic>) {
          accessToken = tokenData['accessToken'] as String? ?? '';
          refreshToken = tokenData['refreshToken'] as String? ?? '';
        }
      }

      return UserModel(
        id: json['userId'] as String,
        name: '',  // These will be populated later if needed
        email: '',
        phone: '',
        role: '',
        status: 'active',
        accessToken: accessToken,
        refreshToken: refreshToken,
      );
    } else {
      // Register response format
      return UserModel(
        id: json['_id'] as String,
        name: json['name'] as String,
        email: json['email'] as String,
        phone: json['phone'] as String,
        role: json['role'] as String,
        status: json['status'] as String,
        accessToken: null,
        refreshToken: null,
      );
    }
  }
  Map<String, dynamic> toJson() => <String, dynamic>{
        '_id': id,
        'name': name,
        'email': email,
        'phone': phone,
        'role': role,
        'status': status,
        'accessToken': accessToken,
        'refreshToken': refreshToken,
      };
}