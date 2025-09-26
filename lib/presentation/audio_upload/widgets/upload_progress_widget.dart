import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class UploadProgressWidget extends StatelessWidget {
  final Map<String, dynamic> progressData;
  final VoidCallback? onPause;
  final VoidCallback? onCancel;

  const UploadProgressWidget({
    Key? key,
    required this.progressData,
    this.onPause,
    this.onCancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String fileName =
        progressData['fileName'] as String? ?? 'Unknown file';
    final double progress =
        (progressData['progress'] as num?)?.toDouble() ?? 0.0;
    final bool isPaused = progressData['isPaused'] as bool? ?? false;
    final String status = progressData['status'] as String? ?? 'Uploading';

    return Container(
      width: 85.w,
      margin: EdgeInsets.symmetric(vertical: 1.h),
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        border: Border.all(
          color: AppTheme.lightTheme.colorScheme.outline,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  fileName,
                  style: AppTheme.lightTheme.textTheme.titleSmall,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (onPause != null)
                GestureDetector(
                  onTap: onPause,
                  child: Container(
                    width: 8.w,
                    height: 8.w,
                    margin: EdgeInsets.only(right: 2.w),
                    decoration: BoxDecoration(
                      color: AppTheme.lightTheme.colorScheme.secondaryContainer,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: CustomIconWidget(
                      iconName: isPaused ? 'play_arrow' : 'pause',
                      color: AppTheme.lightTheme.colorScheme.secondary,
                      size: 16,
                    ),
                  ),
                ),
              if (onCancel != null)
                GestureDetector(
                  onTap: onCancel,
                  child: Container(
                    width: 8.w,
                    height: 8.w,
                    decoration: BoxDecoration(
                      color: AppTheme.lightTheme.colorScheme.errorContainer,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: CustomIconWidget(
                      iconName: 'close',
                      color: AppTheme.lightTheme.colorScheme.error,
                      size: 16,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: 1.h),
          Row(
            children: [
              Expanded(
                child: LinearProgressIndicator(
                  value: progress / 100,
                  backgroundColor: AppTheme.lightTheme.colorScheme.outline
                      .withValues(alpha: 0.3),
                  valueColor: AlwaysStoppedAnimation<Color>(
                    AppTheme.lightTheme.primaryColor,
                  ),
                ),
              ),
              SizedBox(width: 3.w),
              Text(
                '${progress.toInt()}%',
                style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                  color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
          SizedBox(height: 0.5.h),
          Text(
            status,
            style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
              color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
