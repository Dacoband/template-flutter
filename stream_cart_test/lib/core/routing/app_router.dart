import 'package:flutter/material.dart';
import 'package:stream_cart_test/presentation/pages/home_page.dart';
import 'package:stream_cart_test/presentation/pages/login_page.dart';
import 'package:stream_cart_test/presentation/pages/signup_page.dart';
// Import other pages as needed

class AppRouter {
  static const String login = '/login';
  static const String signup = '/signup';
  static const String home = '/home';
  static const String productDetails = '/product-details';

  // Define other route names as constants
  
  static Map<String, WidgetBuilder> getRoutes() {
    return {
      login: (context) => LoginPage(),
      signup: (context) => SignupPage(),
      home: (context) => HomePage(), 
      // Add other routes
    };
  }
}