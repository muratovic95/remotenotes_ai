import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final String hint;
  final String iconName;
  final bool isPassword;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool showVisibilityToggle;

  const CustomTextField({
    Key? key,
    required this.label,
    required this.hint,
    required this.iconName,
    required this.controller,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.showVisibilityToggle = false,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;
  String? _errorText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  void _validateInput(String value) {
    if (widget.validator != null) {
      setState(() {
        _errorText = widget.validator!(value);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w500,
            color: AppTheme.lightTheme.colorScheme.onSurface,
          ),
        ),
        SizedBox(height: 1.h),
        Container(
          height: 6.h,
          child: TextFormField(
            controller: widget.controller,
            obscureText: widget.isPassword ? _obscureText : false,
            keyboardType: widget.keyboardType,
            onChanged: _validateInput,
            style: AppTheme.lightTheme.textTheme.bodyMedium,
            decoration: InputDecoration(
              hintText: widget.hint,
              prefixIcon: Padding(
                padding: EdgeInsets.all(3.w),
                child: CustomIconWidget(
                  iconName: widget.iconName,
                  color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                  size: 20,
                ),
              ),
              suffixIcon: widget.showVisibilityToggle
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                      icon: CustomIconWidget(
                        iconName:
                            _obscureText ? 'visibility_off' : 'visibility',
                        color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                        size: 20,
                      ),
                    )
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: _errorText != null
                      ? AppTheme.lightTheme.colorScheme.error
                      : AppTheme.lightTheme.colorScheme.outline,
                  width: 1,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: _errorText != null
                      ? AppTheme.lightTheme.colorScheme.error
                      : AppTheme.lightTheme.colorScheme.outline,
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: _errorText != null
                      ? AppTheme.lightTheme.colorScheme.error
                      : AppTheme.lightTheme.colorScheme.primary,
                  width: 2,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: AppTheme.lightTheme.colorScheme.error,
                  width: 1,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: AppTheme.lightTheme.colorScheme.error,
                  width: 2,
                ),
              ),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
              filled: true,
              fillColor: AppTheme.lightTheme.colorScheme.surface,
            ),
          ),
        ),
        _errorText != null
            ? Padding(
                padding: EdgeInsets.only(top: 0.5.h, left: 1.w),
                child: Text(
                  _errorText!,
                  style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                    color: AppTheme.lightTheme.colorScheme.error,
                  ),
                ),
              )
            : SizedBox.shrink(),
      ],
    );
  }
}
