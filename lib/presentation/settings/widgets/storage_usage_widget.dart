import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';

class StorageUsageWidget extends StatelessWidget {
  final Map<String, dynamic> storageData;
  final VoidCallback onClearCache;

  const StorageUsageWidget({
    Key? key,
    required this.storageData,
    required this.onClearCache,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final totalUsed = storageData['totalUsed'] as double;
    final totalLimit = storageData['totalLimit'] as double;
    final usagePercentage = totalUsed / totalLimit;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppTheme.lightTheme.colorScheme.outline.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Storage Usage',
                style: AppTheme.lightTheme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppTheme.lightTheme.colorScheme.primary,
                ),
              ),
              Text(
                '${totalUsed.toStringAsFixed(1)} GB / ${totalLimit.toStringAsFixed(1)} GB',
                style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                  color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          Container(
            height: 1.h,
            decoration: BoxDecoration(
              color: AppTheme.lightTheme.colorScheme.outline
                  .withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(4),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: usagePercentage.clamp(0.0, 1.0),
              child: Container(
                decoration: BoxDecoration(
                  color: usagePercentage > 0.8
                      ? AppTheme.lightTheme.colorScheme.error
                      : usagePercentage > 0.6
                          ? Colors.orange
                          : AppTheme.lightTheme.colorScheme.primary,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
          SizedBox(height: 2.h),
          ..._buildStorageBreakdown(),
          SizedBox(height: 2.h),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: onClearCache,
              child: Text('Clear Cache'),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildStorageBreakdown() {
    final breakdown = storageData['breakdown'] as Map<String, dynamic>;
    return breakdown.entries.map((entry) {
      final size = entry.value as double;
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 0.5.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 3.w,
                  height: 3.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _getCategoryColor(entry.key),
                  ),
                ),
                SizedBox(width: 3.w),
                Text(
                  _getCategoryName(entry.key),
                  style: AppTheme.lightTheme.textTheme.bodyMedium,
                ),
              ],
            ),
            Text(
              '${size.toStringAsFixed(2)} GB',
              style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      );
    }).toList();
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'audioFiles':
        return AppTheme.lightTheme.colorScheme.primary;
      case 'transcripts':
        return AppTheme.lightTheme.colorScheme.tertiary;
      case 'cachedData':
        return AppTheme.lightTheme.colorScheme.secondary;
      default:
        return AppTheme.lightTheme.colorScheme.outline;
    }
  }

  String _getCategoryName(String category) {
    switch (category) {
      case 'audioFiles':
        return 'Audio Files';
      case 'transcripts':
        return 'Transcripts';
      case 'cachedData':
        return 'Cached Data';
      default:
        return category;
    }
  }
}
