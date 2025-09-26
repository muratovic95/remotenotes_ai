import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class RecordingQualityWidget extends StatelessWidget {
  final String qualityStatus;
  final double storageRemaining;

  const RecordingQualityWidget({
    Key? key,
    required this.qualityStatus,
    required this.storageRemaining,
  }) : super(key: key);

  Color _getQualityColor() {
    switch (qualityStatus.toLowerCase()) {
      case 'good':
        return AppTheme.lightTheme.colorScheme.tertiary;
      case 'fair':
        return Colors.orange;
      case 'poor':
        return AppTheme.lightTheme.colorScheme.error;
      default:
        return AppTheme.lightTheme.colorScheme.onSurfaceVariant;
    }
  }

  IconData _getQualityIcon() {
    switch (qualityStatus.toLowerCase()) {
      case 'good':
        return Icons.signal_cellular_4_bar;
      case 'fair':
        return Icons.help_outline;
      case 'poor':
        return Icons.help_outline;
      default:
        return Icons.signal_cellular_off;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppTheme.lightTheme.colorScheme.outline,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          // Recording Quality
          Row(
            children: [
              CustomIconWidget(
                iconName: _getQualityIcon().codePoint.toString(),
                color: _getQualityColor(),
                size: 5.w,
              ),
              SizedBox(width: 2.w),
              Text(
                'Quality: $qualityStatus',
                style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                  color: _getQualityColor(),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          // Storage Remaining
          Row(
            children: [
              CustomIconWidget(
                iconName: 'storage',
                color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                size: 5.w,
              ),
              SizedBox(width: 2.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Storage: ${storageRemaining.toStringAsFixed(1)} GB remaining',
                      style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                        color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    SizedBox(height: 1.h),
                    LinearProgressIndicator(
                      value: storageRemaining / 10.0, // Assuming 10GB total
                      backgroundColor: AppTheme.lightTheme.colorScheme.outline,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        storageRemaining > 2.0
                            ? AppTheme.lightTheme.colorScheme.tertiary
                            : AppTheme.lightTheme.colorScheme.error,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
