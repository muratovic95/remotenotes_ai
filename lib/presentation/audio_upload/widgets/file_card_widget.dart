import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class FileCardWidget extends StatelessWidget {
  final Map<String, dynamic> fileData;
  final VoidCallback onRemove;

  const FileCardWidget({
    Key? key,
    required this.fileData,
    required this.onRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String fileName = fileData['name'] as String? ?? 'Unknown file';
    final String duration = fileData['duration'] as String? ?? '0:00';
    final String size = fileData['size'] as String? ?? '0 MB';
    final String format = fileData['format'] as String? ?? 'Unknown';

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
      child: Row(
        children: [
          Container(
            width: 12.w,
            height: 12.w,
            decoration: BoxDecoration(
              color: AppTheme.lightTheme.primaryColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: CustomIconWidget(
              iconName: 'audio_file',
              color: AppTheme.lightTheme.primaryColor,
              size: 24,
            ),
          ),
          SizedBox(width: 3.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  fileName,
                  style: AppTheme.lightTheme.textTheme.titleSmall,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 0.5.h),
                Row(
                  children: [
                    Text(
                      duration,
                      style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                        color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    SizedBox(width: 2.w),
                    Text(
                      '•',
                      style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                        color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    SizedBox(width: 2.w),
                    Text(
                      size,
                      style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                        color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    SizedBox(width: 2.w),
                    Text(
                      '•',
                      style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                        color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    SizedBox(width: 2.w),
                    Text(
                      format.toUpperCase(),
                      style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                        color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: onRemove,
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
    );
  }
}
