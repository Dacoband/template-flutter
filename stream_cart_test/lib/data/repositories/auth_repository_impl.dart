import 'package:stream_cart_test/data/datasources/remote_data_source.dart';
import 'package:stream_cart_test/domain/entities/user.dart';
import 'package:stream_cart_test/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final RemoteDataSource remoteDataSource;
  AuthRepositoryImpl(this.remoteDataSource);
  // Implement the AuthRepository interface
  
  @override
  Future<User> login(String email, String password) async { 
    // Gọi phương thức login từ RemoteDataSource
    // Phương thức này sẽ gọi phương thức login từ RemoteDataSource
    try {
      final userModel = await remoteDataSource.login(email, password);
      return userModel;
    } catch (e) {
      rethrow;
    }
  }
  @override
  Future<User> signup(String name, String email, String password) async {
    // Gọi phương thức signup từ RemoteDataSource
    // Phương thức này sẽ gọi phương thức signup từ RemoteDataSource
    try {
      final userModel = await remoteDataSource.signup(name, email, password);
      return userModel;
    } catch (e) {
      rethrow;
    }
  }
}