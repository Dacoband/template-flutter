import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_cart_test/presentation/blocs/auth/auth_bloc.dart';
import 'package:stream_cart_test/presentation/blocs/auth/auth_event.dart';
import 'package:stream_cart_test/presentation/blocs/auth/auth_state.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _agreeToTerms = false;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.65, curve: Curves.easeOut),
      ),
    );
    _slideAnimation = Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.65, curve: Curves.easeOut),
      ),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Vui lòng nhập họ tên';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Vui lòng nhập email';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Email không hợp lệ';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Vui lòng nhập mật khẩu';
    }
    if (value.length < 6) {
      return 'Mật khẩu phải có ít nhất 6 ký tự';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Vui lòng xác nhận mật khẩu';
    }
    if (value != _passwordController.text) {
      return 'Mật khẩu không khớp';
    }
    return null;
  }

  void _submitForm() {
    if (_formKey.currentState!.validate() && _agreeToTerms) {
      context.read<AuthBloc>().add(
            SignupEvent(
              email: _emailController.text,
              password: _passwordController.text,
              name: _nameController.text,
            ),
          );
    } else if (!_agreeToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Vui lòng đồng ý với Điều khoản dịch vụ'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final isDarkMode = brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: isDarkMode ? Brightness.light : Brightness.dark,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Đăng ký thành công!'),
                backgroundColor: Colors.green,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            );
            Navigator.of(context).pop(); // Trở về trang đăng nhập
          } else if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Đăng ký thất bại: ${state.message}'),
                backgroundColor: Colors.red,
                behavior: SnackBarBehavior.floating,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Form(
                    key: _formKey,
                    child: ListView(
                      children: [
                        const SizedBox(height: 20),
                        Hero(
                          tag: 'appLogo',
                          child: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: isDarkMode ? Colors.white : Colors.black,
                            ),
                            child: Icon(
                              Icons.shopping_cart,
                              color: isDarkMode ? Colors.black : Colors.white,
                              size: 30,
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        Hero(
                          tag: 'title',
                          child: Material(
                            color: Colors.transparent,
                            child: Text(
                              'Tạo tài khoản mới',
                              style: TextStyle(
                                fontSize: 36,
                                fontWeight: FontWeight.bold,
                                color: isDarkMode ? Colors.white : Colors.black,
                                letterSpacing: -0.5,
                              ),
                            ),
                          ),
                        ),
                        Text(
                          'Điền thông tin để tạo tài khoản',
                          style: TextStyle(
                            fontSize: 16,
                            color: isDarkMode ? Colors.white70 : Colors.black54,
                            letterSpacing: -0.2,
                          ),
                        ),
                        const SizedBox(height: 30),
                        // Name field
                        _buildAnimatedInputField(
                          labelText: 'Họ tên',
                          hintText: 'Nhập họ tên của bạn',
                          controller: _nameController,
                          icon: Icons.person_outline,
                          validator: _validateName,
                          isDarkMode: isDarkMode,
                          textInputAction: TextInputAction.next,
                        ),
                        const SizedBox(height: 16),
                        // Email field
                        _buildAnimatedInputField(
                          labelText: 'Email',
                          hintText: 'example@gmail.com',
                          controller: _emailController,
                          icon: Icons.email_outlined,
                          validator: _validateEmail,
                          isDarkMode: isDarkMode,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 16),
                        // Password field
                        _buildAnimatedInputField(
                          labelText: 'Mật khẩu',
                          hintText: '••••••••',
                          controller: _passwordController,
                          icon: Icons.lock_outline,
                          isPassword: true,
                          isPasswordVisible: _isPasswordVisible,
                          onTogglePassword: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                          validator: _validatePassword,
                          isDarkMode: isDarkMode,
                          textInputAction: TextInputAction.next,
                        ),
                        const SizedBox(height: 16),
                        // Confirm password field
                        _buildAnimatedInputField(
                          labelText: 'Xác nhận mật khẩu',
                          hintText: '••••••••',
                          controller: _confirmPasswordController,
                          icon: Icons.lock_outline,
                          isPassword: true,
                          isPasswordVisible: _isConfirmPasswordVisible,
                          onTogglePassword: () {
                            setState(() {
                              _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                            });
                          },
                          validator: _validateConfirmPassword,
                          isDarkMode: isDarkMode,
                          textInputAction: TextInputAction.done,
                        ),
                        const SizedBox(height: 24),
                        // Terms and conditions
                        Row(
                          children: [
                            SizedBox(
                              height: 24,
                              width: 24,
                              child: Checkbox(
                                value: _agreeToTerms,
                                onChanged: (value) {
                                  setState(() {
                                    _agreeToTerms = value ?? false;
                                  });
                                },
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                activeColor: isDarkMode ? Colors.white : Colors.black,
                                checkColor: isDarkMode ? Colors.black : Colors.white,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'Tôi đồng ý với Điều khoản dịch vụ và Chính sách Bảo mật',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: isDarkMode ? Colors.white70 : Colors.black54,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        // Sign up button
                        Hero(
                          tag: 'authButton',
                          child: Material(
                            color: Colors.transparent,
                            child: SizedBox(
                              width: double.infinity,
                              height: 60,
                              child: ElevatedButton(
                                onPressed: state is AuthLoading ? null : _submitForm,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: isDarkMode ? Colors.white : Colors.black,
                                  foregroundColor: isDarkMode ? Colors.black : Colors.white,
                                  disabledBackgroundColor: isDarkMode ? Colors.white60 : Colors.black38,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                child: state is AuthLoading
                                    ? SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          valueColor: AlwaysStoppedAnimation<Color>(
                                            isDarkMode ? Colors.black : Colors.white,
                                          ),
                                        ),
                                      )
                                    : const Text(
                                        'ĐĂNG KÝ',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1.1,
                                        ),
                                      ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Login link
                        Center(
                          child: Hero(
                            tag: 'switchAuthMode',
                            child: Material(
                              color: Colors.transparent,
                              child: TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: isDarkMode ? Colors.white70 : Colors.black54,
                                    ),
                                    children: [
                                      const TextSpan(text: 'Đã có tài khoản? '),
                                      TextSpan(
                                        text: 'Đăng nhập ngay',
                                        style: TextStyle(
                                          color: isDarkMode ? Colors.white : Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildAnimatedInputField({
    required String labelText,
    required String hintText,
    required TextEditingController controller,
    required IconData icon,
    required bool isDarkMode,
    bool isPassword = false,
    bool isPasswordVisible = false,
    VoidCallback? onTogglePassword,
    String? Function(String?)? validator,
    TextInputAction? textInputAction,
    TextInputType? keyboardType,
  }) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            color: isDarkMode ? const Color(0xFF1A1A1A) : const Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(16),
          ),
          child: TextFormField(
            controller: controller,
            validator: validator,
            obscureText: isPassword && !isPasswordVisible,
            textInputAction: textInputAction,
            keyboardType: keyboardType,
            style: TextStyle(
              color: isDarkMode ? Colors.white : Colors.black,
              fontSize: 16,
            ),
            decoration: InputDecoration(
              labelText: labelText,
              hintText: hintText,
              hintStyle: TextStyle(
                color: isDarkMode ? Colors.white38 : Colors.black38,
              ),
              labelStyle: TextStyle(
                color: isDarkMode ? Colors.white70 : Colors.black54,
              ),
              prefixIcon: Icon(
                icon,
                color: isDarkMode ? Colors.white70 : Colors.black54,
              ),
              suffixIcon: isPassword
                  ? IconButton(
                      icon: Icon(
                        isPasswordVisible
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: isDarkMode ? Colors.white70 : Colors.black54,
                      ),
                      onPressed: onTogglePassword,
                    )
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 20),
            ),
          ),
        );
      },
    );  }
}
