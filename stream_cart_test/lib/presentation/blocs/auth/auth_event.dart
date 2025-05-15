import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => []; // So sánh các thuộc tính của sự kiện
  // Phương thức này sẽ trả về một danh sách các thuộc tính của sự kiện
}

class LoginEvent extends AuthEvent {
  // Event for user login
  // Nó là một sự kiện cho việc đăng nhập của người dùng
  // Nó chứa các thông tin cần thiết để thực hiện việc đăng nhập
  final String email;
  final String password;

  LoginEvent({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password]; // So sánh các thuộc tính của sự kiện
}

class SignupEvent extends AuthEvent {
  final String name;
  final String email;
  final String password;
  final String phone;

  SignupEvent({
    required this.name, 
    required this.email, 
    required this.password,
    required this.phone,
  });

  @override
  List<Object?> get props => [name, email, password, phone];
}