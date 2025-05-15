import 'package:dio/dio.dart';
import 'package:stream_cart_test/core/config/env.dart';
import 'package:stream_cart_test/core/services/storage_service.dart';
import 'package:stream_cart_test/domain/entities/user.dart';

class AuthService {
  final Dio _dio;
  final StorageService _storageService;

  AuthService(this._dio, this._storageService);

  // Lưu thông tin đăng nhập
  Future<void> saveAuthData(User user) async {
    if (user.token != null) {
      await _storageService.saveAccessToken(user.token!);
    }
    
    if (user.refreshToken != null) {
      await _storageService.saveRefreshToken(user.refreshToken!);
    }
    
    await _storageService.saveUserId(user.id);
  }

  // Kiểm tra token hiện tại còn hạn hay không
  Future<bool> isLoggedIn() async {
    final token = await _storageService.getAccessToken();
    return token != null && token.isNotEmpty;
  }

  // Refresh token khi access token hết hạn
  Future<String?> refreshAccessToken() async {
    final refreshToken = await _storageService.getRefreshToken();
    
    if (refreshToken == null || refreshToken.isEmpty) {
      return null;
    }
    
    try {
      final response = await _dio.post(
        '${Env.apiUrl}/auth/refresh-token',
        data: {'refreshToken': refreshToken},
      );
      
      if (response.statusCode == 200 && response.data != null) {
        final newToken = response.data['accessToken'] as String?;
        final newRefreshToken = response.data['refreshToken'] as String?;
        
        if (newToken != null) {
          await _storageService.saveAccessToken(newToken);
        }
        
        if (newRefreshToken != null) {
          await _storageService.saveRefreshToken(newRefreshToken);
        }
        
        return newToken;
      }
    } catch (e) {
      print('Error refreshing token: $e');
    }
    
    return null;
  }

  // Đăng xuất
  Future<void> logout() async {
    await _storageService.clearAuthData();
  }

  // Thêm token vào request
  Future<void> addAuthHeader(RequestOptions options) async {
    final token = await _storageService.getAccessToken();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
  }
}
