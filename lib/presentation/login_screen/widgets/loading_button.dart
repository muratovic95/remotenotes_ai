import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';

class LoadingButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isEnabled;
  final Color? backgroundColor;
  final Color? textColor;

  const LoadingButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.isEnabled = true,
    this.backgroundColor,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool canPress = isEnabled && !isLoading && onPressed != null;

    return Container(
      width: double.infinity,
      height: 6.h,
      child: ElevatedButton(
        onPressed: canPress ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: canPress
              ? (backgroundColor ?? AppTheme.lightTheme.colorScheme.primary)
              : AppTheme.lightTheme.colorScheme.onSurface
                  .withValues(alpha: 0.12),
          foregroundColor: canPress
              ? (textColor ?? Colors.white)
              : AppTheme.lightTheme.colorScheme.onSurface
                  .withValues(alpha: 0.38),
          elevation: canPress ? 2 : 0,
          shadowColor: AppTheme.lightTheme.colorScheme.shadow,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
        ),
        child: isLoading
            ? SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    textColor ?? Colors.white,
                  ),
                ),
              )
            : Text(
                text,
                style: AppTheme.lightTheme.textTheme.labelLarge?.copyWith(
                  color: canPress
                      ? (textColor ?? Colors.white)
                      : AppTheme.lightTheme.colorScheme.onSurface
                          .withValues(alpha: 0.38),
                  fontWeight: FontWeight.w600,
                ),
              ),
      ),
    );
  }
}
