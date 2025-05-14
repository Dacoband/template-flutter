import 'package:stream_cart_test/domain/repositories/auth_repository.dart';

class SignupUsecase {
  final AuthRepository authRepository;
  SignupUsecase(this.authRepository);
  Future<void> call(String name, String email, String password) async {
    // Gọi phương thức signup từ AuthRepository
    await authRepository.signup(name, email, password);
  }
}