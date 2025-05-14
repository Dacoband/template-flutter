import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/auth/auth_bloc.dart';
import '../blocs/auth/auth_event.dart';
import '../blocs/auth/auth_state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  bool _isPasswordVisible = false;
  bool _rememberMe = false;

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
    _emailController.dispose();
    _passwordController.dispose();
    _animationController.dispose();
    super.dispose();
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
        toolbarHeight: 0,
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Đăng nhập thành công!'),
                backgroundColor: Colors.green[800],
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            );
            // Navigate to home page
          } else if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
                backgroundColor: Colors.red[800],
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
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
                    child: Center(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 30),
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
                                  'Đăng nhập',
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
                              'Chào mừng bạn quay trở lại',
                              style: TextStyle(
                                fontSize: 16,
                                color: isDarkMode ? Colors.white70 : Colors.black54,
                                letterSpacing: -0.2,
                              ),
                            ),
                            const SizedBox(height: 50),
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
                            const SizedBox(height: 20),
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
                              textInputAction: TextInputAction.done,
                            ),
                            const SizedBox(height: 4),
                            // Remember me and Forgot password
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      height: 24,
                                      width: 24,
                                      child: Checkbox(
                                        value: _rememberMe,
                                        onChanged: (value) {
                                          setState(() {
                                            _rememberMe = value ?? false;
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
                                    Text(
                                      'Ghi nhớ đăng nhập',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: isDarkMode ? Colors.white70 : Colors.black54,
                                      ),
                                    ),
                                  ],
                                ),
                                TextButton(
                                  onPressed: () {
                                    // Handle forgot password
                                  },
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    minimumSize: const Size(10, 10),
                                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                  ),
                                  child: Text(
                                    'Quên mật khẩu?',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: isDarkMode ? Colors.white70 : Colors.black87,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 40),
                            // Login button
                            Hero(
                              tag: 'authButton',
                              child: Material(
                                color: Colors.transparent,
                                child: _buildLoginButton(state, isDarkMode),
                              ),
                            ),
                            const SizedBox(height: 24),
                            // Sign up link
                            Center(
                              child: Hero(
                                tag: 'switchAuthMode',
                                child: Material(
                                  color: Colors.transparent,
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.pushNamed(context, '/signup');
                                    },
                                    child: RichText(
                                      text: TextSpan(
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: isDarkMode ? Colors.white70 : Colors.black54,
                                        ),
                                        children: [
                                          const TextSpan(text: 'Chưa có tài khoản? '),
                                          TextSpan(
                                            text: 'Đăng ký ngay',
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
                          ],
                        ),
                      ),
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
    );
  }

  Widget _buildLoginButton(AuthState state, bool isDarkMode) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        onPressed: state is AuthLoading
            ? null
            : () {
                if (_formKey.currentState!.validate()) {
                  context.read<AuthBloc>().add(
                        LoginEvent(
                          email: _emailController.text,
                          password: _passwordController.text,
                        ),
                      );
                }
              },
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
                'ĐĂNG NHẬP',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.1,
                ),
              ),
      ),
    );
  }
}
