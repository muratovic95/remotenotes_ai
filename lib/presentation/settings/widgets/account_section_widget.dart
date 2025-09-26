import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class AccountSectionWidget extends StatelessWidget {
  final Map<String, dynamic> userProfile;
  final VoidCallback onAccountTap;

  const AccountSectionWidget({
    Key? key,
    required this.userProfile,
    required this.onAccountTap,
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
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
        leading: Container(
          width: 12.w,
          height: 12.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: AppTheme.lightTheme.colorScheme.outline
                  .withValues(alpha: 0.3),
              width: 1,
            ),
          ),
          child: ClipOval(
            child: CustomImageWidget(
              imageUrl: userProfile['avatar'] as String,
              width: 12.w,
              height: 12.w,
              fit: BoxFit.cover,
            ),
          ),
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                userProfile['name'] as String,
                style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
              decoration: BoxDecoration(
                color: _getSubscriptionColor(
                    userProfile['subscription'] as String),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                userProfile['subscription'] as String,
                style: AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 10.sp,
                ),
              ),
            ),
          ],
        ),
        subtitle: Padding(
          padding: EdgeInsets.only(top: 0.5.h),
          child: Text(
            userProfile['email'] as String,
            style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
              color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        trailing: CustomIconWidget(
          iconName: 'chevron_right',
          color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
          size: 20,
        ),
        onTap: onAccountTap,
      ),
    );
  }

  Color _getSubscriptionColor(String subscription) {
    switch (subscription.toLowerCase()) {
      case 'pro':
        return AppTheme.lightTheme.colorScheme.primary;
      case 'team':
        return AppTheme.lightTheme.colorScheme.tertiary;
      default:
        return AppTheme.lightTheme.colorScheme.secondary;
    }
  }
}
