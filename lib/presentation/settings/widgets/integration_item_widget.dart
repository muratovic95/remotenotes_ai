import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class IntegrationItemWidget extends StatelessWidget {
  final Map<String, dynamic> integration;
  final VoidCallback onTap;

  const IntegrationItemWidget({
    Key? key,
    required this.integration,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isConnected = integration['connected'] as bool? ?? false;
    final lastSync = integration['lastSync'] as String?;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 0.5.h),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppTheme.lightTheme.colorScheme.outline.withValues(alpha: 0.2),
        ),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
        leading: Container(
          width: 10.w,
          height: 10.w,
          decoration: BoxDecoration(
            color: AppTheme.lightTheme.colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(8),
          ),
          child: CustomImageWidget(
            imageUrl: integration['logo'] as String,
            width: 10.w,
            height: 10.w,
            fit: BoxFit.contain,
          ),
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                integration['name'] as String,
                style: AppTheme.lightTheme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
              decoration: BoxDecoration(
                color: isConnected
                    ? AppTheme.lightTheme.colorScheme.tertiary
                        .withValues(alpha: 0.1)
                    : AppTheme.lightTheme.colorScheme.error
                        .withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isConnected
                      ? AppTheme.lightTheme.colorScheme.tertiary
                      : AppTheme.lightTheme.colorScheme.error,
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 1.5.w,
                    height: 1.5.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isConnected
                          ? AppTheme.lightTheme.colorScheme.tertiary
                          : AppTheme.lightTheme.colorScheme.error,
                    ),
                  ),
                  SizedBox(width: 1.w),
                  Text(
                    isConnected ? 'Connected' : 'Disconnected',
                    style: AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
                      color: isConnected
                          ? AppTheme.lightTheme.colorScheme.tertiary
                          : AppTheme.lightTheme.colorScheme.error,
                      fontWeight: FontWeight.w500,
                      fontSize: 10.sp,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 0.5.h),
            Text(
              integration['description'] as String,
              style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            if (lastSync != null && isConnected) ...[
              SizedBox(height: 0.5.h),
              Text(
                'Last sync: $lastSync',
                style: AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
                  color: AppTheme.lightTheme.colorScheme.onSurfaceVariant
                      .withValues(alpha: 0.7),
                ),
              ),
            ],
          ],
        ),
        trailing: CustomIconWidget(
          iconName: 'chevron_right',
          color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
          size: 20,
        ),
        onTap: onTap,
      ),
    );
  }
}
