import 'package:dio/dio.dart';
import 'package:stream_cart_test/core/config/env.dart';
import 'package:stream_cart_test/core/constants/api_constants.dart';
import 'package:stream_cart_test/core/services/auth_service.dart';
import 'package:stream_cart_test/data/models/user_model.dart';

class RemoteDataSource {
  final Dio _dio;
  final AuthService? _authService;
  
  RemoteDataSource(this._dio, [this._authService]){
    // Khởi tạo Dio với các tùy chọn mặc định
    // Cấu hình các tùy chọn cho Dio
    _dio.options.baseUrl = Env.apiUrl;
    _dio.options.connectTimeout = const Duration(seconds: 30);
    _dio.options.receiveTimeout = const Duration(seconds: 30);
    _dio.options.sendTimeout = const Duration(seconds: 30);
    _dio.options.responseType = ResponseType.json;
    _dio.options.headers['Content-Type'] = 'application/json';
    _dio.options.headers['Accept'] = 'application/json';
  }    Future<UserModel> login(String email, String password) async {
    try {
      final response = await _dio.post(ApiConstants.loginEndpoint, data: {
        'email': email,
        'password': password,
      });
      
      if (response.statusCode == 200 || response.statusCode == 201) {
        final userModel = UserModel.fromJson(response.data);
        
        // Lưu thông tin đăng nhập nếu auth service được cung cấp
        if (_authService != null && userModel.token != null) {
          await _authService!.saveAuthData(userModel);
        }
        
        return userModel;
      } else {
        throw Exception('Failed to login: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      // Xử lý chi tiết lỗi từ response của API
      if (e.response != null) {
        final errorData = e.response?.data;
        if (errorData is Map<String, dynamic>) {
          final errorMessage = errorData['message'] ?? errorData['error'] ?? 'Unknown error';
          throw Exception('Login failed: $errorMessage');
        }
      }
      throw Exception('Login failed: ${e.message ?? 'Unknown error'}');
    }
  }
    Future<UserModel> signup(String name, String email, String password, String phone) async {
    try {
      final response = await _dio.post(ApiConstants.signupEndpoint, data: {
        'name': name,
        'email': email,
        'password': password,
        'phone': phone,
        'role': 'customer'
      });
      
      if (response.statusCode == 200 || response.statusCode == 201) {
        return UserModel.fromJson(response.data);
      } else {
        throw Exception('Failed to signup: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      // Xử lý chi tiết lỗi từ response của API
      if (e.response != null) {
        final errorData = e.response?.data;
        if (errorData is Map<String, dynamic>) {
          final errorMessage = errorData['message'] ?? errorData['error'] ?? 'Unknown error';
          throw Exception('Signup failed: $errorMessage');
        }
      }
      throw Exception('Signup failed: ${e.message ?? 'Unknown error'}');
    }
  }
}