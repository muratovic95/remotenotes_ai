import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class ApiStatusWidget extends StatelessWidget {
  final String status;
  final String message;

  const ApiStatusWidget({
    Key? key,
    required this.status,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 85.w,
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: _getStatusBackgroundColor(),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            width: 8.w,
            height: 8.w,
            decoration: BoxDecoration(
              color: _getStatusColor().withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(4),
            ),
            child: CustomIconWidget(
              iconName: _getStatusIcon(),
              color: _getStatusColor(),
              size: 16,
            ),
          ),
          SizedBox(width: 3.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'API Status: ${status.toUpperCase()}',
                  style: AppTheme.lightTheme.textTheme.titleSmall?.copyWith(
                    color: _getStatusColor(),
                  ),
                ),
                if (message.isNotEmpty) ...[
                  SizedBox(height: 0.5.h),
                  Text(
                    message,
                    style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                      color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor() {
    switch (status.toLowerCase()) {
      case 'online':
        return AppTheme.lightTheme.colorScheme.tertiary;
      case 'degraded':
        return AppTheme.warningLight;
      case 'offline':
        return AppTheme.lightTheme.colorScheme.error;
      default:
        return AppTheme.lightTheme.colorScheme.onSurfaceVariant;
    }
  }

  Color _getStatusBackgroundColor() {
    switch (status.toLowerCase()) {
      case 'online':
        return AppTheme.lightTheme.colorScheme.tertiaryContainer;
      case 'degraded':
        return AppTheme.warningLight.withValues(alpha: 0.1);
      case 'offline':
        return AppTheme.lightTheme.colorScheme.errorContainer;
      default:
        return AppTheme.lightTheme.colorScheme.surfaceContainerHighest;
    }
  }

  String _getStatusIcon() {
    switch (status.toLowerCase()) {
      case 'online':
        return 'check_circle';
      case 'degraded':
        return 'warning';
      case 'offline':
        return 'error';
      default:
        return 'info';
    }
  }
}