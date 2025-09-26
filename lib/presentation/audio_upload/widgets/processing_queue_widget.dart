import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class ProcessingQueueWidget extends StatelessWidget {
  final List<Map<String, dynamic>> queueItems;

  const ProcessingQueueWidget({
    Key? key,
    required this.queueItems,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (queueItems.isEmpty) {
      return SizedBox.shrink();
    }

    return Container(
      width: 85.w,
      margin: EdgeInsets.symmetric(vertical: 2.h),
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CustomIconWidget(
                iconName: 'queue',
                color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                size: 20,
              ),
              SizedBox(width: 2.w),
              Text(
                'Processing Queue',
                style: AppTheme.lightTheme.textTheme.titleSmall?.copyWith(
                  color: AppTheme.lightTheme.colorScheme.onSurface,
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: queueItems.length,
            separatorBuilder: (context, index) => SizedBox(height: 1.h),
            itemBuilder: (context, index) {
              final item = queueItems[index];
              final String fileName =
                  item['fileName'] as String? ?? 'Unknown file';
              final String estimatedTime =
                  item['estimatedTime'] as String? ?? '0 min';
              final String status = item['status'] as String? ?? 'Waiting';

              return Row(
                children: [
                  Container(
                    width: 8.w,
                    height: 8.w,
                    decoration: BoxDecoration(
                      color: _getStatusColor(status).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: CustomIconWidget(
                      iconName: _getStatusIcon(status),
                      color: _getStatusColor(status),
                      size: 16,
                    ),
                  ),
                  SizedBox(width: 3.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          fileName,
                          style: AppTheme.lightTheme.textTheme.bodyMedium,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          'Est. $estimatedTime',
                          style:
                              AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                            color: AppTheme
                                .lightTheme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    status,
                    style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                      color: _getStatusColor(status),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'processing':
        return AppTheme.lightTheme.primaryColor;
      case 'completed':
        return AppTheme.lightTheme.colorScheme.tertiary;
      case 'error':
        return AppTheme.lightTheme.colorScheme.error;
      default:
        return AppTheme.lightTheme.colorScheme.onSurfaceVariant;
    }
  }

  String _getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'processing':
        return 'sync';
      case 'completed':
        return 'check_circle';
      case 'error':
        return 'error';
      default:
        return 'schedule';
    }
  }
}
