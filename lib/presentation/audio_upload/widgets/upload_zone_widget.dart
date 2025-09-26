import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class UploadZoneWidget extends StatelessWidget {
  final VoidCallback onTap;
  final bool isDragOver;

  const UploadZoneWidget({
    Key? key,
    required this.onTap,
    this.isDragOver = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 85.w,
        height: 25.h,
        decoration: BoxDecoration(
          color: isDragOver
              ? AppTheme.lightTheme.primaryColor.withValues(alpha: 0.1)
              : AppTheme.lightTheme.colorScheme.surface,
          border: Border.all(
            color: isDragOver
                ? AppTheme.lightTheme.primaryColor
                : AppTheme.lightTheme.colorScheme.outline,
            width: 2,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomIconWidget(
              iconName: 'cloud_upload',
              color: isDragOver
                  ? AppTheme.lightTheme.primaryColor
                  : AppTheme.lightTheme.colorScheme.onSurfaceVariant,
              size: 48,
            ),
            SizedBox(height: 2.h),
            Text(
              'Tap to select audio file',
              style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                color: isDragOver
                    ? AppTheme.lightTheme.primaryColor
                    : AppTheme.lightTheme.colorScheme.onSurface,
              ),
            ),
            SizedBox(height: 1.h),
            Text(
              'Supports MP3, MP4, WAV, M4A',
              style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
              ),
            ),
            SizedBox(height: 0.5.h),
            Text(
              'Max 500MB for free tier',
              style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
