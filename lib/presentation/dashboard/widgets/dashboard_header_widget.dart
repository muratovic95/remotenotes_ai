import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class DashboardHeaderWidget extends StatelessWidget {
  final VoidCallback? onNotificationTap;
  final VoidCallback? onAvatarTap;

  const DashboardHeaderWidget({
    Key? key,
    this.onNotificationTap,
    this.onAvatarTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color:
                AppTheme.lightTheme.colorScheme.shadow.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Logo and App Name
          Row(
            children: [
              Container(
                width: 10.w,
                height: 10.w,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppTheme.lightTheme.colorScheme.primary,
                      AppTheme.lightTheme.colorScheme.primary
                          .withValues(alpha: 0.7),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: CustomIconWidget(
                    iconName: 'mic',
                    color: Colors.white,
                    size: 6.w,
                  ),
                ),
              ),
              SizedBox(width: 3.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'RemoteNotes AI',
                    style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppTheme.lightTheme.colorScheme.onSurface,
                    ),
                  ),
                  Text(
                    'Smart Meeting Notes',
                    style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                      color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Spacer(),
          // Notification and Avatar
          Row(
            children: [
              GestureDetector(
                onTap: onNotificationTap,
                child: Container(
                  padding: EdgeInsets.all(2.5.w),
                  decoration: BoxDecoration(
                    color:
                        AppTheme.lightTheme.colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Stack(
                    children: [
                      CustomIconWidget(
                        iconName: 'notifications',
                        color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                        size: 24,
                      ),
                      Positioned(
                        right: 0,
                        top: 0,
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: AppTheme.lightTheme.colorScheme.error,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 3.w),
              GestureDetector(
                onTap: onAvatarTap,
                child: Container(
                  width: 12.w,
                  height: 12.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppTheme.lightTheme.colorScheme.outline
                          .withValues(alpha: 0.3),
                      width: 1,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(11),
                    child: CustomImageWidget(
                      imageUrl:
                          "https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=150&h=150&fit=crop&crop=face",
                      width: 12.w,
                      height: 12.w,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
