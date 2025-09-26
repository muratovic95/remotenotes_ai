import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class FloatingToolbarWidget extends StatelessWidget {
  final VoidCallback? onExportPdf;
  final VoidCallback? onShareLink;
  final VoidCallback? onSendToIntegrations;

  const FloatingToolbarWidget({
    Key? key,
    this.onExportPdf,
    this.onShareLink,
    this.onSendToIntegrations,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(4.w),
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: AppTheme.lightTheme.colorScheme.outline.withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildToolbarButton(
            icon: 'picture_as_pdf',
            label: 'Export PDF',
            onTap: onExportPdf,
          ),
          Container(
            width: 1,
            height: 4.h,
            color:
                AppTheme.lightTheme.colorScheme.outline.withValues(alpha: 0.2),
          ),
          _buildToolbarButton(
            icon: 'share',
            label: 'Share Link',
            onTap: onShareLink,
          ),
          Container(
            width: 1,
            height: 4.h,
            color:
                AppTheme.lightTheme.colorScheme.outline.withValues(alpha: 0.2),
          ),
          _buildToolbarButton(
            icon: 'integration_instructions',
            label: 'Integrations',
            onTap: onSendToIntegrations,
          ),
        ],
      ),
    );
  }

  Widget _buildToolbarButton({
    required String icon,
    required String label,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomIconWidget(
              iconName: icon,
              color: AppTheme.lightTheme.primaryColor,
              size: 24,
            ),
            SizedBox(height: 0.5.h),
            Text(
              label,
              style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w500,
                color: AppTheme.lightTheme.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
