import 'package:stream_cart_test/domain/entities/user.dart';
import 'package:stream_cart_test/domain/repositories/auth_repository.dart';

class LoginUsecase {
  final AuthRepository authRepository;

  LoginUsecase(this.authRepository);
  Future<User> call(String email, String password) async{
    // Gọi phương thức login từ AuthRepository
    final user = await authRepository.login(email, password);
    return user;
  }
}