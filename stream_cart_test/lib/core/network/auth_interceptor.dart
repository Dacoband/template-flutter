import 'package:dio/dio.dart';
import 'package:stream_cart_test/core/services/auth_service.dart';

class AuthInterceptor extends Interceptor {
  final AuthService _authService;
  final Dio _dio;

  AuthInterceptor(this._authService, this._dio);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    // Thêm token vào header nếu có
    await _authService.addAuthHeader(options);
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // Xử lý lỗi khi token hết hạn (401)
    if (err.response?.statusCode == 401) {
      // Thử refresh token
      final newToken = await _authService.refreshAccessToken();
      
      if (newToken != null) {
        // Nếu refresh thành công, thử lại request
        final options = err.requestOptions;
        options.headers['Authorization'] = 'Bearer $newToken';
        
        try {
          final response = await _dio.fetch(options);
          handler.resolve(response);
          return;
        } on DioException catch (e) {
          handler.next(e);
          return;
        }
      }
    }
    
    handler.next(err);
  }
}
