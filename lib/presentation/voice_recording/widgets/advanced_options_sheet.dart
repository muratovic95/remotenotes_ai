import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class AdvancedOptionsSheet extends StatefulWidget {
  final bool noiseCancellation;
  final String audioQuality;
  final bool speakerIdentification;
  final Function(bool) onNoiseCancellationChanged;
  final Function(String) onAudioQualityChanged;
  final Function(bool) onSpeakerIdentificationChanged;

  const AdvancedOptionsSheet({
    Key? key,
    required this.noiseCancellation,
    required this.audioQuality,
    required this.speakerIdentification,
    required this.onNoiseCancellationChanged,
    required this.onAudioQualityChanged,
    required this.onSpeakerIdentificationChanged,
  }) : super(key: key);

  @override
  State<AdvancedOptionsSheet> createState() => _AdvancedOptionsSheetState();
}

class _AdvancedOptionsSheetState extends State<AdvancedOptionsSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(6.w),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Handle bar
          Center(
            child: Container(
              width: 12.w,
              height: 1.h,
              decoration: BoxDecoration(
                color: AppTheme.lightTheme.colorScheme.outline,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          SizedBox(height: 3.h),
          // Title
          Text(
            'Advanced Recording Options',
            style: AppTheme.lightTheme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 4.h),
          // Noise Cancellation Toggle
          _buildToggleOption(
            title: 'Noise Cancellation',
            subtitle: 'Reduce background noise during recording',
            value: widget.noiseCancellation,
            onChanged: widget.onNoiseCancellationChanged,
            icon: 'noise_control_off',
          ),
          SizedBox(height: 3.h),
          // Audio Quality Selection
          _buildQualityOption(),
          SizedBox(height: 3.h),
          // Speaker Identification Toggle
          _buildToggleOption(
            title: 'Speaker Identification',
            subtitle: 'Identify different speakers in the recording',
            value: widget.speakerIdentification,
            onChanged: widget.onSpeakerIdentificationChanged,
            icon: 'people',
          ),
          SizedBox(height: 4.h),
        ],
      ),
    );
  }

  Widget _buildToggleOption({
    required String title,
    required String subtitle,
    required bool value,
    required Function(bool) onChanged,
    required String icon,
  }) {
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
      child: Row(
        children: [
          CustomIconWidget(
            iconName: icon,
            color: AppTheme.lightTheme.colorScheme.primary,
            size: 6.w,
          ),
          SizedBox(width: 4.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 0.5.h),
                Text(
                  subtitle,
                  style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                    color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  Widget _buildQualityOption() {
    final qualities = ['Low', 'Medium', 'High', 'Ultra'];

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CustomIconWidget(
                iconName: 'high_quality',
                color: AppTheme.lightTheme.colorScheme.primary,
                size: 6.w,
              ),
              SizedBox(width: 4.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Audio Quality',
                      style:
                          AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 0.5.h),
                    Text(
                      'Higher quality uses more storage space',
                      style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                        color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          Wrap(
            spacing: 2.w,
            children: qualities.map((quality) {
              final isSelected = widget.audioQuality == quality;
              return GestureDetector(
                onTap: () => widget.onAudioQualityChanged(quality),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppTheme.lightTheme.colorScheme.primary
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isSelected
                          ? AppTheme.lightTheme.colorScheme.primary
                          : AppTheme.lightTheme.colorScheme.outline,
                      width: 1,
                    ),
                  ),
                  child: Text(
                    quality,
                    style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                      color: isSelected
                          ? Colors.white
                          : AppTheme.lightTheme.colorScheme.onSurface,
                      fontWeight:
                          isSelected ? FontWeight.w500 : FontWeight.w400,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
