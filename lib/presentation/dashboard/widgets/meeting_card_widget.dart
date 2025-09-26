import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class MeetingCardWidget extends StatelessWidget {
  final Map<String, dynamic> meeting;
  final VoidCallback? onTap;
  final VoidCallback? onShare;
  final VoidCallback? onExport;
  final VoidCallback? onDelete;
  final VoidCallback? onEdit;
  final VoidCallback? onDuplicate;
  final VoidCallback? onMoveToFolder;

  const MeetingCardWidget({
    Key? key,
    required this.meeting,
    this.onTap,
    this.onShare,
    this.onExport,
    this.onDelete,
    this.onEdit,
    this.onDuplicate,
    this.onMoveToFolder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String title = meeting['title'] ?? 'Untitled Meeting';
    final String date = meeting['date'] ?? '';
    final String duration = meeting['duration'] ?? '';
    final String status = meeting['status'] ?? 'completed';
    final List<double> waveformData =
        (meeting['waveform'] as List?)?.cast<double>() ?? [];

    return Dismissible(
      key: Key(meeting['id'].toString()),
      background: _buildSwipeBackground(isLeft: false),
      secondaryBackground: _buildSwipeBackground(isLeft: true),
      onDismissed: (direction) {
        if (direction == DismissDirection.startToEnd) {
          // Right swipe - Share/Export actions
          _showShareExportDialog(context);
        } else {
          // Left swipe - Delete action
          onDelete?.call();
        }
      },
      child: GestureDetector(
        onTap: onTap,
        onLongPress: () => _showContextMenu(context),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
          padding: EdgeInsets.all(4.w),
          decoration: BoxDecoration(
            color: AppTheme.lightTheme.colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: AppTheme.lightTheme.colorScheme.shadow
                    .withValues(alpha: 0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: AppTheme.lightTheme.textTheme.titleMedium
                              ?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 0.5.h),
                        Text(
                          date,
                          style:
                              AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                            color: AppTheme
                                .lightTheme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  _buildStatusBadge(status),
                ],
              ),
              SizedBox(height: 2.h),
              if (waveformData.isNotEmpty) _buildWaveform(waveformData),
              SizedBox(height: 1.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CustomIconWidget(
                        iconName: 'access_time',
                        color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                        size: 16,
                      ),
                      SizedBox(width: 1.w),
                      Text(
                        duration,
                        style:
                            AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                          color:
                              AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: onShare,
                        child: Container(
                          padding: EdgeInsets.all(2.w),
                          child: CustomIconWidget(
                            iconName: 'share',
                            color: AppTheme.lightTheme.colorScheme.primary,
                            size: 18,
                          ),
                        ),
                      ),
                      SizedBox(width: 2.w),
                      GestureDetector(
                        onTap: onExport,
                        child: Container(
                          padding: EdgeInsets.all(2.w),
                          child: CustomIconWidget(
                            iconName: 'download',
                            color: AppTheme.lightTheme.colorScheme.primary,
                            size: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    Color badgeColor;
    String statusText;

    switch (status.toLowerCase()) {
      case 'recorded':
        badgeColor = AppTheme.lightTheme.colorScheme.tertiary;
        statusText = 'Recorded';
        break;
      case 'transcribing':
        badgeColor = AppTheme.lightTheme.colorScheme.secondary;
        statusText = 'Processing';
        break;
      case 'completed':
        badgeColor = AppTheme.lightTheme.colorScheme.primary;
        statusText = 'Completed';
        break;
      default:
        badgeColor = AppTheme.lightTheme.colorScheme.outline;
        statusText = 'Unknown';
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.5.h),
      decoration: BoxDecoration(
        color: badgeColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: badgeColor.withValues(alpha: 0.3)),
      ),
      child: Text(
        statusText,
        style: AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
          color: badgeColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildWaveform(List<double> waveformData) {
    return Container(
      height: 4.h,
      child: Row(
        children: waveformData.take(20).map((amplitude) {
          return Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 0.5.w),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: (amplitude * 3.h).clamp(0.5.h, 3.h),
                  decoration: BoxDecoration(
                    color: AppTheme.lightTheme.colorScheme.primary
                        .withValues(alpha: 0.6),
                    borderRadius: BorderRadius.circular(1),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSwipeBackground({required bool isLeft}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      decoration: BoxDecoration(
        color: isLeft
            ? AppTheme.lightTheme.colorScheme.error
            : AppTheme.lightTheme.colorScheme.primary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Align(
        alignment: isLeft ? Alignment.centerRight : Alignment.centerLeft,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 6.w),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (isLeft) ...[
                CustomIconWidget(
                  iconName: 'delete',
                  color: Colors.white,
                  size: 24,
                ),
                SizedBox(width: 2.w),
                Text(
                  'Delete',
                  style: AppTheme.lightTheme.textTheme.titleSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ] else ...[
                CustomIconWidget(
                  iconName: 'share',
                  color: Colors.white,
                  size: 24,
                ),
                SizedBox(width: 2.w),
                Text(
                  'Share',
                  style: AppTheme.lightTheme.textTheme.titleSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: 4.w),
                CustomIconWidget(
                  iconName: 'download',
                  color: Colors.white,
                  size: 24,
                ),
                SizedBox(width: 2.w),
                Text(
                  'Export',
                  style: AppTheme.lightTheme.textTheme.titleSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  void _showShareExportDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(6.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: CustomIconWidget(
                iconName: 'share',
                color: AppTheme.lightTheme.colorScheme.primary,
                size: 24,
              ),
              title: Text('Share Meeting'),
              onTap: () {
                Navigator.pop(context);
                onShare?.call();
              },
            ),
            ListTile(
              leading: CustomIconWidget(
                iconName: 'download',
                color: AppTheme.lightTheme.colorScheme.primary,
                size: 24,
              ),
              title: Text('Export Meeting'),
              onTap: () {
                Navigator.pop(context);
                onExport?.call();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showContextMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(6.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: CustomIconWidget(
                iconName: 'visibility',
                color: AppTheme.lightTheme.colorScheme.primary,
                size: 24,
              ),
              title: Text('View'),
              onTap: () {
                Navigator.pop(context);
                onTap?.call();
              },
            ),
            ListTile(
              leading: CustomIconWidget(
                iconName: 'edit',
                color: AppTheme.lightTheme.colorScheme.primary,
                size: 24,
              ),
              title: Text('Edit'),
              onTap: () {
                Navigator.pop(context);
                onEdit?.call();
              },
            ),
            ListTile(
              leading: CustomIconWidget(
                iconName: 'content_copy',
                color: AppTheme.lightTheme.colorScheme.primary,
                size: 24,
              ),
              title: Text('Duplicate'),
              onTap: () {
                Navigator.pop(context);
                onDuplicate?.call();
              },
            ),
            ListTile(
              leading: CustomIconWidget(
                iconName: 'folder',
                color: AppTheme.lightTheme.colorScheme.primary,
                size: 24,
              ),
              title: Text('Move to Folder'),
              onTap: () {
                Navigator.pop(context);
                onMoveToFolder?.call();
              },
            ),
          ],
        ),
      ),
    );
  }
}
