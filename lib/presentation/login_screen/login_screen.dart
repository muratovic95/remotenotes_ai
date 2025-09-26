import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/custom_text_field.dart';
import './widgets/loading_button.dart';
import './widgets/social_login_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isLoading = false;
  bool _isFormValid = false;

  // Mock credentials for testing
  final Map<String, String> _mockCredentials = {
    'admin@remotenotes.ai': 'admin123',
    'user@remotenotes.ai': 'user123',
    'demo@remotenotes.ai': 'demo123',
  };

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_validateForm);
    _passwordController.addListener(_validateForm);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _validateForm() {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    setState(() {
      _isFormValid = _isValidEmail(email) && password.length >= 6;
    });
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email);
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!_isValidEmail(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    // Check mock credentials
    if (_mockCredentials.containsKey(email) &&
        _mockCredentials[email] == password) {
      // Success - trigger haptic feedback
      HapticFeedback.lightImpact();

      setState(() {
        _isLoading = false;
      });

      // Navigate to dashboard
      Navigator.pushReplacementNamed(context, '/dashboard');
    } else {
      setState(() {
        _isLoading = false;
      });

      // Show error message
      _showErrorDialog(
          'Invalid credentials. Please check your email and password.');
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Login Failed',
            style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
              color: AppTheme.lightTheme.colorScheme.error,
            ),
          ),
          content: Text(
            message,
            style: AppTheme.lightTheme.textTheme.bodyMedium,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'OK',
                style: TextStyle(
                  color: AppTheme.lightTheme.colorScheme.primary,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _handleSocialLogin(String provider) async {
    // Simulate social login
    setState(() {
      _isLoading = true;
    });

    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      _isLoading = false;
    });

    // Navigate to dashboard
    Navigator.pushReplacementNamed(context, '/dashboard');
  }

  void _handleForgotPassword() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Forgot Password',
            style: AppTheme.lightTheme.textTheme.titleMedium,
          ),
          content: Text(
            'Password reset functionality will be implemented in a future update.',
            style: AppTheme.lightTheme.textTheme.bodyMedium,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'OK',
                style: TextStyle(
                  color: AppTheme.lightTheme.colorScheme.primary,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _handleSignUp() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Sign Up',
            style: AppTheme.lightTheme.textTheme.titleMedium,
          ),
          content: Text(
            'Sign up functionality will be implemented in a future update.',
            style: AppTheme.lightTheme.textTheme.bodyMedium,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'OK',
                style: TextStyle(
                  color: AppTheme.lightTheme.colorScheme.primary,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 6.w),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 8.h),

                  // App Logo
                  Container(
                    width: 20.w,
                    height: 20.w,
                    decoration: BoxDecoration(
                      color: AppTheme.lightTheme.colorScheme.primary,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                      child: CustomIconWidget(
                        iconName: 'mic',
                        color: Colors.white,
                        size: 10.w,
                      ),
                    ),
                  ),

                  SizedBox(height: 3.h),

                  // App Name
                  Text(
                    'RemoteNotes AI',
                    style:
                        AppTheme.lightTheme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppTheme.lightTheme.colorScheme.onSurface,
                    ),
                  ),

                  SizedBox(height: 1.h),

                  // Subtitle
                  Text(
                    'Transform your meetings into actionable insights',
                    style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                      color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(height: 6.h),

                  // Email Field
                  CustomTextField(
                    label: 'Email',
                    hint: 'Enter your email address',
                    iconName: 'email',
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: _validateEmail,
                  ),

                  SizedBox(height: 3.h),

                  // Password Field
                  CustomTextField(
                    label: 'Password',
                    hint: 'Enter your password',
                    iconName: 'lock',
                    controller: _passwordController,
                    isPassword: true,
                    showVisibilityToggle: true,
                    validator: _validatePassword,
                  ),

                  SizedBox(height: 2.h),

                  // Forgot Password Link
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: _handleForgotPassword,
                      child: Text(
                        'Forgot Password?',
                        style:
                            AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                          color: AppTheme.lightTheme.colorScheme.primary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 3.h),

                  // Login Button
                  LoadingButton(
                    text: 'Login',
                    onPressed: _isFormValid ? _handleLogin : null,
                    isLoading: _isLoading,
                    isEnabled: _isFormValid,
                  ),

                  SizedBox(height: 4.h),

                  // Divider
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: AppTheme.lightTheme.colorScheme.outline,
                          thickness: 1,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4.w),
                        child: Text(
                          'Or continue with',
                          style:
                              AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                            color: AppTheme
                                .lightTheme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: AppTheme.lightTheme.colorScheme.outline,
                          thickness: 1,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 3.h),

                  // Social Login Buttons
                  SocialLoginButton(
                    iconName: 'g_translate',
                    text: 'Continue with Google',
                    onPressed: () => _handleSocialLogin('Google'),
                  ),

                  SocialLoginButton(
                    iconName: 'apple',
                    text: 'Continue with Apple',
                    onPressed: () => _handleSocialLogin('Apple'),
                  ),

                  SizedBox(height: 4.h),

                  // Sign Up Link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'New user? ',
                        style:
                            AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                          color:
                              AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                      TextButton(
                        onPressed: _handleSignUp,
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Text(
                          'Sign Up',
                          style: AppTheme.lightTheme.textTheme.bodyMedium
                              ?.copyWith(
                            color: AppTheme.lightTheme.colorScheme.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 4.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
