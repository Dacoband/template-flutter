import 'package:stream_cart_test/data/datasources/remote_data_source.dart';
import 'package:stream_cart_test/domain/entities/user.dart';
import 'package:stream_cart_test/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final RemoteDataSource remoteDataSource;
  
  AuthRepositoryImpl(this.remoteDataSource);
  
  @override
  Future<User> login(String email, String password) async { 
    try {
      final userModel = await remoteDataSource.login(email, password);
      return userModel;
    } catch (e) {
      rethrow;
    }
  }
  
  @override
  Future<User> signup(String name, String email, String password, String phone) async {
    try {
      final userModel = await remoteDataSource.signup(name, email, password, phone);
      return userModel;
    } catch (e) {
      rethrow;
    }
  }
}