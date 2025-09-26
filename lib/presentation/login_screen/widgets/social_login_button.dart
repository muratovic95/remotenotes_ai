import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class SocialLoginButton extends StatelessWidget {
  final String iconName;
  final String text;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;

  const SocialLoginButton({
    Key? key,
    required this.iconName,
    required this.text,
    required this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 6.h,
      margin: EdgeInsets.symmetric(vertical: 0.5.h),
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: backgroundColor ?? Colors.transparent,
          side: BorderSide(
            color: borderColor ?? AppTheme.lightTheme.colorScheme.outline,
            width: 1,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomIconWidget(
              iconName: iconName,
              color: textColor ?? AppTheme.lightTheme.colorScheme.onSurface,
              size: 20,
            ),
            SizedBox(width: 3.w),
            Text(
              text,
              style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                color: textColor ?? AppTheme.lightTheme.colorScheme.onSurface,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
