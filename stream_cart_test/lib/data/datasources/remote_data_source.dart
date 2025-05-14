import 'package:dio/dio.dart';
import 'package:stream_cart_test/core/config/env.dart';
import 'package:stream_cart_test/core/constants/api_constants.dart';
import 'package:stream_cart_test/data/models/user_model.dart';

class RemoteDataSource {
  final Dio _dio;
  RemoteDataSource(this._dio){
    // Khởi tạo Dio với các tùy chọn mặc định
    // Cấu hình các tùy chọn cho Dio
    _dio.options.baseUrl = Env.apiUrl;
    _dio.options.connectTimeout = const Duration(seconds: 30); // Thời gian kết nối tối đa
    _dio.options.receiveTimeout = const Duration(seconds: 30); // Thời gian nhận dữ liệu tối đa
    _dio.options.sendTimeout = const Duration(seconds: 30); // Thời gian gửi dữ liệu tối đa
    _dio.options.responseType = ResponseType.json; // Kiểu phản hồi là JSON
    _dio.options.headers['Authorization'] = 'Bearer ${Env.apiKey}';
    _dio.options.headers['Content-Type'] = 'application/json';
    _dio.options.headers['Accept'] = 'application/json';
  }
  Future<UserModel> login(String email, String password) async{
    final respone = await _dio.post(ApiConstants.loginEndpoint, data: {
      'email': email,
      'password': password,
    });
    if (respone.statusCode == 200) {
      return UserModel.fromJson(respone.data);
    } else {
      throw Exception('Failed to login');
    }
  }
  Future<UserModel> signup(String name, String email, String password) async{
    final respone = await _dio.post(ApiConstants.signupEndpoint, data: {
      'name': name,
      'email': email,
      'password': password,
    });
    if (respone.statusCode == 200) {
      return UserModel.fromJson(respone.data);  
      // Chuyển đổi dữ liệu từ JSON sang đối tượng UserModel
      // và trả về đối tượng UserModel
      // Nếu không có lỗi, trả về đối tượng UserModel
    // Nếu có lỗi, ném ra một ngoại lệ
    } else {
      throw Exception('Failed to signup');
    }
  }
}