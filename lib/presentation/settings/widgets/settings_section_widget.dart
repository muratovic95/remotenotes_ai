import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class SettingsSectionWidget extends StatelessWidget {
  final String title;
  final List<Map<String, dynamic>> items;
  final Function(String) onItemTap;

  const SettingsSectionWidget({
    Key? key,
    required this.title,
    required this.items,
    required this.onItemTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
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
          Padding(
            padding: EdgeInsets.fromLTRB(4.w, 2.h, 4.w, 1.h),
            child: Text(
              title,
              style: AppTheme.lightTheme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppTheme.lightTheme.colorScheme.primary,
              ),
            ),
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: items.length,
            separatorBuilder: (context, index) => Divider(
              height: 1,
              color: AppTheme.lightTheme.colorScheme.outline
                  .withValues(alpha: 0.1),
              indent: 4.w,
              endIndent: 4.w,
            ),
            itemBuilder: (context, index) {
              final item = items[index];
              return _buildSettingsItem(context, item);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsItem(BuildContext context, Map<String, dynamic> item) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 0.5.h),
      leading: item['icon'] != null
          ? Container(
              width: 8.w,
              height: 8.w,
              decoration: BoxDecoration(
                color: AppTheme.lightTheme.colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(8),
              ),
              child: CustomIconWidget(
                iconName: item['icon'] as String,
                color: AppTheme.lightTheme.colorScheme.primary,
                size: 18,
              ),
            )
          : null,
      title: Text(
        item['title'] as String,
        style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: item['subtitle'] != null
          ? Text(
              item['subtitle'] as String,
              style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
              ),
            )
          : null,
      trailing: _buildTrailingWidget(item),
      onTap: () => onItemTap(item['key'] as String),
    );
  }

  Widget _buildTrailingWidget(Map<String, dynamic> item) {
    if (item['type'] == 'switch') {
      return Switch(
        value: item['value'] as bool? ?? false,
        onChanged: (value) {
          // Handle switch change
        },
      );
    } else if (item['type'] == 'dropdown') {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            item['value'] as String? ?? '',
            style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
              color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
            ),
          ),
          SizedBox(width: 2.w),
          CustomIconWidget(
            iconName: 'chevron_right',
            color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
            size: 16,
          ),
        ],
      );
    } else if (item['type'] == 'status') {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 2.w,
            height: 2.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: (item['connected'] as bool? ?? false)
                  ? AppTheme.lightTheme.colorScheme.tertiary
                  : AppTheme.lightTheme.colorScheme.error,
            ),
          ),
          SizedBox(width: 2.w),
          Text(
            (item['connected'] as bool? ?? false)
                ? 'Connected'
                : 'Disconnected',
            style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
              color: (item['connected'] as bool? ?? false)
                  ? AppTheme.lightTheme.colorScheme.tertiary
                  : AppTheme.lightTheme.colorScheme.error,
            ),
          ),
          SizedBox(width: 2.w),
          CustomIconWidget(
            iconName: 'chevron_right',
            color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
            size: 16,
          ),
        ],
      );
    }
    return CustomIconWidget(
      iconName: 'chevron_right',
      color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
      size: 16,
    );
  }
}
