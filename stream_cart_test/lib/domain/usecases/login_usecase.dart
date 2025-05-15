import 'package:stream_cart_test/domain/entities/user.dart';
import 'package:stream_cart_test/domain/repositories/auth_repository.dart';

class LoginUsecase {
  final AuthRepository authRepository;

  LoginUsecase(this.authRepository);
  
  Future<User> call(String email, String password) async {
    return await authRepository.login(email, password);
  }
}