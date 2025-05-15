import 'package:stream_cart_test/domain/entities/user.dart';
import 'package:stream_cart_test/domain/repositories/auth_repository.dart';

class SignupUsecase {
  final AuthRepository authRepository;
  
  SignupUsecase(this.authRepository);
  
  Future<User> call(String name, String email, String password, String phone) async {
    return await authRepository.signup(name, email, password, phone);
  }
}